object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 410
  ClientWidth = 919
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object edtID: TLabeledEdit
    Left = 88
    Top = 16
    Width = 50
    Height = 21
    EditLabel.Width = 11
    EditLabel.Height = 13
    EditLabel.Caption = 'ID'
    Enabled = False
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object edtNatureza: TLabeledEdit
    Left = 88
    Top = 43
    Width = 50
    Height = 21
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = 'Natureza'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object edtDocumento: TLabeledEdit
    Left = 88
    Top = 70
    Width = 121
    Height = 21
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = 'Documento'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object edtNome: TLabeledEdit
    Left = 88
    Top = 97
    Width = 250
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object edtSobrenome: TLabeledEdit
    Left = 88
    Top = 124
    Width = 250
    Height = 21
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = 'Sobrenome'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object edtDataRegistro: TLabeledEdit
    Left = 88
    Top = 151
    Width = 90
    Height = 21
    EditLabel.Width = 66
    EditLabel.Height = 13
    EditLabel.Caption = 'Data Registro'
    LabelPosition = lpLeft
    TabOrder = 5
  end
  object edtCep: TLabeledEdit
    Left = 88
    Top = 178
    Width = 70
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'CEP'
    LabelPosition = lpLeft
    TabOrder = 6
  end
  object btNovo: TBitBtn
    Left = 376
    Top = 16
    Width = 115
    Height = 40
    Caption = 'Novo'
    TabOrder = 7
    OnClick = btNovoClick
  end
  object btGravar: TBitBtn
    Left = 376
    Top = 68
    Width = 115
    Height = 40
    Caption = 'Gravar'
    TabOrder = 8
    OnClick = btGravarClick
  end
  object btCancelar: TBitBtn
    Left = 376
    Top = 122
    Width = 115
    Height = 40
    Caption = 'Cancelar'
    TabOrder = 9
    OnClick = btCancelarClick
  end
  object btExcluir: TBitBtn
    Left = 376
    Top = 174
    Width = 115
    Height = 40
    Caption = 'Excluir'
    TabOrder = 10
    OnClick = btExcluirClick
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 276
    Width = 919
    Height = 134
    Align = alBottom
    DataSource = dsDados
    ReadOnly = True
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Natureza'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Documento'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Sobrenome'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Data Registro'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cep'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end>
  end
  object btAtualizaEndereco: TBitBtn
    Left = 376
    Top = 230
    Width = 115
    Height = 40
    Caption = 'Atualizar Endere'#231'os'
    TabOrder = 12
    OnClick = btAtualizaEnderecoClick
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 
      'http://localhost:8080/datasnap/rest/TServerMethodsPessoa/GetPess' +
      'oa/1'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 136
    Top = 216
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 216
    Top = 216
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 304
    Top = 216
  end
  object dsDados: TDataSource
    DataSet = cdsDados
    Left = 248
    Top = 24
  end
  object cdsDados: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsDadosAfterScroll
    Left = 296
    Top = 24
    object cdsDadosID: TIntegerField
      FieldName = 'ID'
    end
    object cdsDadosNatureza: TIntegerField
      FieldName = 'Natureza'
    end
    object cdsDadosDocumento: TStringField
      FieldName = 'Documento'
    end
    object cdsDadosNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object cdsDadosSobrenome: TStringField
      FieldName = 'Sobrenome'
      Size = 100
    end
    object cdsDadosDataRegistro: TStringField
      FieldName = 'DataRegistro'
      Size = 10
    end
    object cdsDadosCep: TStringField
      FieldName = 'Cep'
      Size = 8
    end
  end
end
