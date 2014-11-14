unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseMDIForm, System.Actions,
  Vcl.ActnList, Vcl.Menus, DBConnection, Data.DB,
  Data.Win.ADODB, SMBFormFactory, FormFactory;

type
  TfmMain = class(TBaseMDIForm)
    aOpenUsers: TAction;
    N4: TMenuItem;
    N5: TMenuItem;
    aOpenRoles: TAction;
    procedure aOpenUsersExecute(Sender: TObject);
    procedure aOpenRolesExecute(Sender: TObject);
  protected
    function CreateFormFactory(): TSMBFormFactory; override;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.aOpenRolesExecute(Sender: TObject);
begin
  CreateAndShowMDIChild('Roles');
end;

procedure TfmMain.aOpenUsersExecute(Sender: TObject);
begin
  CreateAndShowMDIChild('Users');
end;

function TfmMain.CreateFormFactory: TSMBFormFactory;
begin
  Result := TFormFactory.Create;
end;

end.
