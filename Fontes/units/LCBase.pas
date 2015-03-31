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
unit LCBase;

interface

uses Classes;

const
  CODIGO_MOEDA = '9';

type
  TTipoBoleto = (tbPadrao, tbCarne);
  
  TTipoPessoa = (tpFisica, tpJuridica);

  TTipoArquivo = (taCnab240, taCnab400);

  TTipoRemessa =
    (
    trEntradaTitulos,
    trPedidoBaixa,
    trConcessaoAbatimento,
    trCancelamentoAbatimento,
    trAlteracaoVencimento,
    trConcessaoDesconto,
    trCancelamentoDesconto,
    trProtestar,
    trCancelaSustacaoInstrucaoProtesto,
    trRecusaAlegacaoSacado,
    trAlteracaoOutrosDados,
    trDesagendamentoDebitoAutomatico,
    trAcertoDadosRateioDeCredito,
    trCancelamentoDoRateioDeCredito
    );

  TTipoEmissao =
    (
    teBancoEmite,
    teClienteEmite,
    teBancoReemite,
    teBancoNaoReemite
    );

  TEspecieDocumento =
    (
    edCheque,
    edDuplicataMercantil,
    edDuplicataMercantilPorIndicacao,
    edDuplicataDeServico,
    edDuplicataDeServicoPorIndicacao,
    edDuplicataRural,
    edLetraDeCambio,
    edNotaDeCreditoComercial,
    edNotaDeCreditoAExportacao,
    edNotaDeCreditoIndustrial,
    edNotaDeCreditoRural,
    edNotaPromissoria,
    edNotaPromissoriaRural,
    edTriplicataMercantil,
    edTriplicataDeServico,
    edNotaDeSeguro,
    edRecibo,
    edFatura,
    edNotaDeDebito,
    edApoliceDeSeguro,
    edMensalidadeEscolar,
    edParcelaDeConsorcio,
    edCobrancaSeriada
    );

  TTipoAceite = (taSim, taNao);

  TTipoJuros =
    (
    tjValorPorDia,
    tjPercentual,
    tjIsento,
    tjNaoInformado
    );

  TTipoDesconto =
    (
    tdValorFixo,
    tdPercentual,
    tdAntecipacaoDiaCorrido,
    tdAntecipacaoDiaUtil,
    tdPercentualValorNominal,
    tdNaoInformado
    );
    
  TTipoProtesto =
    (
    tpDiasOcorridos,
    tpDiasUteis,
    tpNaoProtestar
    );

  TTipoBaixa =
    (
    tbBaixar,
    tbNaoBaixar
    );

  TTipoMulta =
   (
   tmValorFixo,
   tmPercentual,
   tmNaoInformado
   );     

  TLCBaseBoletos = class (TComponent);

implementation

end.
