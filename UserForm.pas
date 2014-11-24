unit UserForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseMDIChild, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, DBCtrlsEh, Vcl.CheckLst, UsersModel, System.Generics.Collections;

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
    procedure bnCloseClick(Sender: TObject);
  private
    FUsersModel: TUsersModel;
    FChangeList: TList<String>;
    FRolesChanged: Boolean;
    procedure GetUserRoles;
    procedure RegisterRoleChanges;
  public
    constructor Create(AOwner: TComponent; AUserID: Integer = 0); reintroduce;
  end;

var
  fmUser: TfmUser;

implementation
uses
  Data.Win.ADODB, SMB.ConnectionManager, Data.DB, System.UITypes;

{$R *.dfm}

procedure TfmUser.bnCloseClick(Sender: TObject);
begin
  if FRolesChanged then
    if MessageDlg('Вы изменили роли пользователя. Сохранить изменения?',
      mtConfirmation, mbYesNo, 0, mbYes) = mrYes then
        bnSaveClick(Sender);
  inherited;
end;

procedure TfmUser.bnSaveClick(Sender: TObject);
var
  Enum: TList<String>.TEnumerator;
  Index: Integer;
begin
  inherited;
  Enum := FChangeList.GetEnumerator;
  while Enum.MoveNext do
  begin
    Index := clbRoles.Items.IndexOf(Enum.Current);
    if clbRoles.Checked[Index] then
      FUsersModel.AddRole(Enum.Current)
    else
      FUsersModel.RemoveRole(Enum.Current);
  end;
  FRolesChanged := False;
  FChangeList.Clear;
  bnSave.Enabled := FRolesChanged;
end;

procedure TfmUser.clbRolesClickCheck(Sender: TObject);
begin
  inherited;
  RegisterRoleChanges;
  bnSave.Enabled := FRolesChanged;
end;

constructor TfmUser.Create(AOwner: TComponent; AUserID: Integer);
begin
  inherited Create(AOwner);
  FUsersModel := TUsersModel.Create(ConnectionManager);
  if AUserID = 0 then
    FUsersModel.NewUser
  else
    FUsersModel.UserID := AUserID;
  with eLoginName do
  begin
    DataSource  := FUsersModel.DataSource;
    DataField   := 'login_name';
    Caption     := Caption + Text;
  end;
  GetUserRoles;
  FChangeList := TList<String>.Create;
  FChangeList.Clear;
  bnSave.Enabled := False;
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
  if FChangeList.Contains(ChangedItem) then
    FChangeList.Remove(ChangedItem)
  else
    FChangeList.Add(ChangedItem);

  FRolesChanged := (FChangeList.Count > 0)
end;

end.
