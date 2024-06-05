unit unPedidoController;

interface

uses
  unPedidoModel, unConexao, System.SysUtils, System.Rtti, Data.DB,
  unPedidoProdutoModel;

type
  IPedidoController = interface
    ['{4170C148-A250-43FC-A762-7CAF093E939D}']
    procedure NovoProduto;
    procedure NovoPedido;
    function GravarPedido(const ACodigo_Cliente: Integer; const ADataEmissao: TDate): Integer;
    procedure GravarProduto;
    procedure AtualizarGrid(const AColumnName: String; const ARow: Integer; var AValue: TValue);
    procedure AtualizarGridProduto(const AColumnName: String; const ARow: Integer; const AValue: TValue);
    procedure ExcluirProduto(const AIndex: Integer);
    procedure RemoverProdutoQuantidadeCodigoZerado;
    procedure AtualizarProduto(const AIndex: Integer);

    function QuantidadeProduto: Integer;
    function LookupCliente(const AValor: String): TArray<Variant>;
    function DescricaoProduto(const AIndex: Integer): String;
    function DadosPedido: TArray<Variant>;
    function LocalizarPedido(const ANumeroPedido: String): Boolean;
    function Alterando(const AIndex: Integer): Boolean;
  end;

  TPedidoController = class(TInterfacedObject, IPedidoController)
  strict Private
    FConexao                     : IConexao;
    FPedidoModel                 : TPedidoModel;
    FProcedureAtualizarValorTotal: TProc<Extended>;

    procedure ExecutarLookup(const AScript: String; const AValue: Variant; const AProcedure: TProc<TDataSet>);
  Private
    procedure NovoProduto;
    procedure NovoPedido;
    procedure ValidarPedido;
    procedure GravarProduto;
    procedure AtualizarGrid(const AColumnName: String; const ARow: Integer; var AValue: TValue);
    procedure AtualizarGridProduto(const AColumnName: String; const ARow: Integer; const AValue: TValue);
    procedure ExcluirProduto(const AIndex: Integer);
    procedure LookupProduto(const AValor: String; const AProduto: TPedidoProdutoModel);
    procedure AtualizarObjetoPedido;
    procedure RemoverProdutoQuantidadeCodigoZerado;
    procedure DeletarProduto(const AProduto: TPedidoProdutoModel);
    procedure DeletarPedido;
    procedure AtualizarProduto(const AIndex: Integer); overload;
    procedure AtualizarProduto(const AProduto: TPedidoProdutoModel); overload;

    function GravarPedido(const ACodigo_Cliente: Integer; const ADataEmissao: TDate): Integer;
    function LocalizarPedido(const ANumeroPedido: String): Boolean;
    function GetPedidoModel: TPedidoModel;
    function GetConexao: IConexao;
    function QuantidadeProduto: Integer;
    function LookupCliente(const AValor: String): TArray<Variant>;
    function DescricaoProduto(const AIndex: Integer): String;
    function DadosPedido: TArray<Variant>;
    function Alterando(const AIndex: Integer): Boolean;

    property PedidoModel: TPedidoModel read GetPedidoModel;
    property Conexao: IConexao read GetConexao;
  public
    constructor Create(const AProduceAtualizadorValorTotal: TProc<Extended>); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  System.StrUtils, unClienteModel, unModel,
  FireDAC.Stan.Param, unProdutoModel;

{ TPedidoController }

function TPedidoController.Alterando(const AIndex: Integer): Boolean;
begin
  Result := False;

  if QuantidadeProduto > AIndex then
  begin
    Result := PedidoModel.ProdutoList.Items[AIndex].Status = TModelStatus.update;
  end;
end;

procedure TPedidoController.AtualizarGrid(const AColumnName: String; const ARow: Integer; var AValue: TValue);
var
  LProduto: TPedidoProdutoModel;
begin
  LProduto := PedidoModel.ProdutoList.Items[ARow];

  case AnsiIndexStr(AColumnName, ['codigo_produto', 'descricao', 'quantidade', 'valor_unitario', 'valor_total']) of
    0:
      AValue := LProduto.Codigo_Produto;
    1:
      AValue := LProduto.Descriacao;
    2:
      AValue := LProduto.Quantidade;
    3:
      AValue := LProduto.Valor_Unitario;
    4:
      AValue := LProduto.Valor_Total;
  end;
end;

procedure TPedidoController.AtualizarObjetoPedido;
var
  LProduto: TPedidoProdutoModel;
begin
  Conexao.GetQuery.First;
  PedidoModel.Numero_Pedido  := Conexao.GetQuery.FieldByName('Numero_Pedido').AsInteger;
  PedidoModel.Data_Emissao   := Conexao.GetQuery.FieldByName('Data_Emissao').AsDateTime;
  PedidoModel.Codigo_Cliente := Conexao.GetQuery.FieldByName('Codigo_Cliente').AsInteger;
  PedidoModel.Nome           := Conexao.GetQuery.FieldByName('Nome').AsString;

  PedidoModel.ProdutoList.Clear;

  while not Conexao.GetQuery.Eof do
  begin
    LProduto                := TPedidoProdutoModel.Create;
    LProduto.CodigoItem     := Conexao.GetQuery.FieldByName('CodigoItem').AsInteger;
    LProduto.Codigo_Produto := Conexao.GetQuery.FieldByName('Codigo_Produto').AsInteger;
    LProduto.Descriacao     := Conexao.GetQuery.FieldByName('Descricao').AsString;
    LProduto.Quantidade     := Conexao.GetQuery.FieldByName('Quantidade').AsExtended;
    LProduto.Valor_Unitario := Conexao.GetQuery.FieldByName('Valor_Unitario').AsExtended;

    PedidoModel.ProdutoList.Add(LProduto);
    Conexao.GetQuery.Next;
  end;
end;

procedure TPedidoController.AtualizarProduto(const AProduto: TPedidoProdutoModel);
begin
  try
    Conexao.StartTransaction;
    Conexao.GetQuery.ExecSQL(AProduto.GetUpdate, [AProduto.Quantidade, AProduto.Valor_Unitario, AProduto.Valor_Total, AProduto.CodigoItem,
      PedidoModel.Numero_Pedido]);
    Conexao.GetQuery.ExecSQL(PedidoModel.GetUpdateValorTotal, [PedidoModel.Valor_Total, PedidoModel.Numero_Pedido]);
    Conexao.CommitTransaction;
  except
    Conexao.RollbackTransaction;
    raise;
  end;
end;

procedure TPedidoController.AtualizarProduto(const AIndex: Integer);
var
  LProduto: TPedidoProdutoModel;
begin
  if QuantidadeProduto > AIndex then
  begin
    LProduto := PedidoModel.ProdutoList.Items[AIndex];

    AtualizarProduto(LProduto);
  end;
end;

procedure TPedidoController.AtualizarGridProduto(const AColumnName: String; const ARow: Integer; const AValue: TValue);
var
  LProduto: TPedidoProdutoModel;
begin
  LProduto := PedidoModel.ProdutoList.Items[ARow];

  case AnsiIndexStr(AColumnName, ['codigo_produto', 'descricao', 'quantidade', 'valor_unitario', 'valor_total']) of
    0:
      begin
        LProduto.Codigo_Produto := AValue.AsVariant;
        LookupProduto(AValue.AsVariant, LProduto);
      end;
    1:
      begin
        LProduto.Descriacao := AValue.AsString;
        LookupProduto(AValue.AsVariant, LProduto);
      end;
    2:
      LProduto.Quantidade := AValue.AsVariant;
    3:
      LProduto.Valor_Unitario := AValue.AsVariant;
  end;

  FProcedureAtualizarValorTotal(PedidoModel.Valor_Total);
end;

constructor TPedidoController.Create(const AProduceAtualizadorValorTotal: TProc<Extended>);
begin
  inherited Create;
  FProcedureAtualizarValorTotal := AProduceAtualizadorValorTotal;
end;

function TPedidoController.GetConexao: IConexao;
begin
  if FConexao = nil then
    FConexao := TConexao.Create;

  Result := FConexao;
end;

function TPedidoController.GetPedidoModel: TPedidoModel;
begin
  if FPedidoModel = nil then
  begin
    FPedidoModel := TPedidoModel.Create;
  end;

  Result := FPedidoModel;
end;

function TPedidoController.QuantidadeProduto: Integer;
begin
  Result := PedidoModel.ProdutoList.Count;
end;

procedure TPedidoController.RemoverProdutoQuantidadeCodigoZerado;
var
  LProduto: TPedidoProdutoModel;
begin
  for LProduto in PedidoModel.ProdutoList do
  begin
    if (LProduto.Quantidade <= 0) or (LProduto.CodigoItem <= 0) then
      PedidoModel.ProdutoList.Remove(LProduto);
  end;
end;

procedure TPedidoController.ValidarPedido;
begin
  if PedidoModel.Codigo_Cliente = 0 then
    raise Exception.Create('Informar o cliente.');

  if PedidoModel.ProdutoList.Count = 0 then
    raise Exception.Create('Informar pelo menos um produto para gravar o pedido');
end;

function TPedidoController.DadosPedido: TArray<Variant>;
begin
  Result := [PedidoModel.Numero_Pedido, PedidoModel.Data_Emissao, PedidoModel.Codigo_Cliente, PedidoModel.Nome];
end;

procedure TPedidoController.DeletarPedido;
begin
  try
    Conexao.StartTransaction;
    Conexao.GetQuery.ExecSQL(PedidoModel.GetDelete, [PedidoModel.Numero_Pedido]);
    Conexao.CommitTransaction;
  except
    Conexao.RollbackTransaction;
    raise;
  end;
end;

procedure TPedidoController.DeletarProduto(const AProduto: TPedidoProdutoModel);
begin
  try
    Conexao.StartTransaction;
    Conexao.GetQuery.ExecSQL(AProduto.GetDelete, [AProduto.CodigoItem, PedidoModel.Numero_Pedido]);
    Conexao.CommitTransaction;
  except
    Conexao.RollbackTransaction
  end;
end;

function TPedidoController.DescricaoProduto(const AIndex: Integer): String;
begin
  if PedidoModel.ProdutoList.Count >= AIndex then
  begin
    Result := PedidoModel.ProdutoList.Items[AIndex].Descriacao;
  end;
end;

destructor TPedidoController.Destroy;
begin
  FPedidoModel.Free;
  inherited;
end;

procedure TPedidoController.ExcluirProduto(const AIndex: Integer);
var
  LProduto: TPedidoProdutoModel;
begin
  if QuantidadeProduto >= AIndex then
  begin
    LProduto := PedidoModel.ProdutoList.Items[AIndex];

    if LProduto.Status = TModelStatus.update then
    begin
      DeletarProduto(LProduto);
    end;

    PedidoModel.ProdutoList.Remove(LProduto);

    if (PedidoModel.ProdutoList.Count = 0) and (PedidoModel.Numero_Pedido > 0) then
    begin
      DeletarPedido;
    end;
  end;
end;

procedure TPedidoController.ExecutarLookup(const AScript: String; const AValue: Variant; const AProcedure: TProc<TDataSet>);
begin
  if not AScript.Trim.IsEmpty and Assigned(AProcedure) then
  begin
    try
      Conexao.GetQuery.Open(AScript, [AValue]);

      AProcedure(Conexao.GetQuery);
    except
      raise;
    end;
  end;
end;

function TPedidoController.GravarPedido(const ACodigo_Cliente: Integer; const ADataEmissao: TDate): Integer;
var
  LProduto: TPedidoProdutoModel;
begin
  PedidoModel.Codigo_Cliente := ACodigo_Cliente;
  PedidoModel.Data_Emissao   := ADataEmissao;

  ValidarPedido;

  try
    Conexao.StartTransaction;

    Result := PedidoModel.Numero_Pedido;

    if PedidoModel.Numero_Pedido = 0 then
    begin
      Conexao.GetQuery.Close;
      Conexao.GetQuery.SQL.Text                                := PedidoModel.GetInsert;
      Conexao.GetQuery.ParamByName('Data_Emissao').AsDateTime  := PedidoModel.Data_Emissao;
      Conexao.GetQuery.ParamByName('Codigo_Cliente').AsInteger := PedidoModel.Codigo_Cliente;
      Conexao.GetQuery.ParamByName('Valor_Total').AsExtended   := PedidoModel.Valor_Total;
      Conexao.GetQuery.Open;
      Result := Conexao.GetQuery.Fields[0].Value;
    end;

    for LProduto in PedidoModel.ProdutoList do
    begin
      if LProduto.Status = TModelStatus.update then
        AtualizarProduto(LProduto)
    else
      Conexao.GetQuery.ExecSQL(LProduto.GetInsert, [LProduto.CodigoItem, Result, LProduto.Codigo_Produto, LProduto.Quantidade,
        LProduto.Valor_Unitario, LProduto.Valor_Total]);
  end;

  Conexao.CommitTransaction;
  PedidoModel.ProdutoList.Clear;
except
  on E: Exception do
  begin
    Conexao.RollbackTransaction;
    raise;
  end;
end;
end;

procedure TPedidoController.GravarProduto;
begin
  NovoProduto;
end;

function TPedidoController.LocalizarPedido(const ANumeroPedido: String): Boolean;
begin
  Conexao.GetQuery.Open(PedidoModel.Filter('tbPedido.numero_pedido', '='), [ANumeroPedido]);

  Result := not Conexao.GetQuery.IsEmpty;

  if Result then
  begin
    AtualizarObjetoPedido;
  end;
end;

function TPedidoController.LookupCliente(const AValor: String): TArray<Variant>;
var
  LClienteModel: TClienteModel;
  LValor       : Integer;
  LScript      : String;
  LResult      : TArray<Variant>;
begin
  LClienteModel := TClienteModel.Create;

  try
    try
      if TryStrToInt(AValor, LValor) then
        LScript := LClienteModel.Filter('codigo', '=')
      else
        LScript := LClienteModel.Filter('nome', 'like');

      ExecutarLookup(LScript, AValor,
        procedure(ADataSet: TDataSet)
        begin
          LResult := [ADataSet.FieldByName('codigo').AsInteger, ADataSet.FieldByName('nome').AsString];
        end);
    except
      raise;
    end;
  finally
    Result := LResult;
    LClienteModel.Free;
  end;
end;

procedure TPedidoController.LookupProduto(const AValor: String; const AProduto: TPedidoProdutoModel);
var
  LProdutoModel: TProdutoModel;
  LValor       : Integer;
  LScript      : String;
begin
  LProdutoModel := TProdutoModel.Create;

  try
    try
      if TryStrToInt(AValor, LValor) then
        LScript := LProdutoModel.Filter('codigo', '=')
      else
        LScript := LProdutoModel.Filter('descricao', 'like');

      ExecutarLookup(LScript, AValor,
        procedure(ADataSet: TDataSet)
        begin
          AProduto.Codigo_Produto := ADataSet.FieldByName('codigo').AsInteger;
          AProduto.Descriacao := ADataSet.FieldByName('descricao').AsString;
          AProduto.Valor_Unitario := ADataSet.FieldByName('preco_venda').AsExtended;
        end);
    except
      raise;
    end;
  finally
    LProdutoModel.Free;
  end;
end;

procedure TPedidoController.NovoPedido;
begin
  PedidoModel.Data_Emissao := Now;
end;

procedure TPedidoController.NovoProduto;
var
  LProduto: TPedidoProdutoModel;
begin
  PedidoModel.ProdutoList.Add(TPedidoProdutoModel.Create);
  LProduto            := PedidoModel.ProdutoList.Last;
  LProduto.CodigoItem := QuantidadeProduto;
  LProduto.Status     := TModelStatus.insert;
end;

end.
