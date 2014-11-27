unit ObjectsModel;

interface

uses
  SMB.Model, Data.DB, ADODataDriverEh, MemTableEh;
type
  TObjectsModel = class(TModel)
  private
    FDataSource: TDataSource;
    FDDObjects: TADODataDriverEh;
    FMTObjects: TMemTableEh;
  protected
    procedure Init; override;
  public
    property DataSource: TDataSource read FDataSource write FDataSource;
  end;

implementation

uses
  SMB.ConnectionManager;

{ TObjectsModel }

procedure TObjectsModel.Init;
begin
  inherited;
  FDDObjects  := TADODataDriverEh.Create(nil);
  with FDDObjects do
  begin
    ADOConnection := ConnectionManager['EOGH'];
    SelectCommand.CommandText.Text := (
      'select object_id, parent_id, name, label ' +
      'from Objects ' +
      'order by label asc');
  end;

  FMTObjects := TMemTableEh.Create(nil);
  with FMTObjects do
  begin
    DataDriver                  := FDDObjects;
    StoreDefs                   := True;
    TreeList.Active             := True;
    TreeList.KeyFieldName       := 'object_id';
    TreeList.RefParentFieldName := 'parent_id';
    Active                      := True;
  end;
  FDataSource := TDataSource.Create(nil);
  FDataSource.DataSet := FMTObjects;
end;

end.
