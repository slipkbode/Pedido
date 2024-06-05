program Pedido;

uses
  System.StartUpCopy,
  FMX.Forms,
  unPedidoView in 'View\unPedidoView.pas' {PedidoView},
  unClienteModel in 'Model\unClienteModel.pas',
  unModel in 'Model\unModel.pas',
  unPedidoModel in 'Model\unPedidoModel.pas',
  unPedidoProdutoModel in 'Model\unPedidoProdutoModel.pas',
  unProdutoModel in 'Model\unProdutoModel.pas',
  unPedidoController in 'Controller\unPedidoController.pas',
  unConexao in 'unConexao.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TPedidoView, PedidoView);
  Application.Run;
end.
