unit UsersForm;

interface

uses
  UsersModel, SMBBaseMDIChild, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.StdCtrls, System.Classes,
  Vcl.Controls, Vcl.ExtCtrls, SMB.Model, SMB.Controller;

type
  TfmUsers = class(TSMBBaseMDIChild)
    gdUsers: TDBGridEh;
  protected
    function CreateModel: TModel; override;
    function CreateController: TController; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses
  SMBFormManager, SMB.ConnectionManager, UsersController;

{$R *.dfm}

{ TfmUsers }

constructor TfmUsers.Create(AOwner: TComponent);
begin
  inherited;
  gdUsers.DataSource := Model.DataSource;
end;

function TfmUsers.CreateController: TController;
begin
  Result := TUsersController.Create(Self, Model);
end;

function TfmUsers.CreateModel: TModel;
begin
  Result := TUsersModel.Create(ConnectionManager);
end;

initialization
  FormManager.RegisterForm('Users', TfmUsers, 'Справочники/Пользователи');

end.
