unit UsersForm;

interface

uses
  UsersModel, SMBBaseMDIChild, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.StdCtrls, System.Classes,
  Vcl.Controls, Vcl.ExtCtrls;

type
  TfmUsers = class(TSMBBaseMDIChild)
    gdUsers: TDBGridEh;
  private
    FModel: TUsersModel;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses
  SMBFormManager;

{$R *.dfm}

{ TfmUsers }

constructor TfmUsers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FModel := TUsersModel.Create;
  gdUsers.DataSource := FModel.DataSource['Users'];
end;

initialization
  DefaultSMBFormManager.RegisterForm('Users', TfmUsers, 'Справочники/Пользователи');

end.
