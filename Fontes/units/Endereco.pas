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
unit Endereco;

interface

uses Classes;

type
  TEndereco = class (TPersistent)
  private
    FCidade: string;
    FComplemento: string;
    FBairro: string;
    FEstado: string;
    FNumero: string;
    FLogradouro: string;
    FCep: string;
    procedure SetBairro(const Value: string);
    procedure SetCep(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetEstado(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetNumero(const Value: string);
  published
    property Logradouro: string read FLogradouro write SetLogradouro;
    property Numero: string read FNumero write SetNumero;
    property Bairro: string read FBairro write SetBairro;
    property Complemento: string read FComplemento write SetComplemento;
    property Cidade: string read FCidade write SetCidade;
    property Estado: string read FEstado write SetEstado;
    property Cep: string read FCep write SetCep;
  end;

implementation

{ TEndereco }

procedure TEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCep(const Value: string);
begin
  FCep := Value;
end;

procedure TEndereco.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TEndereco.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetEstado(const Value: string);
begin
  FEstado := Value;
end;

procedure TEndereco.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TEndereco.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

end.



