inherited fmUser: TfmUser
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '
  ClientHeight = 262
  ClientWidth = 284
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  ExplicitWidth = 300
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 13
  inherited plBottomButtons: TPanel
    Top = 235
    Width = 284
    inherited bnClose: TButton
      Left = 208
    end
    object bnSave: TButton
      Left = 133
      Top = 1
      Width = 75
      Height = 25
      Align = alRight
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
      ExplicitLeft = 104
      ExplicitTop = 0
    end
  end
  object pUserData: TPanel
    Left = 0
    Top = 0
    Width = 284
    Height = 235
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 1
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 172
    ExplicitWidth = 314
    ExplicitHeight = 27
    object lLoginName: TLabel
      Left = 1
      Top = 1
      Width = 282
      Height = 13
      Align = alTop
      Caption = #1051#1086#1075#1080#1085' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ExplicitLeft = 0
      ExplicitTop = -5
      ExplicitWidth = 312
    end
    object lRoles: TLabel
      Left = 1
      Top = 36
      Width = 282
      Height = 21
      Align = alTop
      Caption = #1056#1086#1083#1080
      Layout = tlBottom
      ExplicitWidth = 289
    end
    object eLoginName: TDBEditEh
      Left = 1
      Top = 14
      Width = 282
      Height = 22
      Margins.Bottom = 10
      Align = alTop
      DynProps = <>
      EditButtons = <>
      TabOrder = 0
      Text = 'eLoginName'
      Visible = True
      ExplicitLeft = 2
      ExplicitTop = 11
      ExplicitWidth = 312
      ExplicitHeight = 21
    end
    object clbRoles: TCheckListBox
      Left = 1
      Top = 57
      Width = 282
      Height = 177
      OnClickCheck = clbRolesClickCheck
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 314
      ExplicitHeight = 97
    end
  end
end