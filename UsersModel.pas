unit UsersModel;

interface
uses
  SMB.Model, Data.Win.ADODB;
type
  TUsersModel = class (TModel)
  private
    function GetUserID: Integer;
    procedure SetUserID(const Value: Integer);
  protected
    procedure Init; override;
  public
    function GetUserRoles(): TADOQuery;
    property UserID: Integer read GetUserID write SetUserID;
  end;

implementation

uses
  SMB.ConnectionManager, Data.DB;

{ TUsersModel }

function TUsersModel.GetUserID: Integer;
begin
  Result := DataSource.DataSet.FieldValues['user_id'];
end;

function TUsersModel.GetUserRoles(): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  with Result do
  begin
    Active      := False;
    Connection  := ConnectionManager.Connection['EOGH'];
    SQL.Text    :=
      'select r.name as Role, ' +
      '(CASE WHEN ur.user_id IS NULL THEN 0 ELSE 1 END) as Checked ' +
      'from Roles r ' +
      'left join UsersRoles ur ' +
      'on ur.role_id = r.role_id and ur.user_id = :user_id';
    Parameters.ParamValues['user_id'] := UserID;
    Active := True;
  end;
end;

procedure TUsersModel.Init;
begin
  inherited;
  ExecQuery('select user_id, login_name from Users order by user_id asc');
  SetFieldParameters('user_id', 'Код', 5);
  SetFieldParameters('login_name', 'Логин', 20);
end;

procedure TUsersModel.SetUserID(const Value: Integer);
begin
  DataSource.DataSet.Locate('user_id', Value, [loPartialKey]);
end;

end.
