object FrmAbout: TFrmAbout
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'About'
  ClientHeight = 264
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Image1: TImage
    Left = 0
    Top = 1
    Width = 39
    Height = 38
    Picture.Data = {
      055449636F6E0000010001002020100000000000E80200001600000028000000
      2000000040000000010004000000000080020000000000000000000000000000
      0000000000000000000080000080000000808000800000008000800080800000
      80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
      FFFFFF0000000000000000000000000000000000000000000000000000000000
      0000000000007CCCCCCCCCCCCCCCCCCCCCCCCC0000007CFFFFFFFFFFFFFFFFFF
      FFFFFC0000007CFFFFFFFFFFFFFFFFFFFFFFFC0000007CFFFFFFFFFFFFFFFFFF
      FFFFFC0000007CFFFF4444FFFF4444FFF44FFC0000007CFFF44FF44FF44FF44F
      F44FFC0000007CFFF44FF44FF44FF44FF44FFC0000007CFFF44F444FF44FF44F
      F44FFC0000007CFFF44FFFFFF44FF44FF44FFC0000007CFFF44FFFFFF44FF44F
      F44FFC0000007CFFFF4444FFF44FF44FF44FFC0000007CFFFFFFFFFFFFFFFFFF
      FFFFFC0000007CFFFFFFFFFFFFFFFFFFFFFFFC0077777CFFFFFFFFFFFFFFFFFF
      FFFFFC0700007CCCCCCCCCCCCCCCCCCCCCCCCC0000007CCCCCCCCCCCCCCCCCCC
      CCCCCC0000007CCCCCCCCCCCCCCCCCCCCCCCCC00000077777777777777777777
      7777770000000000000000000000000000000000000000000000000000000000
      000000000FFFF0F00F0F00F000FF0FFF0FFF0FF00F00000FF00F00F000F00F0F
      0F0F0F000F00000FF00F00F000F00F0F0F0F0F000FFF00F00F0F0FFF0FFF0FFF
      0FFF0F000F000000000000F000F0000000000F000FFFF000000F000F00F00000
      00000F0000000000000000000000000000000000000000000000000000000000
      00000000CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      CCCCCCCCFFFFFFFFFC000001F0000001F0000001F0000001F0000001F0000001
      F0000001F0000001F0000001F0000001F0000001F0000001F0000001F0000001
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000}
  end
  object LblVersion: TLabel
    Left = 45
    Top = 8
    Width = 360
    Height = 65
    AutoSize = False
    Caption = 'LblVersion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object LblSource: TLabel
    Left = 45
    Top = 95
    Width = 360
    Height = 18
    AutoSize = False
    Caption = 'LblSource'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
    OnClick = LblOpenUrl
    OnMouseEnter = LblUrlEnter
    OnMouseLeave = LblUrlLeave
  end
  object LblForum: TLabel
    Left = 45
    Top = 121
    Width = 360
    Height = 18
    AutoSize = False
    Caption = 'LblForum'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
    OnClick = LblOpenUrl
    OnMouseEnter = LblUrlEnter
    OnMouseLeave = LblUrlLeave
  end
  object LblExifTool: TLabel
    Left = 45
    Top = 148
    Width = 360
    Height = 18
    AutoSize = False
    Caption = 'LblExifTool'
  end
  object LblScreen: TLabel
    Left = 45
    Top = 208
    Width = 360
    Height = 22
    AutoSize = False
    Caption = 'LblScreen'
  end
  object Panel1: TPanel
    Left = 0
    Top = 235
    Width = 414
    Height = 29
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 223
    ExplicitWidth = 406
    DesignSize = (
      414
      29)
    object BtnOk: TBitBtn
      Left = 315
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
      ExplicitLeft = 307
    end
  end
end
