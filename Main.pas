unit Main;

interface

uses
  System.Actions, Vcl.ActnList, Vcl.Menus,
  SMBFormFactory, SMBBaseMDIForm, System.Classes;

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

uses
  EOGHFormFactory;
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
  Result := TEOGHFormFactory.Create;
end;

end.
