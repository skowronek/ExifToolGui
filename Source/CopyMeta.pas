unit CopyMeta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, UnitScaleForm, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons;

type
  TFCopyMetadata = class(TScaleForm)
    StatusBar1: TStatusBar;
    AdvPanel1: TPanel;
    Label2: TLabel;
    BtnCancel: TButton;
    Label1: TLabel;
    BtnExecute: TButton;
    Label3: TLabel;
    LvTagNames: TListView;
    BtnPreview: TButton;
    PnlButtons: TPanel;
    SpbPredefined: TSpeedButton;
    CmbPredefined: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure LvTagNamesCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure BtnPreviewClick(Sender: TObject);
    procedure SpbPredefinedClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CmbPredefinedChange(Sender: TObject);
  private
    { Private declarations }
    FSample: string;
    FShowLogWindow: boolean;
    procedure SetupPredefined;
    procedure SetupListView;
    procedure GetSelectedTags;
    procedure GetTagNames;
    procedure DisplayHint(Sender: TObject);
  public
    procedure PrepareShow(ASample: string);
    function TagSelection: string;
    { Public declarations }
  end;

var
  FCopyMetadata: TFCopyMetadata;

implementation

uses
  Main, MainDef, ExifToolsGUI_Utils, ExifTool, LogWin, UnitLangResources, UFrmPredefinedTags,
  Vcl.Themes;

{$R *.dfm}

var FStyleServices: TCustomStyleServices;

procedure TFCopyMetadata.SetupPredefined;
var
  Indx: integer;
begin
  CmbPredefined.Items.Clear;
  for Indx := 0 to PredefinedTagList.Count -1 do
    CmbPredefined.Items.Add(PredefinedTagList.KeyNames[Indx]);
  CmbPredefined.Text := ExcludeCopyTagListName;
end;

procedure TFCopyMetadata.SetupListView;
var
  ATag, AllTags: string;
  ANItem: TListItem;
begin
  LvTagNames.Items.BeginUpdate;
  try
    LvTagNames.Items.Clear;
    AllTags := ExcludeCopyTagList;
    while (AllTags <> '') do
    begin
      ATag := NextField(AllTags, ' ');
      ANItem := LvTagNames.Items.Add;
      ANitem.Caption := ATag;
      ANItem.Checked := (Pos(' ' + ATag + ' ', ' ' + SelExcludeCopyTagList) > 0);
    end;
  finally
    LvTagNames.Items.EndUpdate;
  end;
end;

procedure TFCopyMetadata.SpbPredefinedClick(Sender: TObject);
begin
  GetTagNames;

  FrmPredefinedTags.PrepareShow(FSample, TIniTagsData.idtCopyTags, CmbPredefined.Text);
  if (FrmPredefinedTags.ShowModal = IDOK) then
  begin
    ExcludeCopyTagListName := FrmPredefinedTags.GetSelectedPredefined;
    SetupPredefined;
    CmbPredefinedChange(CmbPredefined);

    SelExcludeCopyTagList := '';
    SetupListView;
  end;
end;

procedure TFCopyMetadata.GetTagNames;
var
  ANItem: TListItem;
begin
  ExcludeCopyTagList := '';
  for ANItem in LvTagNames.Items do
    ExcludeCopyTagList := ExcludeCopyTagList + ANItem.Caption + ' ';
end;

procedure TFCopyMetadata.GetSelectedTags;
var
  ANItem: TListItem;
begin
  SelExcludeCopyTagList := '';
  for ANItem in LvTagNames.Items do
  begin
    if (ANitem.Checked) then
      SelExcludeCopyTagList := SelExcludeCopyTagList + ANItem.Caption + ' ';
  end;
end;

function TFCopyMetadata.TagSelection: string;
var
  ANItem: TListItem;
begin
  // Save selection. Will be stored in INI
  GetTagNames;
  GetSelectedTags;

  result := '';
  for ANItem in LvTagNames.Items do
  begin
    if (ANitem.Checked = false) then
      result := result + '--' + RemoveInvalidTags(ANItem.Caption) + CRLF;
  end;
end;

procedure TFCopyMetadata.PrepareShow(ASample: string);
begin
  FSample := ASample;

  FShowLogWindow := FLogWin.Showing;
  FLogWin.Close;
end;

procedure TFCopyMetadata.BtnPreviewClick(Sender: TObject);
var
  ETcmd: string;
begin
  ETcmd := '-G0:1' + CRLF + '-a' + CRLF + '-All:all' + CRLF + '-s1' + CRLF + TagSelection;
  FLogWin.Show;
  ET_OpenExec(ETcmd, FSample);
end;

procedure TFCopyMetadata.LvTagNamesCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  StyledDrawListviewItem(FStyleServices, Sender, Item, State);
end;

procedure TFCopyMetadata.CmbPredefinedChange(Sender: TObject);
begin
  ExcludeCopyTagListName := CmbPredefined.Text;
  ExcludeCopyTagList := PredefinedTagList.Values[ExcludeCopyTagListName];
  SelExcludeCopyTagList := '';
  SetupListView;
end;

procedure TFCopyMetadata.FormResize(Sender: TObject);
begin
  LvTagNames.Columns[0].Width := LvTagNames.ClientWidth;
end;

procedure TFCopyMetadata.FormShow(Sender: TObject);
begin
  Application.OnHint := DisplayHint;
  FStyleServices := TStyleManager.Style[GUIsettings.GuiStyle];
  Left := FMain.Left + FMain.GUIBorderWidth + FMain.AdvPageFilelist.Left;
  Top := FMain.Top + FMain.GUIBorderHeight;

  if FMain.MaDontBackup.Checked then
    Label1.Caption := StrBackupOFF
  else
    Label1.Caption := StrBackupON;
  SetupPredefined;
  SetupListView;

  if (FShowLogWindow) then
    FLogWin.Show;
end;

procedure TFCopyMetadata.DisplayHint(Sender: TObject);
begin
  StatusBar1.SimpleText := GetShortHint(Application.Hint);
end;

end.
