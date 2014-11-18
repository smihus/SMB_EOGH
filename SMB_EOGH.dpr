program SMB_EOGH;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fmMain},
  UsersForm in 'UsersForm.pas' {fmUsers},
  UsersModel in 'UsersModel.pas',
  SMBFormManager,
  SMBBaseMDIForm in 'C:\RAD Studio Projects\SMBTemplates\Forms\SMBBaseMDIForm.pas' {BaseMDIForm},
  SMBBaseForm in 'C:\RAD Studio Projects\SMBTemplates\Forms\SMBBaseForm.pas' {BaseForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  fmMain.FormManager := DefaultSMBFormManager;
  Application.Run;
end.
