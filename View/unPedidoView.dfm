object PedidoView: TPedidoView
  Left = 0
  Top = 0
  Caption = 'Pedido'
  ClientHeight = 590
  ClientWidth = 1023
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pgPedido: TPageControl
    Left = 0
    Top = 0
    Width = 1023
    Height = 590
    ActivePage = tsPedido
    Align = alClient
    MultiLine = True
    RaggedRight = True
    TabOrder = 0
    TabPosition = tpLeft
    object tsEntrada: TTabSheet
      Caption = 'Entrada'
      object btnNovoPedido: TBitBtn
        Left = 392
        Top = 176
        Width = 147
        Height = 97
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Novo Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentFont = False
        TabOrder = 0
        OnClick = btnNovoPedidoClick
      end
    end
    object tsPedido: TTabSheet
      Caption = 'Pedido'
      ImageIndex = 1
      object dbgProduto: TDBGrid
        AlignWithMargins = True
        Left = 0
        Top = 47
        Width = 992
        Height = 491
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Right = 0
        Align = alClient
        DataSource = dsPedido
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnCellClick = dbgProdutoCellClick
        OnDrawColumnCell = dbgProdutoDrawColumnCell
        OnEditButtonClick = dbgProdutoEditButtonClick
        OnKeyDown = dbgProdutoKeyDown
        Columns = <
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'codigo_produto'
            Title.Caption = 'C'#243'd. Produto'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 90
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'descricao'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI Semibold'
            Font.Style = []
            Title.Caption = 'Descri'#231#227'o'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 298
            Visible = True
          end
          item
            Color = 10407069
            Expanded = False
            FieldName = 'quantidade'
            Title.Alignment = taCenter
            Title.Caption = 'Quantidade'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 81
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_unitario'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 109
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_total'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Total'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -13
            Title.Font.Name = 'Segoe UI'
            Title.Font.Style = [fsBold]
            Width = 152
            Visible = True
          end
          item
            ButtonStyle = cbsNone
            Expanded = False
            ReadOnly = True
            Visible = True
          end>
      end
      object flwPedido: TFlowPanel
        Left = 0
        Top = 0
        Width = 992
        Height = 44
        Align = alTop
        AutoSize = True
        BevelEdges = []
        BevelInner = bvLowered
        BevelKind = bkFlat
        Color = clWhite
        Padding.Left = 2
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        TabOrder = 1
        object pnlNumeroPedido: TPanel
          Left = 4
          Top = 4
          Width = 229
          Height = 36
          Margins.Top = 0
          Margins.Bottom = 0
          Alignment = taLeftJustify
          BevelInner = bvSpace
          BevelOuter = bvNone
          Caption = 'N'#250'mero Pedido:'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object edtNumeroPedido: TEdit
            Left = 101
            Top = 3
            Width = 121
            Height = 29
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object pnlCliente: TPanel
          Left = 233
          Top = 4
          Width = 552
          Height = 36
          Margins.Top = 0
          Margins.Bottom = 0
          Alignment = taLeftJustify
          BevelInner = bvSpace
          BevelOuter = bvNone
          Caption = 'Cliente:'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          object edtCliente: TEdit
            Left = 48
            Top = 3
            Width = 105
            Height = 29
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnKeyDown = edtClienteKeyDown
          end
          object btnLookupCliente: TBitBtn
            Left = 155
            Top = 4
            Width = 26
            Height = 29
            Cursor = crHandPoint
            Glyph.Data = {
              820C0000424D820C00000000000042000000280000001C0000001C0000000100
              200003000000400C0000C30E0000C30E000000000000000000000000FF0000FF
              0000FF000000000000003643F4003643F4003643F4003643F4003643F4163643
              F4573643F49F3643F4D43643F4F13643F4FE3643F4FE3643F4F23643F4D53643
              F4A03643F4583643F4163643F4003643F4003643F4003643F400000000000000
              000000000000000000000000000000000000000000003643F4003643F4003643
              F4003643F4123643F4693643F4C83643F4F63643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4F73643F4C93643F46A3643
              F4123643F4003643F4003643F400000000000000000000000000000000000000
              00003643F4003643F4003643F4003643F43A3643F4BC3643F4FD3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FD3643F4BD3643F43B3643F4003643F4003643
              F4000000000000000000000000003643F4003643F4003643F5003643F4573643
              F4E33643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4E43643F4583843F0003643F4003643F400000000003643F4003643
              F4003643F4003643F4573643F4EC3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3542F4FF3A47F4FF3845F4FF3643F4ED3643F4583643
              F4003643F4003643F4003643F4003643F4003643F4393643F4E33643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3441F4FF5661F6FFBDC1
              FBFF959CF9FF3845F4FF3643F4E43643F43B3643F4003643F4003643F4003643
              F4113643F4BC3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3442F4FF5661F6FFD1D4FCFFFFFFFFFFBCC1FBFF3A47F4FF3643F4FF3643
              F4BD3643F4123643F4003643F4003643F4683643F4FD3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3542F4FF4753F5FFC8CCFCFFFFFFFFFFD1D4
              FCFF5661F6FF3542F4FF3643F4FF3643F4FD3643F46A3643F4003643F4153643
              F4C83643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3542F4FF3340
              F4FF3643F4FF3B48F4FF3B48F4FF3643F4FF3340F4FF3542F4FF3542F4FF4551
              F5FFAAB0FAFFBABFFBFFC8CCFCFF5661F6FF3441F4FF3643F4FF3643F4FF3643
              F4FF3643F4C93643F4163643F4553643F4F63643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3441F4FF434FF5FF7A83F8FFAFB4FBFFC7CBFCFFC7CAFCFFADB2
              FBFF7880F8FF424EF5FF3542F4FF6D77F7FFB9BDFBFFAAB0FAFF4753F5FF3442
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4F63643F4573643F49E3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3442F4FF626DF6FFCBCEFCFFFCFC
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFFFFC6CAFCFF767FF8FFC1C5
              FCFF6D77F7FF4551F5FF3542F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4A03643F4D23643F4FF3643F4FF3643F4FF3643F4FF3441
              F4FF636DF6FFE3E5FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFE4E5FDFF767FF7FF3542F4FF3542F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4D43643F4F03643
              F4FF3643F4FF3643F4FF3542F4FF4551F5FFCDD0FCFFFFFFFFFFF3F4FEFFE7E9
              FEFFEFF0FEFFECEDFEFFEAECFEFFF0F1FEFFE6E8FEFFF5F5FEFFFFFFFFFFC6CA
              FCFF424EF5FF3542F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4F13643F4FC3643F4FF3643F4FF3643F4FF3340F4FF7E86
              F8FFFDFDFFFFFFFFFFFFE2E4FDFFC6CAFCFFD7D9FDFFCFD2FCFFCBCFFCFFDADD
              FDFFC1C5FCFFE5E7FEFFFFFFFFFFFBFBFFFF7880F8FF3340F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FD3643F4FC3643
              F4FF3643F4FF3643F4FF3744F4FFB4B9FBFFFFFFFFFFFFFFFFFFF8F8FFFFF4F4
              FEFFD5D8FDFFCFD2FCFFCDD1FCFFDCDEFDFFC1C5FCFFE5E7FEFFFFFFFFFFFFFF
              FFFFADB2FBFF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FD3643F4F03643F4FF3643F4FF3643F4FF3D4AF4FFCDD0
              FCFFFFFFFFFFFFFFFFFFF4F5FEFFD8DBFDFFD7D9FDFFD1D4FCFFF5F6FEFFF8F8
              FFFFBFC3FCFFE5E7FEFFFFFFFFFFFFFFFFFFC7CAFCFF3B48F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4F13643F4D23643
              F4FF3643F4FF3643F4FF3E4AF4FFCDD0FCFFFFFFFFFFFFFFFFFFFCFCFFFFBCC0
              FBFFCACDFCFFF5F5FEFFE7E9FEFFF6F7FFFFBFC3FCFFE5E6FEFFFFFFFFFFFFFF
              FFFFC7CBFCFF3B48F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4D43643F49D3643F4FF3643F4FF3643F4FF3744F4FFB5BA
              FBFFFFFFFFFFFFFFFFFFFFFFFFFFF7F8FFFFB2B7FBFFB0B5FBFFB0B5FBFFB4B9
              FBFFDBDEFDFFF4F5FEFFFFFFFFFFFFFFFFFFAEB4FBFF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F49F3643F4553643
              F4F63643F4FF3643F4FF3340F4FF8189F8FFFDFDFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF3F4FEFFE7E9FEFFFFFFFFFFD2D4FDFFBCC1FBFFFDFDFFFFFFFFFFFFFCFC
              FFFF7A83F8FF3340F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4F63643F4573643F4153643F4C73643F4FF3643F4FF3542F4FF4652
              F5FFD0D3FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
              FFFFDADDFDFFF7F7FFFFFFFFFFFFCBCEFCFF434FF5FF3542F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4C83643F4163643F4003643
              F4673643F4FD3643F4FF3643F4FF3441F4FF6771F7FFE6E8FEFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3E4FDFF626C
              F6FF3441F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FD3643F4693643F4003643F4003643F4113643F4BB3643F4FF3643F4FF3643
              F4FF3542F4FF6771F7FFD0D3FCFFFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFDFDFFFFCDD0FCFF636DF6FF3442F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4BC3643F4113643F4003643F4003643
              F4003643F4383643F4E23643F4FF3643F4FF3643F4FF3441F4FF4652F5FF8089
              F8FFB5BAFBFFCDD0FCFFCDD0FCFFB4B9FBFF7E86F8FF4551F5FF3441F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4E33643
              F43A3643F4003643F4003643F4003643F4003643F4003643F4553643F4EC3643
              F4FF3643F4FF3643F4FF3542F4FF3340F4FF3744F4FF3D4AF4FF3D4AF4FF3744
              F4FF3340F4FF3542F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4EC3643F4573643F4003643F4003643F400000000003643
              F4003643F4003643F4003643F4553643F4E23643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4E33643F4573642F4003643
              F4003643F4000000000000000000000000003643F4003643F4003643F4003643
              F4383643F4BA3643F4FD3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FD3643
              F4BC3643F43A3643F4003643F4003643F4000000000000000000000000000000
              0000000000003643F4003643F4003643F4003643F4113643F4673643F4C63643
              F4F63643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643F4FF3643
              F4FF3643F4F63643F4C83643F4683643F4113643F4003643F4003643F4000000
              00000000000000000000000000000000000000000000000000003643F4003643
              F4003643F4003643F4003643F4153643F4543643F49D3643F4D23643F4EF3643
              F4FC3643F4FC3643F4F03643F4D23643F49E3643F4553643F4153643F4003643
              F4003643F4003643F40000000000000000000000000000000000000000000000
              000000000000}
            TabOrder = 1
            OnClick = btnLookupClienteClick
          end
          object pnlNomeCliente: TPanel
            Left = 187
            Top = 3
            Width = 358
            Height = 29
            Color = clSilver
            ParentBackground = False
            TabOrder = 2
          end
        end
        object pntDataEmissao: TPanel
          Left = 785
          Top = 4
          Width = 196
          Height = 36
          Margins.Top = 0
          Margins.Bottom = 0
          Alignment = taLeftJustify
          BevelInner = bvSpace
          BevelOuter = bvNone
          Caption = 'Data Emiss'#227'o:'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          object dtpDataEmissao: TDateTimePicker
            Left = 88
            Top = 3
            Width = 106
            Height = 29
            Date = 45446.000000000000000000
            Time = 0.419022094909450900
            Checked = False
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
      end
      object pnlTotal: TPanel
        Left = 0
        Top = 541
        Width = 992
        Height = 41
        Align = alBottom
        Alignment = taRightJustify
        Caption = 'Total do pedido:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
  end
  object dsPedido: TDataSource
    OnDataChange = dsPedidoDataChange
    Left = 795
    Top = 164
  end
end
