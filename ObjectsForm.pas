unit ObjectsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseMDIChild, Vcl.Menus,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, MemTableDataEh, Data.DB,
  DataDriverEh, MemTableEh, Data.Win.ADODB, GridsEh, DBAxisGridsEh, DBGridEh,
  ADODataDriverEh, ObjectsModel;

type
  TfmObjects = class(TSMBBaseMDIChild)
    gdObjects: TDBGridEh;
  private
    FObjectsModel: TObjectsModel;
  protected
    procedure GetFormActions(out CanCreateData, CanReadData, CanUpdateData, CanDeleteData: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  fmObjects: TfmObjects;

implementation

uses
  SMBFormManager, SMB.ConnectionManager;

{$R *.dfm}

{ TfmObjects }

constructor TfmObjects.Create(AOwner: TComponent);
begin
  inherited;
  FObjectsModel         := TObjectsModel.Create(ConnectionManager);
  gdObjects.DataSource  := FObjectsModel.DataSource;
end;

procedure TfmObjects.GetFormActions(out CanCreateData, CanReadData,
  CanUpdateData, CanDeleteData: Boolean);
begin
  CanCreateData := True;
  CanReadData   := False;
  CanUpdateData := True;
  CanDeleteData := True;
end;

initialization
  FormManager.RegisterForm('fmObjects', TfmObjects, 'Администрирование/Объекты');

end.
