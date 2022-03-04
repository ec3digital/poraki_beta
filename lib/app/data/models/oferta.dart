class Oferta {
  int? OfertaID;
  String? CategoriaChave;
  String? OfertaFKID;
  String? OfertaTitulo;
  String? OfertaDetalhe;
  double? OfertaPreco;
  int? OfertaDesativID;
  int? OfertaDesativAdminID;
  String? OfertaDesativEm;
  String? OfertaImgPath;
  int? OfertaDispoTipo;
  String? OfertaCEP;
  String? OfertaDispoDesde;
  String? OfertaDispoAte;
  int? OfertaPontoMais;
  int? OfertaPontoMenos;
  int? OfertaQtdVendida;
  int? OfertaPrazoEntregaMinutos;
  int? LojaID;
  String? OfertaGUID;
  int? OfertaQtdDispo;
  int? OfertaQtdMaxVenda;
  int? OfertaQtdAviso;
  double? OfertaPeso;
  String? OfertaPesoUnidade;
  int? OfertaDiasValidade;
  double? OfertaPrecoMin;
  bool? OfertaMostraAval;
  bool? OfertaAceitaAuto;
  bool? OfertaAceitaEncomenda;
  bool? OfertaSomenteEncomenda;
  bool? OfertaAceitaProposta;
  int? OfertaTempoEntrega;
  String? OfertaTempoEntregaUnidade;
  String? OfertaFormaFechamento;
  String? OfertaAgenteEntrega;
  String? OfertaAgenteEntregaNome;
  String? OfertaAgenteEntregaID;
  String? OfertaMarcaRevenda;
  String? OfertaCores;
  String? OfertaTamanhos;
  bool? Oferta24hs;
  int? OfertaDistanciaKm;
  double? OfertaSinal;
  String? OfertaEncomendasAPartirDe;
  String? OfertaEntregasAPartirDe;
  String? OfertaCodigoAlt;
  double? ValorEntregaAte1;
  double? ValorEntregaAte2;
  double? ValorEntregaMaisDe2;

  Oferta(this.OfertaID,this.CategoriaChave,this.OfertaFKID,this.OfertaTitulo,this.OfertaDetalhe,this.OfertaPreco,this.OfertaDesativID,this.OfertaDesativAdminID,this.OfertaDesativEm,
      this.OfertaImgPath,this.OfertaDispoTipo,this.OfertaCEP,this.OfertaDispoDesde,this.OfertaDispoAte,this.OfertaPontoMais,this.OfertaPontoMenos,this.OfertaQtdVendida,this.OfertaPrazoEntregaMinutos,
      this.LojaID,this.OfertaGUID,this.OfertaQtdDispo,this.OfertaQtdMaxVenda,this.OfertaQtdAviso,this.OfertaPeso,this.OfertaPesoUnidade,this.OfertaDiasValidade,this.OfertaPrecoMin,
      this.OfertaMostraAval,this.OfertaAceitaAuto,this.OfertaAceitaEncomenda,this.OfertaSomenteEncomenda,this.OfertaAceitaProposta,this.OfertaTempoEntrega,this.OfertaTempoEntregaUnidade,
      this.OfertaFormaFechamento,this.OfertaAgenteEntrega,this.OfertaAgenteEntregaNome,this.OfertaAgenteEntregaID,this.OfertaMarcaRevenda,this.OfertaCores,this.OfertaTamanhos,
      this.Oferta24hs,this.OfertaDistanciaKm,this.OfertaSinal,this.OfertaEncomendasAPartirDe,this.OfertaEntregasAPartirDe,this.OfertaCodigoAlt,this.ValorEntregaAte1,this.ValorEntregaAte2,this.ValorEntregaMaisDe2);


  Oferta.fromJson(Map<String, dynamic> json) {
    CategoriaChave = json['CategoriaChave'] == 'null' ? '': json['CategoriaChave'];
    OfertaCEP = json['OfertaCEP'] == 'null' ? '' : json['OfertaCEP'];
    OfertaDetalhe = json['OfertaDetalhe'] == 'null' ? '' : json['OfertaDetalhe'];
    OfertaID = json['OfertaID'].toString() == 'null' ? null : int.parse(json['OfertaID'].toString());
    OfertaDispoDesde = json['OfertaDispoDesde'] == 'null' ? '' : json['OfertaDispoDesde'];
    OfertaImgPath = json['OfertaImgPath'] == 'null' ? '' : json['OfertaImgPath'];
    OfertaPreco = json['OfertaPreco'] == null ? 0.0 : double.parse(json['OfertaPreco'].toString());
    OfertaTitulo = json['OfertaTitulo'] == null ? '' : json['OfertaTitulo'];
    OfertaFKID = json['OfertaFKID'] == null ? '' : json['OfertaFKID'];
    OfertaDesativID = json['OfertaDesativID'] == null ? null : int.parse(json['OfertaDesativID'].toString());
    OfertaDesativAdminID = json['OfertaDesativAdminID'] == null ? null : int.parse(json['OfertaDesativAdminID'].toString());
    OfertaDesativEm = json['OfertaDesativEm'].toString();
    // OfertaDispoTipo = int.parse(json['OfertaDispoTipo'].toString());
    OfertaDispoAte = json['OfertaDispoAte'].toString();
    // OfertaPontoMenos = int.parse(json['OfertaPontoMenos'].toString());
    // OfertaPontoMenos = int.parse(json['OfertaPontoMenos'].toString());
    // OfertaQtdVendida = int.parse(json['OfertaQtdVendida'].toString());
    // OfertaPrazoEntregaMinutos = json['OfertaPrazoEntregaMinutos'].toString() == 'null' ? 0 : int.parse(json['OfertaPrazoEntregaMinutos'].toString());
    // LojaID = int.parse(json['LojaID'].toString());
    OfertaGUID = json['OfertaGUID'].toString();
    // OfertaQtdDispo = int.parse(json['OfertaQtdDispo'].toString());
    // OfertaQtdMaxVenda = int.parse(json['OfertaQtdMaxVenda'].toString());
    // OfertaQtdAviso = int.parse(json['OfertaQtdAviso'].toString());
    // OfertaPeso = double.parse(json['OfertaPeso'].toString());
    // OfertaPesoUnidade = json['OfertaPesoUnidade'];
    // OfertaDiasValidade = int.parse(json['OfertaDiasValidade'].toString());
    // OfertaPrecoMin = double.parse(json['OfertaPrecoMin'].toString());
    OfertaMostraAval = json['OfertaMostraAval'];
    OfertaAceitaAuto = json['OfertaAceitaAuto'];
    OfertaAceitaEncomenda = json['OfertaAceitaEncomenda'];
    OfertaAceitaProposta = json['OfertaAceitaProposta'];
    // OfertaTempoEntrega = int.parse(json['OfertaTempoEntrega'].toString());
    OfertaTempoEntregaUnidade = json['OfertaTempoEntregaUnidade'].toString();
    OfertaFormaFechamento = json['OfertaFormaFechamento'].toString();
    OfertaAgenteEntrega = json['OfertaAgenteEntrega'].toString();
    OfertaAgenteEntregaNome = json['OfertaAgenteEntregaNome'].toString();
    OfertaAgenteEntregaID = json['OfertaAgenteEntregaID'].toString();
    OfertaMarcaRevenda = json['OfertaMarcaRevenda'].toString();
    OfertaCores = json['OfertaCores'].toString();
    OfertaTamanhos = json['OfertaTamanhos'].toString();
    Oferta24hs = json['Oferta24hs'];
    // OfertaDistanciaKm = int.parse(json['OfertaDistanciaKm'].toString());
    // OfertaSinal = double.parse(json['OfertaSinal'].toString());
    OfertaEncomendasAPartirDe = json['OfertaEncomendasAPartirDe'].toString();
    OfertaEntregasAPartirDe = json['OfertaEntregasAPartirDe'].toString();
    OfertaCodigoAlt = json['OfertaCodigoAlt'].toString();
    // ValorEntregaAte1 = double.parse(json['ValorEntregaAte1'].toString());
    // ValorEntregaAte2 = double.parse(json['ValorEntregaAte2'].toString());
    // ValorEntregaMaisDe2 = double.parse(json['ValorEntregaMaisDe2'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaChave'] = this.CategoriaChave;
    data['OfertaCEP'] = this.OfertaCEP;
    data['OfertaDetalhe'] = this.OfertaDetalhe;
    //data['OfertaDispoDesde'] = this.OfertaDispoDesde;
    //data['OfertaID'] = this.OfertaID.toString();
    //data['OfertaImgPath'] = this.OfertaImgPath;
    data['OfertaPreco'] = this.OfertaPreco.toString();
    data['OfertaTitulo'] = this.OfertaTitulo;
    data['OfertaFKID'] = this.OfertaFKID;
    //data['OfertaDesativID'] = this.OfertaDesativID.toString();
    //data['OfertaDesativAdminID'] = this.OfertaDesativAdminID.toString();
    //data['OfertaDesativEm'] = this.OfertaDesativEm;
    data['OfertaDispoTipo'] = this.OfertaDispoTipo.toString();
    //data['OfertaDispoAte'] = this.OfertaDispoAte;
    //data['OfertaPontoMenos'] = this.OfertaPontoMenos.toString();
    //data['OfertaPontoMenos'] = this.OfertaPontoMenos.toString();
    //data['OfertaQtdVendida'] = this.OfertaQtdVendida.toString();
    //data['OfertaPrazoEntregaMinutos'] = this.OfertaPrazoEntregaMinutos.toString();
    //data['LojaID'] = this.LojaID.toString();
    //data['OfertaGUID'] = this.OfertaGUID;
    data['OfertaQtdDispo'] = this.OfertaQtdDispo.toString();
    data['OfertaQtdMaxVenda'] = this.OfertaQtdMaxVenda.toString();
    data['OfertaQtdAviso'] = this.OfertaQtdAviso.toString();
    data['OfertaPeso'] = this.OfertaPeso.toString();
    data['OfertaPesoUnidade'] = this.OfertaPesoUnidade;
    data['OfertaDiasValidade'] = this.OfertaDiasValidade.toString();
    data['OfertaPrecoMin'] = this.OfertaPrecoMin.toString();
    data['OfertaMostraAval'] = this.OfertaMostraAval.toString();
    data['OfertaAceitaAuto'] = this.OfertaAceitaAuto.toString();
    data['OfertaAceitaEncomenda'] = this.OfertaAceitaEncomenda.toString();
    data['OfertaAceitaProposta'] = this.OfertaAceitaProposta.toString();
    data['OfertaTempoEntrega'] = this.OfertaTempoEntrega.toString();
    data['OfertaTempoEntregaUnidade'] = this.OfertaTempoEntregaUnidade;
    data['OfertaFormaFechamento'] = this.OfertaFormaFechamento;
    //data['OfertaAgenteEntrega'] = this.OfertaAgenteEntrega;
    // data['OfertaAgenteEntregaNome'] = this.OfertaAgenteEntregaNome;
    // data['OfertaAgenteEntregaID'] = this.OfertaAgenteEntregaID;
    data['OfertaMarcaRevenda'] = OfertaMarcaRevenda;
    data['OfertaCores'] = this.OfertaCores;
    data['OfertaTamanhos'] = this.OfertaTamanhos;
    data['Oferta24hs'] = this.Oferta24hs.toString();
    data['OfertaDistanciaKm'] = this.OfertaDistanciaKm.toString();
    //data['OfertaSinal'] = this.OfertaSinal.toString();
    // data['OfertaEncomendasAPartirDe'] = this.OfertaEncomendasAPartirDe;
    // data['OfertaEntregasAPartirDe'] = this.OfertaEntregasAPartirDe;
    data['OfertaCodigoAlt'] = this.OfertaCodigoAlt;
    data['ValorEntregaAte1'] = this.ValorEntregaAte1.toString();
    data['ValorEntregaAte2'] = this.ValorEntregaAte2.toString();
    data['ValorEntregaMaisDe2'] = this.ValorEntregaMaisDe2.toString();
    return data;

    // "Oferta24hs": "true",
    // "OfertaAceitaAuto": "false",
    // "OfertaAceitaEncomenda": "false",
    // "OfertaAceitaProposta": "false",
    // "OfertaCEP": "05735-030",
    // "OfertaCodigoAlt": "codigo",
    // "OfertaCores": "VERDE/AZUL/ROSA",
    // "OfertaDiasValidade": "90",
    // "OfertaDispoTipo": "1",
    // "OfertaDistanciaKm": "3",
    // "OfertaFormaFechamento": "",
    // "OfertaMarcaRevenda": "BOTICARDIO",
    // "OfertaMostraAval": "true",
    // "OfertaPeso": "100",
    // "OfertaPesoUnidade": "ml",
    // //"OfertaPrazoEntregaMinutos": "90",
    // "OfertaQtdAviso": "3",
    // "OfertaQtdDispo": "7",
    // "OfertaQtdMaxVenda": "2",
    // "OfertaSomenteEncomenda": "false",
    // "OfertaTamanhos": "P/M/G",
    // "OfertaTempoEntrega": "90",
    // "OfertaTempoEntregaUnidade": "min",
    // "ValorEntregaAte1": "3.0",
    // "ValorEntregaAte2": "5.0",
    // "ValorEntregaMaisDe2": "7.0"

  }
}