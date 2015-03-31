object frmPrincipal: TfrmPrincipal
  Left = 550
  Top = 131
  Width = 547
  Height = 368
  Caption = 'Teste do Componente'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    531
    330)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 297
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Gerar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 531
    Height = 145
    Align = alTop
    Caption = 'Campos necess'#225'rios para gera'#231#227'o do boleto'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 71
      Height = 13
      Caption = 'N'#250'mero Banco'
    end
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 39
      Height = 13
      Caption = 'Ag'#234'ncia'
    end
    object Label3: TLabel
      Left = 184
      Top = 44
      Width = 36
      Height = 13
      Caption = 'Carteira'
    end
    object Label4: TLabel
      Left = 8
      Top = 68
      Width = 68
      Height = 13
      Caption = 'N'#250'mero Conta'
    end
    object Label5: TLabel
      Left = 8
      Top = 88
      Width = 70
      Height = 26
      Caption = 'Sequ'#234'ncia '#13#10'Nosso N'#250'mero'
    end
    object Label6: TLabel
      Left = 184
      Top = 68
      Width = 45
      Height = 13
      Caption = 'Conv'#234'nio'
    end
    object Label12: TLabel
      Left = 8
      Top = 116
      Width = 56
      Height = 13
      Caption = 'Vencimento'
    end
    object Label13: TLabel
      Left = 184
      Top = 116
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label14: TLabel
      Left = 160
      Top = 92
      Width = 76
      Height = 13
      Caption = 'C'#243'digo Cedente'
    end
    object edNumBanco: TEdit
      Left = 88
      Top = 20
      Width = 57
      Height = 21
      TabOrder = 0
    end
    object edAgencia: TEdit
      Left = 88
      Top = 44
      Width = 57
      Height = 21
      TabOrder = 1
    end
    object edDigitoAgencia: TEdit
      Left = 146
      Top = 44
      Width = 24
      Height = 21
      TabOrder = 2
    end
    object edCarteira: TEdit
      Left = 232
      Top = 44
      Width = 33
      Height = 21
      TabOrder = 3
    end
    object edNumeroConta: TEdit
      Left = 88
      Top = 68
      Width = 57
      Height = 21
      TabOrder = 4
    end
    object edDigitoConta: TEdit
      Left = 146
      Top = 68
      Width = 24
      Height = 21
      TabOrder = 5
    end
    object edSeqNossoNumero: TEdit
      Left = 88
      Top = 92
      Width = 57
      Height = 21
      TabOrder = 7
    end
    object edConvenio: TEdit
      Left = 232
      Top = 68
      Width = 57
      Height = 21
      TabOrder = 6
    end
    object edVencimento: TEdit
      Left = 88
      Top = 116
      Width = 81
      Height = 21
      TabOrder = 9
    end
    object edValor: TEdit
      Left = 216
      Top = 116
      Width = 89
      Height = 21
      TabOrder = 10
    end
    object edCodCedente: TEdit
      Left = 240
      Top = 92
      Width = 89
      Height = 21
      TabOrder = 8
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 145
    Width = 531
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
      TabOrder = 3
      Visible = False
    end
    object edLinhaDigitavel: TEdit
      Left = 88
      Top = 92
      Width = 337
      Height = 21
      TabOrder = 4
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
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 184
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 264
    Top = 296
    Width = 89
    Height = 25
    Caption = 'Primeiro'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 360
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Pr'#243'ximo'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 448
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Remessa'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Boletos1: TLCBoletos
    TipoArquivo = taCnab240
    Left = 392
    Top = 64
  end
  object titTeste: TLCTitulo
    Cedente.Tipo = tpFisica
    Cedente.DadosBanco.SeqNossoNum = 0
    Sacado.Tipo = tpFisica
    Left = 352
    Top = 32
  end
end
