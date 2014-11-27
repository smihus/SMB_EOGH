unit UserForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseMDIChild, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, DBCtrlsEh, Vcl.CheckLst, UsersModel, System.Generics.Collections,
  SMB.DataChangesRegister, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TfmUser = class(TSMBBaseMDIChild)
    eLoginName: TDBEditEh;
    lLoginName: TLabel;
    lRoles: TLabel;
    clbRoles: TCheckListBox;
    pUserData: TPanel;
    bnSave: TButton;
    procedure clbRolesClickCheck(Sender: TObject);
    procedure eLoginNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    FUsersModel: TUsersModel;
    FChangedRolesList: TList<String>;
    FDCR: TSMBDataChangesRegister;
    procedure GetUserRoles;
    procedure RegisterRoleChanges;
    procedure FormControlsUpdate(const DataName: String; const Value: Boolean);
    function Valid: Boolean;
  protected
    procedure GetFormActions(out CanCreateData, CanReadData, CanUpdateData, CanDeleteData: Boolean); override;
    procedure DoUpdateData; override;
  public
    constructor Create(AOwner: TComponent; AUserID: Integer = 0); reintroduce;
  end;

var
  fmUser: TfmUser;

implementation
uses
  Data.Win.ADODB, SMB.ConnectionManager, Data.DB, System.UITypes, UsersForm,
  SMB.Validators;

{$R *.dfm}

procedure TfmUser.clbRolesClickCheck(Sender: TObject);
begin
  inherited;
  RegisterRoleChanges;
end;

constructor TfmUser.Create(AOwner: TComponent; AUserID: Integer);
begin
  inherited Create(AOwner);
  FUsersModel := TUsersModel.Create(ConnectionManager);
  FChangedRolesList := TList<String>.Create;
  FDCR  := TSMBDataChangesRegister.Create;
  FDCR.AfterDataChange := FormControlsUpdate;
  if AUserID = 0 then
    FUsersModel.AppendUser
  else
    FUsersModel.UserID  := AUserID;

  with eLoginName do
  begin
    DataSource  := FUsersModel.DataSource;
    DataField   := 'login_name';
    Caption     := Caption + Text;
  end;
  GetUserRoles;
end;

procedure TfmUser.DoUpdateData;
var
  Enum: TList<String>.TEnumerator;
  Index: Integer;
begin
  inherited;
  if Valid then
  begin
    if FDCR['LoginName'] then
    begin
      FUsersModel.UpdateUser(eLoginName.Text);
      FDCR['LoginName'] := False;
    end;

    if FDCR['Roles'] then
    begin
      Enum := FChangedRolesList.GetEnumerator;
      while Enum.MoveNext do
      begin
        Index := clbRoles.Items.IndexOf(Enum.Current);
        if clbRoles.Checked[Index] then
          FUsersModel.AddRole(Enum.Current)
        else
          FUsersModel.RemoveRole(Enum.Current);
      end;
      FUsersModel.UpdateUserRoles;
      FDCR['Roles'] := False;
    end;

    (Owner as TfmUsers).Refresh(FUsersModel.UserID);{ TODO : Сделать оповещение по другому }
  end;
end;

procedure TfmUser.eLoginNameChange(Sender: TObject);
begin
  inherited;
  if FUsersModel.LoginName <> Trim(eLoginName.Text) then
    FDCR['LoginName'] := True;
end;

procedure TfmUser.GetFormActions(out CanCreateData, CanReadData, CanUpdateData,
  CanDeleteData: Boolean);
begin
  CanCreateData := False;
  CanReadData   := False;
  CanUpdateData := True;
  CanDeleteData := False;
end;

procedure TfmUser.GetUserRoles;
var
  UserRolesQuery: TADOQuery;
  CurrentIndex: Integer;
begin
  UserRolesQuery := FUsersModel.GetUserRoles();
  with clbRoles do
  begin
    Items.Clear;
    with UserRolesQuery do
    begin
      First;
      while not Eof do
      begin
        CurrentIndex          := Items.Add(FieldValues['Role']);
        Checked[CurrentIndex] := FieldValues['Checked'];
        Next;
      end;
    end;
  end;
end;

procedure TfmUser.RegisterRoleChanges;
var
  ChangedItem: string;
begin
  ChangedItem := clbRoles.Items[clbRoles.ItemIndex];
  if FChangedRolesList.Contains(ChangedItem) then
    FChangedRolesList.Remove(ChangedItem)
  else
    FChangedRolesList.Add(ChangedItem);

  FDCR['Roles'] := (FChangedRolesList.Count > 0);
end;

procedure TfmUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FDCR.DataChanged then
    if MessageDlg('Вы изменили данные пользователя. Сохранить изменения?',
      mtConfirmation, mbYesNo, 0, mbYes) = mrYes then
        aUpdateExecute(Sender);
  inherited;
end;

procedure TfmUser.FormControlsUpdate(const DataName: String; const Value: Boolean);
begin
  if (DataName = 'Roles') and not Value then
    FChangedRolesList.Clear;
  aUpdate.Enabled := FDCR.DataChanged;
end;

procedure TfmUser.FormShow(Sender: TObject);
begin
  inherited;
  if FUsersModel.IsNewUser then
    eLoginName.SetFocus
  else
    clbRoles.SetFocus;
end;

function TfmUser.Valid: Boolean;
var
  ErrorMsg: string;
begin
  Result  := HasStrValue('Логин пользователя', eLoginName.Text, ErrorMsg);
  if not Result then
  begin
    MessageDlg(ErrorMsg, mtWarning, [mbOK], 0);
    Abort;
  end;
end;

end.
