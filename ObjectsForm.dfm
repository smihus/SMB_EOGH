inherited fmObjects: TfmObjects
  Caption = #1054#1073#1098#1077#1082#1090#1099' '#1076#1083#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1088#1072#1074' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited plBottomButtons: TPanel
    ExplicitTop = 215
  end
  object gdObjects: TDBGridEh [1]
    Left = 0
    Top = 0
    Width = 418
    Height = 215
    Align = alClient
    AutoFitColWidths = True
    DynProps = <>
    ImeMode = imDisable
    IndicatorOptions = [gioShowRowIndicatorEh]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghExtendVertLines]
    PopupMenu = pmBase
    RowHeight = 4
    RowLines = 1
    TabOrder = 1
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'object_id'
        Footers = <>
        Visible = False
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'parent_id'
        Footers = <>
        Visible = False
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'name'
        Footers = <>
        Title.Caption = #1060#1080#1079#1080#1095#1077#1089#1082#1086#1077' '#1080#1084#1103' '#1086#1073#1098#1077#1082#1090#1072
        Width = 150
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'label'
        Footers = <>
        Title.Caption = #1055#1086#1076#1089#1080#1089#1090#1077#1084#1072'/'#1054#1073#1098#1077#1082#1090
        Width = 200
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  inherited alBase: TActionList
    Top = 104
  end
  inherited mmBase: TMainMenu
    Top = 104
  end
  inherited pmBase: TPopupMenu
    Left = 128
    Top = 104
  end
end
