{******************************************************************************}
{ Projeto: Curso Criando Componente Boleto                                     }
{                                                                              }
{ Copyright (C) 2011 Luiz Carlos                                               }
{                                                                              }
{ Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la  }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation;                                                    }
{                                                                              }
{ Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM    }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT)                             }
{                                                                              }
{                                                                              }
{ Luiz Carlos Alves                                                            }
{ luiz_sistemas@hotmail.com                                                    }
{ http://www.luizsistemas.com.br                                               }
{ Balsas-MA                                                                    }
{                                                                              }
{******************************************************************************}
unit ListaTitulos;

interface

uses
  Classes, Contnrs, Titulo;
  
type
  TListaTitulos = class (TObjectList)
  private
    function GetItems(Index: Integer): TLCTitulo;
    procedure SetItems(Index: Integer; const Value: TLCTitulo);
  public
    function Add(Value: TLCTitulo): integer;
    function IndexOf(Value: TLCTitulo): Integer;
    procedure Insert(Index: integer; Value: TLCTitulo);
    function Remove(Value: TLCTitulo): Integer;
    property Items[Index: Integer]: TLCTitulo read GetItems write SetItems;  default;
  end;


implementation

{ TListaTitulos }

function TListaTitulos.Add(Value: TLCTitulo): integer;
begin
  Result := inherited Add(Value);
end;

function TListaTitulos.GetItems(Index: Integer): TLCTitulo;
begin
  Result := TLCTitulo(inherited Items[Index]);
end;

function TListaTitulos.IndexOf(Value: TLCTitulo): Integer;
begin
  Result := inherited IndexOf(Value);
end;

function TListaTitulos.Remove(Value: TLCTitulo): Integer;
begin
  Result := inherited Remove(Value);
end;

procedure TListaTitulos.SetItems(Index: Integer; const Value: TLCTitulo);
begin
  inherited Items[Index] := Value;
end;

procedure TListaTitulos.Insert(Index: integer; Value: TLCTitulo);
begin
  inherited Insert (Index, Value);
end;


end.
