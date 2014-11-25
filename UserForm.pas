unit UserForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseMDIChild, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, DBCtrlsEh, Vcl.CheckLst, UsersModel, System.Generics.Collections,
  SMB.DataChangesRegister;

type
  TfmUser = class(TSMBBaseMDIChild)
    eLoginName: TDBEditEh;
    lLoginName: TLabel;
    lRoles: TLabel;
    clbRoles: TCheckListBox;
    pUserData: TPanel;
    bnSave: TButton;
    procedure clbRolesClickCheck(Sender: TObject);
    procedure bnSaveClick(Sender: TObject);
    procedure eLoginNameExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FUsersModel: TUsersModel;
    FChangedRolesList: TList<String>;
    FDCR: TSMBDataChangesRegister;
    procedure GetUserRoles;
    procedure RegisterRoleChanges;
    procedure FormControlsUpdate(const DataName: String; const Value: Boolean);
    procedure Save;
    function Valid: Boolean;
  public
    constructor Create(AOwner: TComponent; AUserID: Integer = 0); reintroduce;
  end;

var
  fmUser: TfmUser;

implementation
uses
  Data.Win.ADODB, SMB.ConnectionManager, Data.DB, System.UITypes, UsersForm;

{$R *.dfm}

procedure TfmUser.bnSaveClick(Sender: TObject);
begin
    Save;
end;

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
  begin
    FUsersModel.NewUser;
    FDCR['LoginName'] := True;
  end
  else
    FUsersModel.UserID := AUserID;

  with eLoginName do
  begin
    DataSource  := FUsersModel.DataSource;
    DataField   := 'login_name';
    Caption     := Caption + Text;
  end;
  GetUserRoles;
end;

procedure TfmUser.eLoginNameExit(Sender: TObject);
begin
  inherited;
  if FUsersModel.LoginName <> Trim(eLoginName.Text) then
    FDCR['LoginName'] := True;
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

procedure TfmUser.Save;
var
  Enum: TList<String>.TEnumerator;
  Index: Integer;
begin
  if Valid then
  begin
    if FDCR['LoginName'] then
    begin
      FUsersModel.DataSource.DataSet.Post;
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
      FDCR['Roles'] := False;
    end;

    (Owner as TfmUsers).UpdateData(FUsersModel.UserID);{ TODO : Сделать оповещение по другому }
  end;
end;

procedure TfmUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FDCR.DataChanged then
    if MessageDlg('Вы изменили данные пользователя. Сохранить изменения?',
      mtConfirmation, mbYesNo, 0, mbYes) = mrYes then
        Save;
  inherited;
end;

procedure TfmUser.FormControlsUpdate(const DataName: String; const Value: Boolean);
begin
  if (DataName = 'Roles') and not Value then
    FChangedRolesList.Clear;
  bnSave.Enabled := FDCR.DataChanged;
end;

function TfmUser.Valid: Boolean;
begin
  Result  := not (Trim(eLoginName.Text) = '');
end;

end.
