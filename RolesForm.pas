unit RolesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseMDIChild, Vcl.StdCtrls,
  Vcl.ExtCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  GridsEh, DBAxisGridsEh, DBGridEh, Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TfmRoles = class(TSMBBaseMDIChild)
    DBGridEh1: TDBGridEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRoles: TfmRoles;

implementation

uses
  SMBFormManager;

{$R *.dfm}

initialization
  FormManager.RegisterForm('fmRoles', TfmRoles, 'Администрирование/Роли');

end.
