program SMB_EOGH;

uses
  Vcl.Forms,
  DBConnection in 'DBConnection.pas',
  Main in 'Main.pas' {fmMain},
  SMBBaseForm in '..\SMBTemplates\Forms\SMBBaseForm.pas' {fmSMBBaseForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
