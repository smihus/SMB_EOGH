unit ObjectsModel;

interface

uses
  SMB.Model, Data.DB, ADODataDriverEh, MemTableEh, MemTableDataEh,
  Data.Win.ADODB;
type
  TObjectsModel = class(TModel)
  private
    FDataSource: TDataSource;
    FDDObjects: TADODataDriverEh;
    FMTObjects: TMemTableEh;
    FCurrentObjectParent: Integer;
    procedure DoNewRecord(DataSet: TDataSet);
  protected
    procedure Init; override;
  public
    procedure SaveCurrentObjectParent;
    property DataSource: TDataSource read FDataSource write FDataSource;
    procedure CreateObject;
    procedure DeleteObject;
    procedure UpdateObject;
  end;

implementation

uses
  SMB.ConnectionManager, System.SysUtils, Vcl.Dialogs, System.UITypes;

{ TObjectsModel }

procedure TObjectsModel.CreateObject;
begin
  FMTObjects.Insert;
end;

procedure TObjectsModel.DeleteObject;
begin
  FMTObjects.Delete;
end;

procedure TObjectsModel.DoNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldValues['parent_id'] := FCurrentObjectParent;
end;

procedure TObjectsModel.Init;
begin
  inherited;
  FDDObjects  := TADODataDriverEh.Create(nil);
  with FDDObjects do
  begin
    ADOConnection := ConnectionManager['EOGH'];
    SelectCommand.CommandText.Text :=
      'select object_id, parent_id, name, label ' +
      'from Objects ' +
      'order by label asc';
    InsertCommand.CommandText.Text :=
      'insert into Objects (parent_id, name, label) ' +
      'values (:parent_id, :name, :label)';
    DeleteCommand.CommandText.Text :=
      'delete from Objects ' +
      'where object_id = :object_id';
    UpdateCommand.CommandText.Text :=
      'update Objects ' +
      'set name = :name, label = :label ' +
      'where object_id = :object_id';
  end;

  FMTObjects := TMemTableEh.Create(nil);
  with FMTObjects do
  begin
    DataDriver                  := FDDObjects;
    StoreDefs                   := True;
    TreeList.Active             := True;
    TreeList.KeyFieldName       := 'object_id';
    TreeList.RefParentFieldName := 'parent_id';
    OnNewRecord                 := DoNewRecord;
    Active                      := True;
  end;
  FDataSource := TDataSource.Create(nil);
  FDataSource.DataSet := FMTObjects;
end;

procedure TObjectsModel.SaveCurrentObjectParent;
begin
  FCurrentObjectParent := FMTObjects.FieldByName('object_id').Value;
end;

procedure TObjectsModel.UpdateObject;
begin
  try
    FMTObjects.Post;
  except
    on E: Exception do
    begin
      MessageDlg('Добавить новый объект не удалось, т.к. объект с именем "' +
        FMTObjects.FieldByName('name').AsString + '" уже существует.', mtError, [mbOK], 0);
      Abort;
    end;
  end;
end;

end.
