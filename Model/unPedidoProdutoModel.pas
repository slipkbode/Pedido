unit unPedidoProdutoModel;

interface

uses
  unModel, System.Generics.Collections;

type
  TPedidoProdutoModel = class(TModel)
  private
    FCodigoItem    : Integer;
    FDescriacao    : String;
    FCodigo_Produto: Integer;
    FQuantidade    : Extended;
    FValor_Unitario: Extended;
    function GetValor_Total: Extended;
  protected
    function GetSQL: String; override;

  public
    function GetInsert: String; override;
    function GetDelete: String; override;
    function GetUpdate: String; override;

    property CodigoItem    : Integer read FCodigoItem write FCodigoItem;
    property Descriacao    : String read FDescriacao write FDescriacao;
    property Codigo_Produto: Integer read FCodigo_Produto write FCodigo_Produto;
    property Quantidade    : Extended read FQuantidade write FQuantidade;
    property Valor_Unitario: Extended read FValor_Unitario write FValor_Unitario;
    property Valor_Total   : Extended read GetValor_Total;
  end;

  TPedidoProdutoModelList = class(TObjectList<TPedidoProdutoModel>)
  end;

implementation

{ TPedidoProdutoModel }

function TPedidoProdutoModel.GetDelete: String;
begin
  Result := 'DELETE FROM tbPedidoProduto WHERE codigoitem = :codigoitem and numero_pedido = :numero_pedido';
end;

function TPedidoProdutoModel.GetInsert: String;
begin
  Result := 'INSERT INTO tbPedidoProduto(codigoitem, numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) ' +
    'VALUES(:codigoitem, :numero_pedido, :codigo_produto, :quantidade, :valor_unitario, :valor_total)';
end;

function TPedidoProdutoModel.GetSQL: String;
begin
  Result := 'SELECT codigoitem, numero_pedido, tbPedidoProduto.codigo_produto, tbProduto.descricao, quantidade, valor_unitario, valor_total ' +
    '  FROM tbPedidoProduto ' + 'INNER JOIN tbProduto on tbPedidoProduto.codigo_produto = tbProduto.codigo ' + 'where numero_pedido = :numero_pedido';
end;

function TPedidoProdutoModel.GetUpdate: String;
begin
  Result := 'UPDATE tbPedidoProduto SET quantidade=:quantidade, '+
            'valor_unitario=:valor_unitario, valor_total=:valor_total WHERE codigoitem=:codigoitem and numero_pedido = :numero_pedido';
end;

function TPedidoProdutoModel.GetValor_Total: Extended;
begin
  Result := Quantidade * Valor_Unitario;
end;

end.
