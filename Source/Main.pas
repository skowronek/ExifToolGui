unit Main;
{$WARN SYMBOL_PLATFORM OFF}
// Note all code formatted with Delphi formatter, Right margin 80->150
// Note about the Path.
// - To change: Set ShellTree.Path
// - To read:   Get ShellList.Path
interface

uses
  Winapi.Windows, Winapi.Messages, System.ImageList, System.SysUtils,
  System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Mask,
  Vcl.ValEdit, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.Shell.ShellCtrls, // Embarcadero ShellTreeView and ShellListView
  Winapi.WebView2, Winapi.ActiveX, Winapi.EdgeUtils, Vcl.Edge, // Edgebrowser
  VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart,
  VclTee.Series, // Chart
  BreadcrumbBar, // BreadcrumbBar
  UnitScaleForm, // Scale form from Commandline parm.
  UnitSingleApp, // Single Instance App.
  ExifToolsGUI_ShellTree,  // Extension of ShellTreeView
  ExifToolsGUI_ShellList,  // Extension of ShellListView
  ExifToolsGUI_Thumbnails, // Thumbnails
  ExifToolsGUI_ValEdit,    // MetaData
  ExifToolsGUI_Utils,      // Various
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup, Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImageList,
  System.Win.TaskbarCore, Vcl.Taskbar, Vcl.ToolWin, Vcl.AppEvnts;

const
  CM_ActivateWindow = WM_USER + 100;

type
  TFMain = class(TScaleForm)
    StatusBar: TStatusBar;
    AdvPanelBrowse: TPanel;
    AdvPageBrowse: TPageControl;
    AdvTabBrowse: TTabSheet;
    AdvPagePreview: TPageControl;
    AdvTabPreview: TTabSheet;
    AdvPageMetadata: TPageControl;
    AdvTabMetadata: TTabSheet;
    AdvPageFilelist: TPageControl;
    AdvTabFilelist: TTabSheet;
    AdvPanelFileTop: TPanel;
    AdvPanelETdirect: TPanel;
    AdvPanelMetaTop: TPanel;
    AdvPanelMetaBottom: TPanel;
    ShellTree: ExifToolsGUI_ShellTree.TShellTreeView; // Need to create our own version!
    ShellList: ExifToolsGUI_ShellList.TShellListView; // Need to create our own version!
    MetadataList: ExifToolsGui_ValEdit.TValueListEditor; // Need to create our own version!
    SpeedBtnExif: TSpeedButton;
    SpeedBtnIptc: TSpeedButton;
    SpeedBtnXmp: TSpeedButton;
    SpeedBtnMaker: TSpeedButton;
    SpeedBtnALL: TSpeedButton;
    SpeedBtnCustom: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    SpeedBtnDetails: TSpeedButton;
    CBoxDetails: TComboBox;
    EditETdirect: TLabeledEdit;
    SpeedBtn_ETdirect: TSpeedButton;
    CBoxETdirect: TComboBox;
    SpeedBtn_ETedit: TSpeedButton;
    EditETcmdName: TLabeledEdit;
    CBoxFileFilter: TComboBox;
    SpeedBtnQuick: TSpeedButton;
    MemoQuick: TMemo;
    SpeedBtnLarge: TSpeedButton;
    EditQuick: TEdit;
    SpeedBtnFListRefresh: TSpeedButton;
    SpeedBtnFilterEdit: TSpeedButton;
    SpeedBtnColumnEdit: TSpeedButton;
    SpeedBtnShowLog: TSpeedButton;
    SpeedBtnQuickSave: TSpeedButton;
    SpeedBtnETdirectDel: TSpeedButton;
    SpeedBtnETdirectReplace: TSpeedButton;
    SpeedBtnETdirectAdd: TSpeedButton;
    OpenPictureDlg: TOpenPictureDialog;
    AdvTabOSMMap: TTabSheet;
    AdvPanel_MapTop: TPanel;
    SpeedBtn_ShowOnMap: TSpeedButton;
    AdvPanel_MapBottom: TPanel;
    SpeedBtn_Geotag: TSpeedButton;
    EditMapFind: TLabeledEdit;
    SpeedBtn_MapHome: TSpeedButton;
    SpeedBtn_MapSetHome: TSpeedButton;
    OpenFileDlg: TOpenDialog;
    SaveFileDlg: TSaveDialog;
    AdvTabChart: TTabSheet;
    AdvPanel1: TPanel;
    SpeedBtnChartRefresh: TSpeedButton;
    AdvCheckBox_Subfolders: TCheckBox;
    AdvRadioGroup1: TRadioGroup;
    AdvRadioGroup2: TRadioGroup;
    SpeedBtn_ETdSetDef: TSpeedButton;
    SpeedBtn_ETclear: TSpeedButton;
    RotateImg: TImage;
    ETChart: TChart;
    Series1: TBarSeries;
    EdgeBrowser1: TEdgeBrowser;
    Spb_GoBack: TSpeedButton;
    Spb_Forward: TSpeedButton;
    SpeedBtn_GetLoc: TSpeedButton;
    CmbETDirectMode: TComboBox;
    EditFindMeta: TLabeledEdit;
    EditMapBounds: TLabeledEdit;
    PnlBreadCrumb: TPanel;
    MainActionManager: TActionManager;
    MaAbout: TAction;
    MaPreferences: TAction;
    MaQuickManager: TAction;
    MaGUIStyle: TAction;
    MaExit: TAction;
    MaWorkspaceLoad: TAction;
    MaWorkspaceSave: TAction;
    ActionMainMenuBar: TActionMainMenuBar;
    MaDontBackup: TAction;
    MaPreserveDateMod: TAction;
    MaIgnoreErrors: TAction;
    MaShowGPSdecimal: TAction;
    MaShowSorted: TAction;
    MaShowComposite: TAction;
    MaNotDuplicated: TAction;
    MaShowNumbers: TAction;
    MaShowHexID: TAction;
    MaGroup_g4: TAction;
    MaAPIWindowsWideFile: TAction;
    MaCustomOptions: TAction;
    MaExportMetaTXT: TAction;
    MaExportMetaMIE: TAction;
    MaExportMetaXMP: TAction;
    MaExportMetaEXIF: TAction;
    MaExportMetaHTML: TAction;
    MaImportMetaSingle: TAction;
    MaImportMetaSelected: TAction;
    MaImportRecursiveAll: TAction;
    MaImportGPS: TAction;
    MaImportGPSLog: TAction;
    MaImportXmpLog: TAction;
    MaGenericExtractPreviews: TAction;
    MaGenericImportPreview: TAction;
    MaExifDateTimeshift: TAction;
    MaExifDateTimeEqualize: TAction;
    MaExifLensFromMaker: TAction;
    MaRemoveMeta: TAction;
    MaUpdateLocationfromGPScoordinates: TAction;
    MaFileDateFromExif: TAction;
    MaFileNameDateTime: TAction;
    MaJPGGenericlosslessautorotate: TAction;
    MaOnlineDocumentation: TAction;
    QuickPopUpMenu: TPopupMenu;
    QuickPopUp_FillQuickAct: TMenuItem;
    ImageCollectionMetadata: TImageCollection;
    QuickPopUp_UndoEditAct: TMenuItem;
    QuickPopUp_AddQuickAct: TMenuItem;
    QuickPopUp_DelQuickAct: TMenuItem;
    N1: TMenuItem;
    QuickPopUp_AddCustomAct: TMenuItem;
    QuickPopUp_DelCustomAct: TMenuItem;
    QuickPopUp_AddDetailsUserAct: TMenuItem;
    QuickPopUp_MarkTagAct: TMenuItem;
    N4: TMenuItem;
    QuickPopUp_CopyTagAct: TMenuItem;
    VirtualImageListMetadata: TVirtualImageList;
    TrayIcon: TTrayIcon;
    TrayPopupMenu: TPopupMenu;
    Tray_Resetwindowsize: TMenuItem;
    ImgListTray_TaskBar: TImageList;
    Tray_ExifToolGui: TMenuItem;
    N2: TMenuItem;
    Taskbar: TTaskbar;
    ActLstTaskbar: TActionList;
    TaskBarResetWindow: TAction;
    ApplicationEvents: TApplicationEvents;
    MaAPILargeFileSupport: TAction;
    procedure ShellListClick(Sender: TObject);
    procedure ShellListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedBtnExifClick(Sender: TObject);
    procedure CBoxDetailsChange(Sender: TObject);
    procedure ShellListAddItem(Sender: TObject; AFolder: TShellFolder; var CanAdd: boolean);
    procedure FormShow(Sender: TObject);
    procedure SpeedBtnDetailsClick(Sender: TObject);
    procedure RotateImgResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditETdirectKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedBtn_ETdirectClick(Sender: TObject);
    procedure CBoxETdirectChange(Sender: TObject);
    procedure SpeedBtn_ETeditClick(Sender: TObject);
    procedure EditETdirectChange(Sender: TObject);
    procedure EditETcmdNameChange(Sender: TObject);
    procedure BtnETdirectDelClick(Sender: TObject);
    procedure BtnETdirectReplaceClick(Sender: TObject);
    procedure BtnETdirectAddClick(Sender: TObject);
    procedure BtnFListRefreshClick(Sender: TObject);
    procedure CBoxFileFilterChange(Sender: TObject);
    procedure MetadataListDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure MetadataListSelectCell(Sender: TObject; ACol, ARow: integer; var CanSelect: boolean);
    procedure MetadataListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MetadataListExit(Sender: TObject);
    procedure MetadataListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure MetadataListCtrlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditQuickEnter(Sender: TObject);
    procedure EditQuickExit(Sender: TObject);
    procedure EditQuickKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnQuickSaveClick(Sender: TObject);
    procedure MPreferencesClick(Sender: TObject);
    procedure BtnFilterEditClick(Sender: TObject);
    procedure CBoxFileFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnColumnEditClick(Sender: TObject);
    procedure BtnShowLogClick(Sender: TObject);
    procedure ShellListDeletion(Sender: TObject; Item: TListItem);
    procedure MDontBackupClick(Sender: TObject);
    procedure MPreserveDateModClick(Sender: TObject);
    procedure MIgnoreErrorsClick(Sender: TObject);
    procedure MShowNumbersClick(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
    procedure Splitter2CanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: integer; var Resize: boolean);
    procedure ShellListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure QuickPopUpMenuPopup(Sender: TObject);
    procedure QuickPopUp_UndoEditClick(Sender: TObject);
    procedure QuickPopUp_MarkTagClick(Sender: TObject);
    procedure QuickPopUp_AddCustomClick(Sender: TObject);
    procedure QuickPopUp_DelCustomClick(Sender: TObject);
    procedure QuickPopUp_AddQuickClick(Sender: TObject);
    procedure MQuickManagerClick(Sender: TObject);
    procedure MExitClick(Sender: TObject);
    procedure SpeedBtnLargeClick(Sender: TObject);
    procedure QuickPopUp_DelQuickClick(Sender: TObject);
    procedure MExifDateTimeshiftClick(Sender: TObject);
    procedure MExportMetaTXTClick(Sender: TObject);
    procedure MImportGPSLogClick(Sender: TObject);
    procedure MImportXMPLogClick(Sender: TObject);
    procedure MExifDateTimeEqualizeClick(Sender: TObject);
    procedure MRemoveMetaClick(Sender: TObject);
    procedure MExifLensFromMakerClick(Sender: TObject);
    procedure MFileDateFromExifClick(Sender: TObject);
    procedure MAboutClick(Sender: TObject);
    procedure QuickPopUp_FillQuickClick(Sender: TObject);
    procedure SpeedBtn_GeotagClick(Sender: TObject);
    procedure SpeedBtn_ShowOnMapClick(Sender: TObject);
    procedure SpeedBtn_MapHomeClick(Sender: TObject);
    procedure EditMapFindKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedBtn_MapSetHomeClick(Sender: TObject);
    procedure QuickPopUp_AddDetailsUserClick(Sender: TObject);
    procedure MImportMetaSingleClick(Sender: TObject);
    procedure QuickPopUp_CopyTagClick(Sender: TObject);
    procedure MFileNameDateTimeClick(Sender: TObject);
    procedure MWorkspaceLoadClick(Sender: TObject);
    procedure MWorkspaceSaveClick(Sender: TObject);
    procedure SpeedBtnChartRefreshClick(Sender: TObject);
    procedure AdvRadioGroup2Click(Sender: TObject);
    procedure MImportRecursiveAllClick(Sender: TObject);
    procedure MImportMetaSelectedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedBtn_ETdSetDefClick(Sender: TObject);
    procedure SpeedBtn_ETclearClick(Sender: TObject);
    procedure MGUIStyleClick(Sender: TObject);
    procedure ShellListColumnClick(Sender: TObject; Column: TListColumn);
    procedure AdvRadioGroup1Click(Sender: TObject);
    procedure Spb_GoBackClick(Sender: TObject);
    procedure EdgeBrowser1WebMessageReceived(Sender: TCustomEdgeBrowser; Args: TWebMessageReceivedEventArgs);
    procedure Spb_ForwardClick(Sender: TObject);
    procedure SpeedBtn_GetLocClick(Sender: TObject);
    procedure CmbETDirectModeChange(Sender: TObject);
    procedure ShellTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure MAPIWindowsWideFileClick(Sender: TObject);
    procedure MetadataListDblClick(Sender: TObject);
    procedure EditFindMetaKeyPress(Sender: TObject; var Key: Char);
    procedure GenericExtractPreviewsClick(Sender: TObject);
    procedure GenericImportPreviewClick(Sender: TObject);
    procedure JPGGenericlosslessautorotate1Click(Sender: TObject);
    procedure UpdateLocationfromGPScoordinatesClick(Sender: TObject);
    procedure EdgeBrowser1CreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
    procedure OnlineDocumentation1Click(Sender: TObject);
    procedure MetadataListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MCustomOptionsClick(Sender: TObject);
    procedure EdgeBrowser1ZoomFactorChanged(Sender: TCustomEdgeBrowser; AZoomFactor: Double);
    procedure EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
    procedure Splitter2Moved(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure AdvPagePreviewResize(Sender: TObject);
    procedure FormAfterMonitorDpiChanged(Sender: TObject; OldDPI, NewDPI: Integer);
    procedure Tray_ResetwindowsizeClick(Sender: TObject);
    procedure TrayPopupMenuPopup(Sender: TObject);
    procedure TaskbarThumbButtonClick(Sender: TObject; AButtonID: Integer);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure TrayIconMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TrayIconBalloonClick(Sender: TObject);
    procedure MaAPILargeFileSupportExecute(Sender: TObject);
  private
    { Private declarations }
    ETBarSeriesFocal: TBarSeries;
    ETBarSeriesFnum: TBarSeries;
    ETBarSeriesIso: TBarSeries;
    BreadcrumbBar: TDirBreadcrumbBar;
    EdgeZoom: double;
    MinFileListWidth: integer;
    MenusEnabled: boolean;
    procedure AlignStatusBar;
    procedure ImageDrop(var Msg: TWMDROPFILES); message WM_DROPFILES;
    procedure SetCaption(AnItem: string = '');
    procedure ShowMetadata;
    procedure ShowPreview;
    procedure RestoreGUI;
    procedure ShellListSetFolders;
    procedure EnableMenus(Enable: boolean);
    procedure EnableMenuItems;

    procedure CMActivateWindow(var Message: TMessage); message CM_ActivateWindow;
    procedure WMEndSession(var Msg: TWMEndSession); message WM_ENDSESSION;
    function TranslateTagName(xMeta, xName: string): string;

    procedure BreadCrumbClick(Sender: TObject);
    procedure BreadCrumbHome(Sender: TObject);
    procedure RefreshSelected(Sender: TObject);
    procedure ShellTreeBeforeContext(Sender: TObject);
    procedure ShellTreeAfterContext(Sender: TObject);

    procedure ShellistThumbError(Sender: TObject; Item: TListItem; E: Exception);
    procedure ShellistThumbGenerate(Sender: TObject; Item: TListItem; Status: TThumbGenStatus; Total, Remaining: integer);
    procedure ShellListBeforePopulate(Sender: TObject; var DoDefault: boolean);
    procedure ShellListAfterEnumColumns(Sender: TObject);
    procedure ShellListPathChange(Sender: TObject);
    procedure ShellListItemsLoaded(Sender: TObject);
    procedure ShellListOwnerDataFetch(Sender: TObject; Item: TListItem; Request: TItemRequest; AFolder: TShellFolder);
    procedure ShellListColumnResized(Sender: TObject);
    procedure ShellListMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);

    procedure CounterETEvent(Counter: integer);
  public
    { Public declarations }
    function GetFirstSelectedFile: string;
    function GetFirstSelectedFilePath: string;
    function GetFullPath(MustExpandPath: boolean): string;
    function GetSelectedFile(FileName: string; MustExpandPath: boolean): string; overload;
    function GetSelectedFile(FileName: string): string; overload;
    function GetSelectedFiles(MustExpandPath: boolean): string; overload;
    function GetSelectedFiles: string; overload;
    procedure ExecETEvent_Done(ExecNum: word; EtCmds, EtOuts, EtErrs, StatusLine: string; PopupOnError: boolean);
    procedure ExecRestEvent_Done(Url, Response: string; Succes: boolean);
    procedure UpdateStatusBar_FilesShown;
    procedure SetGuiStyle;
    var GUIBorderWidth, GUIBorderHeight: integer;
    var GUIColorWindow: TColor;
  end;

var
  FMain: TFMain;

implementation

uses System.StrUtils, System.Math, System.Masks, System.Types, System.UITypes,
  Vcl.ClipBrd, Winapi.ShlObj, Winapi.ShellAPI, Winapi.CommCtrl, Vcl.Shell.ShellConsts, Vcl.Themes, Vcl.Styles,
  ExifTool, ExifInfo, ExifToolsGui_LossLess, ExifTool_PipeStream, ExifToolsGUI_MultiContextMenu,
  MainDef, LogWin, Preferences, EditFFilter, EditFCol, UFrmStyle, UFrmAbout,
  QuickMngr, DateTimeShift, DateTimeEqual, CopyMeta, RemoveMeta, Geotag, Geomap, CopyMetaSingle, FileDateTime,
  UFrmGenericExtract, UFrmGenericImport, UFrmLossLessRotate, UFrmGeoTagFiles, UFrmGeoSetup,
  UnitLangResources;


{$R *.dfm}

const
  GUI_SEP = '-GUI-SEP';
{$IFDEF DEBUG}
  ONLINE_DOC_URL = 'https://github.com/FrankBijnen/ExifToolGui/blob/Development/Docs/ExifToolGUI_V6.md';
{$ELSE}
  ONLINE_DOC_URL = 'https://github.com/FrankBijnen/ExifToolGui/blob/main/Docs/ExifToolGUI_V6.md';
{$ENDIF}

const
  CameraFields =
    '-s3' + CRLF + '-f' + CRLF +
    '-ExifIFD:ExposureTime' + CRLF +
    '-ExifIFD:FNumber' + CRLF +
    '-ExifIFD:ISO' + CRLF +
    '-ExifIFD:ExposureCompensation' + CRLF +
    '-ExifIFD:FocalLength' + CRLF +
    '-ExifIFD:Flash' + CRLF +
    '-ExifIFD:ExposureProgram' + CRLF +
    '-IFD0:Orientation';

  LocationFields =
    '-s3' + CRLF + '-f' + CRLF + '-api' + CRLF + 'QuickTimeUTC' + CRLF +
    // In code we take DateTimeOriginal or CreateDate
    '-ExifIFD:DateTimeOriginal' + CRLF +
    '-CreateDate' + CRLF +
    '-GPSLatitude#' + CRLF +
    '-XMP-iptcExt:LocationShownCountryName' + CRLF +
    '-XMP-iptcExt:LocationShownProvinceState' + CRLF +
    '-XMP-iptcExt:LocationShownCity' + CRLF +
    '-XMP-iptcExt:LocationShownSublocation';

  AboutFields =
    '-s3' + CRLF + '-f' + CRLF +
    '-exif:Artist' + CRLF +
    '-XMP-xmp:Rating' + CRLF +
    '-XMP-dc:Type' + CRLF +
    '-XMP-iptcExt:Event' + CRLF +
    '-XMP-iptcExt:PersonInImage';

procedure TFMain.WMEndSession(var Msg: TWMEndSession);
begin // for Windows Shutdown/Log-off while GUI is open
  if Msg.EndSession = true then
    SaveGUIini;
  inherited;
end;

procedure TFMain.CMActivateWindow(var Message: TMessage);
var
  NewSharedDir: string;
begin
  RestoreGUI;

  NewSharedDir := FSharedMem.NewDirectory;
  if (ValidDir(NewSharedDir)) then
    ShellTree.Path := NewSharedDir;

  Message.Result := 0;
  inherited;
end;

procedure TFMain.QuickPopUp_CopyTagClick(Sender: TObject);
begin
  Clipboard.AsText := MetadataList.Cells[1, MetadataList.Row];
end;

procedure TFMain.AdvRadioGroup1Click(Sender: TObject);
begin
  SpeedBtnChartRefreshClick(Sender);
end;

procedure TFMain.AdvRadioGroup2Click(Sender: TObject);
var
  LeftInc: double;
begin
  with ETChart do
  begin
    UndoZoom;
    ETChart.Title.Visible := true;
    Legend.Visible := false;
    RemoveAllSeries;
  end;

  with ETChart.LeftAxis do
  begin
    Title.Text := StrNrOfPhotos;
    Visible := true;
    Automatic := false;
    AutomaticMaximum := false;
    AutomaticMinimum := false;
    Minimum := 0; // Cannot have a negative nr of photos!
  end;

  case AdvRadioGroup2.ItemIndex of
    0:
      begin
        ETChart.LeftAxis.Maximum := ChartMaxFLength;
        ETChart.Title.Text.Text := StrFocalLength;
        ETChart.AddSeries(ETBarSeriesFocal);
      end;
    1:
      begin
        ETChart.LeftAxis.Maximum := ChartMaxFNumber;
        ETChart.Title.Text.Text := StrFNumber;
        ETChart.AddSeries(ETBarSeriesFnum);
      end;
    2:
      begin
        ETChart.LeftAxis.Maximum := ChartMaxISO;
        ETChart.Title.Text.Text := StrISO;
        ETChart.AddSeries(ETBarSeriesIso);
      end;
  end;

  if (ETChart.LeftAxis.Maximum < 5) then
    ETChart.LeftAxis.Maximum := 5;
  LeftInc := ETChart.LeftAxis.CalcIncrement;
  if (LeftInc < 1) then
    LeftInc := 1;
  ETChart.LeftAxis.Increment := LeftInc;
end;

procedure TFMain.BtnColumnEditClick(Sender: TObject);
begin
  if FEditFColumn.ShowModal = mrOK then
    with ShellList do
    begin
      Refresh;
      SetFocus;
    end;
  ShowMetadata;
end;

procedure TFMain.BtnETdirectAddClick(Sender: TObject);
begin
  EditETdirect.Text := trim(EditETdirect.Text);
  ETdirectCmd.Append(EditETdirect.Text); // store command
  EditETcmdName.Text := trim(EditETcmdName.Text);
  CBoxETdirect.ItemIndex := CBoxETdirect.Items.Add(EditETcmdName.Text);
  // store name
  CBoxETdirectChange(Sender);
end;

procedure TFMain.BtnETdirectDelClick(Sender: TObject);
var
  i: smallint;
begin
  i := CBoxETdirect.ItemIndex;
  CBoxETdirect.ItemIndex := -1;
  ETdirectCmd.Delete(i);
  CBoxETdirect.Items.Delete(i);
  EditETcmdName.Text := '';
  EditETcmdName.Modified := false;
  EditETdirect.Modified := true;
  CBoxETdirectChange(Sender);
end;

procedure TFMain.BtnETdirectReplaceClick(Sender: TObject);
var
  i: smallint;
begin
  i := CBoxETdirect.ItemIndex;
  CBoxETdirect.ItemIndex := -1;
  EditETdirect.Text := trim(EditETdirect.Text);
  ETdirectCmd[i] := EditETdirect.Text;
  EditETcmdName.Text := trim(EditETcmdName.Text);
  CBoxETdirect.Items[i] := EditETcmdName.Text;
  CBoxETdirect.ItemIndex := i;
  CBoxETdirectChange(Sender);
end;

procedure TFMain.BtnFilterEditClick(Sender: TObject);
var
  i, n, X: smallint;
begin
  if FEditFFilter.ShowModal = mrOK then
    with CBoxFileFilter do
    begin
      X := ItemIndex;
      OnChange := nil;
      i := FEditFFilter.ListBox1.Items.Count - 1;
      Items.Clear;
      for n := 0 to i do
        Items.Append(FEditFFilter.ListBox1.Items[n]);
      OnChange := CBoxFileFilterChange;
      ItemIndex := 0;
      if X <> 0 then
        CBoxFileFilterChange(Sender);
    end;
end;

procedure TFMain.BtnFListRefreshClick(Sender: TObject);
begin
  ShellList.Refresh; // -use this (to be sure)
  ShellList.SetFocus;
end;

procedure TFMain.BtnQuickSaveClick(Sender: TObject);
var
  I, J, K: integer;
  SavedRow: integer;
  ETcmd, TagValue, Tx: string;
  ETout, ETerr: string;
begin
  if (SpeedBtnQuickSave.Enabled = false) then // If called from CTRL+S from metadatalist
    exit;

  SavedRow := MetadataList.Row;
  SpeedBtnQuickSave.Enabled := false;
  ETcmd := '';
  J := MetadataList.RowCount - 1;
  for I := 1 to J do
  begin
    if pos('*', MetadataList.Keys[I]) = 1 then
    begin
      TagValue := MetadataList.Cells[1, I];

      Tx := MetadataList.Keys[I];
      K := pos(#177, Tx); // is it multi-value tag?
      if (K = 0) or
         (TagValue = '') then
      begin // no: standard tag
        K := 0;
        if RightStr(Tx, 1) = '#' then
          Inc(K);
        Tx := LowerCase(QuickTags[I - 1].Command);
        if K > 0 then
        begin
          if RightStr(Tx, 1) <> '#' then
            Tx := Tx + '#';
        end;
        ETcmd := ETcmd + Tx + '=' + TagValue + CRLF;
      end
      else
      begin // it is multi-value tag (ie.keywords)
        repeat
          ETcmd := ETcmd + QuickTags[I - 1].Command;
          case TagValue[1] of
            '+':
              begin
                ETcmd := ETcmd + '+=';
                Delete(TagValue, 1, 1);
              end;
            '-':
              begin
                ETcmd := ETcmd + '-=';
                Delete(TagValue, 1, 1);
              end;
          else
            ETcmd := ETcmd + '=';
          end;
          K := pos('+', TagValue);
          if K > 0 then
            Tx := Copy(TagValue, 1, K - 1)
          else
          begin
            K := pos('-', TagValue);
            if K > 0 then
              Tx := Copy(TagValue, 1, K - 1)
            else
              Tx := TagValue;
          end;
          if K > 0 then
            Delete(TagValue, 1, K - 1)
          else
            TagValue := '';
          ETcmd := ETcmd + Tx + CRLF;
        until Length(TagValue) = 0;
      end;
    end;
  end;

  if (ET_OpenExec(ETcmd, GetSelectedFiles, ETout, ETerr)) then
  begin
    RefreshSelected(Sender);
    ShowMetadata;
    ShowPreview;
  end;
  MetadataList.SetFocus;
  Metadatalist.Row := SavedRow;
end;

procedure TFMain.BtnShowLogClick(Sender: TObject);
begin
  FLogWin.Show;
end;

procedure TFMain.CBoxDetailsChange(Sender: TObject);
begin
  with CBoxDetails do
    SpeedBtnColumnEdit.Enabled := SpeedBtnDetails.Down and (ItemIndex = Items.Count - 1);

  with ShellList do
  if (Enabled) then
  begin
    Refresh;
    ShowMetadata;
    ShowPreview;
    SetFocus;
  end;
end;

procedure TFMain.GenericExtractPreviewsClick(Sender: TObject);
begin
  if FGenericExtract.ShowModal = mrOK then
  begin
    RefreshSelected(Sender);
    ShowMetadata;
    ShowPreview;
  end;
end;

procedure TFMain.GenericImportPreviewClick(Sender: TObject);
begin
  if FGenericImport.ShowModal = mrOK then
  begin
    RefreshSelected(Sender);
    ShowMetadata;
    ShowPreview;
  end;
end;

function TFMain.GetFirstSelectedFile: string;
begin
  result := '';
  if (ShellList.Selected <> nil) then
    result := ShellList.FileName + CRLF
  else if (ShellList.Items.Count > 0) then
    result := ShellList.FileName(0) + CRLF;
end;

function TFMain.GetFirstSelectedFilePath: string;
begin
  result := '';
  if (ShellList.Selected <> nil) then
    result := ShellList.FilePath
  else if (ShellList.Items.Count > 0) then
    result := ShellList.FilePath(0);
end;

function TFMain.GetFullPath(MustExpandPath: boolean): string;
begin
  result := '';
  if (MustExpandPath) then
    result := IncludeTrailingBackslash(ShellList.Path);
end;

function TFMain.GetSelectedFile(FileName: string; MustExpandPath: boolean): string;
begin
  if (FileName = '') then
    result := ''
  else
    result := GetFullPath(MustExpandPath) + FileName;
end;

function TFMain.GetSelectedFile(FileName: string): string;
begin
  result := GetSelectedFile(FileName, ET_Options.ETAPIWindowsWideFile = '');
end;

function TFMain.GetSelectedFiles(MustExpandPath: boolean): string;
var
  AnItem: TListItem;
  FullPath: string;
begin
  result := '';
  FullPath := GetFullPath(MustExpandPath);
  for AnItem in ShellList.Items do
  begin
    if (AnItem.Selected) and
       (ShellList.Folders[AnItem.Index].IsFolder = false) then
      result := result + FullPath +ShellList.FileName(AnItem.Index) + CRLF;
  end;
end;

function TFMain.GetSelectedFiles: string;
begin
  result := GetSelectedFiles(ET_Options.ETAPIWindowsWideFile = '');
end;

procedure TFMain.EditMapFindKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_Return) and
     (EditMapFind.Text <> '') then
    EditMapFind.Text := MapGotoPlace(EdgeBrowser1, EditMapFind.Text, EditMapBounds.Text, '', InitialZoom_Out);
end;

procedure TFMain.MGUIStyleClick(Sender: TObject);
begin
  ShellTree.SetFocus;
  with FrmStyle do
  begin
    CurPath := ShellList.Path;
    CurStyle := GUIsettings.GuiStyle;
    Show;
  end;
end;

procedure TFMain.MAboutClick(Sender: TObject);
begin
  FrmAbout.ShowModal;
end;

procedure TFMain.MAPIWindowsWideFileClick(Sender: TObject);
begin
  with ET_Options do
    SetApiWindowsWideFile(MaAPIWindowsWideFile.Checked);
end;

procedure TFMain.MaAPILargeFileSupportExecute(Sender: TObject);
begin
  with ET_Options do
    SetApiLargeFileSupport(MaAPILargeFileSupport.Checked);
end;

procedure TFMain.MDontBackupClick(Sender: TObject);
begin
  with ET_Options do
    if MaDontBackup.Checked then
      ETBackupMode := '-overwrite_original' + CRLF
    else
      ETBackupMode := '';
end;

procedure TFMain.MetadataListDblClick(Sender: TObject);
var
  tx: string;
  IsSep: boolean;
begin
  if (GUIsettings.DblClickUpdTags = false) then
    exit;

  tx := MetadataList.Keys[MetadataList.Row];
  IsSep := (length(tx) = 0);
  if (IsSep) then
    exit;

  if SpeedBtnQuick.Down then
    QuickPopUp_DelQuickClick(Sender)
  else
    QuickPopUp_AddQuickClick(Sender);
end;

procedure TFMain.MetadataListDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
  CellTx, KeyTx, WorkTx: string[127];
  NewColor, TxtColor: TColor;
  i, n, X: smallint;
begin
  n := length(QuickTags) - 1;
  if (ARow > 0) then
    with MetadataList do
    begin
      CellTx := Cells[ACol, ARow];
      KeyTx := Cells[0, ARow];
      if (KeyTx = '') then
        with Canvas do
        begin // =Group line
          Brush.Style := bsSolid;
          if ACol = 0 then
          begin
            Brush.Color := clWindow; // $F0F0F0;
            FillRect(Rect);
          end
          else
          begin // ACol=1
            Brush.Color := clWindow;
            Font.Style := [fsBold];
            Font.Color := clWindowText;
            TextRect(Rect, Rect.Left + 4, Rect.Top + 2, CellTx);
          end;
        end
      else if (ACol = 0) then
      begin // -remove "if ACol=0 then" to change both columns
        NewColor := clWindow;
        if SpeedBtnQuick.Down then
        begin // =Edited tag
          if (KeyTx[1] = '*') then
            NewColor := $BBFFFF;
          if NewColor <> clWindow then
            with Canvas do
            begin
              Brush.Style := bsSolid;
              Brush.Color := NewColor;
              Font.Color := $BB0000;
              TextRect(Rect, Rect.Left + 4, Rect.Top + 2, CellTx);
            end;
        end
        else
        begin
          if GUIsettings.Language = '' then
          begin // =Marked tag
            Delete(KeyTx, 1, pos(' ', KeyTx)); // -in case of Show HexID prefix
            TxtColor := clWindowText;
            if pos(KeyTx + ' ', MarkedTags) > 0 then
              TxtColor := $0000FF; // tag is marked
            // check if tag is defined in Workspace
            KeyTx := UpperCase(KeyTx);
            for i := 0 to n do
            begin
              WorkTx := UpperCase(QuickTags[i].Command);
              X := pos(':', WorkTx);
              if X > 0 then
                Delete(WorkTx, 1, X);
              if KeyTx = WorkTx then
              begin
                NewColor := $EEFFDD;
                break;
              end;
            end;
            if (NewColor <> clWindow) or (TxtColor <> clWindowText) then
              with Canvas do
              begin
                Brush.Style := bsSolid;
                Brush.Color := NewColor;
                Font.Color := TxtColor;
                TextRect(Rect, Rect.Left + 4, Rect.Top + 2, CellTx);
              end;
          end;
        end;
      end;
    end;
end;

procedure TFMain.MetadataListExit(Sender: TObject);
begin // remember last selected row
  if SpeedBtnQuick.Down then
    MetadataList.Tag := MetadataList.Row;
end;

procedure TFMain.MetadataListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  I: integer;
begin
  I := MetadataList.Row;
  if (Key = VK_Return) and SpeedBtnQuick.Down and not(QuickTags[I - 1].NoEdit) then
  begin
    if SpeedBtnLarge.Down then
      MemoQuick.SetFocus
    else
      EditQuick.SetFocus;
  end;
end;

// Event handler for CTRL Keydown.
// Allows intercepting CTRL/VK_UP CTRL/VK_DOWN
procedure TFMain.MetadataListCtrlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  function CheckIndex(var Indx: integer): boolean;
  begin
    result := (ShellList.Items.Count > 0);
    if (Indx < 0) then
      Indx := 0;
    if (Indx > ShellList.Items.Count -1) then
      Indx := ShellList.Items.Count -1;
  end;

  procedure SelectPrevNext(const Down: boolean);
  var
    Old: integer;
    New: integer;
    MetaDataRow: integer;
  begin
    // Save MetaData Row
    MetaDataRow := MetadataList.Row;

    // Current
    if Assigned(ShellList.Selected) then
      Old := ShellList.Selected.Index
    else
      Old := ShellList.ItemIndex;
    if not CheckIndex(Old) then
      exit;

    If (Down) then
      New := Old + 1
    else
      New := Old - 1;
    if (New < 0) then
      New := 0;
    if not CheckIndex(New) then
      exit;

    // Select only then item, and make that visible
    ShellList.ClearSelection;
    ShellList.Items[New].Selected := true;
    ShellList.Items[New].MakeVisible(false);

    // Simulate a click on the new item, will load Metadata etc.
    ShellListClick(ShellList);

    // Focus back on original Metadata Row
    MetadataList.SetFocus;
    if (MetadataList.RowCount >= MetaDataRow) then
      MetadataList.Row := MetaDataRow;
  end;

begin
  case Key of
    Ord('C'):
      Clipboard.AsText := MetadataList.Cells[1, MetadataList.Row];
    Ord('S'):
      BtnQuickSaveClick(Sender);
    VK_UP, VK_DOWN:
      begin
        SelectPrevNext(Key = VK_DOWN);
        Key := 0; // Dont want the inherited code. Scrolls to begin/end of Metadatalist
      end;
    end;
end;


procedure TFMain.MetadataListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  XCol, XRow: integer;
begin
  if Button = mbRight then
    with MetadataList do
    begin
      MouseToCell(X, Y, XCol, XRow);
      Row := XRow;
    end;
end;

procedure TFMain.MetadataListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: integer;
begin
  TValueListEditor(Sender).MouseToCell(X, Y, ACol, ARow);
  if (ARow >= 1) and
     (ARow <= TValueListEditor(Sender).RowCount) and
     (TValueListEditor(Sender).Tag <> ARow) then  // Hint already shown?
  begin
    TValueListEditor(Sender).Tag := ARow;         // Remember the row that has the hint.

    Hint := TValueListEditor(Sender).Cells[1, ARow];
    Application.ActivateHint(TValueListEditor(Sender).ClientToScreen(Point(X, Y))); // Force hint display
  end;
end;

procedure TFMain.MetadataListSelectCell(Sender: TObject; ACol, ARow: integer; var CanSelect: boolean);
var EditText: string;
begin

  EditQuick.Text := '';
  MemoQuick.Text := '';
  if (ARow - 1 > High(QuickTags)) then
    exit;
  if SpeedBtnQuick.Down and
     not(QuickTags[ARow - 1].NoEdit) then
  begin
    if RightStr(TValueListEditor(Sender).Keys[ARow], 1) = #177 then
      EditText := '+'
    else
      EditText := TValueListEditor(Sender).Cells[1, ARow];
    if SpeedBtnLarge.Down then
      MemoQuick.Text := EditText
    else
      EditQuick.Text := EditText;
  end;
end;

procedure TFMain.MExifDateTimeEqualizeClick(Sender: TObject);
begin
  if FDateTimeEqual.ShowModal = mrOK then
  begin
    RefreshSelected(Sender);
    ShowMetadata;
  end;
end;

procedure TFMain.MExifDateTimeshiftClick(Sender: TObject);
begin
  if FDateTimeShift.ShowModal = mrOK then
  begin
    RefreshSelected(Sender);
    ShowMetadata;
  end;
end;

procedure TFMain.MExifLensFromMakerClick(Sender: TObject);
var
  ETcmd, ETout, ETerr: string;
begin
  if MessageDlg(StrThisWillFillExif1 + #10 +
                StrThisWillFillExif2 + #10#10 +
                StrOKToProceed, mtInformation, [mbOk, mbCancel], 0) = mrOK then
  begin
    ETcmd := '-Exif:LensInfo<LensID' + CRLF + '-Exif:LensModel<LensID' + CRLF;
    ET_OpenExec(ETcmd, GetSelectedFiles, ETout, ETerr);
    RefreshSelected(Sender);
    ShowMetadata;
  end;
end;

procedure TFMain.MExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFMain.MExportMetaTXTClick(Sender: TObject);
var
  i: smallint;
  ETcmd, xDir, ETout, ETerr: string;
begin
  xDir := '';
  if GUIsettings.DefExportUse then
  begin
    xDir := GUIsettings.DefExportDir;
    i := length(xDir);
    if i > 0 then
      if xDir[i] <> '\' then
        xDir := xDir + '\';
  end;

  if Sender = MaExportMetaTXT then
    ETcmd := '-w' + CRLF + xDir + '%f.txt' + CRLF + '-g0' + CRLF + '-a' + CRLF + '-All:All';
  if Sender = MaExportMetaMIE then
    ETcmd := '-o' + CRLF + xDir + '%f.mie' + CRLF + '-All:All';
  if Sender = MaExportMetaXMP then
    ETcmd := '-o' + CRLF + xDir + '%f.xmp' + CRLF + '-Xmp:All';
  if Sender = MaExportMetaEXIF then
    ETcmd := '-TagsFromFile' + CRLF + '@' + CRLF + '-All:All' + CRLF + '-o' + CRLF + '%f.exif';
  if Sender = MaExportMetaHTML then
    ETcmd := '-w' + CRLF + xDir + '%f.html' + CRLF + '-htmldump';

  ET_OpenExec(ETcmd, GetSelectedFiles, ETout, ETerr);
  if xDir = '' then
    BtnFListRefreshClick(Sender);
end;

procedure TFMain.MFileDateFromExifClick(Sender: TObject);
var
  ETout, ETerr: string;
begin
  if MessageDlg(FileDateFromExif1 + #10 +
                FileDateFromExif2 + #10#10 +
                StrOKToProceed, mtInformation, [mbOk, mbCancel], 0) = mrOK then
  begin
    ET_OpenExec('-FileModifyDate<Exif:DateTimeOriginal', GetSelectedFiles, ETout, ETerr);
    RefreshSelected(Sender);
    ShowMetadata;
    ShowPreview;
  end;
end;

procedure TFMain.MFileNameDateTimeClick(Sender: TObject);
begin
  FFileDateTime.ShowModal;
end;

procedure TFMain.MIgnoreErrorsClick(Sender: TObject);
begin
  with ET_Options do
    if MaIgnoreErrors.Checked then
      ETMinorError := '-m' + CRLF
    else
      ET_Options.ETMinorError := '';
end;

procedure TFMain.MImportMetaSelectedClick(Sender: TObject);
var
  DstExt: string[7];
  ETcmd, ETout, ETerr: string;
  j: smallint;
begin
  // if Sender=MImportMetaIntoJPG then DstExt:='JPG' else DstExt:='TIF';
  DstExt := UpperCase(ExtractFileExt(ShellList.SelectedFolder.PathName));
  Delete(DstExt, 1, 1);

  if (DstExt = 'JPG') or (DstExt = 'TIF') then
  begin
    j := ShellList.SelCount;
    if j > 1 then // message appears only if multi files selected
      if MessageDlg(ImportMetaSel1 + #10 +
                    Format(ImportMetaSel2, [DstExt]) + #10 +
                    ImportMetaSel3 + #10 +
                    ImportMetaSel4 + #10#10 +
                    ImportMetaSel5 + #10 +
                    StrOKToProceed,
                    mtInformation, [mbOk, mbCancel], 0) <> mrOK then
        j := 0;
    if j <> 0 then
    begin
      with OpenPictureDlg do
      begin
        InitialDir := ShellList.Path;
        Filter := 'Image & Metadata files|*.*';
        Options := [ofFileMustExist];
        Title := 'Select any of source files';
        FileName := '';
      end;
      if OpenPictureDlg.Execute then
      begin
        ETcmd := OpenPictureDlg.FileName; // single file selected
        if j > 1 then
          ETcmd := ExtractFileDir(ETcmd) + '\%f' + ExtractFileExt(ETcmd);
        // multiple files
        ETcmd := '-TagsFromFile' + CRLF + ETcmd + CRLF + '-All:All' + CRLF;
        if FCopyMetadata.ShowModal = mrOK then
        begin
          with FCopyMetadata do
          begin
            if not CheckBox1.Checked then
              ETcmd := ETcmd + '--exif:ExifImageWidth' + CRLF + '--exif:ExifImageHeight' + CRLF;
            if not CheckBox2.Checked then
              ETcmd := ETcmd + '--exif:Orientation' + CRLF;
            if not CheckBox3.Checked then
              ETcmd := ETcmd + '--exif:Xresolution' + CRLF + '--exif:Yresolution' + CRLF + '--exif:ResolutionUnit' + CRLF;
            if not CheckBox4.Checked then
              ETcmd := ETcmd + '--exif:ColorSpace' + CRLF + '--exif:InteropIndex' + CRLF;
            if not CheckBox5.Checked then
              ETcmd := ETcmd + '--Makernotes' + CRLF;
            if not CheckBox6.Checked then
              ETcmd := ETcmd + '--Xmp-photoshop' + CRLF;
            if not CheckBox7.Checked then
              ETcmd := ETcmd + '--Xmp-crs' + CRLF;
            if not CheckBox8.Checked then
              ETcmd := ETcmd + '--Xmp-exif' + CRLF;
          end;
          ETcmd := ETcmd + '-ext' + CRLF + DstExt;
          if (ET_OpenExec(ETcmd, GetSelectedFiles, ETout, ETerr)) then
          begin
            RefreshSelected(Sender);
            ShowMetadata;
          end;
        end;
      end;
    end;
  end
  else
    ShowMessage(StrSelectedDestination);
end;

procedure TFMain.MImportMetaSingleClick(Sender: TObject);
begin
  if MessageDlg(ImportMetaSingle1 + #10 +
                ImportMetaSingle2 + #10#10 +
                ImportMetaSingle3 + #10 +
                StrOKToProceed, mtInformation, [mbOk, mbCancel], 0) = mrOK then
  begin
    with OpenPictureDlg do
    begin
      InitialDir := ShellList.Path;
      Filter := 'Image & Metadata files|*.jpg;*.jpeg;*.cr2;*.dng;*.nef;*.tif;*.tiff;*.mie;*.xmp;*.rw2';
      Options := [ofFileMustExist];
      Title := StrSelectSourceFile;
      FileName := '';
    end;
    if OpenPictureDlg.Execute then
    begin
      FCopyMetaSingle.SrcFile := OpenPictureDlg.FileName;
      if FCopyMetaSingle.ShowModal = mrOK then
      begin
        RefreshSelected(Sender);
        ShowMetadata;
      end;
    end;
  end;
end;

procedure TFMain.MImportRecursiveAllClick(Sender: TObject);
var
  i: integer;
  DstExt: string[5];
  ETcmd, ETout, ETerr: string;
begin
  DstExt := LowerCase(ShellList.FileExt);
  Delete(DstExt, 1, 1);
  if (DstExt = 'jpg') or (DstExt = 'tif') then
  begin
    i := MessageDlg(ImportRecursive1 + #10 +
                    Format(ImportRecursive2, [UpperCase(DstExt)]) + #10 +
                    ImportRecursive3 + #10 +
                    ImportRecursive4 + #10#10 +
                    ImportRecursive5, mtInformation,
                    [mbYes, mbNo, mbCancel], 0);
    if i <> mrCancel then
    begin
      with OpenPictureDlg do
      begin
        InitialDir := ShellList.Path;
        Filter := 'Image & Metadata files|*.*';
        Options := [ofFileMustExist];
        Title := StrSelectAnyOfSource;
        FileName := '';
      end;
      if OpenPictureDlg.Execute then
      begin
        ETcmd := '-TagsFromFile' + CRLF + ExtractFilePath(OpenPictureDlg.FileName); // incl. slash
        if i = mrYes then
          ETcmd := ETcmd + '%d\';
        ETcmd := ETcmd + '%f' + ExtractFileExt(OpenPictureDlg.FileName);
        if i = mrYes then
          ETcmd := ETcmd + CRLF + '-r';
        ETcmd := ETcmd + CRLF + '-All:All' + CRLF;
        if FCopyMetadata.ShowModal = mrOK then
        begin
          with FCopyMetadata do
          begin
            if not CheckBox1.Checked then
              ETcmd := ETcmd + '--exif:ExifImageWidth' + CRLF + '--exif:ExifImageHeight' + CRLF;
            if not CheckBox2.Checked then
              ETcmd := ETcmd + '--exif:Orientation' + CRLF;
            if not CheckBox3.Checked then
              ETcmd := ETcmd + '--exif:Xresolution' + CRLF + '--exif:Yresolution' + CRLF + '--exif:ResolutionUnit' + CRLF;
            if not CheckBox4.Checked then
              ETcmd := ETcmd + '--exif:ColorSpace' + CRLF + '--exif:InteropIndex' + CRLF;
            if not CheckBox5.Checked then
              ETcmd := ETcmd + '--Makernotes' + CRLF;
            if not CheckBox6.Checked then
              ETcmd := ETcmd + '--Xmp-photoshop' + CRLF;
            if not CheckBox7.Checked then
              ETcmd := ETcmd + '--Xmp-crs' + CRLF;
            if not CheckBox8.Checked then
              ETcmd := ETcmd + '--Xmp-exif' + CRLF;
          end;
          ETcmd := ETcmd + '-ext' + CRLF + DstExt;
          SetCounter(CounterETEvent, GetNrOfFiles(ShellList.Path, '*.' + DstExt, (i = mrYes)));
          if (ET_OpenExec(ETcmd, '.', ETout, ETerr)) then
          begin
            RefreshSelected(Sender);
            ShowMetadata;
          end;
        end;
      end;
    end;
  end
  else
    ShowMessage(StrSelectedDestination);
end;

procedure TFMain.MImportXMPLogClick(Sender: TObject);
var
  SrcDir, ETcmd, ETout, ETerr: string;
begin
  if MessageDlg(ImportXMP1 + #10+
                ImportXMP2 + #10 +
                ImportXMP3 + #10 +
                ImportXMP4 + #10#10 +
                ImportXMP5 + #10#10 +
                StrOKToProceed,
                mtInformation, [mbOk, mbCancel], 0) = mrOK then
  begin
    if GpsXmpDir <> '' then
      SrcDir := GpsXmpDir
    else
      SrcDir := ShellList.Path;
    SrcDir := BrowseFolderDlg(StrChooseFolderContai, 1, SrcDir);
    if SrcDir <> '' then
    begin
      if SrcDir[length(SrcDir)] <> '\' then
        SrcDir := SrcDir + '\';
      GpsXmpDir := SrcDir;
      ETcmd := '-TagsFromFile' + CRLF + SrcDir + '%f.xmp' + CRLF;
      ETcmd := ETcmd + '-GPS:GPSLatitude<Xmp-exif:GPSLatitude' + CRLF + '-GPS:GPSLongitude<Xmp-exif:GPSLongitude' + CRLF;
      ETcmd := ETcmd + '-GPS:GPSLatitudeRef<Composite:GPSLatitudeRef' + CRLF + '-GPS:GPSLongitudeRef<Composite:GPSLongitudeRef' + CRLF;
      ETcmd := ETcmd + '-GPS:GPSDateStamp<XMP-exif:GPSDateTime' + CRLF + '-GPS:GPSTimeStamp<XMP-exif:GPSDateTime';
      if (ET_OpenExec(ETcmd, GetSelectedFiles, ETout, ETerr)) then
      begin
        RefreshSelected(Sender);
        ShowMetadata;
      end;
    end;
  end;
end;

procedure TFMain.JPGGenericlosslessautorotate1Click(Sender: TObject);
begin
  if FLossLessRotate.ShowModal = mrOK then
  begin
    RefreshSelected(Sender);
    ShowMetadata;
    ShowPreview;
  end;
end;

procedure TFMain.MImportGPSLogClick(Sender: TObject);
begin
  if FGeotag.ShowModal = mrOK then
  begin
    RefreshSelected(Sender);
    ShowMetadata;
  end;
end;

procedure TFMain.MPreferencesClick(Sender: TObject);
begin
  if FPreferences.ShowModal = mrOK then
  begin
    EnableMenus(ET_StayOpen(ShellList.Path)); // Recheck Exiftool.exe.
    ShellListSetFolders;
    ShellList.Refresh;
    ShowMetadata;
  end;
end;

procedure TFMain.MPreserveDateModClick(Sender: TObject);
begin
  with ET_Options do
    if MaPreserveDateMod.Checked then
      ETFileDate := '-P' + CRLF
    else
      ETFileDate := '';
end;

procedure TFMain.MQuickManagerClick(Sender: TObject);
var
  Indx: smallint;
begin
  if FQuickManager.ShowModal = mrOK then
  begin
    Indx := FQuickManager.StringGrid1.Row;
    if SpeedBtnQuick.Down then
    begin
      ShowMetadata;
      if ShellList.ItemIndex >= 0 then
        MetadataList.Row := Indx + 1;
    end;
  end;
end;

procedure TFMain.MRemoveMetaClick(Sender: TObject);
begin
  if FRemoveMeta.ShowModal = mrOK then
    ShowMetadata;
end;

procedure TFMain.MShowNumbersClick(Sender: TObject);
begin
  if Sender = MaShowNumbers then
    with ET_Options do
      if MaShowNumbers.Checked then
        ETShowNumber := '-n' + CRLF
      else
        ETShowNumber := '';
  if Sender = MaShowGPSdecimal then
    ET_Options.SetGpsFormat(MaShowGPSdecimal.Checked); // + used by MaShowHexID, MaGroup_g4, MaShowComposite, MaShowSorted, MaNotDuplicated
  RefreshSelected(Sender);
  ShowMetadata;
end;

procedure TFMain.MCustomOptionsClick(Sender: TObject);
begin
  ET_Options.ETCustomOptions := InputBox(StrSpecifyCustomOptio,
                                         StrCustomOptions,
                                         ET_Options.ETCustomOptions);
end;

procedure TFMain.MWorkspaceLoadClick(Sender: TObject);
begin
  with OpenFileDlg do
  begin
    // DefaultExt:='ini';
    InitialDir := WrkIniDir;
    Filter := 'Ini file|*.ini';
    Title := StrLoadWorkspaceDefin;
    if Execute then
    begin
      if LoadWorkspaceIni(FileName) then
      begin
        if SpeedBtnQuick.Down then
          ShowMetadata
        else
          ShowMessage(StrNewWorkspaceLoaded);
      end
      else
        ShowMessage(StrIniFileDoesntCon);
      WrkIniDir := ExtractFileDir(FileName);
    end;
  end;
end;

procedure TFMain.MWorkspaceSaveClick(Sender: TObject);
var
  DoSave, IsOK: boolean;
begin
  with SaveFileDlg do
  begin
    DefaultExt := 'ini';
    InitialDir := WrkIniDir;
    Filter := 'Ini file|*.ini';
    Title := StrSaveWorkspaceDefini;
    repeat
      IsOK := false;
      DoSave := Execute;
      InitialDir := ExtractFileDir(FileName);
      if DoSave then
      begin
        IsOK := (ExtractFileName(FileName) <> ExtractFileName(GetIniFilePath(false)));
        if not IsOK then
          ShowMessage(StrUseAnotherNameFor);
      end;
    until not DoSave or IsOK;
    if DoSave then
    begin
      if SaveWorkspaceIni(FileName) then
        ShowMessage(StrWorkspaceDefinition)
      else
        ShowMessage(StrWorkspaceDefNotSaved);
      WrkIniDir := ExtractFileDir(FileName);
    end;
  end;
end;

procedure TFMain.OnlineDocumentation1Click(Sender: TObject);
begin
  ShellExecute(0, 'Open', PWideChar(ONLINE_DOC_URL), '', '', SW_SHOWNORMAL);
end;

procedure TFMain.QuickPopUpMenuPopup(Sender: TObject);
var
  i: smallint;
  IsSep, Other: boolean;
  tx: string;
begin
  i := MetadataList.Row;
  tx := MetadataList.Keys[i];
  QuickPopUp_UndoEditAct.Visible := (pos('*', tx) = 1);
  IsSep := (length(tx) = 0);

  QuickPopUp_AddQuickAct.Visible := not(SpeedBtnQuick.Down or SpeedBtnCustom.Down or IsSep);
  QuickPopUp_AddCustomAct.Visible := not(SpeedBtnQuick.Down or SpeedBtnCustom.Down or IsSep);
  QuickPopUp_DelCustomAct.Visible := SpeedBtnCustom.Down and not(IsSep);
  QuickPopUp_AddDetailsUserAct.Visible := not IsSep and (SpeedBtnExif.Down or SpeedBtnXmp.Down or SpeedBtnIptc.Down);

  Other := (GUIsettings.Language <> '') or IsSep;

  QuickPopUp_MarkTagAct.Visible := not(SpeedBtnQuick.Down or SpeedBtnCustom.Down or Other);

  QuickPopUp_DelQuickAct.Visible := not(IsSep) and SpeedBtnQuick.Down;
  QuickPopUp_FillQuickAct.Visible := QuickPopUp_DelQuickAct.Visible;
  QuickPopUp_CopyTagAct.Visible := not IsSep;
end;

procedure TFMain.TaskbarThumbButtonClick(Sender: TObject; AButtonID: Integer);
begin
  case (AButtonID) of
    0: Tray_ResetwindowsizeClick(Sender);
  end;
end;

function TFMain.TranslateTagName(xMeta, xName: string): string;
var
  Indx: integer; // xMeta~'-Exif:' or '-IFD0:' or ...
  ETout: TStringList;
begin
  ETout := TStringList.Create;
  try
    if ET_Options.ETLangDef <> '' then
    begin
      ET_OpenExec('-X' + CRLF + '-l' + CRLF + xMeta + 'All', GetSelectedFile(ShellList.FileName), ETout);
      Indx := ETout.Count;
      while Indx > 1 do
      begin
        dec(Indx);
        if pos('desc>' + xName + '</et:', ETout[Indx]) > 0 then
          break;
      end;
      dec(Indx);
      if Indx >= 0 then
      begin
        xName := ETout[Indx];
        Indx := pos(':', xName);
        Delete(xName, 1, Indx);
        Indx := pos(' ', xName);
        SetLength(xName, Indx - 1);
      end;
    end;
    result := xName;
  finally
    ETout.Free;
  end;
end;

procedure TFMain.RestoreGUI;
begin
  Application.Restore;
  Application.BringToFront;
  Show;

  TrayIcon.Visible := false;
end;

procedure TFMain.TrayIconBalloonClick(Sender: TObject);
begin
  GUIsettings.ShowBalloon := false;
end;

procedure TFMain.TrayIconMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = TMouseButton.mbRight) then
    TrayPopupMenu.Popup(X, Y)
  else
    RestoreGUI;
end;

procedure TFMain.TrayPopupMenuPopup(Sender: TObject);
begin
  Tray_ExifToolGui.Caption := TrayIcon.Hint;
end;

procedure TFMain.QuickPopUp_AddCustomClick(Sender: TObject);
var
  i: smallint;
  tx, ts: string;
  IsVRD: boolean;
begin
  i := MetadataList.Row;
  tx := MetadataList.Keys[i];
  if LeftStr(tx, 2) = '0x' then
    Delete(tx, 1, 7)
  else if LeftStr(tx, 2) = '- ' then
    Delete(tx, 1, 2);
  tx := TrimRight(tx);
  if SpeedBtnExif.Down then
    ts := '-Exif:'
  else if SpeedBtnXmp.Down then
    ts := '-Xmp:'
  else if SpeedBtnIptc.Down then
    ts := '-Iptc:'
  else if SpeedBtnMaker.Down then
  begin
    repeat
      dec(i);
      IsVRD := (pos('CanonVRD', MetadataList.Cells[1, i]) > 0);
    until IsVRD or (i = 0);
    if IsVRD then
      ts := '-CanonVRD:'
    else
      ts := '-Makernotes:';
  end
  else
    ts := '-';
  tx := ts + TranslateTagName(ts, tx);
  if pos(tx, CustomViewTags) > 0 then
    ShowMessage(StrTagAlreadyExistsI)
  else
    CustomViewTags := CustomViewTags + tx + ' ';
end;

procedure TFMain.QuickPopUp_AddDetailsUserClick(Sender: TObject);
var
  I, N, X: smallint;
  Tx, Tk: string;
begin
  I := length(FListColUsr);
  SetLength(FListColUsr, I + 1);
  N := MetadataList.Row;
  X := N;
  repeat // find group
    Dec(X);
    Tx := MetadataList.Keys[X];
  until length(Tx) = 0;
  Tx := MetadataList.Cells[1, X];     // eg '---- IFD0 ----'
  Delete(Tx, 1, 5);                   // ='IFD0 ----'
  X := pos(' ', Tx);
  SetLength(Tx, X - 1);               // ='IFD0'
  Tx := '-' + Tx + ':';               // ='-IFD0:'

  Tk := MetadataList.Keys[N];         // 'Make'
  if LeftStr(Tk, 2) = '0x' then
    Delete(Tk, 1, 7)
  else if LeftStr(Tk, 2) = '- ' then
    Delete(Tk, 1, 2);
  Tk := TrimRight(Tk);

  FListColUsr[I].Caption := Tk;
  Tk := TranslateTagName(Tx, Tk);
  FListColUsr[I].Command := Tx + Tk;  // ='-IFD0:Make'
  FListColUsr[I].Width := 96;
  FListColUsr[I].AlignR := 0;

  with CBoxDetails do
  begin
    I := ItemIndex;
    N := Items.Count - 1;
  end;
  if I = N then
    ShellList.Refresh;
end;

procedure TFMain.QuickPopUp_AddQuickClick(Sender: TObject);
var
  I, N, X: smallint;
  Tx, Ty, Tz, T1: string;
  CrWait, CrNormal: HCURSOR;
begin
  CrWait := LoadCursor(0, IDC_WAIT);
  CrNormal := SetCursor(CrWait);
  try
    I := Length(QuickTags);
    SetLength(QuickTags, I + 1);
    N := MetadataList.Row;
    if SpeedBtnExif.Down then
      Tz := 'Exif:'
    else if SpeedBtnXmp.Down then
      Tz := 'Xmp:'
    else if SpeedBtnIptc.Down then
      Tz := 'Iptc:'
    else
      Tz := '';

    if MaGroup_g4.Checked then
      Tx := Tz
    else
    begin // find group
      X := N;
      repeat
        Dec(X);
        Tx := MetadataList.Keys[X];
      until length(Tx) = 0;
      Tx := MetadataList.Cells[1, X]; // eg '---- IFD0 ----'
      Delete(Tx, 1, 5);               // -> 'IFD0 ----'
      X := pos(' ', Tx);
      SetLength(Tx, X - 1);           // -> 'IFD0'
      Tx := Tx + ':';                 // -> 'IFD0:'
    end;

    Ty := MetadataList.Keys[N];       // e.g. 'Make' or '0x010f Make' or '- Rating'
    if LeftStr(Ty, 2) = '0x' then
      Delete(Ty, 1, 7)
    else if LeftStr(Ty, 2) = '- ' then
      Delete(Ty, 1, 2);
    Ty := TrimRight(Ty);
    T1 := Ty;                         // tl=language specific tag name
    Ty := TranslateTagName('-' + Tz, Ty);
    with QuickTags[I] do
    begin
      Caption := Tz + T1;
      Command := '-' + Tx + Ty;       // ='-IFD0:Make'
      Help := 'No Hint defined';
    end;
  finally
    MetadataList.Refresh;
    SetCursor(CrNormal);
  end;
end;

procedure TFMain.QuickPopUp_DelCustomClick(Sender: TObject);
var
  I, J: smallint;
  Tx, T1: string;
begin
  I := MetadataList.Row;
  if ET_Options.ETLangDef <> '' then
  begin
    T1 := ET_Options.ETLangDef;
    ET_Options.ETLangDef := '';
    ShowMetadata;
    Tx := MetadataList.Keys[I];
    ET_Options.ETLangDef := T1;
  end
  else
    Tx := MetadataList.Keys[I];

  if LeftStr(Tx, 2) = '0x' then
    Delete(Tx, 1, 7)
  else if LeftStr(Tx, 2) = '- ' then
    Delete(Tx, 1, 2);
  Tx := TrimRight(Tx); // =tag name

  if Length(Tx) > 0 then
  begin // should be always true!
    I := pos(Tx, CustomViewTags);
    J := I;
    repeat
      dec(I);
    until CustomViewTags[I] = '-';
    repeat
      inc(J);
    until CustomViewTags[J] = ' ';
    Delete(CustomViewTags, I, J - I + 1);
  end;
  ShowMetadata;
end;

procedure TFMain.QuickPopUp_DelQuickClick(Sender: TObject);
var
  i, n: smallint;
begin
  n := MetadataList.Row - 1;
  i := length(QuickTags) - 1;
  while n < i do
  begin
    QuickTags[n].Caption := QuickTags[n + 1].Caption;
    QuickTags[n].Command := QuickTags[n + 1].Command;
    QuickTags[n].Help := QuickTags[n + 1].Help;
    QuickTags[n].NoEdit := QuickTags[n + 1].NoEdit;
    inc(n);
  end;
  SetLength(QuickTags, i);
  ShowMetadata;
end;

procedure TFMain.QuickPopUp_FillQuickClick(Sender: TObject);
var
  i, n: smallint;
  tx: string;
begin
  n := length(QuickTags);
  with MetadataList do
  begin
    for i := 0 to n - 1 do
    begin
      tx := QuickTags[i].Caption;
      if RightStr(tx, 1) = '*' then
      begin
        Insert('*', tx, 1);
        Keys[i + 1] := tx;
        Cells[1, i + 1] := QuickTags[i].Help;
      end;
    end;
    SpeedBtnQuickSave.Enabled := true;
  end;
end;

procedure TFMain.QuickPopUp_MarkTagClick(Sender: TObject);
var
  I, J: smallint;
  Tx: string;
begin
  with MetadataList do
    Tx := Keys[Row];
  I := pos(' ', Tx);
  if I > 0 then
    Delete(Tx, 1, I); // if Show HexID exist
  if Length(Tx) > 0 then
  begin
    I := pos(Tx, MarkedTags);
    if I > 0 then
    begin // tag allready marked: unmark it
      J := I;
      repeat
        inc(J);
      until MarkedTags[J] = ' ';
      Delete(MarkedTags, I, J - I + 1);
    end
    else
      MarkedTags := MarkedTags + Tx + ' '; // mark tag
  end;
end;

procedure TFMain.QuickPopUp_UndoEditClick(Sender: TObject);
var
  I, N, X: smallint;
  Tx, ETouts, ETerrs: string;
begin
  I := MetadataList.Row;
  MetadataList.Keys[I] := QuickTags[I - 1].Caption;
  Tx := '-s3' + CRLF + '-f' + CRLF + QuickTags[I - 1].Command;
  ET_OpenExec(Tx, GetSelectedFile(ShellList.FileName), ETouts, ETerrs);
  MetadataList.Cells[1, I] := ETouts;
  N := MetadataList.RowCount - 1;
  X := 0;
  for I := 1 to N do
    if pos('*', MetadataList.Keys[I]) = 1 then
      inc(X);
  SpeedBtnQuickSave.Enabled := (X > 0);
end;

procedure TFMain.ExecETEvent_Done(ExecNum: word; EtCmds, EtOuts, EtErrs, StatusLine: string; PopupOnError: boolean);
var
  Indx: Integer;
  ErrStatus: string;
begin
  with FLogWin do
  begin
    ErrStatus := '-';
    if (PopupOnError) then
    begin
      if (ETerrs = '') then
        ErrStatus := StrOK
      else
      begin
        ErrStatus := StrNotOK;
        Show; // Popup Log window when there's an error.
      end;
      // Try to show 'xxx image files read'.
      StatusBar.Panels[1].Text := StatusLine;
    end;

    if (Showing) and
       ((ChkShowAll.Checked) or (ErrStatus <> '-')) then
    begin
      Indx := NextLogId;
      FExecs[Indx] := Format(StrExecuteDSUpdat, [ExecNum, TimeToStr(now), ErrStatus]);
      FCmds[Indx] := EtCmds;
      FEtOuts[Indx] := EtOuts;
      FEtErrs[Indx] := EtErrs;

      LBExecs.Items.Assign(Fexecs);
      LBExecs.ItemIndex := Indx;
      LBExecsClick(LBExecs);
    end;
  end;
end;

procedure TFmain.ExecRestEvent_Done(Url, Response: string; Succes: boolean);
var
  Indx: integer;
  ErrStatus: string;
begin
  with FLogWin do
  begin
    if (Showing) then
    begin
      Indx := NextLogId;
      if (Succes) then
        ErrStatus := StrOk
      else
        ErrStatus := StrNOTOk;
      FExecs[Indx] := Format(StrRestRequestSUpd, [TimeToStr(now), ErrStatus]);
      FCmds[Indx] := Url;
      FEtOuts[Indx] := Response;

      LBExecs.Items.Assign(Fexecs);
      LBExecs.ItemIndex := Indx;
      LBExecsClick(LBExecs);
    end;
  end;
end;

procedure TFMain.UpdateLocationfromGPScoordinatesClick(Sender: TObject);
var
  CrWait, CrNormal: HCURSOR;
  SelectedFiles: TStringList;
  AFile: string;
  GPSCoordinates: string;
  IsQuickTime: boolean;
begin
  GetMetadata(GetFirstSelectedFilePath, false, false, true, false);
  if (Foto.GPS.Supported) then
  begin
    FGeoSetup.Lat := Foto.GPS.GeoLat;
    FGeoSetup.Lon := Foto.GPS.GeoLon;
  end
  else
  begin
    GPSCoordinates := GetGpsCoordinates(GetFirstSelectedFilePath);
    AnalyzeGPSCoords(GPSCoordinates, FGeoSetup.Lat, FGeoSetup.Lon, IsQuickTime);
  end;

  if not (ValidLatLon(FGeoSetup.Lat, FGeoSetup.Lon)) then
  begin
    MessageDlgEx(StrSelectedFileHasNo, '',
                 TMsgDlgType.mtError, [TMsgDlgBtn.mbOK]);
    exit;
  end;

  if (FGeoSetup.ShowModal = MROK) then
  begin
    CrWait := LoadCursor(0, IDC_WAIT);
    CrNormal := SetCursor(CrWait);
    SelectedFiles := TStringList.Create;
    try
      SelectedFiles.Text := GetSelectedFiles(true);   // Need full pathname
      for AFile in SelectedFiles do
      begin
        StatusBar.Panels[1].Text := AFile;
        StatusBar.Update;
        FillLocationInImage(AFile);
      end;
    finally
      SelectedFiles.Free;
      RefreshSelected(Sender);
      SetCursor(CrNormal);
    end;
  end;
  StatusBar.Panels[1].Text := '';
end;

procedure TFMain.UpdateStatusBar_FilesShown;
begin
  StatusBar.Panels[0].Text := Format(StrFiles, [ShellList.Items.Count]);
end;

procedure TFMain.EdgeBrowser1CreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
var Url: string;
begin
  if (AResult <> S_OK) then
  begin
    Url := '';
    if not CheckWebView2Loaded then
    begin
      if (MessageDlgEx(StrTheWebView2Loaderd + #10 +
                       StrShowOnlineHelp,
                       '', TMsgDlgType.mtError, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo]) = ID_YES) then
        Url := '/#m_edge_dll';
    end
    else
    begin
      if (MessageDlgEx(StrUnableToStartEdge +#10 +
                       StrShowOnlineHelp,
                       '', TMsgDlgType.mtError, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo]) = ID_YES) then
        Url := '/#m_edge_runtime';
    end;
    if (Url <> '') then
      ShellExecute(0, 'Open', PWideChar(ONLINE_DOC_URL + Url), '', '', SW_SHOWNORMAL);
  end;

end;

// Retain zoomfactor
procedure TFMain.EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
begin
  Sender.ZoomFactor := EdgeZoom;
end;

procedure TFMain.EdgeBrowser1ZoomFactorChanged(Sender: TCustomEdgeBrowser; AZoomFactor: Double);
begin
  EdgeZoom := AZoomFactor;
end;

procedure TFMain.EdgeBrowser1WebMessageReceived(Sender: TCustomEdgeBrowser; Args: TWebMessageReceivedEventArgs);
var
  Message: PChar;
  Msg, Parm1, Parm2, Lat, Lon: string;
begin
  Args.ArgsInterface.Get_webMessageAsJson(Message);
  ParseJsonMessage(Message, Msg, Parm1, Parm2);

  if (Msg = OSMGetBounds) then
  begin
    EditMapBounds.Text := Parm1;

    ParseLatLon(Parm2, Lat, Lon);
    AdjustLatLon(Lat, Lon, Coord_Decimals);
    EditMapFind.Text := Lat + ', ' + Lon;

    exit;
  end;

  AdjustLatLon(Parm1, Parm2, Coord_Decimals);
  EditMapFind.Text := Parm1 + ', ' + Parm2;
  if (Msg = OSMCtrlClick) then
  begin
    MapGotoPlace(EdgeBrowser1, EditMapFind.Text, '', OSMCtrlClick, InitialZoom_In);

    exit;
  end;

  if (Msg = OSMGetLocation) then
  begin
    MapGotoPlace(EdgeBrowser1, EditMapFind.Text, '', OSMGetLocation, InitialZoom_Out);

    exit;
  end;

end;

procedure TFMain.EditETcmdNameChange(Sender: TObject);
begin
  if (EditETdirect.Text <> '') and (EditETcmdName.Text <> '') then
  begin
    SpeedBtnETdirectReplace.Enabled := (CBoxETdirect.ItemIndex >= 0);
    SpeedBtnETdirectAdd.Enabled := EditETdirect.Modified;
  end
  else
  begin
    SpeedBtnETdirectReplace.Enabled := false;
    SpeedBtnETdirectAdd.Enabled := false;
  end;
end;

procedure TFMain.EditETdirectChange(Sender: TObject);
begin
  if (EditETdirect.Text <> '') and (EditETcmdName.Text <> '') then
  begin
    SpeedBtnETdirectReplace.Enabled := (CBoxETdirect.ItemIndex >= 0);
    SpeedBtnETdirectAdd.Enabled := EditETcmdName.Modified;
  end
  else
  begin
    SpeedBtnETdirectReplace.Enabled := false;
    SpeedBtnETdirectAdd.Enabled := false;
  end;
end;

procedure TFMain.CmbETDirectModeChange(Sender: TObject);
begin
  GUIsettings.ETdirMode := CmbETDirectMode.ItemIndex;
end;

procedure TFMain.EditETdirectKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  IsRecursive, ETResult: boolean;
  I: smallint;
  ETtx, ETout, ETerr: string;
  ETprm: string;
  SelectedFiles: string;
begin
  if (Key = VK_ESCAPE) and
     (SpeedBtn_ETdirect.Down) then
  begin
    SpeedBtn_ETdirect.Down := not SpeedBtn_ETdirect.Down;
    SpeedBtn_ETdirectClick(Sender);
    exit;
  end;

  ETtx := EditETdirect.Text;
  if (Key = VK_Return) and (length(ETtx) > 1) then
  begin
    IsRecursive := (pos('-r ', ETtx) > 0);
    ETprm := ETtx;
    if IsRecursive then
    begin // init ETcounter:
      ETprm := ETprm + ' "' + ExcludeTrailingPathDelimiter(ShellList.Path) + '"'; // If pathname ends with \, it would be escaping a "
      I := pos('-ext ', ETtx); // ie. '-ext jpg ...'
      if I = 0 then
        ETtx := '*.*'
      else
      begin
        inc(I, 4);
        Delete(ETtx, 1, I);
        ETtx := TrimLeft(ETtx); // ='jpg ...'
        I := pos(' ', ETtx);
        if I > 0 then
          ETtx := LeftStr(ETtx, I - 1);
        ETtx := '*.' + ETtx;
      end;
      SetCounter(CounterETEvent, GetNrOfFiles(ShellList.Path, ETtx, true));
      SelectedFiles := '';
    end
    else
      SelectedFiles := GetSelectedFiles;

    // Call ETDirect or ET_OpenExec
    case CmbETDirectMode.ItemIndex of
      0: ETResult := ET_OpenExec(ArgsFromDirectCmd(ETprm), SelectedFiles, ETout, ETerr);
      1: ETResult := ExecET(ETprm, SelectedFiles, ShellList.Path, ETout, ETerr);
      else
        ETResult := false; // Make compiler happy
    end;

    if not ETResult then
      ShowMessage(StrExifToolNotExecute);

    RefreshSelected(Sender);
    ShowMetadata;
    ShowPreview;
  end;
end;

procedure TFMain.EditFindMetaKeyPress(Sender: TObject; var Key: Char);
var NewRow: Integer;
begin
  StatusBar.Panels[1].Text := '';
  if (Key = #13) then
  begin
    NewRow := MetadataList.Row;
    while (NewRow < Metadatalist.RowCount -1) do
    begin
      if (MetadataList.Keys[NewRow +1] <> '') and // Dont look in group names
         (ContainsText(MetadataList.Strings[NewRow], TLabeledEdit(Sender).Text)) then
      begin
        MetadataList.Row := NewRow +1;
        Exit;
      end;
      Inc(NewRow);
    end;
    StatusBar.Panels[1].Text := StrNoMoreMatchesFo;
  end;
  MetadataList.Row := 1;
end;

procedure TFMain.EditQuickEnter(Sender: TObject);
begin
  with MetadataList do
  begin
    if Sender = EditQuick then
    begin
      if QuickTags[Row - 1].NoEdit then
        EditQuick.Color := $9090FF
      else
        EditQuick.Color := $BBFFFF;
    end
    else
    begin
      if QuickTags[Row - 1].NoEdit then
        MemoQuick.Color := $9090FF
      else
        MemoQuick.Color := $BBFFFF;
      MemoQuick.SelectAll;
    end;
    StatusBar.Panels[2].Text := QuickTags[Row - 1].Help;
  end;
end;

procedure TFMain.EditQuickExit(Sender: TObject);
begin
  if Sender = EditQuick then
    EditQuick.Color := clWindow
  else
    MemoQuick.Color := clWindow;
  StatusBar.Panels[2].Text := '';
end;

procedure TFMain.EditQuickKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: smallint;
  tx: string;
begin
  i := MetadataList.Row;
  if (Key = VK_Return) and not(QuickTags[i - 1].NoEdit) then
    with MetadataList do
    begin
      if Sender = EditQuick then
        tx := trim(EditQuick.Text) // delete leading and trailing
      else
        tx := trim(MemoQuick.Text);
      Cells[1, i] := tx;
      tx := Keys[i];
      if tx[1] <> '*' then
        Keys[i] := '*' + tx; // mark tag value changed
      if GUIsettings.AutoIncLine and // select next row
        (i < RowCount - 1) then
        Row := i + 1;
      Refresh;
      SetFocus;
      SpeedBtnQuickSave.Enabled := true;
    end;

  if Key = VK_ESCAPE then
    with MetadataList do
    begin
      if Sender = EditQuick then
      begin
        if QuickTags[i - 1].NoEdit then
          EditQuick.Text := ''
        else
        begin
          if RightStr(Keys[i], 1) = #177 then
            EditQuick.Text := '+'
          else
            EditQuick.Text := Cells[1, i];
        end;
      end
      else
      begin
        if QuickTags[i - 1].NoEdit then
          MemoQuick.Text := ''
        else
        begin
          if RightStr(Keys[i], 1) = #177 then
            MemoQuick.Text := '+'
          else
            MemoQuick.Text := Cells[1, i];
        end;
      end;
      SetFocus;
    end;
end;

procedure TFMain.ShowPreview;
var
  Rotate: integer;
  FPath: string;
  ABitMap: TBitmap;
  HBmp: HBITMAP;
  CrWait, CrNormal: HCURSOR;
begin
  RotateImg.Picture.Bitmap := nil;
  if ShellList.SelCount > 0 then
  begin
    CrWait := LoadCursor(0, IDC_WAIT);
    CrNormal := SetCursor(CrWait);
    try
      FPath := ShellList.FilePath;
      Rotate := 0;
      if GUIsettings.AutoRotatePreview then
      begin
        GetMetadata(FPath, false, false, false, false);
        case Foto.IFD0.Orientation of
          0, 1:
            Rotate := 0; // no tag or don't rotate
          3:
            Rotate := 180;
          6:
            Rotate := 90;
          8:
            Rotate := 270;
        end;
      end;
      ABitMap := GetBitmapFromWic(WicPreview(FPath, Rotate, RotateImg.Width, RotateImg.Height));
      if (ABitMap = nil) then
      begin
        if (GetThumbCache(FPath, HBmp, SIIGBF_THUMBNAILONLY, RotateImg.Width, RotateImg.Height) = S_OK) then
        begin
          ABitMap := TBitmap.Create;
          ABitMap.Handle := HBmp;
        end;
      end;
      if (ABitMap <> nil) then
      begin
        ResizeBitmapCanvas(ABitMap, RotateImg.Width, RotateImg.Height, GUIColorWindow);
        RotateImg.Picture.Bitmap := ABitMap;
        ABitMap.Free;
      end;
    finally
      SetCursor(CrNormal);
    end;
  end;
end;

procedure TFMain.AdvPagePreviewResize(Sender: TObject);
begin
  ShowPreview;
end;

procedure TFMain.CBoxETdirectChange(Sender: TObject);
var
  i: smallint;
begin
  i := CBoxETdirect.ItemIndex;
  if i >= 0 then
  begin
    EditETdirect.Text := ETdirectCmd[i];
    EditETdirect.Modified := false;
    EditETcmdName.Text := CBoxETdirect.Text;
    EditETcmdName.Modified := false;
    SpeedBtnETdirectDel.Enabled := true; // Delete
  end
  else
    SpeedBtnETdirectDel.Enabled := false;
  SpeedBtnETdirectReplace.Enabled := false;
  SpeedBtnETdirectAdd.Enabled := false;
  EditETdirect.SetFocus;
end;

procedure TFMain.CBoxFileFilterChange(Sender: TObject);
var
  i: smallint;
begin
  i := CBoxFileFilter.ItemIndex;
  if i >= 0 then
  begin
    SpeedBtnFilterEdit.Enabled := (i <> 0);
    ShellList.Refresh;
    ShellList.SetFocus;
  end;
end;

procedure TFMain.CBoxFileFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
  begin
    CBoxFileFilter.Text := trim(CBoxFileFilter.Text);
    ShellList.Refresh;
    ShellList.SetFocus;
  end;
end;

procedure TFMain.AlignStatusBar;
begin
  StatusBar.Panels[0].Width := AdvPageBrowse.Width + Splitter1.Width;
  StatusBar.Panels[1].Width := AdvPageFilelist.Width + Splitter2.Width;
end;

procedure TFMain.ApplicationEventsMinimize(Sender: TObject);
begin
  if (GUIsettings.MinimizeToTray) then
  begin
    Application.Minimize;
    Hide;

    if (GUIsettings.ShowBalloon) then
    begin
      TrayIcon.ShowBalloonHint;
      TrayIcon.BalloonHint := StrMinimizedToTray + #10 +
                              StrClickToDisableThi;
    end
    else
      TrayIcon.BalloonHint := '';

    TrayIcon.Visible := true;
  end;
end;

procedure TFMain.FormAfterMonitorDpiChanged(Sender: TObject; OldDPI, NewDPI: Integer);
begin
  GUIBorderWidth := Width - ClientWidth;
  GUIBorderHeight := Height - ClientHeight;

  AdvPanelETdirect.Height := ScaleDesignDpi(32);
  AdvPanelMetaBottom.Height := ScaleDesignDpi(32);
  Splitter2.MinSize := ScaleDesignDpi(320);

  MakeFullyVisible;
end;

procedure TFMain.FormCanResize(Sender: TObject; var NewWidth, NewHeight: integer; var Resize: boolean);
var
  N: integer;
begin
  if (WindowState <> wsMinimized) and
     (Showing) then
  begin
    N := GUIBorderWidth + AdvPanelBrowse.Width + Splitter1.Width +
                          MinFileListWidth + Splitter2.Width +
                          AdvPageMetadata.Width;
    if (NewWidth < N) then
      NewWidth := N;
  end;
  AlignStatusBar;
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EdgeBrowser1.CloseBrowserProcess; // Close Edge. Else we can not remove the tempdir.
  EdgeBrowser1.CloseWebView;
  SaveGUIini;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  ReadGUIini;
  // AdvPageFilelist.Constraints.MinWidth only used at design time. Form does not align well.
  // We check for MinFileListWidth in code.
  MinFileListWidth := AdvPageFilelist.Constraints.MinWidth;
  AdvPageFilelist.Constraints.MinWidth := 0;


  // Tray Icon
  TrayIcon.Hint := GetFileVersionNumber(Application.ExeName);

  // Create Bread Crumb
  BreadcrumbBar := TDirBreadcrumbBar.Create(Self);
  BreadcrumbBar.Parent := PnlBreadCrumb;
  BreadcrumbBar.Font := PnlBreadCrumb.Font;
  BreadcrumbBar.Align := alClient;
  BreadcrumbBar.OnChange := BreadCrumbClick;
  BreadcrumbBar.OnHome := BreadCrumbHome;

  // Create Bar Chart series
  ETBarSeriesFocal := TBarSeries.Create(ETChart);
  ETBarSeriesFocal.Marks.Visible := false;

  ETBarSeriesFnum := TBarSeries.Create(ETChart);
  ETBarSeriesFnum.Marks.Visible := false;

  ETBarSeriesIso := TBarSeries.Create(ETChart);
  ETBarSeriesIso.Marks.Visible := false;

  // Set Style
  TStyleManager.TrySetStyle(GUIsettings.GuiStyle, false);
  SetGuiStyle;

  // EdgeBrowser
  EdgeBrowser1.UserDataFolder := GetEdgeUserData;

  // Set properties of ShellTree in code.
  ShellTree.OnBeforeContextMenu := ShellTreeBeforeContext;
  ShellTree.OnAfterContextMenu := ShellTreeAfterContext;

  // Set properties of Shelllist in code.
  ShellList.OnPopulateBeforeEvent := ShellListBeforePopulate;
  ShellList.OnEnumColumnsAfterEvent := ShellListAfterEnumColumns;
  ShellList.OnPathChange := ShellListPathChange;
  ShellList.OnItemsLoaded := ShellListItemsLoaded;
  ShellList.OnOwnerDataFetchEvent := ShellListOwnerDataFetch;
  ShellList.OnColumnResized := ShellListColumnResized;
  ShellList.OnThumbGenerate := ShellistThumbGenerate;
  ShellList.OnThumbError := ShellistThumbError;
  ShellList.OnMouseWheel := ShellListMouseWheel;
  // Enable Column sorting if Sorted = true. Disables Sorted.
  ShellList.ColumnSorted := ShellList.Sorted;

  // Metadatalist Ctrl handler
  MetadataList.OnCtrlKeyDown := MetadataListCtrlKeyDown;

  CBoxFileFilter.Text := SHOWALL;
  ExifTool.ExecETEvent := ExecETEvent_Done;
  Geomap.ExecRestEvent := ExecRestEvent_Done;
end;

procedure TFMain.ShellListMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := false;
  if (ssCtrl in Shift) then
    ShellList.SetIconSpacing(WheelDelta, 0);
  if (ssAlt in shift) then
    ShellList.SetIconSpacing(0, 0);
end;

// ---------------Drag_Drop procs --------------------
procedure TFMain.ImageDrop(var Msg: TWMDROPFILES);
var
  NumFiles: integer;
  Buffer: array of Char;
  PBuffer: PChar absolute Buffer;
  LBuffer: integer;
  FName: string;
  AnItem: TListItem;
begin
  NumFiles := DragQueryFile(Msg.Drop, UINT(-1), nil, 0);
  if NumFiles > 1 then
    ShowMessage(StrDropOnlyOneFileA)
  else
  begin
    LBuffer := DragQueryFile(Msg.Drop, 0, nil, 0) +1;
    SetLength(Buffer, LBuffer);
    DragQueryFile(Msg.Drop, 0, PBuffer, LBuffer);
    FName := PBuffer;

    ShellList.ItemIndex := -1;
    if (DirectoryExists(FName)) then
      ShellTree.Path := FName
    else
    begin
      ShellTree.Path := ExtractFileDir(FName);
      FName := ExtractFileName(FName);
      for AnItem in ShellList.Items do
      begin
        if ShellList.FileName(AnItem.Index) = FName then
        begin
          ShellList.ItemIndex := AnItem.Index;
          break;
        end;
      end;
    end;
    ShowPreview;
    ShowMetadata;
    Application.BringToFront;
  end;
end;

// ------------- ^ Enf of Drag_Drop procs ^-------------------------------

procedure TFMain.FormShow(Sender: TObject);
var
  AnItem: TListItem;
  Param: string;
  Lat, Lon: string;
  I: integer;
  PathFromParm: boolean;
begin
  if TrayIcon.Visible then
    exit;

  FSharedMem.RegisterOwner(Self.Handle, CM_ActivateWindow);

  SetCaption;

  OnAfterMonitorDpiChanged(Sender, 0, 0); // DPI Values are not used

  AdvPageMetadata.ActivePage := AdvTabMetadata;
  AdvPageFilelist.ActivePage := AdvTabFilelist;

  MaUpdateLocationfromGPScoordinates.Enabled := false;
  AdvTabOSMMap.Enabled := false;
  if GUIsettings.EnableGMap then
  begin
    try
      MaUpdateLocationfromGPScoordinates.Enabled := true;
      ParseLatLon(GUIsettings.DefGMapHome, Lat, Lon);
      OSMMapInit(EdgeBrowser1, Lat, Lon, OSMHome, InitialZoom_Out);
      AdvTabOSMMap.Enabled := true;
    except
      on E:Exception do
        MessageDlgEx(E.Message, StrErrorPositioningHo, TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK]);
    end;
  end;

  // Init Chart
  AdvRadioGroup2Click(Sender);

  if not SpeedBtnDetails.Down then
  begin
    ShellList.ViewStyle := vsIcon;
    CBoxDetails.Enabled := false;
  end;

  I := CBoxDetails.Items.Count - 1;
  SpeedBtnColumnEdit.Enabled := (CBoxDetails.ItemIndex = I);
  WrkIniDir := GetAppPath;
  if GUIsettings.UseExitDetails then
    CBoxDetailsChange(Sender);

  DontSaveIni := FindCmdLineSwitch('DontSaveIni', true);

  // The shellList is initally disabled. Now enable and refresh
  PathFromParm := false;
  ShellListSetFolders;
  ShellList.Enabled := true;

  // GUI started as "Send to" or "Open with":
  if ParamCount > 0 then
  begin
    Param := ParamStr(1);

    if DirectoryExists(Param) then
    begin
      PathFromParm := true;
      ShellTree.Path := Param; // directory only
    end
    else
    begin
      if FileExists(Param) then
      begin // file specified
        PathFromParm := true;
        ShellTree.Path := ExtractFileDir(Param);
        Param := ExtractFileName(Param);
        ShellList.ItemIndex := -1;
        for AnItem in ShellList.Items do
        begin
          if SameText(ShellList.FileName(AnItem.Index), Param) then
          begin
            ShellList.ItemIndex := AnItem.Index;
            break;
          end;
        end;
        if (ShellList.ItemIndex <> -1) then
        begin
          ShellList.SetFocus;
          ShellListClick(Sender);
        end
        else
          ShellTree.SetFocus;
      end;
    end;
  end;

  // If Path was not set from parm, use the setting
  if (PathFromParm = false) and
     ValidDir(GUIsettings.InitialDir) then
  begin
    ShellTree.Path := GUIsettings.InitialDir;
    ShellList.SetFocus;
  end;

  // Scroll in view. Select initial
  if (ShellTree.Selected <> nil) then
    ShellTree.Selected.MakeVisible;

  // --------------------------
  DragAcceptFiles(Self.Handle, true);
end;

procedure TFMain.RotateImgResize(Sender: TObject);
begin
  ShowPreview;
end;

procedure TFMain.BreadCrumbClick(Sender: TObject);
begin
  if FrmStyle.Showing then
    exit;
  ShellTree.Path := BreadcrumbBar.Directory;
  if (ShellTree.Selected <> nil) then
    ShellTree.Selected.MakeVisible;
end;

procedure TFMain.BreadCrumbHome(Sender: TObject);
begin
  if FrmStyle.Showing then
    exit;

  // Setting ObjectTypes will always call RootChanged, even if the value has not changed.
  ShellTree.ObjectTypes := ShellTree.ObjectTypes;
  ShellTree.Refresh(ShellTree.TopItem);
end;

procedure TFMain.ShellListAddItem(Sender: TObject; AFolder: TShellFolder; var CanAdd: boolean);
var
  FolderName: string;
  FilterItem, Filter: string;
  FilterMatches: boolean;
begin
  CanAdd := TShellListView(Sender).Enabled and not FrmStyle.Showing and ValidFile(AFolder);
  FolderName := ExtractFileName(AFolder.PathName);
  if (CBoxFileFilter.Text <> SHOWALL) then
  begin
    Filter := CBoxFileFilter.Text;
    FilterMatches := Afolder.IsFolder;
    while (FilterMatches = false) and (Filter <> '') do
    begin
      FilterItem := NextField(Filter, ';');
      FilterMatches := MatchesMask(FolderName, FilterItem);
    end;
    CanAdd := CanAdd and FilterMatches;
  end;
end;

procedure TFMain.ShellListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  UpdateStatusBar_FilesShown;
end;

procedure TFMain.ShellListClick(Sender: TObject);
begin
  ShowPreview;
  ShowMetadata;
  SpeedBtnQuickSave.Enabled := false;

  EnableMenuItems;
end;

procedure TFMain.ShellListColumnClick(Sender: TObject; Column: TListColumn);
begin
  ShellList.ColumnClick(Column);
  ShowMetadata;
  ShowPreview;
end;

procedure TFMain.ShellListColumnResized(Sender: TObject);
var
  ColIndex: integer;
begin
  ColIndex := TListColumn(Sender).Index;
  if (ColIndex = 0) then // Name field
    FListStdColWidth[ColIndex] := TListColumn(Sender).Width
  else
  begin
    case CBoxDetails.ItemIndex of
      0:
        FListStdColWidth[ColIndex] := TListColumn(Sender).Width;
      1:
        FListColDef1[ColIndex - 1].Width := TListColumn(Sender).Width;
      2:
        FListColDef2[ColIndex - 1].Width := TListColumn(Sender).Width;
      3:
        FListColDef3[ColIndex - 1].Width := TListColumn(Sender).Width;
      4:
        FListColUsr[ColIndex - 1].Width := TListColumn(Sender).Width;
    end;
  end;
end;

procedure TFMain.ShellListBeforePopulate(Sender: TObject; var DoDefault: boolean);
begin
  DoDefault := (ShellList.ViewStyle <> vsReport) or (CBoxDetails.ItemIndex = 0);
end;

procedure TFMain.ShellListAfterEnumColumns(Sender: TObject);

  procedure AdjustColumns(ColumnDefs: array of smallint);
  var
    i, j: integer;
  begin
    j := Min(High(ColumnDefs), ShellList.Columns.Count - 1);
    for i := 0 to j do
      ShellList.Columns[i].Width := ColumnDefs[i];
  end;

  procedure AddColumn(const ACaption: string; AWidth: integer; const AAlignment: smallint = 0);
  begin
    with TShellListView(Sender).Columns.Add do
    begin
      Caption := ACaption;
      Width := AWidth;
      if (AAlignment > 0) then
        Alignment := taRightJustify;
    end;
  end;

  procedure AddColumns(ColumnDefs: array of FListColDefRec); overload;
  var
    i: integer;
  begin
    with ShellList do
    begin
      Columns.Clear;
      AddColumn(SShellDefaultNameStr, FListStdColWidth[0]); // Name field
      for i := 0 to High(ColumnDefs) do
        AddColumn(ColumnDefs[i].Caption, ColumnDefs[i].Width, ColumnDefs[i].AlignR);
    end;
  end;

  procedure AddColumns(ColumnDefs: array of FListColUsrRec); overload;
  var
    DefRecords: array of FListColDefRec;
    i: integer;
  begin
    SetLength(DefRecords, length(ColumnDefs));
    for i := 0 to length(DefRecords) - 1 do
      DefRecords[i] := FListColDefRec.Create(ColumnDefs[i]);

    AddColumns(DefRecords);
  end;

begin

  case CBoxDetails.ItemIndex of
    0:
      AdjustColumns(FListStdColWidth);
    1:
      AddColumns(FListColDef1);
    2:
      AddColumns(FListColDef2);
    3:
      AddColumns(FListColDef3);
    4:
      AddColumns(FListColUsr);
  end;

end;

// Path is about to change. Need to restart ExiftTool and setup the menu's
procedure TFMain.ShellListPathChange(Sender: TObject);
var
  ET_Active: boolean;
begin
  if FrmStyle.Showing then
    exit;

  if PnlBreadCrumb.Visible then
  begin
    BreadcrumbBar.Home := ShellTree.Items[0].Text;
    BreadcrumbBar.Directory := TShellListView(Sender).Path;
  end;

  // Start ExifTool in this directory
  ET_Active := ET_StayOpen(TShellListView(Sender).Path);

  // Dis/Enable menus
  EnableMenus(ET_Active);
end;

// Items are loaded and possibly sorted. Select the first
procedure TFMain.ShellListItemsLoaded(Sender: TObject);
var
  AShellList: TShellListView;
begin
  AShellList := TShellListView(Sender);

  // Select 1st Item rightaway
  if (AShellList.Items.Count > 0) then
  begin
    AShellList.Items[0].Selected := true;
    if (Assigned(AShellList.OnClick)) then
      AShellList.OnClick(Sender);
  end;

  EnableMenuItems;
end;

procedure TFMain.ShellListOwnerDataFetch(Sender: TObject; Item: TListItem; Request: TItemRequest; AFolder: TShellFolder);
var
  AShellList: TShellListView;
  ETcmd, Tx, ADetail: String;
  Indx: integer;
  Details: TStrings;
begin
  if (Item.Index < 0) then
    exit;

  AShellList := TShellListView(Sender);
  if (AShellList.ViewStyle <> vsReport) then
    exit;

  AFolder := AShellList.Folders[Item.Index];
  if not Assigned(AFolder) then
    exit;

  // The Item.Caption and Item.ImageIndex (for small icons) should always be set
  if (irText in Request) then
    Item.Caption := AFolder.DisplayName;
  if (irImage in Request) then
    Item.ImageIndex := AFolder.ImageIndex(AShellList.ViewStyle = vsIcon);

  Details := AFolder.DetailStrings;
  if (Details.Count = 0) and
     (Afolder.IsFolder = false) then
  begin
    with Foto do
    begin
      case CBoxDetails.ItemIndex of
        1:
          begin
            GetMetadata(AFolder.PathName, false, false, false, false);
            if (Foto.ExifIFD.Supported) then
            begin
              Tx := ExifIFD.ExposureTime;
              Tx.PadLeft(7);
              Details.Add(Tx);
              Tx := ExifIFD.FNumber;
              Tx.PadLeft(4);
              Details.Add(Tx);
              Tx := ExifIFD.ISO;
              Tx.PadLeft(5);
              Details.Add(Tx);
              Tx := ExifIFD.ExposureBias;
              Tx.PadLeft(4);
              Details.Add(Tx);
              Tx := ExifIFD.FocalLength;
              Tx.PadLeft(6);
              Details.Add(Tx);
              if (ExifIFD.Flash and $FF00) <> 0 then
              begin
                if (ExifIFD.Flash and 1) = 1 then
                  Details.Add(StrYes)
                else
                  Details.Add(StrNo);
              end
              else
                Details.Add('');
              Details.Add(ExifIFD.ExposureProgram);
              if IFD0.Orientation > 0 then
              begin
                if (IFD0.Orientation and 1) = 1 then
                  Details.Add(StrHor)
                else
                  Details.Add(StrVer);
              end
              else
                Details.Add('');
            end
            else
            begin
              if (GUIsettings.EnableUnsupported) then
                ET_OpenExec(CameraFields, GetSelectedFile(ShellList.FileName(Item.Index)), Details, False)
              else
                Details.Add(NotSupported);
            end;
          end;
        2:
          begin
            GetMetadata(AFolder.PathName, true, false, true, false);
            if (Foto.ExifIFD.Supported) then
            begin
              Details.Add(ExifIFD.DateTimeOriginal);
              if GPS.Latitude <> '' then
                Details.Add(StrYes)
              else
                Details.Add(StrNo);
              Details.Add(Xmp.CountryShown);
              Details.Add(Xmp.ProvinceShown);
              Details.Add(Xmp.CityShown);
              Details.Add(Xmp.LocationShown);
            end
            else
            begin
              if (GUIsettings.EnableUnsupported) then
              begin
                ET_OpenExec(LocationFields, GetSelectedFile(ShellList.FileName(Item.Index)), Details, False);

                // Details[0] = DateTimeOriginal
                // Details[1] = CreateDate
                if (Details[0] = '-') then
                  Details.Delete(0)
                else
                  Details.Delete(1);

                // Now Details[1] = GPS:GPSLatitude
                // GPS tagged?
                if (Details[1] = '-') or
                   (Details[1] = '0') then
                  Details[1] := StrNo
                else
                  Details[1] := StrYes;

              end
              else
                Details.Add(NotSupported);
            end;
          end;
        3:
          begin
            GetMetadata(AFolder.PathName, true, false, false, false);
            if (Foto.IFD0.Supported) then
            begin
              Details.Add(IFD0.Artist);
              Details.Add(Xmp.Rating);
              Details.Add(Xmp.PhotoType);
              Details.Add(Xmp.Event);
              Details.Add(Xmp.PersonInImage);
            end
            else
            begin
              if (GUIsettings.EnableUnsupported) then
                ET_OpenExec(AboutFields, GetSelectedFile(ShellList.FileName(Item.Index)), Details, False)
              else
                Details.Add(NotSupported);
            end;
          end;
        4:
          begin
            ETcmd := '-s3' + CRLF + '-f';
            for Indx := 0 to High(FListColUsr) do
              ETcmd := ETcmd + CRLF + FListColUsr[Indx].Command;
            ET_OpenExec(ETcmd, GetSelectedFile(ShellList.FileName(Item.Index)), Details, False);
          end;
      end;
    end;
  end;
  for ADetail in Details do
    Item.SubItems.Append(ADetail);
end;

procedure TFMain.ShellListDeletion(Sender: TObject; Item: TListItem);
begin // event is executed for each deleted file -so make it fast!
  RotateImg.Picture.Bitmap.Handle := 0;
  MetadataList.Strings.Clear;
end;

procedure TFMain.ShellListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

  procedure DeleteSelected;
  var
    ANItem: TListItem;
    CurIndex: integer;
    CrWait, CrNormal: HCURSOR;
  begin
    if (ShellList.SelCount = 0) then
      exit;

    CrWait := LoadCursor(0, IDC_WAIT);
    CrNormal := SetCursor(CrWait);
    ShellList.Items.BeginUpdate;
    try
      CurIndex := ShellList.Selected.Index -1;
      for ANItem in ShellList.Items do
      begin
        if (ANItem.Selected = false) then
          Continue;
        DoContextMenuVerb(ShellList.Folders[ANItem.Index], SCmdVerbDelete);
      end;

      ShellList.Refresh;
      ShellList.ClearSelection;
      if (CurIndex < 0) then
        CurIndex := 0;
      if (CurIndex > ShellList.Items.Count -1) then
        CurIndex := ShellList.Items.Count -1;
      ShellList.Selected := ShellList.Items[CurIndex];
      ShellList.ItemFocused := ShellList.Items[CurIndex];
    finally
      ShellList.Items.EndUpdate;
      SetCursor(CrNormal);
    end;
  end;

begin
  if (Key = VK_UP) or (Key = VK_DOWN) then       // Up-Down arrow
    ShellListClick(Sender);
  if (Key = Ord('A')) and (ssCTRL in Shift) then // Ctrl+A
    ShellList.SelectAll;
  if (Key = Ord('C')) and (ssCTRL in Shift) then // Ctrl+C
    ShellList.FileNamesToClipboard;
  if (Key = Ord('X')) and (ssCTRL in Shift) then // Ctrl+X
    ShellList.FileNamesToClipboard(True);
  if (Key = Ord('V')) and (ssCTRL in Shift) then // Ctrl+V
    ShellList.PasteFilesFromClipboard;
  if (Key = VK_PRIOR) or (Key = VK_NEXT) then    // PageUp/Down
    ShellListClick(Sender);

  if (Key = VK_ADD) and (ssCtrl in Shift) then
    ShellList.SetIconSpacing(1, 0);
  if (Key = VK_SUBTRACT) and (ssCtrl in Shift) then
    ShellList.SetIconSpacing(-1, 0);
  if ((Key = Ord('0')) or (Key = VK_NUMPAD0)) and (ssCtrl in Shift) then
    ShellList.SetIconSpacing(0, 0);
  if (Key = VK_F2) and (ShellList.Selected <> nil) then
    ShellList.Selected.EditCaption;
{$IFDEF NOTYET}
  if (Key = VK_DELETE) and (ssCtrl in Shift) then
    DeleteSelected;
{$ENDIF}
end;

procedure TFMain.ShellListSetFolders;
var Value: TShellObjectTypes;

  function AddHiddenIfAllowed(ObjectTypes: TShellObjectTypes): TShellObjectTypes;
  begin
    result := ObjectTypes;
    if GUIsettings.CanShowHidden then
      include(result, TShellObjectType.otHidden)
    else
      exclude(result, TShellObjectType.otHidden);
  end;

begin
  Value := AddHiddenIfAllowed(ShellList.ObjectTypes);
  if (GUIsettings.ShowFolders) then
    include(Value, TShellObjectType.otFolders)
  else
    exclude(Value, TShellObjectType.otFolders);
  if (Value <> ShellList.ObjectTypes) then
    ShellList.ObjectTypes := Value;

  Value := AddHiddenIfAllowed(ShellTree.ObjectTypes);
  if (Value <> ShellTree.ObjectTypes) then
    ShellTree.ObjectTypes := Value;

  PnlBreadCrumb.Visible := GUIsettings.ShowBreadCrumb;
  BreadcrumbBar.ShowHiddenDirs := GUIsettings.CanShowHidden;
end;

procedure TFMain.EnableMenus(Enable: boolean);
begin
  MenusEnabled := Enable;
  EnableMenuItems;

  AdvPageMetadata.Enabled := Enable;
  AdvPanelETdirect.Enabled := Enable;
  AdvPanelFileTop.Enabled := Enable;

  if not Enable then
    if (MessageDlgEx(StrERRORExifTool1 + #10 +  #10 +
        StrERRORExifTool2 + #10 +
        StrERRORExifTool3 + GetAppPath + #10 +
        StrERRORExifTool4 + #10 + #9 +
        StrERRORExifTool5 + #10 + #9 +
        StrERRORExifTool6 + #10 +
        StrERRORExifTool7 + #10 + #10 +
        StrERRORExifTool8 + #10 + #10 +
        StrERRORExifTool9 + #10 + #10 +
        StrShowOnlineHelp, '',
        TMsgDlgType.mtError, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo]) = ID_YES) then
      ShellExecute(0, 'Open', PWideChar(ONLINE_DOC_URL + '/#m_reqs_exiftool'), '', '', SW_SHOWNORMAL);

end;

procedure TFMain.EnableMenuItems;
var
  EnableItem: boolean;
  Indx: integer;
begin
//  0: Program (Has also 99, never disable)
// 10: Options
// 20: Export/Import
// 30: Modify
// 40: Various
// 50: Help

  EnableItem := (ShellList.SelCount > 0);
  for Indx := 0 to MainActionManager.ActionCount -1 do
  begin

    case MainActionManager.Actions[Indx].Tag of
      50, 99:
        continue;
      20, 30, 40:
        MainActionManager.Actions[Indx].Enabled := MenusEnabled and EnableItem;
      else
        MainActionManager.Actions[Indx].Enabled := MenusEnabled;
    end;
  end;
end;

procedure TFMain.ShellTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  RotateImg.Picture.Bitmap := nil;
  if Assigned(ETBarSeriesFocal) then
    ETBarSeriesFocal.Clear;
  if Assigned(ETBarSeriesFnum) then
    ETBarSeriesFnum.Clear;
  if Assigned(ETBarSeriesIso) then
    ETBarSeriesIso.Clear;
end;

procedure TFMain.RefreshSelected(Sender: TObject);
var AnItem: TListItem;
begin
  for AnItem in ShellList.Items do
  begin
    if AnItem.Selected then
    begin
      ShellList.Folders[AnItem.Index].DetailStrings.Clear;
      AnItem.Update;
    end;
  end;
end;

procedure TFMain.Tray_ResetwindowsizeClick(Sender: TObject);
begin
  RestoreGUI;
  ResetWindowSizes;
  ShellList.Refresh;
  Realign;
end;

// Close Exiftool before context menu. Delete directory fails
procedure TFMain.ShellTreeBeforeContext(Sender: TObject);
begin
  ET_OpenExit;
end;

// Restart Exiftool when context menu done.
procedure TFMain.ShellTreeAfterContext(Sender: TObject);
begin
  if (ValidDir(ShellList.Path)) then
    ET_StayOpen(ShellList.Path);
end;

procedure TFMain.SetCaption(AnItem: string = '');
var
  NewCaption: string;
begin
  NewCaption := '';
  if (IsElevated) then
    NewCaption := StrAdministrator + ' ';
  NewCaption := NewCaption + Application.Title;
  if (AnItem <> '') then
    NewCaption := NewCaption + ' - ' + AnItem;
  Caption := NewCaption
end;

// =========================== Show Metadata ====================================
procedure TFMain.ShowMetadata;
var
  E, N: integer;
  ETcmd, Item, Tx: string;
  ETResult: TStringList;
  NoChars:  TSysCharSet;
begin
  MetadataList.Tag := -1; // Reset hint row
  Item := GetSelectedFile(ShellList.FileName);
  SetCaption(Item);
  if (Item = '') then
  begin
    with MetadataList do
    begin
      Row := 1;
      Strings.Clear;
    end;
    EditQuick.Text := '';
    MemoQuick.Text := '';
    exit;
  end;

  ETResult := TStringList.Create;
  try
    if SpeedBtnQuick.Down then
    begin
      N := Length(QuickTags) - 1;
      ETcmd := '-s3' + CRLF + '-f';

      for E := 0 to N do
      begin
        Tx := QuickTags[E].Command;
        if UpperCase(LeftStr(tx, Length(GUI_SEP))) = GUI_SEP then
          Tx := GUI_SEP;
        ETcmd := ETcmd + CRLF + Tx;
      end;
      ET_OpenExec(ETcmd, Item, ETResult, false);
      N := Min(N, ETResult.Count - 1);
      with MetadataList do
      begin
        Strings.Clear;
        if (ETResult.Count < Length(QuickTags)) and
           (ETResult.Count > 0) then
          Strings.Append(Format('=' + StrWarningOnlyDRes,
                                [ETResult.Count, Length(QuickTags)]));
        for E := 0 to N do
        begin
          Tx := QuickTags[E].Command;
          if UpperCase(LeftStr(Tx, Length(GUI_SEP))) = GUI_SEP then
            Tx := '=' + QuickTags[E].Caption
          else
          begin
            Tx := QuickTags[E].Caption;
            if (Pos('?', Tx) > 0) then
            begin
              Include(NoChars, '-');
              if (Pos('??', Tx) > 0) then
                Include(NoChars, '0');

              if CharInSet(ETResult[E][1], NoChars) then
                Tx := Tx + '='+ StrNOAst
              else
                Tx := Tx + '=' + StrYESAst;
            end
            else
              Tx := QuickTags[E].Caption + '=' + ETResult[E];
          end;
          Strings.Append(Tx);
        end;
      end;
    end
    else
    begin
      if MaGroup_g4.Checked then
        ETcmd := '-g4' + CRLF
      else
        ETcmd := '-g1' + CRLF;
      if not MaNotDuplicated.Checked then
        ETcmd := ETcmd + '-a' + CRLF;
      if MaShowSorted.Checked then
        ETcmd := ETcmd + '-sort' + CRLF;
      if MaShowHexID.Checked then
        ETcmd := ETcmd + '-H' + CRLF;
      if ET_Options.ETLangDef = '' then
        ETcmd := ETcmd + '-S' + CRLF;
      if SpeedBtnExif.Down then
        ETcmd := ETcmd + '-Exif:All';
      if SpeedBtnIptc.Down then
        ETcmd := ETcmd + '-Iptc:All';
      if SpeedBtnXmp.Down then
        ETcmd := ETcmd + '-Xmp:All';
      if SpeedBtnMaker.Down then
        ETcmd := ETcmd + '-Makernotes:All' + CRLF + '-CanonVRD:All';
      if SpeedBtnALL.Down then
      begin
        ETcmd := ETcmd + '-All:All'; // +CRLF+'-e';
        if not MaShowComposite.Checked then
          ETcmd := ETcmd + CRLF + '-e';
      end;

      if SpeedBtnCustom.Down then
      begin
        if (Trim(CustomViewTags) = '') then
        begin
          // Show only message, no data.
          ETcmd := ETcmd + '-f' + CRLF +  '-Echo' + CRLF + StrNoCustomTags;
          Item := '';
        end
        else
        begin
          ETcmd := ETcmd + '-f' + CRLF + CustomViewTags;
          E := Length(ETcmd);
          SetLength(ETcmd, E - 1); // remove last space char
          ETcmd := StringReplace(ETcmd, ' ', CRLF, [rfReplaceAll]);
        end;
      end;

      ET_OpenExec(ETcmd, Item, ETResult, false);
      E := 0;
      if ETResult.Count = 0 then
      begin
        ETResult.Append('=' + StrExifToolExecuted);
        ETResult.Append('=' + StrNoData);
      end
      else
      begin
        while E < ETResult.Count do
        begin
          ETResult[E] := StringReplace(ETResult[E], ': ', '=', []);
          inc(E);
        end;
      end;

      with MetadataList do
      begin
        E := Row;
        Row := 1;
        Strings.Clear;
        Strings.AddStrings(ETResult);
        if RowCount > E then
          Row := E
        else
          Row := RowCount - 1;
      end;
    end;
  finally
    ETResult.Free;
  end;
end;

// ==============================================================================
procedure TFMain.Spb_ForwardClick(Sender: TObject);
begin
  EdgeBrowser1.GoForward;
end;

procedure TFMain.SpeedBtn_GetLocClick(Sender: TObject);
begin
  MapGetLocation(EdgeBrowser1);
end;

procedure TFMain.Spb_GoBackClick(Sender: TObject);
begin
  EdgeBrowser1.GoBack;
end;

procedure TFMain.SpeedBtnChartRefreshClick(Sender: TObject);
var
  Ext: string;
  I: integer;
  CrWait, CrNormal: HCURSOR;
begin
  for I := Low(ChartFLength) to High(ChartFLength) do
    ChartFLength[I] := 0;
  for I := Low(ChartFNumber) to High(ChartFNumber) do
    ChartFNumber[I] := 0;
  for I := Low(ChartISO) to High(ChartISO) do
    ChartISO[I] := 0;
  Ext := '*.*';
  if AdvRadioGroup1.ItemIndex > 0 then
    Ext := '*.' + AdvRadioGroup1.Items[AdvRadioGroup1.ItemIndex];
  ETBarSeriesFocal.Clear;
  ETBarSeriesFnum.Clear;
  ETBarSeriesIso.Clear;

  CrWait := LoadCursor(0, IDC_WAIT);
  CrNormal := SetCursor(CrWait);
  try
    ChartFindFiles(ShellList.Path, Ext, AdvCheckBox_Subfolders.Checked);
  finally
    SetCursor(CrNormal);
  end;

  ChartMaxFLength := 0;
  for I := Low(ChartFLength) to High(ChartFLength) do
  begin
    if ChartFLength[I] > 0 then
    begin
      if ChartFLength[I] > ChartMaxFLength then
        ChartMaxFLength := ChartFLength[I];
      Ext := IntToStr(I);
      if I < 100 then
        Insert('.', Ext, length(Ext)) // 58->5.8
      else
        SetLength(Ext, length(Ext) - 1);
      ETBarSeriesFocal.AddBar(ChartFLength[I], Ext, GUIsettings.CLFocal);
    end;
  end;
  ChartMaxFLength := Round(ChartMaxFLength * 1.1);

  ChartMaxFNumber := 0;
  for I := Low(ChartFNumber) to High(ChartFNumber) do
  begin
    if ChartFNumber[I] > 0 then
    begin
      if ChartFNumber[I] > ChartMaxFNumber then
        ChartMaxFNumber := ChartFNumber[I];
      Ext := IntToStr(I);
      Insert('.', Ext, length(Ext)); // 40->4.0
      ETBarSeriesFnum.AddBar(ChartFNumber[I], Ext, GUIsettings.CLFNumber);
    end;
  end;
  ChartMaxFNumber := Round(ChartMaxFNumber * 1.1);

  ChartMaxISO := 0;
  for I := Low(ChartISO) to High(ChartISO) do
  begin
    if ChartISO[I] > 0 then
    begin
      if ChartISO[I] > ChartMaxISO then
        ChartMaxISO := ChartISO[I];
      Ext := IntToStr(I) + '0'; // 80->800
      ETBarSeriesIso.AddBar(ChartISO[I], Ext, GUIsettings.CLISO);
    end;
  end;
  ChartMaxISO := Round(ChartMaxISO * 1.1);

  AdvRadioGroup2Click(Sender);
end;

procedure TFMain.SpeedBtnDetailsClick(Sender: TObject);
var
  SavedPath: string;
begin
  with ShellList do
  begin
    SavedPath := ShellTreeView.Path;
    Enabled := false;
    if SpeedBtnDetails.Down then
      ViewStyle := vsReport
    else
      ViewStyle := vsIcon;
    Enabled := true;
    ShellTreeView.Path := SavedPath;
  end;
  ShowMetadata;
  ShowPreview;
  CBoxDetails.Enabled := SpeedBtnDetails.Down;
end;

procedure TFMain.SpeedBtnExifClick(Sender: TObject);
begin
  AdvPanelMetaBottom.Visible := SpeedBtnQuick.Down;
  SpeedBtnQuickSave.Enabled := false;
  ShowMetadata;
end;

procedure TFMain.SpeedBtnLargeClick(Sender: TObject);
var
  F: integer;
begin
  F := ShellList.ItemIndex;
  if SpeedBtnLarge.Down then
  begin
    MemoQuick.Clear;
    MemoQuick.Text := EditQuick.Text;
    EditQuick.Visible := false;
    AdvPanelMetaBottom.Height := ScaleDesignDpi(105);
    if F <> -1 then
      MemoQuick.SetFocus;
  end
  else
  begin
    EditQuick.Text := MemoQuick.Text;
    AdvPanelMetaBottom.Height := ScaleDesignDpi(32);
    EditQuick.Visible := true;
    if F <> -1 then
      EditQuick.SetFocus;
  end;
end;

procedure TFMain.SpeedBtn_ETclearClick(Sender: TObject);
begin
  CBoxETdirect.ItemIndex := -1;
  CBoxETdirect.Repaint;
  CBoxETdirectChange(Sender);
end;

procedure TFMain.SpeedBtn_ETdirectClick(Sender: TObject);
var
  H: integer;
begin
  if SpeedBtn_ETdirect.Down then
  begin
    if SpeedBtn_ETedit.Down then
      H := 184 // min 181
    else
      H := 105;
    AdvPanelETdirect.Height := ScaleDesignDpi(H);
    EditETdirect.SetFocus;
  end
  else
  begin
    AdvPanelETdirect.Height := ScaleDesignDpi(32);
    ShellList.SetFocus;
  end;
end;

procedure TFMain.SpeedBtn_ETdSetDefClick(Sender: TObject);
begin
  GUIsettings.ETdirDefCmd := CBoxETdirect.ItemIndex;
end;

procedure TFMain.SpeedBtn_ETeditClick(Sender: TObject);
var
  H: integer;
begin
  if SpeedBtn_ETedit.Down then
    H := 181
  else
    H := 105;
  AdvPanelETdirect.Height := ScaleDesignDpi(H);
end;

procedure TFMain.SpeedBtn_GeotagClick(Sender: TObject);
begin
  ParseLatLon(EditMapFind.Text, FGeotagFiles.Lat, FGeotagFiles.Lon);
  if not (ValidLatLon(FGeotagFiles.Lat, FGeotagFiles.Lon)) then
  begin
    MessageDlgEx(StrNoValidLatLon, '', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK]);
    exit;
  end;

  if ShellList.SelectedFolder = nil then
  begin
    MessageDlgEx(StrNoFilesSelected, '', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK]);
    exit;
  end;

  if (Geosettings.ReverseGeoCodeDialog = false) then
  begin
    FGeotagFiles.FillPreview;
    FGeotagFiles.Execute;
  end
  else
    FGeotagFiles.ShowModal;
  RefreshSelected(Sender);
  ShowMetadata;
  ShowPreview;
end;

procedure TFMain.SpeedBtn_MapHomeClick(Sender: TObject);
begin
  MapGotoPlace(EdgeBrowser1, GUIsettings.DefGMapHome, '', OSMHome, InitialZoom_Out);
end;

procedure TFMain.SpeedBtn_MapSetHomeClick(Sender: TObject);
begin
  GUIsettings.DefGMapHome := EditMapFind.Text;
end;

procedure TFMain.SpeedBtn_ShowOnMapClick(Sender: TObject);
begin
  if ShellList.SelectedFolder <> nil then
    ShowImagesOnMap(EdgeBrowser1, ShellList.Path, GetGpsCoordinates(GetSelectedFiles))
  else
    ShowMessage(StrNoFilesSelected);
end;

procedure TFMain.Splitter1CanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
begin
  Accept := ((Splitter2.Left - Splitter2.Width - Splitter1.Width - NewSize) > MinFileListWidth);
end;

procedure TFMain.Splitter1Moved(Sender: TObject);
begin
  AlignStatusBar;
end;

procedure TFMain.Splitter2CanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
begin
  Accept := ((ClientWidth - Splitter1.Left - Splitter1.Width - Splitter2.Width - NewSize) > MinFileListWidth);
end;

procedure TFMain.Splitter2Moved(Sender: TObject);
begin
  AlignStatusBar;
end;

procedure TFMain.SetGuiStyle;
var
  AStyleService: TCustomStyleServices;
begin
  GUIColorWindow := clBlack;
  AStyleService := TStyleManager.Style[GUIsettings.GuiStyle];
  if Assigned(AStyleService) then
    GUIColorWindow := AStyleService.GetStyleColor(scWindow);

  BreadcrumbBar.Style := GUIsettings.GuiStyle;
end;

procedure TFMain.ShellistThumbError(Sender: TObject; Item: TListItem; E: Exception);
begin
  raise Exception.Create(Format(StrErrorSSCreating, [E.Message, #10, ShellList.Folders[Item.Index].PathName]));
end;

procedure TFMain.ShellistThumbGenerate(Sender: TObject; Item: TListItem; Status: TThumbGenStatus; Total, Remaining: integer);
begin
  if (Remaining > 0) then
    StatusBar.Panels[1].Text := Format(StrRemainingThumbnails, [Remaining])
  else
    StatusBar.Panels[1].Text := '';
end;

procedure TFMain.CounterETEvent(Counter: integer);
begin
  StatusBar.Panels[1].Text := Format(StrDFilesRemaining, [Counter]);
  StatusBar.Update;
end;

end.
