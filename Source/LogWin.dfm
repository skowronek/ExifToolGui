object FLogWin: TFLogWin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'ExifTool LOG'
  ClientHeight = 544
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 184
    Width = 582
    Height = 6
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 172
    ExplicitWidth = 568
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 402
    Width = 582
    Height = 6
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 403
    ExplicitWidth = 568
  end
  object PctExecs: TPageControl
    Left = 0
    Top = 0
    Width = 582
    Height = 184
    ActivePage = TabExecs
    Align = alTop
    TabOrder = 0
    object TabExecs: TTabSheet
      Caption = 'Logged ExifTool commands'
      object LBExecs: TListBox
        Left = 0
        Top = 0
        Width = 574
        Height = 156
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = LBExecsClick
        ExplicitHeight = 131
      end
    end
  end
  object PnlMidle: TPanel
    Left = 0
    Top = 190
    Width = 582
    Height = 212
    Align = alClient
    Constraints.MinWidth = 200
    TabOrder = 2
    ExplicitTop = 165
    ExplicitWidth = 578
    ExplicitHeight = 236
    object Splitter3: TSplitter
      Left = 288
      Top = 1
      Width = 6
      Height = 210
      ExplicitHeight = 220
    end
    object PCTCommands: TPageControl
      Left = 1
      Top = 1
      Width = 287
      Height = 210
      ActivePage = TabCommands
      Align = alLeft
      TabOrder = 1
      ExplicitHeight = 234
      object TabCommands: TTabSheet
        Caption = 'Executed commands'
        object MemoCmds: TMemo
          Left = 0
          Top = 0
          Width = 279
          Height = 182
          Align = alClient
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          OnKeyDown = MemoKeyDown
          ExplicitHeight = 206
        end
      end
    end
    object PCTOutput: TPageControl
      Left = 294
      Top = 1
      Width = 287
      Height = 210
      ActivePage = TabOutput
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 283
      ExplicitHeight = 234
      object TabOutput: TTabSheet
        Caption = 'Output from commands'
        object MemoOuts: TMemo
          Left = 0
          Top = 0
          Width = 279
          Height = 182
          Align = alClient
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          OnKeyDown = MemoKeyDown
          ExplicitWidth = 275
          ExplicitHeight = 206
        end
      end
    end
  end
  object PCTErrors: TPageControl
    Left = 0
    Top = 408
    Width = 582
    Height = 136
    ActivePage = TabErrors
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 407
    ExplicitWidth = 578
    object TabErrors: TTabSheet
      Caption = 'Errors'
      object MemoErrs: TMemo
        Left = 0
        Top = 0
        Width = 574
        Height = 108
        Align = alClient
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        OnKeyDown = MemoKeyDown
        ExplicitWidth = 570
      end
    end
  end
  object ChkShowAll: TCheckBox
    Left = 163
    Top = 1
    Width = 131
    Height = 17
    Hint = 
      'Show also non-critical commands to populate the Metadata and fil' +
      'elist?'
    Caption = 'Show all Commands'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
end
