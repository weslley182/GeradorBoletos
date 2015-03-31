unit BradescoCnab400;

interface

uses Cnab400, uFuncoes, SysUtils, LCBase;

type
  TBradescoCnab400 = class(TCnab400)
  protected
    function GetOcorrencia: string; override;
    function GetEspecieDoc(ATipo: TEspecieDocumento): string; override;

    procedure HeaderArquivo; override;
    procedure Registros; override;
  public
    function GerarRemessa: Boolean; override;
  end;

implementation

uses Titulo, Arquivo;

{ TBradescoCnab400 }

function TBradescoCnab400.GerarRemessa: Boolean;
begin
  NomeCompletoArquivo := DirRemessa + 'CB' + FormatDateTime('ddmmss',Now) + '.REM';
  Result := inherited GerarRemessa;
end;

procedure TBradescoCnab400.Registros;
var
  i: integer;
  TipoEmissao: string;
begin
  for i := 0 to Titulos.Count - 1 do
  begin
    with Titulos.Items[i] do
    begin
      case Cedente.Tipo of
        tpFisica: FTipoPessoa := '01';
        tpJuridica: FTipoPessoa := '02';
      else
        FTipoPessoa := '99';
      end;

      if DadosComplementares.EmissaoBoleto = teBancoEmite then
        TipoEmissao := '1'
      else
        TipoEmissao := '2';

      FLinha := '1'                                             +  // Identifica��o do Registro
        RPad( '0', 19)                                          +  // Identifica��o do D�bito Autom�tico em C/C
        '0'+                                                       //
        RPad(Cedente.DadosBanco.Carteira,3)                     +  // Identifica��o da Empresa Cedente no Banco
        RPad(Cedente.DadosBanco.Agencia,5)                      +  //
        Cedente.DadosBanco.Conta                                +  //
        Cedente.DadosBanco.DigitoConta                          +  //
        LPad(NumDocumento,25)                                   +  // Numero de Controle do Participante
        '000'                                                   +  // C�digo do Banco a ser debitado na C�mara de Compensa��o
        '00000'                                                 +  // zeros
        Cedente.DadosBanco.NossoNumero                          +
        Cedente.DadosBanco.DigitoNossoNumero                    +
        RPad(FormatCurr('0', DadosComplementares.ValorDesconto * 100), 10) + // Desconto Bonifica��o por dia
        TipoEmissao                                             +  // Condi��o para Emiss�o
        'N'                                                     + // Ident. se emite papeleta para D�bito Autom�tico
        LPad('',10)                                             + // Identifica��o da Opera��o do Banco - brancos
        ' '                                                     + // Indicador Rateio Cr�dito
        '0'                                                     + // Endere�amento para Aviso do D�bito Autom�tico em Conta Corrente
        '  '                                                    + //  branco
        GetOcorrencia                                           + // Identifica��o ocorr�ncia
        LPad(NumDocumento,  10)                                 +
        FormatDateTime( 'ddmmyy', Vencimento)                   +
        RPad(FormatCurr('0', Valor * 100), 13)                  +
        RPad('0',8)                                             + // conta agencia encarregada
        GetEspecieDoc(DadosComplementares.EspecieDocumento)     +
        IfElse(DadosComplementares.Aceite = taSim, 'S', 'N')    +  // Identifica��o
        FormatDateTime( 'ddmmyy', Data )                        ;  // Data da emiss�o do T�tulo
        case DadosComplementares.Protesto of
          tpDiasOcorridos:
            begin
              FLinha := FLinha + '06' +
              RPad(IntToStr(DadosComplementares.DiasProtesto), 2);
            end;
          tpDiasUteis:
            begin
              FLinha := FLinha + '06' +
              RPad(IntToStr(DadosComplementares.DiasProtesto), 2);
            end;
          tpNaoProtestar:
            begin
              FLinha := FLinha + '00' +
              RPad('0', 2);
            end;
        end;
        FLinha := FLinha +
        RPad(FormatCurr('0', DadosComplementares.ValorJuros * 100), 13)            +
        IfElse(DadosComplementares.DataDesconto < EncodeDate(1999,01,01),'000000',
          FormatDateTime( 'ddmmyy', DadosComplementares.DataDesconto))             +
        RPad(FormatCurr('0', DadosComplementares.ValorDesconto * 100), 13)         +
        RPad(FormatCurr('0', DadosComplementares.ValorIOF * 100), 13)              +
        RPad(FormatCurr('0', DadosComplementares.ValorAbatimento * 100), 13)       +
        FTipoPessoa                                                                +
        RPad(SomenteTexto(Sacado.Cpf_Cnpj),14)                                     +
        LPad(Sacado.Nome, 40)                                                      +
        LPad(Sacado.Endereco.Logradouro + Sacado.Endereco.Numero                   +
          Sacado.Endereco.Bairro + Sacado.Endereco.Cidade + Sacado.Endereco.Estado, 40) +
        LPad('', 12) + LPad(SomenteTexto(Sacado.Endereco.Cep),8)                                 +
        LPad('', 60 )                                                              +  // Sacador/Avalista ou 2� Mensagem
        RPad(IntToStr(i + 2), 6);
        //adiciona FLinha
        FArquivoTexto.Add(FLinha);
    end;
  end;
end;

procedure TBradescoCnab400.HeaderArquivo;
begin
  FCodigoEmpresa := Titulos.Items[0].Cedente.DadosBanco.CodCedente;

  inherited;

end;

function TBradescoCnab400.GetOcorrencia: string;
begin
  Result := inherited GetOcorrencia;
  case Remessa of
    trDesagendamentoDebitoAutomatico: Result := '35';
    trAcertoDadosRateioDeCredito:     Result := '68';
    trCancelamentoDoRateioDeCredito:  Result := '69';
  end;
end;

function TBradescoCnab400.GetEspecieDoc(ATipo: TEspecieDocumento): string;
begin
  case ATipo of
    edDuplicataMercantil: Result := '01';
    edNotaPromissoria:    Result := '02';
    edNotaDeSeguro:       Result := '03';
    edCobrancaSeriada:    Result := '04';
    edRecibo:             Result := '05';
    edLetraDeCambio:      Result := '10';
    edNotaDeDebito:       Result := '11';
    edDuplicataDeServico: Result := '12';
  else
    Result := '99';
  end;
end;

end.
