program SMB_EOGH;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fmMain},
  UsersForm in 'UsersForm.pas' {fmUsers},
  UsersModel in 'UsersModel.pas',
  SMBFormManager,
  SMBBaseMDIForm in '..\SMBTemplates\Forms\SMBBaseMDIForm.pas' {BaseMDIForm},
  SMBBaseForm in '..\SMBTemplates\Forms\SMBBaseForm.pas' {BaseForm},
  SMB.ConnectionManager in '..\SMBLibs\SMB.ConnectionManager.pas',
  SMB.Model in '..\SMBLibs\SMB.Model.pas',
  UserForm in 'UserForm.pas' {fmUser},
  SMB.DataChangesRegister in '..\SMBLibs\SMB.DataChangesRegister.pas',
  SMBBaseMDIChild in '..\SMBTemplates\Forms\SMBBaseMDIChild.pas' {SMBBaseMDIChild},
  RolesForm in 'RolesForm.pas' {fmRoles},
  SMB.Validators in '..\SMBLibs\SMB.Validators.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  fmMain.SetFormManager(FormManager);

  Application.Run;
end.
