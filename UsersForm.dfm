inherited fmUsers: TfmUsers
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  ClientHeight = 439
  ClientWidth = 584
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
  ExplicitWidth = 600
  ExplicitHeight = 497
  PixelsPerInch = 96
  TextHeight = 13
  inherited plBottomButtons: TPanel
    Top = 412
    Width = 584
    ExplicitTop = 412
    ExplicitWidth = 584
    inherited bnClose: TButton
      Left = 508
      ExplicitLeft = 508
    end
  end
  object gdUsers: TDBGridEh [1]
    Left = 0
    Top = 0
    Width = 584
    Height = 412
    Align = alClient
    DynProps = <>
    IndicatorOptions = [gioShowRowIndicatorEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghExtendVertLines]
    PopupMenu = pmBase
    ReadOnly = True
    SearchPanel.Enabled = True
    SearchPanel.FilterOnTyping = True
    STFilter.InstantApply = False
    TabOrder = 1
    OnDblClick = gdUsersDblClick
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  inherited alBase: TActionList
    Left = 64
    Top = 88
  end
  inherited mmBase: TMainMenu
    Left = 24
    Top = 88
  end
  inherited pmBase: TPopupMenu
    Left = 104
    Top = 88
  end
end
