unit UsersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseDialogForm, Vcl.StdCtrls,
  Vcl.ExtCtrls, UsersModel, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TfmUsers = class(TSMBBaseDialogForm)
    gdUsers: TDBGridEh;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FModel: TUsersModel;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

{ TfmUsers }

constructor TfmUsers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FModel := TUsersModel.Create;
  gdUsers.DataSource := FModel.DataSource['Users'];
end;

procedure TfmUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
