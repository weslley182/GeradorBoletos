unit Cnab400;

interface

uses
  Arquivo;

type
  TCnab400 = class(TArquivo)
  protected
    FTipoPessoa,
    FCodigoEmpresa: string;
    FBancoDestinatario: string;
    FComplementoHeader: string;
    procedure HeaderArquivo; virtual;
    procedure Registros; virtual; abstract;
    procedure TrailerArquivo; virtual;
  public
    function GerarRemessa: Boolean; override;
  end;

implementation

uses
  Classes, uFuncoes, SysUtils;

{ TCnab400 }

function TCnab400.GerarRemessa: Boolean;
begin
  FArquivoTexto.Clear;
  try
    {Registro 0 - Header}
    HeaderArquivo;

    {Registro 1 - Cobrança de Titulos}
    Registros;

    {Registro 2 - Cobrança de Titulos Mensagens - Opcional}
    //RegistroMensagens - não implementado neste componente

    {Registro 9 - trailer do arquivo}
    TrailerArquivo;

    FArquivoTexto.SaveToFile(NomeCompletoArquivo);
    
    Result := True;
  except
    raise;
  end;
end;

procedure TCnab400.HeaderArquivo;
begin
  with Titulos.Items[0].Cedente do
  begin
    FLinha :=
      '0'                             + //!CODIGO DO REGISTRO             !  1!  1!  1! - !'0'
      '1'                             + //!CODIGO DA REMESSA              !  2!  2!  1! - !'1'
      'REMESSA'                       + //!LITERAL DA REMESSA             !  3!  9!  7! - !'REMESSA'
      '01'                            + //!CODIGO IDENTIF. DO SERVICO     ! 10! 11!  2! - !'01'
      Lpad('COBRANCA',15)             + //!LITERAL DO SERVICO             ! 12! 26! 15! - !'COBRANCA'
      LPad(FCodigoEmpresa, 20)        + //!COD.IDENTIFICADOR EMPRESA      ! 27! 46! 20! - !
      LPad(Nome, 30)                  + //!NOME POR EXTENSO...            ! 47! 76! 30! - !
      DadosBanco.NumeroBanco          + //!COD. COMPENSACAO               ! 77! 79!  3! - !
      Lpad(FBancoDestinatario, 15)    + //!NOME DO BANCO DESTINATRIO      ! 80! 94! 15! - !
      FormatDateTime('ddmmyy', Date)  + //!DATA EM QUE FOI GERADO ARQUIVO ! 95!100!  6! - !
      LPad(FComplementoHeader, 289)   + //!COMPLEMENTO REGISTRO           !101!389!289! - !
      RPad(IntToStr(NumArquivo),5)    + //!NUM. SEQ. ARQUIVO              !390!394!  5! - !
      RPad('1',6)                     ; //!NUM. SEQ. REGISTRO             !395!400!  6! - !
    //adiciona FLinha
    FArquivoTexto.Add(FLinha);
  end;
end;

procedure TCnab400.TrailerArquivo;
begin
  FLinha :=
    '9'                                   + //!CODIGO IDENT. REGISTRO         !  1!  1!  1! - !'9'
    LPad('',393)                          + //!COMPLEMENTO DO REGISTRO        !  2!394!393! - !BRANCOS
    RPad(IntToStr(FArquivoTexto.Count + 1), 6); //!NUM. SEQ. REG. ARQ             !395!400!  6! - !
  //adiciona FLinha
  FArquivoTexto.Add(FLinha);
end;

end.
