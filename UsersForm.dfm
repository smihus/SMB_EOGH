inherited fmUsers: TfmUsers
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  ClientHeight = 242
  Menu = mmMain
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited plBottomButtons: TPanel
    Top = 215
    ExplicitTop = 215
  end
  object gdUsers: TDBGridEh
    Left = 0
    Top = 0
    Width = 418
    Height = 215
    Align = alClient
    DynProps = <>
    IndicatorOptions = [gioShowRowIndicatorEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghExtendVertLines]
    ReadOnly = True
    SearchPanel.Enabled = True
    SearchPanel.FilterOnTyping = True
    STFilter.InstantApply = False
    TabOrder = 1
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object alMain: TActionList
    Left = 384
    Top = 72
    object aCreateUser: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnExecute = aCreateUserExecute
    end
    object aOpenUser: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100
      ShortCut = 113
      OnExecute = aOpenUserExecute
    end
    object aDeleteUser: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 8238
      OnExecute = aDeleteUserExecute
    end
  end
  object mmMain: TMainMenu
    AutoMerge = True
    Left = 384
    Top = 120
    object miActions: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      GroupIndex = 1
      object miCreate: TMenuItem
        Action = aCreateUser
      end
      object miUpdate: TMenuItem
        Action = aOpenUser
      end
      object miDelete: TMenuItem
        Action = aDeleteUser
      end
    end
  end
end
