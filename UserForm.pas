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
  private
    FUsersModel: TUsersModel;
    FChangeList: TList<String>;
    FRolesChanged: Boolean;
    procedure GetUserRoles;
    procedure RegisterRoleChanges;
  public
    constructor Create(AOwner: TComponent; AUserID: Integer); reintroduce;
  end;

var
  fmUser: TfmUser;

implementation
uses
  Data.Win.ADODB, SMB.ConnectionManager, Data.DB;

{$R *.dfm}

procedure TfmUser.clbRolesClickCheck(Sender: TObject);
var
  ChangedItem: string;
  Index: Integer;
begin
  inherited;
  RegisterRoleChanges;
  bnSave.Enabled := FRolesChanged;
end;

constructor TfmUser.Create(AOwner: TComponent; AUserID: Integer);
begin
  inherited Create(AOwner);
  FUsersModel := TUsersModel.Create(ConnectionManager);
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
  Index: Integer;
begin
  ChangedItem := clbRoles.Items[clbRoles.ItemIndex];
  if FChangeList.Contains(ChangedItem) then
    FChangeList.Remove(ChangedItem)
  else
    FChangeList.Add(ChangedItem);

  FRolesChanged := (FChangeList.Count > 0)
end;

end.
