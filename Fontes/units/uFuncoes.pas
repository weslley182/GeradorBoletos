{******************************************************************************}
{ Projeto: Curso Criando Componente Boleto                                     }
{                                                                              }
{ Copyright (C) 2011 Luiz Carlos                                               }
{                                                                              }
{ Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la  }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation;                                                    }
{                                                                              }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM    }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT)                             }
{                                                                              }
{                                                                              }
{ Luiz Carlos Alves                                                            }
{ luiz_sistemas@hotmail.com                                                    }
{ http://www.luizsistemas.com.br                                               }
{ Balsas-MA                                                                    }
{                                                                              }
{******************************************************************************}
unit uFuncoes;

interface

uses SysUtils, TypInfo, Graphics, Windows, ExtCtrls;

function FatorVencimento(AVencimento: TDateTime): string;
function FormatarTexto(Texto: string; TamanhoDesejado: integer; AcrescentarADireita
  : boolean = true; CaracterAcrescentar: char = ' '): string;
function LPad(S: string; Len: Integer; Ch: Char = ' '): string;
function RPad(S: string; Len: Integer; Ch: Char = '0'): string;
function ValidaCaractere(AChar: Char): Char;
function ValidaTexto(ATexto: string): string;
function DVBarras(ACodigo: string): string;
function Modulo10(Valor: string): string;
function Modulo11(Valor: string; Base: Integer = 9; Resto: boolean = false): string;
procedure CopyObject(Source, Dest: TObject);
function SomenteTexto(ATexto: string): string;
function IfElse(Expressao: Boolean; Verdadeiro, Falso: Variant): Variant;
Procedure GerarImagemCodBarras(Cod : String; Imagem : TImage);

implementation

Procedure GerarImagemCodBarras(Cod : String; Imagem : TImage);
const
  LarguraBarraGrossa: Integer = 3;
  LarguraBarraFina:   Integer = 1;
  digitos: array['0'..'9'] of string[5] = ('00110',
    '10001',
    '01001',
    '11000',
    '00101',
    '10100',
    '01100',
    '00011',
    '10010',
    '01010');
var
  Numero: string;
  Cod1: array[1..1000] of Char;
  Cod2: array[1..1000] of Char;
  Codigo: array[1..1000] of Char;
  Digito: string;
  c1, c2: Integer;
  x, y, z, h: LongInt;
  a, b, c, d: TPoint;
  I: Boolean;
begin
  Numero := Cod;
  for x := 1 to 1000 do
  begin
    Cod1[x] := #0;
    Cod2[x] := #0;
    Codigo[x] := #0;
  end;
  c1 := 1;
  c2 := 1;
  x := 1;
  for y := 1 to Length(Numero) div 2 do
  begin
    Digito := Digitos[Numero[x]];
    for z := 1 to 5 do
    begin
      Cod1[c1] := Digito[z];
      Inc(c1);
    end;
    Digito := Digitos[Numero[x + 1]];
    for z := 1 to 5 do
    begin
      Cod2[c2] := Digito[z];
      Inc(c2);
    end;
    Inc(x, 2);
  end;
  y := 5;
  Codigo[1] := '0';
  Codigo[2] := '0';
  Codigo[3] := '0';
  Codigo[4] := '0'; { Inicio do Codigo }
  for x := 1 to c1 - 1 do
  begin
    Codigo[y] := Cod1[x];
    Inc(y);
    Codigo[y] := Cod2[x];
    Inc(y);
  end;
  Codigo[y] := '1';
  Inc(y); { Final do Codigo }
  Codigo[y] := '0';
  Inc(y);
  Codigo[y] := '0';

  for x := 1 to Length(Codigo) do
    case Codigo[x] of
      '0': Imagem.Width := Imagem.Width + LarguraBarraFina;
      '1': Imagem.Width := Imagem.Width + LarguraBarraGrossa;
    end;

  Imagem.Canvas.Pen.Width := 1;
  Imagem.Canvas.Brush.Color := ClWhite;
  Imagem.Canvas.Pen.Color := ClWhite;
  a.x := 1;
  a.y := 0;
  b.x := 1;
  b.y := 79;
  c.x := 2000;
  c.y := 79;
  d.x := 2000;
  d.y := 0;
  Imagem.Canvas.Polygon([a, b, c, d]);
  Imagem.Canvas.Brush.Color := ClBlack;
  Imagem.Canvas.Pen.Color := ClBlack;
  x := 0;
  i := True;
  for y := 1 to 1000 do
  begin
    if Codigo[y] <> #0 then
    begin
      if Codigo[y] = '0' then
        h := 1
      else
        h := 3;
      a.x := x;
      a.y := 0;
      b.x := x;
      b.y := 79;
      c.x := x + h - 1;
      c.y := 79;
      d.x := x + h - 1;
      d.y := 0;
      if i then
        Imagem.Canvas.Polygon([a, b, c, d]);
      i := not (i);
      x := x + h;
    end;
  end;
end;

function IfElse(Expressao: Boolean; Verdadeiro, Falso: Variant): Variant;
begin
  if Expressao then
    Result := Verdadeiro
  else
    Result := Falso;
end;

function SomenteTexto(ATexto: string): string;
var
  Texto: string;
  i: integer;
begin
  for i := 1 to Length(ATexto) do
  begin
    if ATexto[i] in ['0'..'9', 'a'..'z', 'A'..'Z'] then
      Texto := Texto + ATexto[i];
  end;
  Result := Texto;
end;

//insira a unit TypInfo em uses
procedure CopyObject(Source, Dest: TObject);
var
  TypInfo: PTypeInfo;
  PropList: TPropList;
  PropCount, i: integer;
  Value: variant;
  AObjSource,
  AObjDest: TObject;
begin
  TypInfo := Source.ClassInfo;
  PropCount := GetPropList(TypInfo, tkAny, @PropList);
  for i := 0 to PropCount - 1 do
  begin
    if (PropList[i]^.PropType^.Kind = tkClass) then
    begin
      AObjSource := GetObjectProp(Source, Proplist[i]);
      AObjDest   := GetObjectProp(Dest, Proplist[i]);
      if AObjDest <> nil then
        CopyObject(AObjSource, AObjDest)
      else
        SetObjectProp(AObjDest, Proplist[i], AObjSource);
    end
    else
    if (PropList[i]^.PropType^.Kind = tkMethod) or
       (PropList[i]^.Name = 'Name') or
       (PropList[i]^.SetProc = nil) then
    begin
      Continue;
    end
    else
    begin
      Value := GetPropValue (Source, PropList [i]^.Name);
      SetPropValue (Dest, PropList [i]^.Name, Value);
    end;
  end;
end;


function FatorVencimento(AVencimento: TDateTime): string;
begin
  Result := IntToStr(Trunc(AVencimento - EncodeDate(1997, 10, 7)));
end;

function FormatarTexto(Texto: string; TamanhoDesejado: integer; AcrescentarADireita
  : boolean = true; CaracterAcrescentar: char = ' '): string;
var
  QuantidadeAcrescentar,
  TamanhoTexto,
  PosicaoInicial: integer;
begin
  //valida texto e caractere
  CaracterAcrescentar := ValidaCaractere(CaracterAcrescentar);
  Texto := ValidaTexto(Texto);
  TamanhoTexto := Length(Texto);

  QuantidadeAcrescentar := TamanhoDesejado - TamanhoTexto;

  if QuantidadeAcrescentar < 0 then
    QuantidadeAcrescentar := 0;
  if CaracterAcrescentar = '' then
    CaracterAcrescentar := ' ';
  if TamanhoTexto >= TamanhoDesejado then
    PosicaoInicial := TamanhoTexto - TamanhoDesejado + 1
  else
    PosicaoInicial := 1;

  if AcrescentarADireita then
    Texto := Copy(Texto, 1, TamanhoDesejado) +
      StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar)
  else
    Texto := StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar) +
      Copy(Texto, PosicaoInicial, TamanhoDesejado);

  Result := AnsiUpperCase(Texto);
end;

function ValidaTexto(ATexto: string): string;
var
  Texto: string;
  TamanhoTexto: integer;
  i: integer;
begin
  Texto := Trim(AnsiUpperCase(ATexto));
  TamanhoTexto := Length(Texto);
  for i := 1 to (TamanhoTexto) do
  begin
    if Pos(Texto[i],
      '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~ '' "!@#$%^& * ()_-+\=|/\{}[]:;,.<>') = 0 then
    begin
      case Texto[i] of
        'Á', 'À', 'Â', 'Ä', 'Ã': Texto[i] := 'A';
        'É', 'È', 'Ê', 'Ë': Texto[i] := 'E';
        'Í', 'Ì', 'Î', 'Ï': Texto[i] := 'I';
        'Ó', 'Ò', 'Ô', 'Ö', 'Õ': Texto[i] := 'O';
        'Ú', 'Ù', 'Û', 'Ü': Texto[i] := 'U';
        'Ç': Texto[i] := 'C';
        'Ñ': Texto[i] := 'N';
      else
        Texto[i] := ' ';
      end;
    end;
  end;
  Result := Texto;
end;

function ValidaCaractere(AChar: Char): Char;
begin
  case AChar of
    '0'..'9', 'a'..'z', 'A'..'Z': Result := AChar;
  else
    Result := ' '; // retorna espaço em branco
  end;
end;                        

function LPad(S: string; Len: Integer; Ch: Char): string;
begin
  Result := FormatarTexto(S, Len, True, Ch);
end;

function RPad(S: string; Len: Integer; Ch: Char): string;
begin
  Result := FormatarTexto(S, Len, False, Ch);
end;

{Digito verificador do Código de Barras}
function DVBarras(ACodigo: string): string;
var
  resto, i, soma, multiplicador: Integer;
begin
  multiplicador := 2;
  soma := 0;
  for i := Length(ACodigo) downto 1 do
  begin
    soma := soma + (StrToInt(ACodigo[i]) * multiplicador);
    inc(multiplicador);
    if multiplicador = 10 then multiplicador := 2;
  end;

  resto := soma mod 11;

  if resto in [0,1,10,11] then
    Result :=  '1'
  else
    Result := IntToStr(11-resto);
end;

function Modulo10(Valor: string): string;
var
  Auxiliar: string;
  Contador, Peso: integer;
  Digito: integer;
begin
  Auxiliar := '';
  Peso := 2;
  for Contador := Length(Valor) downto 1 do
  begin
    Auxiliar := IntToStr(StrToInt(Valor[Contador]) * Peso) + Auxiliar;
    if Peso = 1 then
      Peso := 2
    else
      Peso := 1;
  end;

  Digito := 0;
  for Contador := 1 to Length(Auxiliar) do
  begin
    Digito := Digito + StrToInt(Auxiliar[Contador]);
  end;
  Digito := 10 - (Digito mod 10);
  if (Digito > 9) then
    Digito := 0;
  Result := IntToStr(Digito);
end;

function Modulo11(Valor: string; Base: Integer = 9; Resto: boolean = false): string;
var
  Soma: integer;
  Contador, Peso, Digito: integer;
begin
  Soma := 0;
  Peso := 2;
  for Contador := Length(Valor) downto 1 do
  begin
    Soma := Soma + (StrToInt(Valor[Contador]) * Peso);
    if Peso < Base then
      Peso := Peso + 1
    else
      Peso := 2;
  end;

  if Resto then
    Result := IntToStr(Soma mod 11)
  else
  begin
    Digito := 11 - (Soma mod 11);
    if (Digito > 9) then
      Digito := 0;
    Result := IntToStr(Digito);
  end
end;



end.

