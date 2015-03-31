object frmMain: TfrmMain
  Left = 696
  Top = 122
  Width = 624
  Height = 556
  Caption = 'Teste do Componente Boleto'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    608
    518)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 487
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Gerar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 216
    Width = 608
    Height = 121
    Align = alTop
    Caption = 'Dados do T'#237'tulo'
    TabOrder = 1
    object Label5: TLabel
      Left = 8
      Top = 20
      Width = 51
      Height = 13
      Caption = 'Sequ'#234'ncia'
    end
    object Label12: TLabel
      Left = 184
      Top = 44
      Width = 56
      Height = 13
      Caption = 'Vencimento'
    end
    object Label13: TLabel
      Left = 360
      Top = 44
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label22: TLabel
      Left = 160
      Top = 20
      Width = 55
      Height = 13
      Caption = 'Documento'
    end
    object Label25: TLabel
      Left = 8
      Top = 69
      Width = 49
      Height = 13
      Caption = 'Tipo Juros'
    end
    object Label26: TLabel
      Left = 8
      Top = 93
      Width = 50
      Height = 13
      Caption = 'Tipo Multa'
    end
    object Label27: TLabel
      Left = 216
      Top = 69
      Width = 124
      Height = 13
      Caption = 'Juros: Valor ou Percentual'
    end
    object Label28: TLabel
      Left = 216
      Top = 93
      Width = 125
      Height = 13
      Caption = 'Multa: Valor ou Percentual'
    end
    object Label34: TLabel
      Left = 8
      Top = 44
      Width = 39
      Height = 13
      Caption = 'Emiss'#227'o'
    end
    object edSeqNossoNumero: TEdit
      Left = 88
      Top = 20
      Width = 57
      Height = 21
      TabOrder = 0
      Text = '37'
    end
    object edVencimento: TEdit
      Left = 264
      Top = 44
      Width = 81
      Height = 21
      TabOrder = 2
      Text = '07/01/2012'
    end
    object edValor: TEdit
      Left = 392
      Top = 44
      Width = 89
      Height = 21
      TabOrder = 3
      Text = '49,62'
    end
    object edDocumento: TEdit
      Left = 216
      Top = 20
      Width = 142
      Height = 21
      TabOrder = 1
      Text = 'BOL000037/1'
    end
    object cbTipoJuros: TComboBox
      Left = 88
      Top = 69
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = 'Valor por dia'
      Items.Strings = (
        'Valor por dia'
        'Percentual'
        'Isento'
        'N'#227'o Informado')
    end
    object cbTipoMulta: TComboBox
      Left = 88
      Top = 93
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Text = 'Valor Fixo'
      Items.Strings = (
        'Valor Fixo'
        'Percentual'
        'N'#227'o Informado')
    end
    object edValorJuros: TEdit
      Left = 352
      Top = 69
      Width = 89
      Height = 21
      TabOrder = 5
      Text = '0,12'
    end
    object edValorMulta: TEdit
      Left = 352
      Top = 93
      Width = 89
      Height = 21
      TabOrder = 7
      Text = '3,47'
    end
    object edEmissao: TEdit
      Left = 88
      Top = 44
      Width = 81
      Height = 21
      TabOrder = 8
      Text = '08/12/2011'
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 337
    Width = 608
    Height = 144
    Align = alTop
    Caption = 'Resultado'
    TabOrder = 2
    object Label7: TLabel
      Left = 8
      Top = 44
      Width = 70
      Height = 13
      Caption = 'Nosso N'#250'mero'
    end
    object Label8: TLabel
      Left = 8
      Top = 68
      Width = 59
      Height = 13
      Caption = 'Campo Livre'
    end
    object Label9: TLabel
      Left = 8
      Top = 116
      Width = 66
      Height = 13
      Caption = 'C'#243'digo Barras'
      Visible = False
    end
    object Label10: TLabel
      Left = 8
      Top = 92
      Width = 70
      Height = 13
      Caption = 'Linha Digit'#225'vel'
    end
    object Label11: TLabel
      Left = 8
      Top = 20
      Width = 62
      Height = 13
      Caption = 'Nome Banco'
    end
    object edCampoLivre: TEdit
      Left = 88
      Top = 68
      Width = 185
      Height = 21
      TabOrder = 2
    end
    object edCodigoBarras: TEdit
      Left = 88
      Top = 116
      Width = 289
      Height = 21
      TabOrder = 4
      Visible = False
    end
    object edLinhaDigitavel: TEdit
      Left = 88
      Top = 92
      Width = 337
      Height = 21
      TabOrder = 3
    end
    object edNomeBanco: TEdit
      Left = 88
      Top = 20
      Width = 289
      Height = 21
      TabOrder = 0
    end
    object edNossoNumero: TEdit
      Left = 88
      Top = 44
      Width = 185
      Height = 21
      TabOrder = 1
    end
  end
  object Button2: TButton
    Left = 96
    Top = 487
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Adiciona'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 176
    Top = 487
    Width = 81
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Limpa Boletos'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 264
    Top = 487
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Primeiro'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 344
    Top = 487
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Pr'#243'ximo'
    TabOrder = 6
    OnClick = Button5Click
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 0
    Width = 608
    Height = 120
    Align = alTop
    Caption = 'Dados Cedente'
    TabOrder = 7
    object Label15: TLabel
      Left = 8
      Top = 20
      Width = 28
      Height = 13
      Caption = 'Nome'
    end
    object Label16: TLabel
      Left = 312
      Top = 20
      Width = 43
      Height = 13
      Caption = 'Cnpj_Cpf'
    end
    object Label1: TLabel
      Left = 8
      Top = 44
      Width = 71
      Height = 13
      Caption = 'N'#250'mero Banco'
    end
    object Label2: TLabel
      Left = 8
      Top = 69
      Width = 39
      Height = 13
      Caption = 'Ag'#234'ncia'
    end
    object Label3: TLabel
      Left = 152
      Top = 45
      Width = 36
      Height = 13
      Caption = 'Carteira'
    end
    object Label4: TLabel
      Left = 184
      Top = 69
      Width = 68
      Height = 13
      Caption = 'N'#250'mero Conta'
    end
    object Label6: TLabel
      Left = 8
      Top = 93
      Width = 45
      Height = 13
      Caption = 'Conv'#234'nio'
    end
    object Label14: TLabel
      Left = 384
      Top = 69
      Width = 76
      Height = 13
      Caption = 'C'#243'digo Cedente'
    end
    object Label17: TLabel
      Left = 160
      Top = 93
      Width = 40
      Height = 13
      Caption = 'Contrato'
    end
    object Label33: TLabel
      Left = 272
      Top = 93
      Width = 68
      Height = 13
      Caption = 'Tipo Remessa'
    end
    object edNomeCedente: TEdit
      Left = 88
      Top = 20
      Width = 217
      Height = 21
      TabOrder = 0
      Text = 'EMPRESA TESTE'
    end
    object edCnpjCedente: TEdit
      Left = 360
      Top = 20
      Width = 142
      Height = 21
      TabOrder = 1
      Text = '99.999.999/9999-99'
    end
    object edNumBanco: TEdit
      Left = 88
      Top = 44
      Width = 57
      Height = 21
      TabOrder = 2
      Text = '001'
    end
    object edAgencia: TEdit
      Left = 88
      Top = 69
      Width = 57
      Height = 21
      TabOrder = 4
      Text = '9999'
    end
    object edDigitoAgencia: TEdit
      Left = 146
      Top = 69
      Width = 24
      Height = 21
      TabOrder = 5
      Text = '9'
    end
    object edCarteira: TEdit
      Left = 200
      Top = 45
      Width = 33
      Height = 21
      TabOrder = 3
      Text = '17'
    end
    object edNumeroConta: TEdit
      Left = 264
      Top = 69
      Width = 82
      Height = 21
      TabOrder = 6
      Text = '99999'
    end
    object edDigitoConta: TEdit
      Left = 349
      Top = 69
      Width = 24
      Height = 21
      TabOrder = 7
      Text = '9'
    end
    object edConvenio: TEdit
      Left = 88
      Top = 93
      Width = 57
      Height = 21
      TabOrder = 9
      Text = '9999999'
    end
    object edCodigoCedente: TEdit
      Left = 464
      Top = 69
      Width = 81
      Height = 21
      TabOrder = 8
      Text = '99999'
    end
    object edContrato: TEdit
      Left = 208
      Top = 93
      Width = 57
      Height = 21
      TabOrder = 10
      Text = '12345678'
    end
    object cbTipoRemessa: TComboBox
      Left = 352
      Top = 93
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 11
      Text = 'CNAB 240'
      Items.Strings = (
        'CNAB 240'
        'CNAB 400')
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 120
    Width = 608
    Height = 96
    Align = alTop
    Caption = 'Dados Sacado'
    TabOrder = 8
    object Label18: TLabel
      Left = 8
      Top = 20
      Width = 28
      Height = 13
      Caption = 'Nome'
    end
    object Label19: TLabel
      Left = 440
      Top = 20
      Width = 43
      Height = 13
      Caption = 'Cnpj_Cpf'
    end
    object Label20: TLabel
      Left = 8
      Top = 44
      Width = 46
      Height = 13
      Caption = 'Endereco'
    end
    object Label21: TLabel
      Left = 211
      Top = 67
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object Label23: TLabel
      Left = 390
      Top = 67
      Width = 14
      Height = 13
      Caption = 'UF'
    end
    object Label24: TLabel
      Left = 310
      Top = 44
      Width = 12
      Height = 13
      Caption = 'N'#186
    end
    object Label29: TLabel
      Left = 312
      Top = 20
      Width = 21
      Height = 13
      Caption = 'Tipo'
    end
    object Label30: TLabel
      Left = 374
      Top = 44
      Width = 27
      Height = 13
      Caption = 'Bairro'
    end
    object Label31: TLabel
      Left = 454
      Top = 67
      Width = 19
      Height = 13
      Caption = 'Cep'
    end
    object Label32: TLabel
      Left = 8
      Top = 68
      Width = 32
      Height = 13
      Caption = 'Compl.'
    end
    object edNomeSacado: TEdit
      Left = 88
      Top = 20
      Width = 217
      Height = 21
      TabOrder = 0
      Text = 'CLIENTE TESTE 1 D'
    end
    object edCnpjSacado: TEdit
      Left = 488
      Top = 20
      Width = 113
      Height = 21
      TabOrder = 2
      Text = '999.999.999-99'
    end
    object edEnderecoSacado: TEdit
      Left = 88
      Top = 44
      Width = 217
      Height = 21
      TabOrder = 3
      Text = 'RUA TESTE TESTE TESTE'
    end
    object edCidadeSacado: TEdit
      Left = 248
      Top = 67
      Width = 137
      Height = 21
      TabOrder = 7
      Text = 'CIDADE TESTE'
    end
    object edUFSacado: TEdit
      Left = 408
      Top = 67
      Width = 33
      Height = 21
      TabOrder = 8
      Text = 'MA'
    end
    object edNumeroSacado: TEdit
      Left = 328
      Top = 44
      Width = 33
      Height = 21
      TabOrder = 4
      Text = '20'
    end
    object cbTipoSacado: TComboBox
      Left = 339
      Top = 20
      Width = 94
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Pessoa F'#237'sica'
      Items.Strings = (
        'Pessoa F'#237'sica'
        'Pessoa Jur'#237'dica')
    end
    object edBairroSacado: TEdit
      Left = 408
      Top = 44
      Width = 169
      Height = 21
      TabOrder = 5
      Text = 'BAIRRO TESTE'
    end
    object edCepSacado: TEdit
      Left = 488
      Top = 67
      Width = 89
      Height = 21
      TabOrder = 9
      Text = '99.999-999'
    end
    object edComplementoSacado: TEdit
      Left = 88
      Top = 67
      Width = 113
      Height = 21
      TabOrder = 6
      Text = 'CONTATO1'
    end
  end
  object Button6: TButton
    Left = 424
    Top = 487
    Width = 89
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Gerar Remessa'
    TabOrder = 9
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 528
    Top = 488
    Width = 75
    Height = 25
    Caption = 'Boleto'
    TabOrder = 10
    OnClick = Button7Click
  end
  object titTeste: TLCTitulo
    Cedente.Tipo = tpFisica
    Cedente.DadosBanco.LocalPagamento = 'PAGAVEL EM QUALQUER AGENCIA BANCARIA ATE O VENCIMENTO'
    Cedente.DadosBanco.SeqNossoNum = 0
    Sacado.Tipo = tpFisica
    Left = 504
    Top = 232
  end
  object Boletos1: TLCBoletos
    TipoArquivo = taCnab240
    TipoBoleto = tbPadrao
    Left = 512
    Top = 369
  end
end
