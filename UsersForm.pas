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
    procedure gdUsersDblClick(Sender: TObject);
  private
    FUsersModel: TUsersModel;
  protected
    procedure GetFormActions(out CanCreateData, CanReadData, CanUpdateData, CanDeleteData: Boolean); override;
    procedure DoCreateData; override;
    procedure DoReadData; override;
    procedure DoDeleteData; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Refresh(UserID: Integer);
  end;

implementation
uses
  SMBFormManager, UserForm, SMB.ConnectionManager, Vcl.Dialogs, System.UITypes;

{$R *.dfm}

{ TfmUsers }

constructor TfmUsers.Create(AOwner: TComponent);
begin
  inherited;
  FUsersModel         := TUsersModel.Create(ConnectionManager);
  gdUsers.DataSource  := FUsersModel.DataSource;
end;

procedure TfmUsers.DoCreateData;
var
  UserF: TfmUser;
begin
  inherited;
  UserF := TfmUser.Create(Self);
  UserF.Show;
end;

procedure TfmUsers.DoDeleteData;
begin
  inherited;
  if MessageDlg('Вы действительно хотите удалить этого пользователя?',
    mtConfirmation, mbYesNo, 0, mbNo) = mrYes then
      FUsersModel.DeleteUser;
end;

procedure TfmUsers.DoReadData;
var
  UserF: TfmUser;
begin
  inherited;
  UserF := TfmUser.Create(Self, FUsersModel.UserID);
  UserF.Show;
end;

procedure TfmUsers.gdUsersDblClick(Sender: TObject);
begin
  aReadExecute(Sender);
end;

procedure TfmUsers.GetFormActions(out CanCreateData, CanReadData, CanUpdateData,
  CanDeleteData: Boolean);
begin
  CanCreateData := True;
  CanReadData   := True;
  CanUpdateData := False;
  CanDeleteData := True;
end;

procedure TfmUsers.Refresh(UserID: Integer);
begin
  FUsersModel.Update(UserID);
end;

initialization
  FormManager.RegisterForm('fmUsers', TfmUsers, 'Администрирование/Пользователи');

end.
