unit unPedidoView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation,
  FMX.ScrollBox, unPedidoController, FMX.StdCtrls, FMX.Edit, FMX.DateTimeCtrls, System.ImageList, FMX.ImgList;

type
  TPedidoView = class(TForm)
    lytPedido: TLayout;
    grdProduto: TGrid;
    codigo_produto: TIntegerColumn;
    descricao: TStringColumn;
    quantidade: TFloatColumn;
    valor_unitario: TFloatColumn;
    valor_total: TFloatColumn;
    botao: TColumn;
    Layout2: TLayout;
    lblTotal: TLabel;
    lblValorTotal: TLabel;
    lblNumeroPedido: TLabel;
    edtNumeroPedido: TEdit;
    lblCliente: TLabel;
    edtCliente: TEdit;
    SearchEdtCliente: TSearchEditButton;
    Panel1: TPanel;
    lblNomeCliente: TLabel;
    lblDataEmissao: TLabel;
    deEmissao: TDateEdit;
    cbLocalizarPedido: TCornerButton;
    cbFinalizarPedido: TCornerButton;
    procedure FormCreate(Sender: TObject);
    procedure grdProdutoGetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
    procedure grdProdutoSetValue(Sender: TObject; const ACol, ARow: Integer; const Value: TValue);
    procedure SearchEdtClienteClick(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure grdProdutoDrawColumnCell(Sender: TObject; const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
    procedure grdProdutoCellClick(const Column: TColumn; const Row: Integer);
    procedure cbLocalizarPedidoClick(Sender: TObject);
    procedure cbFinalizarPedidoClick(Sender: TObject);
    procedure edtClienteEnter(Sender: TObject);
    procedure grdProdutoSelectCell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
  private
    FPedidoController: IPedidoController;

    procedure LookupCliente;
    procedure VisivelBotaoLocalizarPedido;
    procedure AtualizarComponentesPedido;
    procedure LimparComponentes;

    function GetPedidoController: IPedidoController;
    { Private declarations }
    property PedidoController: IPedidoController read GetPedidoController;
    procedure AtualizarGrid;
  public
    { Public declarations }
  end;

var
  PedidoView: TPedidoView;

implementation

uses System.StrUtils, FireDAC.FMXUI.Wait, FMX.DialogService;

{$R *.fmx}

procedure TPedidoView.cbFinalizarPedidoClick(Sender: TObject);
var
  LNumeroPedido: Integer;
  LTipoMensagem: TMsgDlgType;
  LMensagem    : string;
begin
  LTipoMensagem := TMsgDlgType.mtError;

  try
    PedidoController.RemoverProdutoQuantidadeCodigoZerado;
    AtualizarGrid;

    LNumeroPedido := PedidoController.GravarPedido(StrToIntDef(edtCliente.Text, 0), deEmissao.Date);

    TDialogService.MessageDialog('O pedido de número ' + LNumeroPedido.ToString + ' foi salvo com sucesso!', TMsgDlgType.mtInformation,
      [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
      procedure(const AModalResult: TModalResult)
      begin
        LimparComponentes;
      end);
  except
    on E: Exception do
    begin
      LMensagem := 'Ocorre um erro ao tentar salvar o pedido' + #13 + 'Motivo: ' + E.Message;

      if E.Message.Contains('Informar') then
      begin
        LTipoMensagem := TMsgDlgType.mtWarning;
        LMensagem     := E.Message;

        if E.Message.Contains('cliente') then
          edtCliente.SetFocus
        else
          grdProduto.SetFocus;
      end;

      TDialogService.MessageDialog(LMensagem, LTipoMensagem, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0, nil);
    end;
  end;
end;

procedure TPedidoView.cbLocalizarPedidoClick(Sender: TObject);
begin
  TDialogService.InputQuery('Consultar pedido', ['Número do Pedido:'], [''],
    procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      if AResult = mrOk then
      begin
        try
          if not PedidoController.LocalizarPedido(AValues[0]) then
            TDialogService.MessageDialog('Não foi encontrado o pedido ' + AValues[0], TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK],
              TMsgDlgBtn.mbOK, 0, nil)
          else
            AtualizarComponentesPedido;

          AtualizarGrid;
        except
          on E: Exception do
          begin
            TDialogService.MessageDialog('Ocorre um erro ao tentar localizar o pedido' + #13 + 'Motivo: ' + E.Message, TMsgDlgType.mtError,
              [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0, nil);
          end;
        end;
      end;
    end);
end;

procedure TPedidoView.edtClienteEnter(Sender: TObject);
begin
  PedidoController.RemoverProdutoQuantidadeCodigoZerado;
  AtualizarGrid;
end;

procedure TPedidoView.edtClienteExit(Sender: TObject);
begin
  LookupCliente;
  VisivelBotaoLocalizarPedido;
end;

procedure TPedidoView.VisivelBotaoLocalizarPedido;
begin
  cbLocalizarPedido.Visible := edtCliente.Text.Trim.IsEmpty;
end;

procedure TPedidoView.FormCreate(Sender: TObject);
begin
  grdProduto.RowCount := 0;
  edtCliente.SetFocus;
  VisivelBotaoLocalizarPedido;
end;

procedure TPedidoView.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkDelete then
  begin
    TDialogService.MessageDialog('Deseja excluir o produto ' + PedidoController.DescricaoProduto(grdProduto.Row) + '?', TMsgDlgType.mtConfirmation,
      [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
      procedure(const AResult: TModalResult)
      begin
        if AResult = mrYes then
        begin
          PedidoController.ExcluirProduto(grdProduto.Row);
          AtualizarGrid;

          if PedidoController.QuantidadeProduto = 0 then
            LimparComponentes;
        end;
      end);
  end;
end;

function TPedidoView.GetPedidoController: IPedidoController;
begin
  if FPedidoController = nil then
    FPedidoController := TPedidoController.Create(
      procedure(AValor: Extended)
      begin
        lblValorTotal.Text := FormatFloat('##,##0.00', AValor);
      end);

  Result := FPedidoController;
end;

procedure TPedidoView.AtualizarComponentesPedido;
var
  LDados: TArray<Variant>;
begin
  LDados := PedidoController.DadosPedido;

  edtNumeroPedido.Text := LDados[0];
  edtCliente.Text      := LDados[2];
  lblNomeCliente.Text  := LDados[3];
  deEmissao.Date       := LDados[1];
end;

procedure TPedidoView.AtualizarGrid;
begin
  grdProduto.RowCount := PedidoController.QuantidadeProduto;
end;

procedure TPedidoView.grdProdutoCellClick(const Column: TColumn; const Row: Integer);
begin
  if Column = botao then
  begin
    if PedidoController.Alterando(Row) then
      PedidoController.AtualizarProduto(Row);
    PedidoController.NovoProduto;
    AtualizarGrid;
  end;
end;

procedure TPedidoView.grdProdutoDrawColumnCell(Sender: TObject; const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF;
const Row: Integer; const Value: TValue; const State: TGridDrawStates);
var
  LRect: TRectF;
begin
  if Column = botao then
  begin
    Canvas.Fill.Color := TAlphaColorRec.Silver;

    LRect := Bounds;
    LRect.Inflate(1, 1);

    Canvas.FillRect(LRect, 0, 0, AllCorners, 1.0);
    Canvas.Fill.Color := TAlphaColorRec.Black;
    Canvas.Font.Size  := grdProduto.TextSettings.Font.Size;
    Canvas.FillText(Bounds, 'Inserir', False, 1, [], TTextAlign.Center, TTextAlign.Center);
  end;
end;

procedure TPedidoView.grdProdutoGetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
begin
  if PedidoController.QuantidadeProduto >= ARow then
  begin
    PedidoController.AtualizarGrid(grdProduto.Columns[ACol].Name, ARow, Value);
  end;
end;

procedure TPedidoView.grdProdutoSelectCell(Sender: TObject; const ACol, ARow: Integer; var CanSelect: Boolean);
var
  LEnabled: Boolean;
begin
  LEnabled := PedidoController.Alterando(ARow);

  codigo_produto.ReadOnly := LEnabled;
  descricao.ReadOnly      := LEnabled;
end;

procedure TPedidoView.grdProdutoSetValue(Sender: TObject; const ACol, ARow: Integer; const Value: TValue);
begin
  if PedidoController.QuantidadeProduto >= ARow then
  begin
    PedidoController.AtualizarGridProduto(grdProduto.Columns[ACol].Name, ARow, Value);
  end;
end;

procedure TPedidoView.LimparComponentes;
begin
  edtNumeroPedido.Text := '';
  edtCliente.Text      := '';
  deEmissao.Date       := Now;
  AtualizarGrid;
  lblNomeCliente.Text := '';
  VisivelBotaoLocalizarPedido;
end;

procedure TPedidoView.LookupCliente;
var
  LRetorno: TArray<Variant>;
begin
  if not edtCliente.Text.Trim.IsEmpty then
  begin
    try
      LRetorno := PedidoController.LookupCliente(edtCliente.Text);

      if LRetorno <> nil then
      begin
        edtCliente.Text     := LRetorno[0];
        lblNomeCliente.Text := LRetorno[1];

        if PedidoController.QuantidadeProduto = 0 then
        begin
          PedidoController.NovoProduto;
          AtualizarGrid;
        end;

        grdProduto.SetFocus;
        codigo_produto.SetFocus;
        grdProduto.SelectColumn(codigo_produto.Index)
      end
      else
      begin
        edtCliente.Text     := '';
        lblNomeCliente.Text := '';
      end;
    except
      on E: Exception do
      begin
        TDialogService.MessageDialog('Não foi possível executar o lookup de cliente.' + #13 + 'Motivo: ' + E.Message, TMsgDlgType.mtError,
          [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0, nil);
      end;
    end;
  end;
end;

procedure TPedidoView.SearchEdtClienteClick(Sender: TObject);
begin
  LookupCliente;
end;

end.
