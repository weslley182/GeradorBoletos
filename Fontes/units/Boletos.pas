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
unit Boletos;

interface

uses
  SysUtils, Classes, LCBase, ListaTitulos;

type
  TLCBoletos = class(TLCBaseBoletos)
  private
    FDirRemessa: string;
    FListaTitulos: TListaTitulos;
    FTipoArquivo: TTipoArquivo;
    FTipoBoleto: TTipoBoleto;
    procedure SetDirRemessa(const Value: string);
    procedure SetListaTitulos(const Value: TListaTitulos);
    procedure SetTipoArquivo(const Value: TTipoArquivo);
    procedure SetTipoBoleto(const Value: TTipoBoleto);
    function VerificaTitulos: Boolean;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GerarArquivo: Boolean;

    procedure ImprimirBoletos;

    property ListaTitulos: TListaTitulos read FListaTitulos write SetListaTitulos;
  published
    { Published declarations }
    property DirRemessa: string read FDirRemessa write SetDirRemessa;
    property TipoArquivo: TTipoArquivo read FTipoArquivo write SetTipoArquivo;
    property TipoBoleto: TTipoBoleto read FTipoBoleto write SetTipoBoleto;
  end;

procedure Register;

implementation

uses Banco, FactoryArquivo, Arquivo, udmLCBoletos;

procedure Register;
begin
  RegisterComponents('Boletos', [TLCBoletos]);
end;

{ TLCBoletos }

constructor TLCBoletos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListaTitulos := TListaTitulos.Create(False);
end;

destructor TLCBoletos.Destroy;
begin
  FreeAndNil(FlistaTitulos);
  inherited;
end;

function TLCBoletos.VerificaTitulos: Boolean;
var
  i: Integer;
  ANumBanco,
  AConta,
  AAgencia: string;
begin
  with ListaTitulos.Items[0].Cedente.DadosBanco do
  begin
    //pegamos os dados do primeiro t�tulo
    ANumBanco := NumeroBanco;
    AAgencia  := Agencia;
    AConta    := Conta;
  end;

  Result := True;

  for i := 0 to ListaTitulos.Count - 1 do
  begin
    with ListaTitulos.Items[i].Cedente.DadosBanco do
    begin
      if (ANumBanco <> NumeroBanco) or
        (AConta <> Conta) or
        (AAgencia <> Agencia) then
      begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

function TLCBoletos.GerarArquivo: Boolean;
var
  Fabrica: TFactoryArquivo;
  AArquivo: TArquivo;
begin
  if Trim(DirRemessa) = '' then
    raise Exception.Create('Informe o diret�rio do arquivo de remessa.');

  if not DirectoryExists(DirRemessa) then
    raise Exception.Create('Diret�rio do Arquivo de Remessa inexistente!');

  if ListaTitulos.Count = 0 then
    raise Exception.Create('N�o existem t�tulos na lista!');

  if not VerificaTitulos then
    raise Exception.Create('Os t�tulos selecionados para a gera��o do arquivo devem ser da mesma conta!');

  Fabrica  := TFactoryArquivo.GetFabrica(ListaTitulos.Items[0].Cedente.DadosBanco.NumeroBanco);

  AArquivo                     := Fabrica.CreateArquivo(TipoArquivo);
  AArquivo.NumArquivo          := 1;
  AArquivo.DirRemessa          := DirRemessa;
  AArquivo.Titulos             := ListaTitulos;

  Result := AArquivo.GerarRemessa;
end;

procedure TLCBoletos.ImprimirBoletos;
begin
  dmLcBoletos := tdmLcBoletos.Create(nil);
  try
    dmLCBoletos.GeraBoletos(Self);
  finally
    FreeAndNil(dmLCBoletos);
  end;
end;

procedure TLCBoletos.SetDirRemessa(const Value: string);
begin
  FDirRemessa := Value;
end;

procedure TLCBoletos.SetListaTitulos(const Value: TListaTitulos);
begin
  FListaTitulos := Value;
end;

procedure TLCBoletos.SetTipoArquivo(const Value: TTipoArquivo);
begin
  FTipoArquivo := Value;
end;

procedure TLCBoletos.SetTipoBoleto(const Value: TTipoBoleto);
begin
  FTipoBoleto := Value;
end;

end.
 