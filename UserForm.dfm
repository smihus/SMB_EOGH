inherited fmUser: TfmUser
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '
  ClientHeight = 242
  ClientWidth = 284
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  OnShow = FormShow
  ExplicitWidth = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited plBottomButtons: TPanel
    Top = 215
    Width = 284
    ExplicitWidth = 284
    inherited bnClose: TButton
      Left = 208
      ExplicitLeft = 208
    end
    object bnSave: TButton
      Left = 133
      Top = 1
      Width = 75
      Height = 25
      Action = aUpdate
      Align = alRight
      TabOrder = 1
    end
  end
  object pUserData: TPanel [1]
    Left = 0
    Top = 0
    Width = 284
    Height = 215
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 1
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 1
    object lLoginName: TLabel
      Left = 1
      Top = 1
      Width = 282
      Height = 13
      Align = alTop
      Caption = #1051#1086#1075#1080#1085' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ExplicitWidth = 104
    end
    object lRoles: TLabel
      Left = 1
      Top = 35
      Width = 282
      Height = 13
      Align = alTop
      Caption = #1056#1086#1083#1080
      Layout = tlBottom
      ExplicitWidth = 24
    end
    object eLoginName: TDBEditEh
      Left = 1
      Top = 14
      Width = 282
      Height = 21
      Margins.Bottom = 10
      Align = alTop
      DynProps = <>
      EditButtons = <>
      TabOrder = 0
      Visible = True
      OnChange = eLoginNameChange
    end
    object clbRoles: TCheckListBox
      Left = 1
      Top = 48
      Width = 282
      Height = 166
      OnClickCheck = clbRolesClickCheck
      Align = alClient
      ItemHeight = 13
      PopupMenu = pmBase
      TabOrder = 1
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
