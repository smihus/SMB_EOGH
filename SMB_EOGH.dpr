program SMB_EOGH;

uses
  Vcl.Forms,
  DBConnection in 'DBConnection.pas',
  SMBBaseForm in '..\SMBTemplates\Forms\SMBBaseForm.pas' {fmSMBBaseForm},
  SMBBaseMDIForm in '..\SMBTemplates\Forms\SMBBaseMDIForm.pas' {BaseMDIForm},
  Main in 'Main.pas' {fmMain},
  UsersForm in 'UsersForm.pas' {fmUsers},
  SMBBaseDialogForm in '..\SMBTemplates\Forms\SMBBaseDialogForm.pas' {SMBBaseDialogForm},
  UsersModel in 'UsersModel.pas',
  SMBModel in '..\SMBLibs\SMBModel.pas',
  SMB.DBUtils in '..\SMBLibs\SMB.DBUtils.pas',
  SMBFormFactory in '..\SMBLibs\SMBFormFactory.pas',
  EOGHFormFactory in 'EOGHFormFactory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
