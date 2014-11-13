unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseMDIForm, System.Actions,
  Vcl.ActnList, Vcl.Menus, DBConnection, UsersForm, UsersModel, Data.DB,
  Data.Win.ADODB;

type
  TfmMain = class(TBaseMDIForm)
    aOpenUsers: TAction;
    N4: TMenuItem;
    procedure aOpenUsersExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.aOpenUsersExecute(Sender: TObject);
begin
  inherited;
  fmUsers := TfmUsers.Create(Self);
  fmUsers.Show;
end;

end.
