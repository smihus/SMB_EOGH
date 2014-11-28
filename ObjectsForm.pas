unit ObjectsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SMBBaseMDIChild, Vcl.Menus,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, MemTableDataEh, Data.DB,
  DataDriverEh, MemTableEh, Data.Win.ADODB, GridsEh, DBAxisGridsEh, DBGridEh,
  ADODataDriverEh, ObjectsModel, Vcl.DBCtrls;

type
  TfmObjects = class(TSMBBaseMDIChild)
    gdObjects: TDBGridEh;
  private
    FObjectsModel: TObjectsModel;
  protected
    procedure GetFormActions(out CanCreateData, CanReadData, CanUpdateData, CanDeleteData: Boolean); override;
    procedure DoCreateData; override;
    procedure DoDeleteData; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  fmObjects: TfmObjects;

implementation

uses
  SMBFormManager, SMB.ConnectionManager, System.UITypes;

{$R *.dfm}

{ TfmObjects }

constructor TfmObjects.Create(AOwner: TComponent);
begin
  inherited;
  FObjectsModel         := TObjectsModel.Create(ConnectionManager);
  gdObjects.DataSource  := FObjectsModel.DataSource;
end;

procedure TfmObjects.DoCreateData;
begin
  inherited;
  FObjectsModel.SaveCurrentObjectParent;
  FObjectsModel.CreateObject;
end;

procedure TfmObjects.DoDeleteData;
begin
  inherited;
  if MessageDlg('Вы действительно хотите удалить этот объект?',
    mtConfirmation, mbYesNo, 0, mbNo) = mrYes then
      FObjectsModel.DeleteObject;
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
