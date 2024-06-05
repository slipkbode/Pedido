unit unModel;

interface

uses System.Generics.Collections;

type
  TModelStatus = (update, insert);

  TModel = class
  private
    FStatus: TModelStatus;

  protected
    function GetSQL: String; virtual;
    function GetInsert: String; virtual;
    function GetDelete: String; virtual;
    function GetUpdate: String; virtual;
  public
    function Filter(const AField, AOperator: String): String;
    property Status: TModelStatus read FStatus write FStatus;
  end;

implementation

uses
  System.SysUtils;

{ TModel }

function TModel.Filter(const AField, AOperator: String): String;
var
  LFilter: string;
begin
  LFilter := AField + ' ' + AOperator + ' :' + AField;

  if AOperator.Equals('like') then
    LFilter := AField + ' ' + AOperator + '% :' + AField + '%';

  Result := Format('%s and %s',
                   [GetSQL,
                    LFilter]);
end;

function TModel.GetDelete: String;
begin

end;

function TModel.GetInsert: String;
begin

end;

function TModel.GetSQL: String;
begin

end;

function TModel.GetUpdate: String;
begin

end;

end.
