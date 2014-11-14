unit EOGHFormFactory;

interface

uses
  SMBFormFactory, Vcl.Forms, System.Classes;

type
  TFormFactory = class(TSMBFormFactory)
  public
    function createForm(aName: string; aOwner: TComponent): TForm; override;
  end;

implementation

uses
  System.SysUtils, UsersForm;

{ TFormFactory }

function TFormFactory.createForm(aName: string; aOwner: TComponent): TForm;
begin
  if aName = 'Users' then
    Result := TfmUsers.Create(aOwner)
  else
    raise Exception.Create('Форма "' + aName + '" находится в разработке. Обратитесь к программисту');
end;

end.
