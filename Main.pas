unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  SMBBaseForm;

type
  TfmMain = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    FSMBBaseForm: TfmSMBBaseForm;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation
uses
  DBConnection;
{$R *.dfm}

procedure TfmMain.Button1Click(Sender: TObject);
begin
  if not Assigned(FSMBBaseForm) then
    FSMBBaseForm := TfmSMBBaseForm.Create(Self);
  FSMBBaseForm.Show;
end;

end.
