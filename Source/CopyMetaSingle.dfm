object FCopyMetaSingle: TFCopyMetaSingle
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Import into selected files'
  ClientHeight = 386
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    Left = 436
    Top = 317
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 367
    Width = 520
    Height = 19
    Panels = <>
    ExplicitTop = 366
    ExplicitWidth = 516
  end
  object AdvPanel1: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 367
    Align = alLeft
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 366
    object ChkImportAll: TCheckBox
      Left = 16
      Top = 16
      Width = 355
      Height = 17
      Caption = '-import ALL metadata'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = ChkImportAllClick
    end
    object ChkNoOverWrite: TCheckBox
      Left = 16
      Top = 342
      Width = 355
      Height = 17
      Caption = 'Dont overwrite existing data (-wm cg)'
      TabOrder = 3
    end
    object PnlButtons: TPanel
      Left = 16
      Top = 45
      Width = 355
      Height = 25
      TabOrder = 1
      object SpbAdd: TSpeedButton
        Left = 2
        Top = 0
        Width = 70
        Height = 22
        Caption = 'Add'
        OnClick = SpbAddClick
      end
      object SpbDel: TSpeedButton
        Left = 68
        Top = 0
        Width = 70
        Height = 22
        Caption = 'Del'
        OnClick = SpbDelClick
      end
      object SpbEdit: TSpeedButton
        Left = 134
        Top = 0
        Width = 70
        Height = 22
        Caption = 'Edit'
        OnClick = SpbEditClick
      end
      object SpbReset: TSpeedButton
        Left = 200
        Top = 0
        Width = 70
        Height = 22
        Caption = 'Reset'
        OnClick = SpbResetClick
      end
    end
    object LvTagNames: TListView
      Left = 16
      Top = 76
      Width = 355
      Height = 260
      Checkboxes = True
      Columns = <
        item
          Caption = 'Tag name'
          Width = 320
        end>
      GridLines = True
      HideSelection = False
      SmallImages = VirtualImageList
      TabOrder = 2
      ViewStyle = vsReport
      OnCustomDrawItem = LvTagNamesCustomDrawItem
      OnEdited = LvTagNamesEdited
      OnItemChecked = LvTagNamesItemChecked
    end
  end
  object BtnCancel: TButton
    Left = 436
    Top = 16
    Width = 64
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object BtnExecute: TButton
    Left = 436
    Top = 336
    Width = 64
    Height = 25
    Caption = 'Execute'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 3
    OnClick = BtnExecuteClick
  end
  object BtnPreview: TButton
    Left = 436
    Top = 286
    Width = 64
    Height = 25
    Caption = 'Preview'
    Enabled = False
    TabOrder = 2
    OnClick = BtnPreviewClick
  end
  object ImageCollection: TImageCollection
    Images = <
      item
        Name = 'LvExcludeTag'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000004600000046080300000046F012
              B60000000774494D4507E80718063B3AEF7DDA17000000097048597300000AF0
              00000AF00142AC34980000000467414D410000B18F0BFC610500000117504C54
              45FFFFFFF7F7F73131312929292121213939394242424A4A4A5A5A5AEFEFEF08
              08080800001800001000000000001818181010106300008400008C00007B0000
              6B0000730000CE0808D61818CE2121CE1818D61010D60808DE0000DE0808E710
              10EF1818EF3131EF2929EF2121EF1010EF0000CE0000D60000C60000BD0000B5
              0000AD0000A500009C00009400005A0000290000DE4A4ADE6363DE5252DE5A5A
              E75252E74242E74A4ADE4242E73939E73131E72929F71010F70808FF0000F700
              00310000E76B6BE76363E75A5AF72121F71818FF1010FF0808E7737339000021
              0000DE6B6B4A0000E77B7BCE2929E78484C61010D63939D64242D64A4ADE3939
              DE3131E72121C60808DE2929E70000420000DE2121520000B3D1938A00000243
              4944415478DAED94696FDA401086617D40CD654E731628B0AC6D0C8423019AD8
              40DB1802292D6DD3D2E6FFFF8E8E0DC6548A02B2FA711F468385EC47338BF5FA
              7C140A8542A150CEE13FB9E639C4F388E311C373318E832B8E115F6A88651112
              18148B2146842F26C8BB9650043E569D27E212062221F6E811A6C954269549C7
              E3F14EBC033C3F9F6F5ABBDD6A69ED4E584087C54219526A124214455181D611
              19FF19DE00D71693325664B80BE3266E9680DD6ED730B0D6151D4D9A909F1286
              06850996A024A9589470F1D7D1329E94ED276D1A80B1A7F95B3868840EF9F275
              BBDD7EDBDA8C46DF6D7E00E3A3653C797AAA556A15A05EA9DCEEB9BBBB2BAD05
              E76C3AF2E7C566B3795C2C16B3D96A369FCF3F00C3A1BB115826D56AF51D5003
              3ED980E7DE2C2DC583260A9A47B0EC359665FEAAE5A36BB9379BDD9833CD9AC0
              34175B6AA716134F9D2316D6726EE5D16292A326BA56F30B4F1B99A64EC2ACB3
              D452CDADBCCD62EAF283A3119724D7F3663175F5E178C45335DFF3B21160A811
              C6F9C32D8D378BA541CE5253253FB8D072FB8F45D7752DEC4C23765B85AB5EAF
              3F18F4AFFAC3EB9BD1D87A7CF21E38B154EA75FBEDB7D00D43D7AD328C76D899
              460827A56C2E97CDE6B3857CA15828148B5092547A5BAEB8B3D41BB849642B07
              B0A212A5D552354D6B273AD1C0418342F14422994C251229209DC9A481571B44
              16C4965D21E7ED7BE31342FB9F21DBA2760EC295107DA909315610595664AC08
              65182B7C4F42193110B10CE21044321708F08160F0D2E6F3FB5D0F8542A15028
              FF97BF5FECE036BEFCEE640000000049454E44AE426082}
          end>
      end
      item
        Name = 'LvIncludeTag'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000004600000046080300000046F012
              B60000000774494D4507E80719111A254F3F1091000000097048597300000AF0
              00000AF00142AC34980000000467414D410000B18F0BFC610500000300504C54
              45FFFFFFF7F7F742424218181810101021212129292939393931313152525221
              0000290000310000180000100000080000080808000000630000D60000C60000
              BD0000CE0000AD0000B500009C00009400008400007B0000EFEFEF6B6B6BF700
              00FF0000EF00004A4A4ADE0000F70808FF1010FF0808A50000F710108C0000E7
              0000F71818EF0808730000EF1010EF21216B0000F72121EF1818420000390000
              EF29295A5A5A5200004A0000EF3131CE0808D61818CE2121CE1818D61010D608
              08DE0808E710105A0000DE4A4ADE6363DE5252DE5A5AE75252E74242E74A4ADE
              4242E73939E73131E72929E76B6BE76363E75A5AE77373DE6B6BE77B7BCE2929
              E78484C61010D63939D64242D64A4ADE3939DE3131E72121C60808DE2929DE21
              21D62929DE1010DE1818DE737363636300000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000000000000FF
              004BBE289D0000000174524E530040E6D866000001F54944415478DAD597416E
              C32010456DC0808D0DC301DC05FB4A9512A1AC7B96DCFF0A294E8DEB0416F140
              5575E2C84EA43CCD1FC29FA169FE5FB4EB1B154E10E7FABEF757EFDFAE5782A3
              1063ACD6D6841B8035C01886E2CDE9F618934524E4CDED3934221F6F138CA2C7
              0BDDA7D90CF47032B3D7A9A8E398A64F450DDD5F61E64C6D30A25C254C2A6AAA
              531B7D1CD3666A63791551BA1246D611751C53299BEC4A0904C6FC1606E37EB9
              DA90E3B6255EABCD9E4B8424440A2239115488F02438CB8802D975520297944A
              CEC28DEB9D4EA3C36BB976113EA55B53EF630AA14DB77160BC1504C85598792F
              C12816311F259813AC18F82CC15C20D6A608738EADD41661543468B89460C658
              E24A185B84D9DA059C4B305B2B6565185A65336CEDC29661A241B322CC14B361
              AA0813B381A90463DD8A91E6B51FE8518518A6610A96156CEB7E99F8EF9B1B30
              DF5F9B659A5E7C303C8581FA1973B60C6807ACEB185F2C94F3C57C77A62C79B0
              582E850C962C9C23CE7BA713CC66098F9EDEFE7032A193493418D47CB84FA5D9
              8C9843438A3933C469282B0A81B11951353088234333674B8CC826C128D44A55
              11955929550953A736982343068339956544552A314E548A410CE93951886C66
              CD6A60DA341BA311A21ACD0635AA61E903617C35600143094337A5ECDE06045F
              ACBEC751AA45FBF216FA02014BD0A29E1C02E40000000049454E44AE426082}
          end>
      end>
    Left = 461
    Top = 78
  end
  object VirtualImageList: TVirtualImageList
    DisabledOpacity = 127
    Images = <
      item
        CollectionIndex = 1
        CollectionName = 'LvIncludeTag'
        Name = 'LvIncludeTag'
      end
      item
        CollectionIndex = 0
        CollectionName = 'LvExcludeTag'
        Name = 'LvExcludeTag'
      end>
    ImageCollection = ImageCollection
    Left = 460
    Top = 142
  end
end
