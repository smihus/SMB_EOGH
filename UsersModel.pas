unit UsersModel;

interface
uses
  SMB.Model, Data.Win.ADODB, System.Generics.Collections, Data.DB;
type
  TUsersModel = class (TModel)
  private
    FUsersRoles: TDictionary<Integer, String>;
    function GetUserID: Integer;
    procedure SetUserID(const Value: Integer);
    procedure AddCalcStringField(DataSet: TDataSet; FieldName,
      DisplayLabel: String; DisplatySize: Integer);
    procedure DoCalculateFields(DataSet: TDataSet);
    function GetLoginName: String;
  protected
    procedure Init; override;
  public
    function GetUserRoles: TADOQuery;
    procedure GetUsersRoles;
    procedure AddRole(RoleName: String);
    procedure RemoveRole(RoleName: String);
    procedure NewUser;
    procedure DeleteUser;
    property UserID: Integer read GetUserID write SetUserID;
    property LoginName: String read GetLoginName;
    procedure Update(UserID: Integer);
  end;

implementation

uses
  SMB.ConnectionManager, System.Classes;

{ TUsersModel }

procedure TUsersModel.AddCalcStringField(DataSet: TDataSet; FieldName,DisplayLabel: String; DisplatySize:
Integer);
var
  f : TField;
  i : Integer;
begin
  with DataSet do
  begin
    FieldDefs.Update;
    Active := False;
    for i := 0 to FieldDefs.Count - 1 do
      if not Assigned(FindField(FieldDefs[i].Name)) then
        FieldDefs.Items[i].CreateField(DataSet);
    f := tStringField.Create(DataSet);
    f.Name := DataSet.Name+FieldName;
    f.FieldName := FieldName;
    f.DisplayLabel := DisplayLabel;
    f.DisplayWidth := DisplatySize;
    f.Size         := DisplatySize;
    f.Calculated := True;
    f.DataSet := DataSet;

    FieldDefs.Update;
    Active := True;
  end;
end;

procedure TUsersModel.AddRole(RoleName: String);
var
  Command: TADOCommand;
begin
  Command := TADOCommand.Create(nil);
  with Command do
  begin
    Connection  := ConnectionManager.Connection['EOGH'];
    CommandText :=
      'insert into UsersRoles (user_id, role_id) ' +
      'select :user_id, role_id ' +
      'from Roles ' +
      'where name = :RoleName';
    Parameters.ParamValues['user_id']   := UserID;
    Parameters.ParamValues['RoleName']  := RoleName;
    Execute;
  end;
end;

procedure TUsersModel.DeleteUser;
begin
  DataSource.DataSet.Delete;
end;

procedure TUsersModel.DoCalculateFields(DataSet: TDataSet);
var
  Role: String;
begin
  with DataSet do
  begin
    FUsersRoles.TryGetValue(FieldByName('user_id').AsInteger, Role);
    FieldByName('CalcRoles').AsString := Role;
  end;
end;

function TUsersModel.GetLoginName: String;
begin
  Result := DataSource.DataSet.FieldValues['login_name'];
end;

function TUsersModel.GetUserID: Integer;
begin
  Result := DataSource.DataSet.FieldValues['user_id'];
end;

procedure TUsersModel.GetUsersRoles;
var
  Query: TADOQuery;
  User: Integer;
  LastUser: Integer;
  Role: String;
begin
  LastUser := -1;
  FUsersRoles.Clear;
  Query := TADOQuery.Create(nil);
  with Query do
  begin
    Active := False;
    Connection  := ConnectionManager.Connection['EOGH'];
    SQL.Text    :=
      'select u.user_id, r.name ' +
      'from Users u ' +
      'join UsersRoles ur ' +
      'on ur.user_id = u.user_id ' +
      'left join Roles r ' +
      'on r.role_id = ur.role_id';
    Active := True;
    while not Query.Eof do
    begin
      User := FieldValues['user_id'];
      Role := FieldValues['name'];
      if User <> LastUser then
        FUsersRoles.Add(User, Role)
      else
        FUsersRoles.Items[User] := FUsersRoles.Items[User] + ', ' + Role;
      LastUser := User;
      Next;
    end;
  end;
  Query.Free;
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
  DataSource.DataSet.OnCalcFields := DoCalculateFields;
  FUsersRoles := TDictionary<Integer, String>.Create;
  ExecQuery('select user_id, login_name from Users order by user_id asc');
  GetUsersRoles;
  AddCalcStringField(DataSource.DataSet, 'CalcRoles', 'Роли', 50);

  SetFieldParameters('user_id', 'Код', 5);
  SetFieldParameters('login_name', 'Логин', 20);
  DataSource.DataSet.Active := True;
end;

procedure TUsersModel.NewUser;
begin
  with DataSource.DataSet do
  begin
    Append;
    FieldValues['login_name'] := '';
    Post;
  end;

end;

procedure TUsersModel.RemoveRole(RoleName: String);
var
  Command: TADOCommand;
begin
  Command := TADOCommand.Create(nil);
  with Command do
  begin
    Connection  := ConnectionManager.Connection['EOGH'];
    CommandText :=
      'delete from UsersRoles ' +
      'where user_id = :user_id and ' +
      'role_id = (select role_id from Roles where name = :RoleName)';
    Parameters.ParamValues['user_id']   := UserID;
    Parameters.ParamValues['RoleName']  := RoleName;
    Execute;
  end;
end;

procedure TUsersModel.SetUserID(const Value: Integer);
begin
  DataSource.DataSet.Locate('user_id', Value, [loPartialKey]);
end;

procedure TUsersModel.Update(UserID: Integer);
begin
  DataSource.DataSet.Active := False;
  GetUsersRoles;
  DataSource.DataSet.Active := True;
  DataSource.DataSet.Locate('user_id', UserID, [loPartialKey]);
end;

end.
