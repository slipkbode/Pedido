unit unClienteModel;

interface

uses
  unModel;

type
  TClienteModel = class(TModel)
  protected
    function GetSQL: string; override;
  end;

implementation

{ TClienteModel }

function TClienteModel.GetSQL: string;
begin
  Result := 'select codigo, nome, cidade, uf ' +
            'from tbCliente ' +
            'where 1=1';
end;

end.
