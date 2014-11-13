unit UsersModel;

interface
uses
  SMBModel;
type
  TUsersModel = class (TModel)
  public
    constructor Create; override;
  end;

implementation

{ TUsersModel }

constructor TUsersModel.Create;
begin
  inherited;
  AddDataSource('Users', 'select * from T_User');
end;

end.
