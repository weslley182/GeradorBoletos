unit LcaBase;

interface

uses Classes;

const
  CODIGO_MOEDA = '9';

type
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
    trAlteracaoOutrosDados
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
    edParcelaDeConsorcio
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

   TlcaBaseBoleto = class(TComponent);


implementation

end.
