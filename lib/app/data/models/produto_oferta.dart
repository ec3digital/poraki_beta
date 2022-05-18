class ProdutoOferta {
  String? categoriaChave;
  String? ofertaCEP;
  String? ofertaDetalhe;
  String? ofertaDispoDesde;
  int? ofertaID;
  String? ofertaImgPath;
  double? ofertaPreco;
  String? ofertaTitulo;
  String? ofertaGUID;
  String? ofertaFKID;
  String? lojaID;
  // int? ofertaQtdMaxVenda;
  String? ofertaPeso;
  String? ofertaPesoUnidade;
  // int? ofertaDiasValidade;
  double? ofertaPrecoMin;
  bool? ofertaMostraAval;
  bool? ofertaAceitaAuto;
  bool? ofertaAceitaProposta;
  bool? ofertaAceitaEncomenda;
  bool? ofertaSomenteEncomenda;
  // int? ofertaTempoEntrega;
  String? ofertaTempoEntregaUnidade;
  String? ofertaFormaFechamento;
  String? ofertaMarcaRevenda;
  String? ofertaCores;
  String? ofertaTamanhos;
  bool? oferta24hs;
  // int? ofertaDistanciaKm;
  double? ofertaSinal;
  String? ofertaEncomendasAPartirDe;
  String? ofertaEntregasAPartirDe;
  String? ofertaCodigoAlt;
  double? valorEntregaAte1;
  double? valorEntregaAte2;
  double? valorEntregaMaisDe2;
  String? ofertaSinalTipo;
  bool? ofertaPrecoAPartir;
  bool? ofertaPrecoCombinar;
  bool? ofertaMostraReview;
  bool? ofertaAceitaEntregaComprador;
  bool? ofertaAceitaEntregaVendedor;
  bool? ofertaAceitaEntregaParceiro;
  // int? ofertaTotalAval;
  // int? ofertaQtdAval;

  ProdutoOferta(
      {this.categoriaChave,
      this.ofertaCEP,
      this.ofertaDetalhe,
      this.ofertaDispoDesde,
      this.ofertaID,
      this.ofertaImgPath,
      this.ofertaPreco,
      this.ofertaTitulo,
      this.ofertaFKID,
        this.lojaID,
      this.ofertaGUID,
      this.oferta24hs,
      this.ofertaAceitaAuto,
      this.ofertaAceitaEncomenda,
      this.ofertaAceitaEntregaComprador,
      this.ofertaAceitaEntregaParceiro,
      this.ofertaAceitaEntregaVendedor,
      this.ofertaAceitaProposta,
      this.ofertaCodigoAlt,
      this.ofertaCores,
      // this.ofertaDiasValidade,
      // this.ofertaDistanciaKm,
      this.ofertaEncomendasAPartirDe,
      this.ofertaEntregasAPartirDe,
      this.ofertaFormaFechamento,
      this.ofertaMarcaRevenda,
      this.ofertaMostraAval,
      this.ofertaMostraReview,
      this.ofertaPeso,
      this.ofertaPesoUnidade,
      this.ofertaPrecoAPartir,
      this.ofertaPrecoCombinar,
      this.ofertaPrecoMin,
      // this.ofertaQtdAval,
      // this.ofertaQtdMaxVenda,
      this.ofertaSinal,
      this.ofertaSinalTipo,
      this.ofertaSomenteEncomenda,
      this.ofertaTamanhos,
      // this.ofertaTempoEntrega,
      this.ofertaTempoEntregaUnidade,
      // this.ofertaTotalAval,
      this.valorEntregaAte1,
      this.valorEntregaAte2,
      this.valorEntregaMaisDe2});

  ProdutoOferta.fromJson(Map<String, dynamic> json) {
    categoriaChave = json['CategoriaChave'];
    ofertaCEP = json['OfertaCEP'];
    ofertaDetalhe = json['OfertaDetalhe'];
    ofertaDispoDesde = json['OfertaDispoDesde'];
    ofertaID = int.parse(json['OfertaID'].toString());
    ofertaImgPath = json['OfertaImgPath'];
    ofertaPreco = double.parse(json['OfertaPreco'].toString());
    ofertaTitulo = json['OfertaTitulo'];
    ofertaFKID = json['OfertaFKID'];
    lojaID = json['LojaID'];
    ofertaGUID = json['OfertaGUID'];
    // oferta24hs = json['Oferta24hs'];
    // ofertaAceitaAuto = json['OfertaAceitaAuto'];
    // ofertaAceitaEncomenda = json['OfertaAceitaEncomenda'];
    // ofertaAceitaEntregaComprador = json['OfertaAceitaEntregaComprador'];
    // ofertaAceitaEntregaParceiro = json['OfertaAceitaEntregaParceiro'];
    // ofertaAceitaEntregaVendedor = json['OfertaAceitaEntregaVendedor'];
    // ofertaAceitaProposta = json['OfertaAceitaProposta'];
    // ofertaCodigoAlt = json['OfertaCodigoAlt'];
    // ofertaCores = json['OfertaCores'];
    // // ofertaDiasValidade = json['OfertaDiasValidade'];
    // // ofertaDistanciaKm = json['OfertaDistanciaKm'];
    // ofertaEncomendasAPartirDe = json['OfertaEncomendasAPartirDe'];
    // ofertaEntregasAPartirDe = json['OfertaEntregasAPartirDe'];
    // ofertaFormaFechamento = json['OfertaFormaFechamento'];
    // ofertaMarcaRevenda = json['OfertaMarcaRevenda'];
    // ofertaMostraAval = json['OfertaMostraAval'];
    // ofertaMostraReview = json['OfertaMostraReview'];
    // ofertaPeso = json['OfertaPeso'];
    // ofertaPesoUnidade = json['OfertaPesoUnidade'];
    // ofertaPrecoAPartir = json['OfertaPrecoAPartir'];
    // ofertaPrecoCombinar = json['OfertaPrecoCombinar'];
    // ofertaPrecoMin = json['OfertaPrecoMin'];
    // // ofertaQtdAval = json['OfertaQtdAval'];
    // // ofertaQtdMaxVenda = json['OfertaQtdMaxVenda'];
    // ofertaSinal = json['OfertaSinal'];
    // ofertaSinalTipo = json['OfertaSinalTipo'];
    // ofertaSomenteEncomenda = json['OfertaSomenteEncomenda'];
    // ofertaTamanhos = json['OfertaTamanhos'];
    // // ofertaTempoEntrega = json['OfertaTempoEntrega'];
    // ofertaTempoEntregaUnidade = json['OfertaTempoEntregaUnidade'];
    // // ofertaTotalAval = json['OfertaTotalAval'];
    // valorEntregaAte1 = json['ValorEntregaAte1'];
    // valorEntregaAte2 = json['ValorEntregaAte2'];
    // valorEntregaMaisDe2 = json['ValorEntregaMaisDe2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaChave'] = this.categoriaChave;
    data['OfertaCEP'] = this.ofertaCEP;
    data['OfertaDetalhe'] = this.ofertaDetalhe;
    data['OfertaDispoDesde'] = this.ofertaDispoDesde;
    data['OfertaID'] = this.ofertaID.toString();
    data['OfertaImgPath'] = this.ofertaImgPath;
    data['OfertaPreco'] = this.ofertaPreco.toString();
    data['OfertaTitulo'] = this.ofertaTitulo;
    data['OfertaFKID'] = this.ofertaFKID;
    data['LojaID'] = this.lojaID;
    data['OfertaGUID'] = this.ofertaGUID;
    data['Oferta24hs'] = this.oferta24hs;
    data['OfertaAceitaAuto'] = this.ofertaAceitaAuto;
    data['OfertaAceitaEncomenda'] = this.ofertaAceitaEncomenda;
    data['OfertaAceitaEntregaComprador'] = this.ofertaAceitaEntregaComprador;
    data['OfertaAceitaEntregaParceiro'] = this.ofertaAceitaEntregaParceiro;
    data['OfertaAceitaEntregaVendedor'] = this.ofertaAceitaEntregaVendedor;
    data['OfertaAceitaProposta'] = this.ofertaAceitaProposta;
    data['OfertaCodigoAlt'] = this.ofertaCodigoAlt;
    data['OfertaCores'] = this.ofertaCores;
    // data['OfertaDiasValidade'] = this.ofertaDiasValidade;
    // data['OfertaDistanciaKm'] = this.ofertaDistanciaKm;
    data['OfertaEncomendasAPartirDe'] = this.ofertaEncomendasAPartirDe;
    data['OfertaEntregasAPartirDe'] = this.ofertaEntregasAPartirDe;
    data['OfertaFormaFechamento'] = this.ofertaFormaFechamento;
    data['OfertaMarcaRevenda'] = this.ofertaMarcaRevenda;
    data['OfertaMostraAval'] = this.ofertaMostraAval;
    data['OfertaMostraReview'] = this.ofertaMostraReview;
    data['OfertaPeso'] = this.ofertaPeso;
    data['OfertaPesoUnidade'] = this.ofertaPesoUnidade;
    data['OfertaPrecoAPartir'] = this.ofertaPrecoAPartir;
    data['OfertaPrecoCombinar'] = this.ofertaPrecoCombinar;
    data['OfertaPrecoMin'] = this.ofertaPrecoMin;
    // data['OfertaQtdAval'] = this.ofertaQtdAval;
    // data['OfertaQtdMaxVenda'] = this.ofertaQtdMaxVenda;
    data['OfertaSinal'] = this.ofertaSinal;
    data['OfertaSinalTipo'] = this.ofertaSinalTipo;
    data['OfertaSomenteEncomenda'] = this.ofertaSomenteEncomenda;
    data['OfertaTamanhos'] = this.ofertaTamanhos;
    // data['OfertaTempoEntrega'] = this.ofertaTempoEntrega;
    data['OfertaTempoEntregaUnidade'] = this.ofertaTempoEntregaUnidade;
    // data['OfertaTotalAval'] = this.ofertaTotalAval;
    data['ValorEntregaAte1'] = this.valorEntregaAte1;
    data['ValorEntregaAte2'] = this.valorEntregaAte2;
    data['ValorEntregaMaisDe2'] = this.valorEntregaMaisDe2;

    return data;
  }
}
