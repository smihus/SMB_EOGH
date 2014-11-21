unit Main;

interface

uses
  Vcl.Menus, SMBBaseMDIForm, System.Classes;

type
  TfmMain = class(TBaseMDIForm)
    procedure FormShow(Sender: TObject);
  end;

var
  fmMain: TfmMain;

implementation
uses
  Windows;

{$R *.dfm}

procedure TfmMain.FormShow(Sender: TObject);
begin
  inherited;
  Caption := Caption + User;
end;

end.
