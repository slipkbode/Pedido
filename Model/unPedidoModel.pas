unit unPedidoModel;

interface

uses
  unModel, unPedidoProdutoModel;

type
  TPedidoModel = class(TModel)
  private
    FData_Emissao  : TDate;
    FCodigo_Cliente: Integer;
    FNumero_Pedido : Integer;
    FProdutoList   : TPedidoProdutoModelList;
    FNome          : String;

    function GetProdutoList: TPedidoProdutoModelList;
    function GetValor_Total: Extended;
  protected
    function GetSQL: String; override;
  public
    destructor Destroy; override;

    function GetInsert: String; override;
    function GetDelete: String; override;
    function GetUpdate: String; override;
    function GetUpdateValorTotal: String;

    property Numero_Pedido: Integer read FNumero_Pedido write FNumero_Pedido;
    property Data_Emissao: TDate read FData_Emissao write FData_Emissao;
    property Codigo_Cliente: Integer read FCodigo_Cliente write FCodigo_Cliente;
    property Nome: String read FNome write FNome;
    property Valor_Total: Extended read GetValor_Total;
    property ProdutoList: TPedidoProdutoModelList read GetProdutoList;
  end;

implementation

{ TPedidoModel }

destructor TPedidoModel.Destroy;
begin
  FProdutoList.Free;
  inherited;
end;

function TPedidoModel.GetDelete: String;
begin
  Result := 'delete from tbPedido where numero_pedido = :numero_pedido';
end;

function TPedidoModel.GetInsert: String;
begin
  Result := 'INSERT INTO tbPedido(data_emissao, codigo_cliente, valor_total) ' +
    'VALUES(:data_emissao, :codigo_cliente, :valor_total); SELECT LAST_INSERT_ID();';
end;

function TPedidoModel.GetProdutoList: TPedidoProdutoModelList;
begin
  if FProdutoList = nil then
    FProdutoList := TPedidoProdutoModelList.Create;

  Result := FProdutoList;
end;

function TPedidoModel.GetSQL: String;
begin
  Result := 'SELECT tbPedido.numero_pedido, tbPedido.data_emissao, tbPedido.codigo_cliente, tbPedido.valor_total, ' + #13 +
    '       tbPedidoProduto.codigoitem, tbPedidoProduto.codigo_produto, tbPedidoProduto.quantidade, tbPedidoProduto.valor_unitario, ' + #13 +
    '       tbCliente.nome, tbProduto.descricao ' + #13 + 'FROM tbPedido ' + #13 +
    'inner join tbPedidoProduto on tbPedidoProduto.numero_pedido = tbPedido.numero_pedido ' + #13 +
    'inner join tbCliente on tbPedido.codigo_cliente = tbCliente.codigo' + #13 +
    'inner join tbProduto on tbPedidoProduto.codigo_produto = tbProduto.codigo ' + #13 + 'where 1=1 ';
end;

function TPedidoModel.GetUpdate: String;
begin
  Result := 'UPDATE tbPedido SET data_emissao = :data_emissao, codigo_cliente = :codigo_cliente, valor_total = :valor_total ' +
    ' WHERE Numero_Pedido = : Numero_Pedido';

end;

function TPedidoModel.GetUpdateValorTotal: String;
begin
  Result := 'update tbPedido set valor_total = :valor_total where numero_pedido = :numero_pedido';
end;

function TPedidoModel.GetValor_Total: Extended;
var
  LProduto: TPedidoProdutoModel;
begin
  Result := 0;

  for LProduto in ProdutoList do
  begin
    Result := Result + LProduto.Valor_Total;
  end;
end;

end.
