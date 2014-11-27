unit MainForm;

interface

uses
  Vcl.Menus, SMBBaseMDIForm, System.Classes, Vcl.StdActns, System.Actions,
  Vcl.ActnList;

type
  TfmMain = class(TBaseMDIForm)
    N4: TMenuItem;
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
