inherited fmMain: TfmMain
  Caption = 'fmMain'
  ClientHeight = 262
  ClientWidth = 384
  WindowState = wsMaximized
  ExplicitWidth = 400
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited mmMenu: TMainMenu
    inherited N1: TMenuItem
      object N4: TMenuItem
        Action = aOpenUsers
      end
      object N5: TMenuItem
        Action = aOpenRoles
      end
    end
  end
  inherited alMain: TActionList
    object aOpenUsers: TAction
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      OnExecute = aOpenUsersExecute
    end
    object aOpenRoles: TAction
      Caption = #1056#1086#1083#1080
      OnExecute = aOpenRolesExecute
    end
  end
end
