unit unConexao;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Stan.Option, FireDAC.Phys.MSSQL, FireDAC.Phys.FB, FireDAC.Phys.SQLite,
  FireDAC.Phys.Oracle, FireDAC.Phys.PG, FireDAC.Phys.MySQL,
  FireDAC.Stan.Def, FireDAC.VCLUI.Wait;

type
  IConexao = interface
    ['{06BCC2D7-AF94-4E28-90BD-D8282B7F764D}']
    function GetQuery: TFDQuery;
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
  end;

  TConexao = class(TInterfacedObject, IConexao)
  strict private
    FConnection: TFDConnection;
    FPhysMySQL : TFDPhysMySQLDriverLink;
  private
    FQuery: TFDQuery;
    procedure CriarArquivoConfiguracao;
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;

    function GetConnection: TFDConnection;
    function GetQuery: TFDQuery;

    property Connection: TFDConnection read GetConnection;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses System.IOUtils, System.Classes, System.SysUtils;

const
  cConfig = 'config.ini';

  { TConexao }

function TConexao.GetConnection: TFDConnection;
begin
  if FConnection = nil then
  begin
    FConnection             := TFDConnection.Create(nil);
    FConnection.LoginPrompt := False;

    FConnection.Params.LoadFromFile(cConfig);
    FPhysMySQL.VendorLib := FConnection.Params.Values['VendorLib'];
  end;

  Result := FConnection;
end;

function TConexao.GetQuery: TFDQuery;
begin
  if FQuery = nil then
  begin
    FQuery            := TFDQuery.Create(nil);
    FQuery.Connection := Connection;
  end;

  Result := FQuery;
end;

procedure TConexao.CommitTransaction;
begin
  Connection.Commit;
end;

procedure TConexao.RollbackTransaction;
begin
  Connection.Rollback;
end;

procedure TConexao.StartTransaction;
begin
  Connection.StartTransaction;
end;

constructor TConexao.Create;
begin
  FPhysMySQL := TFDPhysMySQLDriverLink.Create(nil);
  CriarArquivoConfiguracao;
end;

procedure TConexao.CriarArquivoConfiguracao;
begin
  if not TFile.Exists(cConfig) then
  begin
    TFile.WriteAllLines(cConfig, ['DriverID=MySQL', 'Server=Localhost', 'User_Name=root', 'Password=Meduarda@20', 'Database=Teste', 'Port=3306',
      'VendorLib=', 'VendorHome=']);
  end;
end;

destructor TConexao.Destroy;
begin
  FreeAndNil(FPhysMySQL);
  FConnection.Rollback;
  FConnection.Free;
  FQuery.Free;
  inherited;
end;

end.
