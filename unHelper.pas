unit unHelper;

interface

uses
  Vcl.StdCtrls, unModel, System.SysUtils, Data.DB, System.Generics.Collections;

//type
//  THelperTEdit = class helper for TEdit
//  private
//    class var FModel: IModel;
//  public
//    class property Model: IModel read FModel write FModel;
//    class procedure Lookup(const AFields: TArray<String>; const AProcedureReturn: TProc<TDataSet>; const AValue: String);
//  end;

implementation

{ THelperTEdit }

//class procedure THelperTEdit.Lookup(const AFields: TArray<String>; const AProcedureReturn: TProc<TDataSet>; const AValue: String);
//var
//  LFieldList: TDictionary<String, Variant>;
//  LField    : String;
//begin
//  if (Model <> nil) and (AFields <> nil) and (Assigned(AProcedureReturn)) then
//  begin
//    LFieldList := TDictionary<String, Variant>.Create;
//
//    for LField in AFields do
//    begin
//      LFieldList.Add(LField, AValue);
//    end;
//
//    Model.Filter(LFieldList);
//
//    AProcedureReturn(Model.DataSet);
//  end;
//end;

end.
