unit unProdutoModel;

interface

uses
  unModel;

type
  TProdutoModel = class(TModel)
  protected
    function GetSQL: string; override;
  end;

implementation

{ TProdutoModel }

function TProdutoModel.GetSQL: string;
begin
  Result := 'select codigo, descricao, preco_venda ' +
            'from tbProduto ' +
            'where 1=1';
end;

end.
