unit Cnab240;

interface

uses Arquivo, uFuncoes, LCBase, SysUtils;

type
  TCnab240 = class(TArquivo)
  private

  protected
    FTipoPessoa,
    FCedenteCPFCNPJ,
    FCodConvenio,
    FCodigoConta,
    FLayoutArquivo,
    FLayoutLote,
    FCampoUsoEmpresa,
    FNumeroDocumento,
    FAgenciaCobradora,
    FTipoDocumento,
    FContrato,
    FNomeBanco: string;

    procedure SegmentoP(Index: Integer); virtual;
    procedure SegmentoQ(Index: Integer); virtual;
    procedure SegmentoR(Index: Integer); virtual;

    procedure HeaderArquivo; virtual;
    procedure HeaderLote; virtual;
    procedure Registros; virtual;
    procedure TrailerLote; virtual;
    procedure TrailerArquivo; virtual;
  public
    function GerarRemessa: Boolean; override;

  end;

implementation

{ TCnab240 }

function TCnab240.GerarRemessa: Boolean;
begin
  FArquivoTexto.clear;
  try
    HeaderArquivo;

    HeaderLote;

    Registros;

    TrailerLote;

    TrailerArquivo;

    FArquivoTexto.SaveToFile(NomeCompletoArquivo);

    Result := True;
  except
    raise;
  end;
end;

procedure TCnab240.HeaderArquivo;
begin
  with Titulos.Items[0].Cedente do
  begin
    {Header do Arquivo}
    case Tipo of
      tpFisica: FTipoPessoa := '1';
      tpJuridica: FTipoPessoa := '2';
    end;

    FCedenteCPFCNPJ := RPad(SomenteTexto(Cpf_Cnpj), 14, '0');
    FLinha := DadosBanco.NumeroBanco  + //!CODIGO DO BANCO NA COMPENSACAO !  1!  3!  3! - !NUMERICO     !54 !
      '0000'                          + //!LOTE DE SERVICO                !  4!  7!  4! - ! 0000        ! 1 !
      '0'                             + //!REGISTRO HEADER DE ARQUIVO     !  8!  8!  1! - ! 0           ! 2 !
      LPad('', 9)                     + //!USO EXCLUSIVO FEBRABAN/CNAB    !  9! 17!  9! - !BRANCOS      !   !
      FTipoPessoa                     + //!TIPO DE INSCRICAO DA EMPRESA   ! 18! 18!  1! - !1-CPF, 2-CGC ! 6 !
      FCedenteCPFCNPJ                 + //!N  DE INSCRICAO DA EMPRESA     ! 19! 32! 14! - !NUMERICO     ! 6 !
      LPad(FCodConvenio,20)           + //!CODIGO DO CONVENIO NO BANCO    ! 33! 52! 20! - !ALFANUMERICO !6/7!
      DadosBanco.Agencia              + //!AGENCIA MANTENEDORA DA CONTA   ! 53! 57!  5! - !NUMERICO     !6/8!
      DadosBanco.DigitoAgencia        + //!DIGITO VERIFICADOR DA AGENCIA  ! 58! 58!  1! - !ALFANUMERICO !6/8!
      LPad(FCodigoConta,14)           + //!CODIGO DA CONTA, AGENCIA - VARIA
      LPad(Nome, 30)                  + //!NOME DA EMPRESA                ! 73!102! 30! - !ALFANUMERICO !   !
      LPad(FNomeBanco, 30)            + //!NOME DO BANCO                  !103!132! 30! - !ALFANUMERICO !   !
      LPad('', 10)                    + //!USO EXCLUSIVO FEBRABAN/CNAB    !133!142! 10! - !BRANCOS      !   !
      '1'                             + //!CODIGO REMESSA / RETORNO       !143!143!  1! - !1-REM e 2-RET!   !
      FormatDateTime('ddmmyyyy', Date)+ //!DATA DE GERACAO DO ARQUIVO     !144!151!  8! - !NUM/DDMMAAAA/!   !
      FormatDateTime('hhmmss', Time)  + //!HORA DE GERACAO DO ARQUIVO     !152!157!  6! - !NUM /HHMMSS/ !   !
      RPad(IntToStr(NumArquivo), 6)   + //!N  SEQUENCIAL DO ARQUIVO       !158!163!  6! - !NUMERICO     !17 !
      FLayoutArquivo                  + //!N DA VERSAO DO LAYOUT DO ARQUIV - VARIA
      RPad('0', 5)                    + //!DENSIDADE DE GRAVACAO DO ARQUIV!167!171!  5! - !NUMERICO/BPI/!   !
      LPad('', 20)                    + //!PARA USO RESERVADO DO BANCO    !172!191! 20! - !ALFANUMERICO !   !
      FCampoUsoEmpresa                + //! uso da empresa - VARIA        !192!230! 39!
      LPad('',10)                     ; //em branco

    //adiciona FLinha
    FArquivoTexto.Add(FLinha);
  end;
end;

procedure TCnab240.HeaderLote;
begin
  with Titulos.Items[0].Cedente do
  begin
    FLinha := DadosBanco.NumeroBanco   + //!CODIGO DO BANCO NA COMPENSACAO !  1!  3!  3! - !NUMERICO     !   !
      '0001'                           + //!LOTE DE SERVICO                !  4!  7!  4! - !NUMERICO     ! 1 !
      '1'                              + //!REGISTRO HEADER DO LOTE        !  8!  8!  1! - ! 1           ! 2 !
      'R'                              + //!TIPO DE OPERACAO               !  9!  9!  1! - !ALFANUMERICO ! 3 !
      '01'                             + //!TIPO DE SERVICO                ! 10! 11!  2! - ! 01          ! 4 !
      '00'                             + //!FORMA DE LANCAMENTO            ! 12! 13!  2! - !ZEROS        !39 !
      FLayoutLote                      + //!N  DA VERSAO DO LAYOUT DO LOTE - VARIA
      ' '                              + //!USO EXCLUSIVO FEBRABAN/CNAB    ! 17! 17!  1! - !BRANCOS      !   !
      FTipoPessoa                      + //!TIPO DE INSCRICAO DA EMPRESA   ! 18! 18!  1! - !1-CPF, 2-CGC !   !
      RPad(FCedenteCPFCNPJ, 15)        + //!N  DE INSCRICAO DA EMPRESA     ! 19! 33! 15! - !NUMERICO     !   !
      LPad(FCodConvenio,20)            + //!CODIGO DO CONVENIO NO BANCO    ! 34! 53! 20! - !ALFANUMERICO ! 7 !
      DadosBanco.Agencia               + //!AGENCIA MANTENEDORA DA CONTA   ! 54! 58!  5! _ !NUMERICO     !   !
      DadosBanco.DigitoAgencia         + //!DIGITO VERIFICADOR DA AGENCIA  ! 59! 59!  1! - !ALFANUMERICO !   !
      LPad(FCodigoConta,14)            + //!NUMERO DA CONTA CORRENTE       ! 60! 71! 12! _ !NUMERICO     !   !
      LPad(Nome,30)                    + //!NOME DA EMPRESA                ! 74!103! 30! - !ALFANUMERICO !   !
      LPad('', 40)                     + //!MENSAGEM 1                     !104!143! 40! - !ALFANUMERICO !19 !
      LPad('', 40)                     + //!MENSAGEM 2                     !144!183! 40! - !ALFANUMERICO !19 !
      RPad(IntToStr(NumArquivo), 8)    + //!NUMERO REMESSA/RETORNO         !184!191!  8! - !NUMERICO     !   !
      FormatDateTime('ddmmyyyy', Date) + //!DATA DE GRAVACAO REMESSA/RETORN!192!199!  8! - !DDMMAAAA     !   !
      RPad('0', 8)                     + //!DATA DO CREDITO                !200!207!  8! - !DDMMAAAA     !   !
      LPad('', 33)                     ; //!USO EXCLUSIVO FEBRABAN/CNAB    !208!240! 33! - !BRANCOS      !   !

    //adiciona FLinha
    FArquivoTexto.Add(FLinha);
  end;
end;

procedure TCnab240.Registros;
var
  i: integer;
begin
  for i:= 0 to titulos.Count - 1 do
  begin
    SegmentoP(i);
    SegmentoQ(i);
    SegmentoR(i);
  end;
end;

procedure TCnab240.SegmentoP(Index: Integer);
var
  ANossoNumero,
  AEspecDocumento,
  AEmissao,
  AAceite: string;
begin
  with Titulos do
  begin
    with Items[Index] do
    begin
      {Segmento P}
      ANossoNumero    := LPad(Cedente.DadosBanco.NossoNumero +
         Cedente.DadosBanco.DigitoNossoNumero, 20);

      AEspecDocumento := GetEspecieDoc(DadosComplementares.EspecieDocumento);
      AEmissao        := GetEmissao(DadosComplementares.EmissaoBoleto);
      
      case DadosComplementares.Aceite of
        taSim: AAceite := 'A';
        taNao: AAceite := 'N';
      end;

      FLinha := Cedente.DadosBanco.NumeroBanco + //!CODIGO DO BANCO NA COMPENSACAO !  1!  3!  3! - !NUMERICO     !   !
        RPad(IntToStr(NumeroLote), 4)          + //!LOTE DE SERVICO                !  4!  7!  4! - !NUMERICO     ! 1 !
        '3'                                    + //!REGISTRO DETALHE               !  8!  8!  1! - !Igual a 3    ! 2 !
        RPad(IntToStr(Index + 1), 5)           + //!N  SEQUENCIAL DO REG. NO LOTE  !  9! 13!  5! - !NUMERICO     !10 !
        'P'                                    + //!COD. SEGMENTO DO REG. DETALHE  ! 14! 14!  1! - !Igual a P    !11 !
        ' '                                    + //!USO EXCLUSIVO FEBRABAN/CNAB    ! 15! 15!  1! - !BRANCOS      !   !
        GetOcorrencia                          + //!CODIGO DE MOVIMENTO            ! 16! 17!  2! - !NUMERICO     !20 !
        Cedente.DadosBanco.Agencia             + //!AGENCIA MANTENEDORA DA CONTA   ! 18! 22!  5! _ !NUMERICO     ! 8 !
        Cedente.DadosBanco.DigitoAgencia       + //!DIGITO VERIFICADOR DA AGENCIA  ! 23! 23!  1! _ !ALFANUMERICO ! 8 !
        LPad(FCodigoConta,14)                  + //!CODIGO CONTA E ABENCIA - VARIA
        ANossoNumero                           + //!IDENTIFICACAO DO TITULO NO BANC! 38! 57! 20! - !ALFANUMERICO !21 !
        '1'                                    + //!CODIGO DA CARTEIRA             ! 58! 58!  1! _ !NUMERICO     !22 !
        '1'                                    + //!FORMA DE CADASTRAMENTO DO TITU-! 59! 59!  1! _ !1-COM CADAST !   !
        FTipoDocumento                         + //!TIPO DE DOCUMENTO              ! 60! 60!  1! _ !1-TRADICIONAL!   !
        AEmissao                               + //!IDENTIFI DA EMISSAO E DISTRIB  ! 61! 61!  2! _ !NUMERICO     !23 !
        LPad(FNumeroDocumento, 15)             + //!NUMERO DO DOCUMENTO DE COBRANCA! 63! 77! 15! - !ALFANUMERICO !24 !
        FormatDateTime('ddmmyyyy', Vencimento) + //!DATA DE VENCIMENTO DO TITULO   ! 78! 85!  8! - !DDMMAAAA     !48 !
        RPad(FormatCurr('0', Valor * 100), 15) + //!VALOR NOMINAL DO TITULO        ! 86!100! 13! 2 !NUMERICO     !   !
        FAgenciaCobradora                      + //!AGENCIA ENCARREGADA DA COBRANCA!101!105!  5! - !NUMERICO     !49 !
        AEspecDocumento                        + //!ESPECIE DO TITULO              !107!108!  2! - !NUMERICO     !25 !
        AAceite                                + //!IDENTIFICACAO DE TITULO ACEITO/!109!109!  1! - !A - ACEITE   !   !
        FormatDateTime('ddmmyyyy', Data)       ; //!DATA DA EMISSAO DO TITULO      !110!117!  8! - !DDMMAAAA     !   !

      if DadosComplementares.TipoJuros = tjValorPorDia then
      begin
        FLinha := FLinha + '1' +
        RPad('0', 8) +
        RPad(FormatCurr('0',DadosComplementares.ValorJuros * 100), 15);
      end
      else if DadosComplementares.TipoJuros = tjPercentual then
      begin
        FLinha := FLinha + '2' +
        RPad('0', 8) +
        RPad(FormatCurr('0', DadosComplementares.ValorJuros * 100), 15);
      end
      else
      begin
        FLinha := FLinha + '0' +
        RPad('0', 8) +
        RPad('0', 15);
      end;
      case DadosComplementares.TipoDesconto of
        tdValorFixo:
          begin
            FLinha := FLinha + '1' +
            FormatDateTime('ddmmyyyy', DadosComplementares.DataDesconto) +
            RPad(FormatCurr('0', DadosComplementares.ValorDesconto * 100), 15);
          end;
        tdPercentual:
          begin
            FLinha := FLinha + '2' +
            FormatDateTime('ddmmyyyy', DadosComplementares.DataDesconto) +
            RPad(FormatCurr('0', DadosComplementares.ValorDesconto * 100), 15);
          end;
        tdAntecipacaoDiaCorrido:
          begin
            FLinha := FLinha + '3' +
            RPad('0', 8) +
            RPad(FormatCurr('0', DadosComplementares.ValorDesconto * 100), 15);
          end;
        tdAntecipacaoDiaUtil:
          begin
            FLinha := FLinha + '4' +
            RPad('0', 8) +
            RPad(FormatCurr('0', DadosComplementares.ValorDesconto * 100), 15);
          end;
        tdPercentualValorNominal:
          begin
            FLinha := FLinha + '5' +
            RPad('0', 8) +
            RPad(FormatCurr('0', DadosComplementares.ValorDesconto * 100), 15);
          end;
      else
        begin
          FLinha := FLinha + '0' +
          RPad('0', 8) +
          RPad('0', 15);
        end;
      end;

      FLinha := FLinha + RPad(FormatCurr('0', DadosComplementares.ValorIOF * 100), 15) + //!VALOR DO IOF A SER RECOLHIDO   !166!180! 13! 2 !NUMERICO     !   !
      RPad(FormatCurr('0', DadosComplementares.ValorAbatimento * 100), 15) +             //!VALOR DO ABATIMENTO            !181!195! 13! 2 !NUMERICO     !   !
      LPad(NumDocumento, 25);                                                            //!IDENTIFICACAO DO TIT. NA EMPRES!196!220! 25! - !ALFANUMERICO !   !

      case DadosComplementares.Protesto of
        tpDiasOcorridos:
          begin
            FLinha := FLinha + '1' +
            RPad(IntToStr(DadosComplementares.DiasProtesto), 2);
          end;
        tpDiasUteis:
          begin
            FLinha := FLinha + '2' +
            RPad(IntToStr(DadosComplementares.DiasProtesto), 2);
          end;
        tpNaoProtestar:
          begin
            FLinha := FLinha + '3' +
            RPad(IntToStr(DadosComplementares.DiasProtesto), 2);
          end;
      end;

      case DadosComplementares.Baixa of
        tbBaixar:
          begin
            FLinha := FLinha + '1' +
            RPad(IntToStr(DadosComplementares.DiasBaixa), 3);
          end;
        tbNaoBaixar:
          begin
            FLinha := FLinha + '2' +
            RPad('0', 3);
          end;
      end;

      FLinha := FLinha + RPad(CODIGO_MOEDA, 2) + //!CODIGO DA MOEDA                !228!229!  2! - !NUMERICO     !29 !
        RPad(FContrato, 10)  + //!N. DO CONTR. DA OPERACAO D CRED!230!239! 10! - !NUMERICO     !   !
        ' ';                                     //!USO EXCLUSIVO FEBRABAN/CNAB    !240!240!  1! - !BRANCOS      !   !

      //adiciona FLinha
      FArquivoTexto.Add(FLinha);
    end;
  end;
end;

procedure TCnab240.SegmentoQ(Index: Integer);
var
  ATipoSacado,
  ASacadoCPFCNPJ,
  AEndereco: string;
begin
  with Titulos do
  begin
    with Items[Index] do
    begin
      case Sacado.Tipo of
        tpFisica: ATipoSacado := '1';
        tpJuridica: ATipoSacado := '2';
      end;

      ASacadoCPFCNPJ := RPad(SomenteTexto(Sacado.Cpf_Cnpj), 15, '0');
      AEndereco     := LPad(Sacado.Endereco.Logradouro + ' ' +
         sacado.Endereco.Numero + ' ' + Sacado.Endereco.Complemento, 40);

      FLinha := Cedente.DadosBanco.NumeroBanco + //!CODIGO DO BANCO NA COMPENSACAO !  1!  3!  3! - !NUMERICO     !   !
        RPad(IntToStr(NumeroLote), 4)          + //!LOTE DE SERVICO                !  4!  7!  4! - !NUMERICO     ! 1 !
        '3'                                    + //!REGISTRO DETALHE               !  8!  8!  1! - ! 3           ! 2 !
        RPad(IntToStr(2 * Index + 2), 5)       + //!N  SEQUENCIAL DO REG. NO LOTE  !  9! 13!  5! - !NUMERICO     !10 !
        'Q'                                    + //!COD. SEGMENTO DO REG. DETALHE  ! 14! 14!  1! - ! Q           !11 !
        ' '                                    + //!USO EXCLUSIVO FEBRABAN/CNAB    ! 15! 15!  1! - !BRANCOS      !   !
        GetOcorrencia                          + //!CODIGO DE MOVIMENTO            ! 16! 17!  2! - !NUMERICO     !20 !
        ATipoSacado                            + //!TIPO DE INSCRICAO              ! 18! 18!  1! - !NUMERICO     !30 !
        ASacadoCPFCNPJ                         + //!NUMERO DE INSCRICAO            ! 19! 33! 15! - !NUMERICO     !30 !
        LPad(Sacado.Nome, 40)                  + //!NOME                           ! 34! 73! 40! - !ALFANUMERICO !   !
        AEndereco                              + //!ENDERECO                       ! 74!113! 40! - !ALFANUMERICO !   !
        LPad(Sacado.Endereco.Bairro, 15)       + //!BAIRRO                         !114!128! 15! - !ALFANUMERICO !   !
        LPad(SomenteTexto(Sacado.Endereco.Cep), 8, '0') + //!CEP E SUFIXO                   !129!133!  8! - !NUMERICO     !   !
        LPad(Sacado.Endereco.Cidade, 15)       + //!CIDADE                         !137!151! 15! - !ALFANUMERICO !   !
        LPad(Sacado.Endereco.Estado, 2)        + //!UNIDADE DA FEDERACAO           !152!153!  2! - !ALFANUMERICO !   !
        '0'                                    + //!TIPO DE INSCRICAO              !154!154!  1! - !NUMERICO     !30 !
        RPad('0', 15)                          + //!NUMERO DE INSCRICAO            !155!169! 15! - !NUMERICO     !30 !
        LPad('', 40)                           + //!NOME DO SACADOR/AVALISTA       !170!209! 40! - !ALFANUMERICO !31 !
        '000'                                  + //!COD. BCO CORRESP. NA COMPENSACA!210!212!  3! - !NUMERICO     !32 !
        LPad('', 20)                           + //!NOSSO NUM. NO BCO CORRESPONDENT!213!232! 20! - !ALFANUMERICO !32 !
        LPad('', 8);                             //!USO EXCLUSIVO FEBRABAN/CNAB    !233!240!  8! - !BRANCOS      !   !

      FArquivoTexto.Add(FLinha);
    end;
  end;
end;


procedure TCnab240.SegmentoR(Index: Integer);
begin
  with Titulos do
  begin
    with Items[Index] do
    begin
      FLinha := cedente.DadosBanco.NumeroBanco + //!CODIGO DO BANCO NA COMPENSACAO !  1!  3!  3! - !NUMERICO     !   !
      RPad(IntToStr(NumeroLote), 4)            + //!LOTE DE SERVICO                !  4!  7!  4! - !NUMERICO     ! 1 !
      '3'                                      + //!REGISTRO DETALHE               !  8!  8!  1! - ! 3           ! 2 !
      RPad(IntToStr(3 * Index + 3), 5)             + //!N  SEQUENCIAL DO REG. NO LOTE  !  9! 13!  5! - !NUMERICO     !10 !
      'R'                                      + //!COD. SEGMENTO DO REG. DETALHE  ! 14! 14!  1! - !'R'          !11 !
      ' '                                      + //!USO EXCLUSIVO FEBRABAN/CNAB    ! 15! 15!  1! - !BRANCOS      !   !
      '01'                                     + //!CODIGO DE MOVIMENTO            ! 16! 17!  2! - !NUMERICO     !20 !
      '0'                                      + //!CODIGO DO DESCONTO 2           ! 18! 18!  1! - !NUMERICO     !28 !
      RPad('0', 8)                             + //!DATA DO DESCONTO 2             ! 19! 26!  8! - !DDMMAAAA     !   !
      RPad('0', 15)                            + //!VALOR/PERCENTUAL A SER CONCEDID! 27! 41! 13! 2 !NUMERICO     !   !
      '0'                                      + //!CODIGO DO DESCONTO 3           ! 42! 42!  1! - !NUMERICO     !28 !
      RPad('0', 8)                             + //!DATA DO DESCONTO 3             ! 43! 50!  8! - !DDMMAAAA     !   !
      RPad('0', 15)                            ; //!VALOR/PERCENTUAL A SER CONCEDID! 51! 65! 13! 2 !NUMERICO     !   !

      case DadosComplementares.TipoMulta of
        tmValorFixo:
          begin
            FLinha := FLinha + '1' +
            FormatDateTime('ddmmyyyy', Vencimento + 1) +
            RPad(FormatCurr('0', DadosComplementares.ValorMulta * 100), 15);
          end;
        tmPercentual:
          begin
            FLinha := FLinha + '2' +
            FormatDateTime('ddmmyyyy', Vencimento + 1) +
            RPad(FormatCurr('0', DadosComplementares.ValorMulta * 100), 15);
          end;
      else
        begin
          FLinha := FLinha + '0' +
          RPad('0', 8) +
          RPad('0', 15);
        end;
      end;

      FLinha := FLinha + LPad('', 10) + //!INFORMACAO DO BANCO AO SACADO  ! 90! 99! 10! - !ALFANUMERICO !33 !
      LPad('', 40)                    + //!MENSAGEM 3                     !100!139! 40! - !ALFANUMERICO !34 !
      LPad('', 40)                    + //!MENSAGEM 4                     !140!179! 40! - !ALFANUMERICO !34 !
      RPad('0', 3)                    + //!COD. DO BANCO DA CONTA DO DEBIT!180!182!  3! - !NUMERICO     !   !
      RPad('0', 4)                    + //!CODIGO DA AGENCIA DO DEBITO    !183!186!  4! - !NUMERICO     !   !
      RPad('0', 13)                   + //!CONTA CORRENTE/DV DO DEBITO    !187!199! 13! - !NUMERICO     !   !
      RPad('0', 8)                    + //!CODIGOS DE OCORRENCIA DO SACADO!200!207!  8! - !NUMERICO     !54 !
      LPad('', 33)                    ; //!USO EXCLUSIVO FEBRABAN/CNAB    !208!240! 33! - !BRANCOS      !   !

      FArquivoTexto.Add(FLinha);
    end;
  end;
end;

procedure TCnab240.TrailerLote;
begin
  with Titulos do
  begin
      FLinha := Items[0].Cedente.DadosBanco.NumeroBanco + //!CODIGO DO BANCO NA COMPENSACAO !  1!  3!  3! - !NUMERICO     !   !
      RPad(IntToStr(NumeroLote), 4)        + //!LOTE DE SERVICO                !  4!  7!  4! - !NUMERICO     ! 1 !
      '5'                                  + //!REGISTRO TRAILER DO LOTE       !  8!  8!  1! - ! 5           ! 2 !
      LPad('', 9)                          + //!USO EXCLUSIVO FEBRABAN/CNAB    !  9! 17!  9! - !BRANCOS      !   !
      RPad(IntToStr(FArquivoTexto.Count), 6)   + //!QUANTIDADE DE REGISTROS DO LOTE! 18! 23!  6! - !NUMERICO     !38 !
      RPad('0', 6)                         + //!QUANTIDADE DE TIT. EM COBRANCA ! 24! 29!  6! - !NUMERICO     !41 !
      RPad('0', 17)                         + //!VALOR TOT. DOS TIT. EM CARTEIRA! 30! 46! 15! 2 !NUMERICO     !41 !
      RPad('0', 6)                          + //!QUANTIDADE DE TIT. EM COBRANCA ! 47! 52!  6! - !NUMERICO     !41 !
      RPad('0', 17)                        + //!VALOR TOT DOS TIT. EM CARTEIRAS! 53! 69! 15! 2 !NUMERICO     !41 !
      RPad('0', 6)                         + //!QUANTIDADE DE TIT. EM COBRANCA ! 70! 75!  6! - !NUMERICO     !41 !
      RPad('0', 17)                         + //!VALOR TOT DOS TIT. EM CARTEIRAS! 76! 92! 15! 2 !NUMERICO     !41 !
      RPad('0', 6)                          + //!QUANTIDADE DE TIT. EM COBRANCA ! 93! 98!  6! - !NUMERICO     !41 !
      RPad('0',17)                         + //!VALOR TOT DOS TIT. EM CARTEIRAS! 99!115! 15! 2 !NUMERICO     !41 !
      LPad('',8)                           + //!NUMERO DO AVISO DE LANCAMENTO  !116!123!  8! - !ALFANUMERICO !41 !
      LPad('',117) ;                         //!USO EXCLUSIVO FEBRABAN/CNAB    !124!240!117! - !BRANCOS      !   !
    FArquivoTexto.Add(FLinha);
    FLinha := '';
  end;
end;

procedure TCnab240.TrailerArquivo;
begin
  with Titulos do
  begin
    with Items[0].Cedente do
    begin
      FLinha := DadosBanco.NumeroBanco         + //!CODIGO DO BANCO NA COMPENSACAO !  1!  3!  3! - !NUMERICO     !   !
        '9999'                                 + //!LOTE DE SERVICO                !  4!  7!  4! - ! 9999        ! 1 !
        '9'                                    + //!REGISTRO TRAILER DE ARQUIVO    !  8!  8!  1! - ! 9           ! 2 !
        LPad('', 9)                            + //!USO EXCLUSIVO FEBRABAN/CNAB    !  9! 17!  9! - !BRANCOS      !   !
        RPad(IntToStr(NumeroLote), 6)          + //!QUANTID. DE LOTES DO ARQUIVO   ! 18! 23!  6! - !NUM. REGIST. !   !
        RPad(IntToStr(FArquivoTexto.Count + 1), 6) + //!QUANTID. DE REGISTROS DO ARQUIV! 24! 29!  6! - !NUM.REG.TIPOS!   !
        LPad('', 6)                            + //!QTDADE DE CONTAS P/CONC.- LOTES! 30! 35!  6! - !NUM.REG.     !   !
        LPad('', 205)                          ; //!USO EXCLUSIVO FEBRABAN/CNAB    ! 36!240!205! - !BRANCOS      !   !
    end;
    FArquivoTexto.Add(FLinha);
  end;
end;

end.
