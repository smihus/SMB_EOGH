inherited fmRoles: TfmRoles
  Caption = #1056#1086#1083#1080
  ClientHeight = 367
  ClientWidth = 584
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
  ExplicitWidth = 600
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 13
  inherited plBottomButtons: TPanel
    Top = 340
    Width = 584
    ExplicitTop = 340
    ExplicitWidth = 584
    inherited bnClose: TButton
      Left = 508
      ExplicitLeft = 508
    end
  end
  object DBGridEh1: TDBGridEh [1]
    Left = 0
    Top = 0
    Width = 584
    Height = 340
    Align = alClient
    DynProps = <>
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 1
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  inherited pmBase: TPopupMenu
    Left = 112
    Top = 8
  end
end
