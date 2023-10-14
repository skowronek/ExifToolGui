unit ExifTool;

interface

uses System.Classes, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TExecETEvent = procedure(ExecNum: word; EtCmds, EtOuts, EtErrs, StatusLine: string; PopupOnError: boolean) of object;

  ET_OptionsRec = record
    // don't define '-a' (because of Filelist custom columns)
    // don't define '-e' (because of extracting previews)
    ETLangDef: string;
    ETBackupMode: string;
    ETFileDate: string;
    ETSeparator: string;
    ETMinorError: string;
    ETGpsFormat: string;
    ETShowNumber: string;
    ETCharset: string;
    ETVerbose: string;
    ETAPIWindowsWideFile: string;
    procedure SetGpsFormat(UseDecimal: boolean);
    procedure SetApiWindowsWideFile(UseWide: boolean);
    function GetOptions(Charset: boolean = true): string;
  end;

const
  CRLF = #13#10;
  ReadyPrompt = '{ready';
  FilePrompt  = '========';

var
  ExecETEvent: TExecETEvent;
  ET_Options: ET_OptionsRec = (ETLangDef: '';
    ETBackupMode: '-overwrite_original' + CRLF;   // or ='' or='overwrite_original_in_place'
    ETFileDate: '';                               // or '-P'+CRLF (preserve FileModify date)
    ETSeparator: '-sep' + CRLF + '*' + CRLF;      // or '' (for keywords etc.)
    ETMinorError: '';                             // or '-m'+CRLF
    ETGpsFormat: '';                              // See SetGpsFormat
    ETShowNumber: '';                             // or '-n'+CRLF
    ETCharset: '-CHARSET' + CRLF + 'FILENAME=UTF8' + CRLF + '-CHARSET' + CRLF + 'UTF8'; // UTF8 it is. No choice
    ETVerbose: '-v0' );                           // For file counter

function ETWorkDir: string;

function ET_StayOpen(WorkDir: string): boolean;
function ET_OpenExec(ETcmd: string; FNames: string; var ETouts, ETErrs: string; PopupOnError: boolean = true): boolean; overload;
function ET_OpenExec(ETcmd: string; FNames: string; ETout: TStrings; PopupOnError: boolean = true): boolean; overload;
function ET_OpenExec(ETcmd: string; FNames: string; PopupOnError: boolean = true): boolean; overload;
procedure ET_OpenExit(WaitForClose: boolean = false);

function ExecET(ETcmd, FNames, WorkDir: string; var ETouts, ETErrs: string): boolean; overload;
function ExecET(ETcmd, FNames, WorkDir: string; var ETouts: string): boolean; overload;

function ExecCMD(xCmd, WorkDir: string; var ETouts, ETErrs: string): boolean; overload;
function ExecCMD(xCmd, WorkDir: string): boolean; overload;

procedure SetCounter(AStatusBar: TStatusBar; APanel, ACounter: integer);

implementation

uses System.SysUtils, System.SyncObjs, Winapi.Windows, Vcl.Forms, Main, MainDef, ExifToolsGUI_Utils;

const
  szPipeBuffer = 65535;

var
  ETCounterBar: TStatusBar = nil;
  ETCounterPanel: integer = 0;
  ETCounter: integer = 0;

  ETprocessInfo: TProcessInformation;
  PipeInRead, PipeInWrite: THandle;
  PipeOutRead, PipeOutWrite: THandle;
  PipeErrRead, PipeErrWrite: THandle;
  FETWorkDir: string;
  ETEvent: TEvent;
  ExecNum: word;

// Returns the output of ExifTool, but skips last {ready line, if found
// Statusline is the line immediately preceding the last line. Contains xxxx image files read.
function AnalyseResult(const AString: string; var StatusLine: string): string;
var StartPrevLine: integer;
begin
  result := AString;
  StatusLine := LastLine(AString, Length(result), StartPrevLine);
  if (Pos(ReadyPrompt, StatusLine) > 0) then
  begin
    SetLength(result, StartPrevLine -1);
    StatusLine := LastLine(AString, Length(result), StartPrevLine);
  end;
end;

procedure ET_OptionsRec.SetGpsFormat(UseDecimal: boolean);
begin
  if UseDecimal then
    ETGpsFormat := '-c' + CRLF + '%.6f' + #$B0 + CRLF
  else
    ETGpsFormat := '-c' + CRLF + '%d' + #$B0 + '%.4f' + CRLF;
end;

procedure ET_OptionsRec.SetApiWindowsWideFile(UseWide: boolean);
begin
  if UseWide then
    ETAPIWindowsWideFile := '-API' + CRLF + 'WindowsWideFile=1' + CRLF
  else
    ETAPIWindowsWideFile := '';
end;

function ET_OptionsRec.GetOptions(Charset: boolean = true): string;
begin
  result := '';
  if (Charset) then
    result := ETCharset + CRLF;
  result := result + ETVerbose + CRLF; // -for file counter!
  if ETLangDef <> '' then
    result := result + '-lang' + CRLF + ETLangDef;
  result := result + ETBackupMode;
  result := result + ETSeparator;
  result := result + ETMinorError + ETFileDate;
  result := result + ETGpsFormat + ETShowNumber;
  result := result + ETAPIWindowsWideFile;
  // +further options...
end;

procedure UpdateExecNum;
begin
  inc(ExecNum);
  if (ExecNum > 99) then
    ExecNum := 10;
end;

// Scan for Ready prompt and optionally for ===== (New file processed by ExifTool)
function CheckBuffer(PipeBuffer: array of byte; BuffLen: Dword): boolean;
var Buffer: AnsiString;
    LastBufferLine: string;
    CheckNum: string;
    FilePos, PrevPos: integer;
begin
  if (BuffLen = 0) then
    exit(true);

  // Get Buffer as an AnsiString
  SetLength(Buffer, BuffLen);
  Move(PipeBuffer[0], Buffer[1], BuffLen);

  // Last Line is our ready prompt?
  CheckNum := ReadyPrompt + IntToStr(ExecNum) + '}';
  LastBufferLine := LastLine(Buffer, Length(Buffer), FilePos);
  result := (LastBufferLine = CheckNum);

  // Count the nr of Files processed.
  FilePos := BuffLen;
  PrevPos := 1;
  while (ETCounter > 0) and
        (FilePos > 0) do
  begin
    FilePos := Pos(FilePrompt, Buffer, PrevPos);

    if (FilePos > 0) then
    begin
      Dec(ETCounter);
      if (Assigned(ETCounterBar)) then
      begin
        ETCounterBar.Panels[ETCounterPanel].Text := IntToStr(ETCounter) + ' Files remaining';
        ETCounterBar.Update;
      end;
      if ((ETCounter mod 10) = 0) then
        Application.ProcessMessages;
    end;
    PrevPos := FilePos + Length(FilePrompt) + 1;
  end;
end;

function ETWorkDir: string;
begin
  result := FETWorkDir;
end;

// ============================== ET_Open mode ==================================
function ET_StayOpen(WorkDir: string): boolean;
var
  SecurityAttr: TSecurityAttributes;
  StartupInfo: TStartupInfo;
  PWorkDir: PChar;
  ETcmd: string;
begin
  result := true;
  if (FETWorkDir = WorkDir) then
    exit;
  ET_OpenExit; // -changing WorkDir OnTheFly requires Exit first

  ETcmd := GUIsettings.ETOverrideDir + 'exiftool -stay_open True -@ -';
  FillChar(ETprocessInfo, SizeOf(TProcessInformation), #0);
  FillChar(SecurityAttr, SizeOf(TSecurityAttributes), #0);
  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.bInheritHandle := true;
  SecurityAttr.lpSecurityDescriptor := nil;
  CreatePipe(PipeInRead, PipeInWrite, @SecurityAttr, 0);
  CreatePipe(PipeOutRead, PipeOutWrite, @SecurityAttr, 65535);
  CreatePipe(PipeErrRead, PipeErrWrite, @SecurityAttr, 32767);
  FillChar(StartupInfo, SizeOf(TStartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  with StartupInfo do
  begin
    hStdInput := PipeInRead;
    hStdOutput := PipeOutWrite;
    hStdError := PipeErrWrite;
    wShowWindow := SW_HIDE;
    dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
  end;
  if WorkDir = '' then
    PWorkDir := nil
  else
    PWorkDir := PChar(WorkDir);
  if CreateProcess(nil, PChar(ETcmd), nil, nil, true,
                   CREATE_DEFAULT_ERROR_MODE or CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
                   nil, PWorkDir,
    StartupInfo, ETprocessInfo) then
  begin
    CloseHandle(PipeInRead);
    CloseHandle(PipeOutWrite);
    CloseHandle(PipeErrWrite);
    FETWorkDir := WorkDir;
  end
  else
  begin
    CloseHandle(PipeInRead);
    CloseHandle(PipeInWrite);
    CloseHandle(PipeOutRead);
    CloseHandle(PipeOutWrite);
    CloseHandle(PipeErrRead);
    CloseHandle(PipeErrWrite);
  end;
  result := (FETWorkDir <> '');
end;

function ET_OpenExec(ETcmd: string; FNames: string; var ETouts, ETErrs: string; PopupOnError: boolean = true): boolean;
var
  ETstream: TStringStream;
  PipeBuffer: array [0 .. szPipeBuffer] of byte;
  FinalCmd: string;
  TempFile: string;
  StatusLine: string;
  ETlogs: string;
  Call_ET: AnsiString; // Needs to be AnsiString. Only holds the -@ <argsfilename>
  BytesCount: Dword;
  I: word;
  CanUseUtf8: boolean;
  EndReady: boolean;
  Wr: TWaitResult;
  CrWait, CrNormal: HCURSOR;
begin
  result := false;

  // Update Execnum
  UpdateExecNum;

  if (FETWorkDir <> '') and
     (Length(ETcmd) > 1) then
  begin
    Wr := ETEvent.WaitFor(GUIsettings.ETTimeOut);
    if (Wr <> wrSignaled) then
    begin
      ETEvent.SetEvent;
      result := false;
      ETouts := '';
      ETErrs := 'Time out waiting for Event' + CRLF;
      exit;
    end;
    ETEvent.ReSetEvent;

    ETstream := TStringStream.Create;
    CrWait := LoadCursor(0, IDC_WAIT);
    CrNormal := SetCursor(CrWait);
    try
      // Create TempFile with commands and filenames
      if pos('||', ETcmd) > 0 then
        ETcmd := StringReplace(ETcmd, '||', CRLF, [rfReplaceAll]);
      CanUseUtf8 := (pos('-L' + CRLF, ETcmd) = 0);
      FinalCmd := EndsWithCRLF(ET_Options.GetOptions(CanUseUtf8) + ETcmd);
      if FNames <> '' then
        FinalCmd := EndsWithCRLF(FinalCmd + FNames);
      FinalCmd := EndsWithCRLF(FinalCmd + '-execute' + IntToStr(ExecNum));

      // Create tempfile
      TempFile := GetExifToolTmp;
      WriteArgsFile(FinalCmd, TempFile);
      Call_ET := EndsWithCRLF('-@' + CRLF + TempFile);

      // Write command to Pipe. Triggers ExifTool execution
      WriteFile(PipeInWrite, Call_ET[1], ByteLength(Call_ET), BytesCount, nil);
      FlushFileBuffers(PipeInWrite);

      // ========= Read StdOut =======================
      ETstream.Clear;
      repeat
        ReadFile(PipeOutRead, PipeBuffer, szPipeBuffer, BytesCount, nil);
        ETstream.Write(PipeBuffer, BytesCount);
        EndReady := CheckBuffer(PipeBuffer, BytesCount);
      until EndReady;
      ETstream.Position := 0;
      ETlogs := UTF8ToString(ETstream.DataString);
      SetCounter(nil, 0 ,0);

      // ========= Read StdErr =======================
      ETstream.Clear;
      I := 0;
      repeat
        PeekNamedPipe(PipeErrRead, nil, 0, nil, @BytesCount, nil);
        if BytesCount > 0 then
        begin
          ReadFile(PipeErrRead, PipeBuffer, szPipeBuffer, BytesCount, nil);
          ETstream.Write(PipeBuffer, BytesCount);
        end;
        inc(I);
      until (BytesCount = 0) or (I > 5); // max 2 attempts observed
      ETstream.Position := 0;
      ETErrs := UTF8ToString(ETstream.DataString);

      // Analyse
      ETouts := AnalyseResult(ETlogs, StatusLine); // Etouts: returned as result, ETlogs: shown in log window

      // Callback for Logging
      if Assigned(ExecETEvent) then
        ExecETEvent(ExecNum, FinalCmd, ETlogs, ETErrs, StatusLine, PopupOnError);

      result := true;
    finally
      ETstream.Free;
      SetCursor(CrNormal);
      ETEvent.SetEvent;
    end;
  end;
end;

function ET_OpenExec(ETcmd: string; FNames: string; ETout: TStrings; PopupOnError: boolean = true): boolean;
var
  ETouts, ETErrs: string;
begin
  result := ET_OpenExec(ETcmd, FNames, ETouts, ETErrs, PopupOnError);
  ETout.Text := ETouts;
end;

function ET_OpenExec(ETcmd: string; FNames: string; PopupOnError: boolean = true): boolean;
var
  ETouts, ETErrs: string;
begin
  result := ET_OpenExec(ETcmd, FNames, ETouts, ETErrs, PopupOnError);
end;

procedure ET_OpenExit(WaitForClose: boolean = false);
const
  ExitCmd: AnsiString = '-stay_open' + CRLF + 'False' + CRLF; // Needs to be AnsiString.
var
  BytesCount: Dword;
begin
  if (FETWorkDir <> '') then
  begin
    WriteFile(PipeInWrite, ExitCmd[1], Length(ExitCmd), BytesCount, nil);
    FlushFileBuffers(PipeInWrite);

    if (WaitForClose) then
      WaitForSingleObject(ETprocessInfo.hProcess, GUIsettings.ETTimeOut);

    CloseHandle(ETprocessInfo.hThread);
    CloseHandle(ETprocessInfo.hProcess);
    CloseHandle(PipeInWrite);
    CloseHandle(PipeOutRead);
    CloseHandle(PipeErrRead);
    FETWorkDir := '';
  end;
end;

// ^^^^^^^^^^^^^^^^^^^^^^^^^^^ End of ET_Open mode ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//
// =========================== ET classic mode ==================================
function ExecET(ETcmd, FNames, WorkDir: string; var ETouts, ETErrs: string): boolean;
var
  ETstream: TStringStream;
  PipeBuffer: array [0 .. szPipeBuffer] of byte;
  ProcessInfo: TProcessInformation;
  SecurityAttr: TSecurityAttributes;
  StartupInfo: TStartupInfo;
  PipeOutRead, PipeOutWrite: THandle;
  PipeErrRead, PipeErrWrite: THandle;
  FinalCmd: string;
  TempFile: string;
  StatusLine: string;
  ETlogs: string;
  Call_ET: string;
  PWorkDir: PChar;
  BytesCount: Dword;
  CanUseUtf8: boolean;
  CrWait, CrNormal: HCURSOR;
begin
  CrWait := LoadCursor(0, IDC_WAIT);
  CrNormal := SetCursor(CrWait);
  ETstream := TStringStream.Create;
  try
    FillChar(ProcessInfo, SizeOf(TProcessInformation), #0);
    FillChar(SecurityAttr, SizeOf(TSecurityAttributes), #0);
    SecurityAttr.nLength := SizeOf(SecurityAttr);
    SecurityAttr.bInheritHandle := true;
    SecurityAttr.lpSecurityDescriptor := nil;
    CreatePipe(PipeOutRead, PipeOutWrite, @SecurityAttr, 65535);
    CreatePipe(PipeErrRead, PipeErrWrite, @SecurityAttr, 32767);
    FillChar(StartupInfo, SizeOf(TStartupInfo), #0);
    StartupInfo.cb := SizeOf(StartupInfo);
    with StartupInfo do
    begin
      hStdInput := 0;
      hStdOutput := PipeOutWrite;
      hStdError := PipeErrWrite;
      wShowWindow := SW_HIDE;
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    end;
    if WorkDir = '' then
      PWorkDir := nil
    else
      PWorkDir := PChar(WorkDir);

    UpdateExecNum;
    CanUseUtf8 := (pos('-L ', ETcmd) = 0);

    FinalCmd := EndsWithCRLF(ET_Options.GetOptions(CanUseUtf8) + ArgsFromDirectCmd(ETcmd));
    FinalCmd := EndsWithCRLF(FinalCmd + FNames);
    TempFile := GetExifToolTmp;
    WriteArgsFile(FinalCmd, TempFile);
    Call_ET := GUIsettings.ETOverrideDir + 'exiftool -@ "' + TempFile + '"';

    result := CreateProcess(nil, PChar(Call_ET), nil, nil, true,
                            CREATE_DEFAULT_ERROR_MODE or CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
                            nil, PWorkDir, StartupInfo, ProcessInfo);

    CloseHandle(PipeOutWrite);
    CloseHandle(PipeErrWrite);

    if not result then
    begin
      CloseHandle(PipeOutRead);
      CloseHandle(PipeErrRead);
    end
    else
    begin
      // ========= Read StdOut =======================
      ETstream.Clear;
      repeat
        ReadFile(PipeOutRead, PipeBuffer, szPipeBuffer, BytesCount, nil);
        ETstream.Write(PipeBuffer, BytesCount);
        CheckBuffer(PipeBuffer, BytesCount);
      until BytesCount = 0;

      ETstream.Position := 0;
      ETLogs := UTF8ToString(ETstream.DataString);
      CloseHandle(PipeOutRead);
      SetCounter(nil, 0, 0);

      // ========= Read StdErr =======================
      ETstream.Clear;
      repeat
        ReadFile(PipeErrRead, PipeBuffer, szPipeBuffer, BytesCount, nil);
        ETstream.Write(PipeBuffer, BytesCount);
      until (BytesCount = 0);
      ETstream.Position := 0;
      ETErrs := UTF8ToString(ETstream.DataString);
      CloseHandle(PipeErrRead);

      // ----------------------------------------------
      WaitForSingleObject(ProcessInfo.hProcess, GUIsettings.ETTimeOut);
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ProcessInfo.hProcess);

      // Analyse
      ETouts := AnalyseResult(ETlogs, StatusLine); // Etouts: returned as result, ETlogs: shown in log window

      // Callback for Logging
      if Assigned(ExecETEvent) then
        ExecETEvent(ExecNum, FinalCmd, ETlogs, ETErrs, StatusLine, true);

      result := true;
    end;
  finally
    ETstream.Free;
    SetCursor(CrNormal);
  end;
end;

function ExecET(ETcmd, FNames, WorkDir: string; var ETouts: string): boolean;
var
  ETErrs: string;
begin
  result := ExecET(ETcmd, FNames, WorkDir, ETouts, ETErrs);
end;

// ^^^^^^^^^^^^^^^^^^^^^^^^^^ End of ET Classic mode ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//
// ==============================================================================
function ExecCMD(xCmd, WorkDir: string; var ETouts, ETErrs: string): boolean;
var
  ETstream: TMemoryStream;
  PipeBuffer: array [0 .. szPipeBuffer] of byte;
  ETout, ETerr: TStringList;
  ProcessInfo: TProcessInformation;
  SecurityAttr: TSecurityAttributes;
  StartupInfo: TStartupInfo;
  PipeOutRead, PipeOutWrite: THandle;
  PipeErrRead, PipeErrWrite: THandle;
  PWorkDir: PChar;
  BytesCount: Dword;
  CrWait, CrNormal: HCURSOR;
begin
  FillChar(ProcessInfo, SizeOf(TProcessInformation), #0);
  FillChar(SecurityAttr, SizeOf(TSecurityAttributes), #0);
  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.bInheritHandle := true;
  SecurityAttr.lpSecurityDescriptor := nil;
  CreatePipe(PipeOutRead, PipeOutWrite, @SecurityAttr, 8192);
  CreatePipe(PipeErrRead, PipeErrWrite, @SecurityAttr, 8192);
  FillChar(StartupInfo, SizeOf(TStartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  with StartupInfo do
  begin
    hStdInput := 0;
    hStdOutput := PipeOutWrite;
    hStdError := PipeErrWrite;
    wShowWindow := SW_HIDE;
    dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
  end;
  if WorkDir = '' then
    PWorkDir := nil
  else
    PWorkDir := PChar(WorkDir);

  ETout := TStringList.Create;
  ETerr := TStringList.Create;
  ETstream := TMemoryStream.Create;
  CrWait := LoadCursor(0, IDC_WAIT);
  CrNormal := SetCursor(CrWait);
  try
    UniqueString(xCmd); // Required by CreateprocessW
    result := CreateProcess(nil, PChar(xCmd), nil, nil, true,
                            CREATE_DEFAULT_ERROR_MODE or CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
                            nil, PWorkDir, StartupInfo, ProcessInfo);

    CloseHandle(PipeOutWrite);
    CloseHandle(PipeErrWrite);

    if not result then
    begin
      CloseHandle(PipeOutRead);
      CloseHandle(PipeErrRead);
    end
    else
    begin
      // ========= Read StdOut =======================
      ETstream.Clear; // BuffAddress:=Addr(BuffContent);
      repeat
        ReadFile(PipeOutRead, PipeBuffer, szPipeBuffer, BytesCount, nil);
        if BytesCount > 1 then
          ETstream.Write(PipeBuffer, BytesCount);
        // Application.ProcessMessages;
      until BytesCount = 0;
      ETstream.Position := 0;
      ETout.LoadFromStream(ETstream);
      ETouts := UTF8ToString(ETout.Text);
      CloseHandle(PipeOutRead);
      // ========= Read StdErr =======================
      ETstream.Clear;
      repeat
        ReadFile(PipeErrRead, PipeBuffer, szPipeBuffer, BytesCount, nil);
        ETstream.Write(PipeBuffer, BytesCount);
      until (BytesCount = 0);
      ETstream.Position := 0;
      ETerr.LoadFromStream(ETstream);
      ETErrs := UTF8ToString(ETerr.Text);
      CloseHandle(PipeErrRead);
      // ----------------------------------------------
      WaitForSingleObject(ProcessInfo.hProcess, GUIsettings.ETTimeOut); // msec=5sec /or INFINITE
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ProcessInfo.hProcess);
    end;
  finally
    ETout.Free;
    ETerr.Free;
    ETstream.Free;
    SetCursor(CrNormal);
  end;
end;

function ExecCMD(xCmd, WorkDir: string): boolean;
var
  ETout, ETerr: string;
begin
  result := ExecCMD(xCmd, WorkDir, ETout, ETerr);
end;
// ==============================================================================

procedure SetCounter(AStatusBar: TStatusBar; APanel, ACounter: integer);
begin
  ETCounterBar := AStatusBar;
  ETCounterPanel := APanel;
  ETCounter := ACounter;
end;

initialization

begin
  ETEvent := TEvent.Create(nil, true, true, ExtractFileName(Paramstr(0)));
  ExecNum := 10; // From 10 to 99
  FETWorkDir := '';
end;

finalization

begin
  ET_OpenExit(true);
  ETEvent.Free;
end;

end.
