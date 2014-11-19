unit UsersModel;

interface
uses
  SMB.Model, SMB.ConnectionManager;
type
  TUsersModel = class (TModel)
  public
    constructor Create(ConnectionManager: IConnectionManager); override;
  end;

implementation

uses
  Vcl.Dialogs;

{ TUsersModel }

constructor TUsersModel.Create(ConnectionManager: IConnectionManager);
begin
  inherited;
  ExecQuery('select DB_Name, Kod_Exec, Key_Div, Corpus, Mesto, Net_Name, ' +
    'P_Sost, Tel, FIO, mask, Key_Pers from T_User');
  SetDisplayLabel('DB_Name',  'Имя пользователя в домене');
  SetDisplayLabel('FIO',      'Фамилия И.О.');
end;

end.
