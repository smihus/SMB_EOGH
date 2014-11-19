program SMB_EOGH;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fmMain},
  UsersForm in 'UsersForm.pas' {fmUsers},
  UsersModel in 'UsersModel.pas',
  SMBFormManager,
  SMBBaseMDIForm in '..\SMBTemplates\Forms\SMBBaseMDIForm.pas' {BaseMDIForm},
  SMBBaseForm in '..\SMBTemplates\Forms\SMBBaseForm.pas' {BaseForm},
  SMBBaseMDIChild in '..\SMBTemplates\Forms\SMBBaseMDIChild.pas' {SMBBaseMDIChild},
  SMB.ConnectionManager in '..\SMBLibs\SMB.ConnectionManager.pas',
  SMB.Model in '..\SMBLibs\SMB.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  fmMain.SetFormManager(FormManager);

  Application.Run;
end.
