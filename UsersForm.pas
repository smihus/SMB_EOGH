unit UsersForm;

interface

uses
  SMBBaseMDIChild, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.StdCtrls, System.Classes,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Menus, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, System.Actions, Vcl.ActnList, UsersModel;

type
  TfmUsers = class(TSMBBaseMDIChild)
    gdUsers: TDBGridEh;
    alMain: TActionList;
    aCreateUser: TAction;
    aOpenUser: TAction;
    aDeleteUser: TAction;
    mmMain: TMainMenu;
    miActions: TMenuItem;
    miCreate: TMenuItem;
    miUpdate: TMenuItem;
    miDelete: TMenuItem;
    procedure aOpenUserExecute(Sender: TObject);
    procedure aCreateUserExecute(Sender: TObject);
    procedure aDeleteUserExecute(Sender: TObject);
  private
    FUsersModel: TUsersModel;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses
  SMBFormManager, UserForm, SMB.ConnectionManager, Vcl.Dialogs, System.UITypes;

{$R *.dfm}

{ TfmUsers }

procedure TfmUsers.aCreateUserExecute(Sender: TObject);
var
  UserF: TfmUser;
begin
  inherited;
  UserF := TfmUser.Create(Owner);
  UserF.Show;
end;

procedure TfmUsers.aDeleteUserExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg('Вы действительно хотите удалить этого пользователя?',
      mtConfirmation, mbYesNo, 0, mbNo) = mrYes then
        FUsersModel.DeleteUser;
end;

procedure TfmUsers.aOpenUserExecute(Sender: TObject);
var
  UserF: TfmUser;
begin
  inherited;
  UserF := TfmUser.Create(Owner, FUsersModel.UserID);
  UserF.Show;
end;

constructor TfmUsers.Create(AOwner: TComponent);
begin
  inherited;
  FUsersModel         := TUsersModel.Create(ConnectionManager);
  gdUsers.DataSource  := FUsersModel.DataSource;
end;

initialization
  FormManager.RegisterForm('Users', TfmUsers, 'Администрирование/Пользователи');

end.
