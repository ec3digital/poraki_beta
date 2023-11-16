class Oferta {
  String? OfertaID;
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
  // int? OfertaPontoMais;
  // int? OfertaPontoMenos;
  // int? OfertaQtdVendida;
  // int? OfertaPrazoEntregaMinutos;
  String? LojaID;
  String? OfertaGUID;
  // int? OfertaQtdDispo;
  // int? OfertaQtdMaxVenda;
  // int? OfertaQtdAviso;
  // double? OfertaPeso;
  // String? OfertaPesoUnidade;
  // int? OfertaDiasValidade;
  // double? OfertaPrecoMin;
  // bool? OfertaMostraAval;
  // bool? OfertaAceitaAuto;
  bool? OfertaAceitaEncomenda;
  bool? OfertaSomenteEncomenda;
  // bool? OfertaAceitaProposta;
  // int? OfertaTempoEntrega;
  // String? OfertaTempoEntregaUnidade;
  // String? OfertaFormaFechamento;
  // String? OfertaAgenteEntrega;
  // String? OfertaAgenteEntregaNome;
  // String? OfertaAgenteEntregaID;
  String? OfertaMarcaRevenda;
  // String? OfertaCores;
  // String? OfertaTamanhos;
  bool? Oferta24hs;
  // int? OfertaDistanciaKm;
  // double? OfertaSinal;
  String? OfertaEncomendasAPartirDe;
  String? OfertaEntregasAPartirDe;
  // String? OfertaCodigoAlt;
  // double? ValorEntregaAte1;
  // double? ValorEntregaAte2;
  // double? ValorEntregaMaisDe2;
  // bool? OfertaSemQtd;
  // String? OfertaSinalTipo;
  // bool? OfertaPrecoAPartir;
  bool? OfertaPrecoCombinar;
  bool? SegDispo;
  bool? TerDispo;
  bool? QuaDispo;
  bool? QuiDispo;
  bool? SexDispo;
  bool? SabDispo;
  bool? DomDispo;
  String? SegDas;
  String? SegAs;
  String? TerDas;
  String? TerAs;
  String? QuaDas;
  String? QuaAs;
  String? QuiDas;
  String? QuiAs;
  String? SexDas;
  String? SexAs;
  String? SabDas;
  String? SabAs;
  String? DomDas;
  String? DomAs;
  // bool? OfertaMostraReview;
  // bool? OfertaAceitaEntregaComprador;
  // bool? OfertaAceitaEntregaParceiro;
  // bool? OfertaAceitaEntregaVendedor;
  bool? OfertaRevisao;
  bool? OfertaMostra;
  String? LojaNome;

  Oferta(
      this.OfertaID,
      this.CategoriaChave,
      this.OfertaFKID,
      this.OfertaTitulo,
      this.OfertaDetalhe,
      this.OfertaPreco,
      this.OfertaDesativID,
      this.OfertaDesativAdminID,
      this.OfertaDesativEm,
      this.OfertaImgPath,
      this.OfertaDispoTipo,
      this.OfertaCEP,
      this.OfertaDispoDesde,
      this.OfertaDispoAte,
      // this.OfertaPontoMais,
      // this.OfertaPontoMenos,
      // this.OfertaQtdVendida,
      // this.OfertaPrazoEntregaMinutos,
      this.LojaID,
      this.OfertaGUID,
      // this.OfertaQtdDispo,
      // this.OfertaQtdMaxVenda,
      // this.OfertaQtdAviso,
      // this.OfertaPeso,
      // this.OfertaPesoUnidade,
      // this.OfertaDiasValidade,
      // this.OfertaPrecoMin,
      // this.OfertaMostraAval,
      // this.OfertaAceitaAuto,
      this.OfertaAceitaEncomenda,
      this.OfertaSomenteEncomenda,
      // this.OfertaAceitaProposta,
      // this.OfertaTempoEntrega,
      // this.OfertaTempoEntregaUnidade,
      // this.OfertaFormaFechamento,
      // this.OfertaAgenteEntrega,
      // this.OfertaAgenteEntregaNome,
      // this.OfertaAgenteEntregaID,
      this.OfertaMarcaRevenda,
      // this.OfertaCores,
      // this.OfertaTamanhos,
      this.Oferta24hs,
      // this.OfertaDistanciaKm,
      // this.OfertaSinal,
      this.OfertaEncomendasAPartirDe,
      this.OfertaEntregasAPartirDe,
      // this.OfertaCodigoAlt,
      // this.ValorEntregaAte1,
      // this.ValorEntregaAte2,
      // this.ValorEntregaMaisDe2,
      // this.OfertaSemQtd,
      // this.OfertaSinalTipo,
      // this.OfertaPrecoAPartir,
      this.OfertaPrecoCombinar,
      this.SegDispo,
      this.TerDispo,
      this.QuaDispo,
      this.QuiDispo,
      this.SexDispo,
      this.SabDispo,
      this.DomDispo,
      this.SegDas,
      this.SegAs,
      this.TerDas,
      this.TerAs,
      this.QuaDas,
      this.QuaAs,
      this.QuiDas,
      this.QuiAs,
      this.SexDas,
      this.SexAs,
      this.SabDas,
      this.SabAs,
      this.DomDas,
      this.DomAs,
      // this.OfertaMostraReview,
      // this.OfertaAceitaEntregaComprador,
      // this.OfertaAceitaEntregaParceiro,
      // this.OfertaAceitaEntregaVendedor,
      this.OfertaRevisao,
      this.OfertaMostra,
      this.LojaNome);


  Oferta.fromJson(Map<String, dynamic> json) {
    //print('json ofertas: ' + json.toString());
    CategoriaChave = json['CategoriaChave'].toString().trim();
    OfertaCEP = json['OfertaCEP'].toString() == 'null' ? '' : json['OfertaCEP'].toString().trim();
    OfertaDetalhe =
        json['OfertaDetalhe'].toString() == 'null' ? '' : json['OfertaDetalhe'].toString().trim();
    OfertaID = json['OfertaID'].toString() == 'null'
        ? null
        : json['OfertaID'].toString().trim();
    OfertaDispoDesde =
        json['OfertaDispoDesde'].toString() == 'null' ? '' : json['OfertaDispoDesde'].toString().trim();
    OfertaImgPath =
        json['OfertaImgPath'].toString() == 'null' ? '' : json['OfertaImgPath'].toString().trim();
    OfertaPreco = json['OfertaPreco'].toString() == 'null'
        ? 0.0
        : double.parse(json['OfertaPreco'].toString().trim());
    OfertaTitulo = json['OfertaTitulo'].toString() == 'null' ? '' : json['OfertaTitulo'].toString().trim();
    OfertaFKID = json['OfertaFKID'].toString() == 'null' ? '' : json['OfertaFKID'].toString().trim();
    //OfertaDesativID = json['OfertaDesativID'] == null ? null : int.parse(json['OfertaDesativID'].toString().trim());
    // OfertaDesativAdminID = json['OfertaDesativAdminID'] == null ? null : int.parse(json['OfertaDesativAdminID'].toString().trim());
    // OfertaDesativEm = json['OfertaDesativEm'].toString().trim();
    // OfertaDispoTipo = int.parse(json['OfertaDispoTipo'].toString());
    OfertaDispoAte = json['OfertaDispoAte'].toString().trim();
    // OfertaPontoMenos = int.parse(json['OfertaPontoMenos'].toString());
    // OfertaPontoMenos = int.parse(json['OfertaPontoMenos'].toString());
    // OfertaQtdVendida = int.parse(json['OfertaQtdVendida'].toString());
    // OfertaPrazoEntregaMinutos = json['OfertaPrazoEntregaMinutos'].toString() == 'null' ? 0 : int.parse(json['OfertaPrazoEntregaMinutos'].toString());
    LojaID = json['LojaID'].toString();
    OfertaGUID = json['OfertaGUID'].toString();
    // OfertaQtdDispo = int.parse(json['OfertaQtdDispo'].toString());
    // OfertaQtdMaxVenda = int.parse(json['OfertaQtdMaxVenda'].toString());
    // OfertaQtdAviso = int.parse(json['OfertaQtdAviso'].toString());
    // OfertaPeso = double.parse(json['OfertaPeso'].toString());
    // OfertaPesoUnidade = json['OfertaPesoUnidade'];
    // OfertaDiasValidade = int.parse(json['OfertaDiasValidade'].toString());
    // OfertaPrecoMin = double.parse(json['OfertaPrecoMin'].toString());
    // OfertaMostraAval = json['OfertaMostraAval'];
    // OfertaAceitaAuto = json['OfertaAceitaAuto'].toString() == 'true' ? true : false;
    // OfertaAceitaEncomenda = json['OfertaAceitaEncomenda'];
    // OfertaAceitaProposta = json['OfertaAceitaProposta'];
    // OfertaTempoEntrega = int.parse(json['OfertaTempoEntrega'].toString());
    // OfertaTempoEntregaUnidade = json['OfertaTempoEntregaUnidade'].toString();
    // OfertaFormaFechamento = json['OfertaFormaFechamento'].toString().trim();
    // OfertaAgenteEntrega = json['OfertaAgenteEntrega'].toString().trim();
    // OfertaAgenteEntregaNome = json['OfertaAgenteEntregaNome'].toString().trim();
    // OfertaAgenteEntregaID = json['OfertaAgenteEntregaID'].toString().trim();
    OfertaMarcaRevenda = json['OfertaMarcaRevenda'].toString().trim();
    // OfertaCores = json['OfertaCores'].toString().trim();
    // OfertaTamanhos = json['OfertaTamanhos'].toString().trim();
    // Oferta24hs = json['Oferta24hs'];
    // OfertaDistanciaKm = int.parse(json['OfertaDistanciaKm'].toString());
    // OfertaSinal = double.parse(json['OfertaSinal'].toString());
    // OfertaEncomendasAPartirDe = json['OfertaEncomendasAPartirDe'].toString().trim();
    // OfertaEntregasAPartirDe = json['OfertaEntregasAPartirDe'].toString().trim();
    // OfertaCodigoAlt = json['OfertaCodigoAlt'].toString().trim();
    // OfertaMostraReview = json['OfertaMostraReview'];
    // OfertaAceitaEntregaComprador = json['OfertaAceitaEntregaComprador'].toString().trim() == 'true' ? true : false;
    // OfertaAceitaEntregaParceiro = json['OfertaAceitaEntregaParceiro'].toString().trim() == 'true' ? true : false;
    // OfertaAceitaEntregaVendedor = json['OfertaAceitaEntregaVendedor'].toString().trim() == 'true' ? true : false;
    // OfertaRevisao = json['OfertaRevisao'].toString().trim() == 'true' ? true : false;
    // OfertaMostra = json['OfertaMostra'].toString().trim() == 'true' ? true : false;
    // ValorEntregaAte1 = double.parse(json['ValorEntregaAte1'].toString());
    // ValorEntregaAte2 = double.parse(json['ValorEntregaAte2'].toString());
    // ValorEntregaMaisDe2 = double.parse(json['ValorEntregaMaisDe2'].toString());
    LojaNome = json['LojaNome'].toString().trim();
  }

  Map<String, dynamic> toJsonPost() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaChave'] = this.CategoriaChave.toString().trim();
    data['OfertaCEP'] = this.OfertaCEP.toString().trim();
    data['OfertaDetalhe'] = this.OfertaDetalhe.toString().trim();
    // data['OfertaDispoDesde'] = this.OfertaDispoDesde;
    //data['OfertaID'] = this.OfertaID.toString();
    // data['OfertaImgPath'] = this.OfertaImgPath.toString().trim();
    data['OfertaPreco'] = this.OfertaPreco.toString().trim();
    data['OfertaTitulo'] = this.OfertaTitulo.toString().trim();
    data['OfertaFKID'] = this.OfertaFKID.toString().trim();
    //data['OfertaDesativID'] = this.OfertaDesativID.toString();
    //data['OfertaDesativAdminID'] = this.OfertaDesativAdminID.toString();
    //data['OfertaDesativEm'] = this.OfertaDesativEm;
    //data['OfertaDispoTipo'] = '1'; // this.OfertaDispoTipo.toString();
    // data['OfertaDispoAte'] = this.OfertaDispoAte;
    //data['OfertaPontoMenos'] = this.OfertaPontoMenos.toString();
    //data['OfertaPontoMenos'] = this.OfertaPontoMenos.toString();
    //data['OfertaQtdVendida'] = this.OfertaQtdVendida.toString();
    // data['OfertaPrazoEntregaMinutos'] = this.OfertaPrazoEntregaMinutos.toString();
    // data['LojaID'] = this.LojaID.toString();
    data['OfertaGUID'] = this.OfertaGUID;
    // data['OfertaQtdDispo'] = '1'; // this.OfertaQtdDispo.toString();
    // data['OfertaQtdMaxVenda'] = this.OfertaQtdMaxVenda.toString();
    // data['OfertaQtdAviso'] = this.OfertaQtdAviso.toString();
    // data['OfertaPeso'] = this.OfertaPeso.toString();
    // data['OfertaPeso'] = 0.00;
    // data['OfertaPesoUnidade'] = this.OfertaPesoUnidade;
    // data['OfertaDiasValidade'] = 0; // this.OfertaDiasValidade.toString();
    // data['OfertaPrecoMin'] = this.OfertaPrecoMin.toString();
    // data['OfertaMostraAval'] = 'false'; // this.OfertaMostraAval.toString();
    // data['OfertaAceitaAuto'] = this.OfertaAceitaAuto.toString().trim();
    data['OfertaAceitaEncomenda'] = this.OfertaAceitaEncomenda.toString().trim();
    // data['OfertaAceitaProposta'] = 'false'; // this.OfertaAceitaProposta.toString();
    // data['OfertaTempoEntrega'] = this.OfertaTempoEntrega.toString();
    // data['OfertaTempoEntregaUnidade'] = this.OfertaTempoEntregaUnidade;
    // data['OfertaFormaFechamento'] = this.OfertaFormaFechamento.toString().trim();
    //data['OfertaAgenteEntrega'] = this.OfertaAgenteEntrega;
    // data['OfertaAgenteEntregaNome'] = this.OfertaAgenteEntregaNome;
    // data['OfertaAgenteEntregaID'] = this.OfertaAgenteEntregaID;
    data['OfertaMarcaRevenda'] = this.OfertaMarcaRevenda.toString().trim();
    // data['OfertaCores'] = this.OfertaCores.toString().trim();
    // data['OfertaTamanhos'] = this.OfertaTamanhos.toString().trim();
    data['Oferta24hs'] = this.Oferta24hs.toString().trim();
    // data['OfertaDistanciaKm'] = '0'; // this.OfertaDistanciaKm.toString();
    // data['OfertaSinal'] = '0.00'; // this.OfertaSinal.toString();
    // data['OfertaEncomendasAPartirDe'] = this.OfertaEncomendasAPartirDe;
    // data['OfertaEntregasAPartirDe'] = this.OfertaEntregasAPartirDe;
    // data['OfertaCodigoAlt'] = this.OfertaCodigoAlt.toString().trim();
    // data['ValorEntregaAte1'] = '0.00'; // this.ValorEntregaAte1.toString();
    // data['ValorEntregaAte2'] = '0.00'; // this.ValorEntregaAte2.toString();
    // data['ValorEntregaMaisDe2'] = '0.00'; // this.ValorEntregaMaisDe2.toString();

    // data['OfertaSemQtd'] = this.OfertaSemQtd.toString();
    // data['OfertaSemQtd'] = 'true';
    // data['OfertaSinalTipo'] = this.OfertaSinalTipo.toString();
    // data['OfertaPrecoAPartir'] = 'false'; // this.OfertaPrecoAPartir.toString();
    data['OfertaPrecoCombinar'] = 'false'; // this.OfertaPrecoCombinar.toString();
    data['SegDispo'] = 'true'; // this.SegDispo.toString();
    data['TerDispo'] = 'true'; // this.TerDispo.toString();
    data['QuaDispo'] = 'true'; // this.QuaDispo.toString();
    data['QuiDispo'] = 'true'; // this.QuiDispo.toString();
    data['SexDispo'] = 'true'; // this.SexDispo.toString();
    data['SabDispo'] = 'true'; // this.SabDispo.toString();
    data['DomDispo'] = 'true'; // this.DomDispo.toString();
    data['SegDas'] = this.SegDas.toString().trim();
    data['SegAs'] = this.SegAs.toString().trim();
    data['TerDas'] = this.TerDas.toString().trim();
    data['TerAs'] = this.TerAs.toString().trim();
    data['QuaDas'] = this.QuaDas.toString().trim();
    data['QuaAs'] = this.QuaAs.toString().trim();
    data['QuiDas'] = this.QuiDas.toString().trim();
    data['QuiAs'] = this.QuiAs.toString().trim();
    data['SexDas'] = this.SexDas.toString().trim();
    data['SexAs'] = this.SexAs.toString().trim();
    data['SabDas'] = this.SabDas.toString().trim();
    data['SabAs'] = this.SabAs.toString().trim();
    data['DomDas'] = this.DomDas.toString().trim();
    data['DomAs'] = this.DomAs.toString().trim();
    data['OfertaSomenteEncomenda'] = 'false';
    // data['OfertaMostraReview'] = this.OfertaMostraReview.toString();
    data['LojaNome'] = this.LojaNome.toString().trim();
    return data;
  }

  Map<String, dynamic> toJsonPut() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    print("ofertaGuid: ${this.OfertaGUID}");
    print("CategoriaChave: ${this.CategoriaChave}");

    data['OfertaGUID'] = this.OfertaGUID;
    data['CategoriaChave'] = this.CategoriaChave; //.toString().trim();
    // data['OfertaAgenteEntrega'] = this.OfertaAgenteEntrega.toString().trim();
    // data['OfertaAgenteEntregaNome'] = this.OfertaAgenteEntregaNome.toString().trim();
    data['OfertaCEP'] = this.OfertaCEP.toString().trim();
    // data['OfertaCodigoAlt'] = this.OfertaCodigoAlt.toString().trim();
    // data['OfertaCores'] = this.OfertaCores.toString().trim();
    data['OfertaDetalhe'] = this.OfertaDetalhe.toString().trim();
    // data['OfertaDiasValidade'] = 0; // this.OfertaDiasValidade.toString();
    // data['OfertaDispoAte'] = this.OfertaDispoAte;
    // data['OfertaDispoDesde'] = this.OfertaDispoDesde;
    // data['OfertaDispoTipo'] = this.OfertaDispoTipo.toString().trim();
    // data['OfertaDistanciaKm'] = this.OfertaDistanciaKm.toString().trim();
    // data['OfertaEncomendasAPartirDe'] = this.OfertaEncomendasAPartirDe;
    // data['OfertaEntregasAPartirDe'] = this.OfertaEntregasAPartirDe;
    // data['OfertaFormaFechamento'] = this.OfertaFormaFechamento.toString().trim();
    data['OfertaMarcaRevenda'] = OfertaMarcaRevenda.toString().trim();
    // data['OfertaPeso'] = this.OfertaPeso.toString().trim();
    // data['OfertaPesoUnidade'] = this.OfertaPesoUnidade.toString().trim();
    data['OfertaPreco'] = this.OfertaPreco.toString().trim();
    // data['OfertaPrecoMin'] = this.OfertaPrecoMin.toString().trim();
    // data['OfertaQtdAviso'] = this.OfertaQtdAviso.toString().trim();
    // data['OfertaQtdDispo'] = 0; // this.OfertaQtdDispo.toString();
    // data['OfertaQtdMaxVenda'] = this.OfertaQtdMaxVenda.toString().trim();
    // data['OfertaSinal'] = this.OfertaSinal.toString().trim();
    // data['OfertaTamanhos'] = this.OfertaTamanhos.toString().trim();
    // data['OfertaTempoEntrega'] = this.OfertaTempoEntrega.toString().trim();
    // data['OfertaTempoEntregaUnidade'] = this.OfertaTempoEntregaUnidade.toString().trim();
    data['OfertaTitulo'] = this.OfertaTitulo.toString().trim();
    // data['ValorEntregaAte1'] = this.ValorEntregaAte1.toString().trim();
    // data['ValorEntregaAte2'] = this.ValorEntregaAte2.toString().trim();
    // data['ValorEntregaMaisDe2'] = this.ValorEntregaMaisDe2.toString().trim();
    // data['OfertaMostraAval'] = this.OfertaMostraAval.toString().trim();
    data['OfertaAceitaEncomenda'] = this.OfertaAceitaEncomenda.toString().trim();
    // data['OfertaAceitaProposta'] = this.OfertaAceitaProposta.toString().trim();
    // data['OfertaAceitaProposta'] = "false";
    data['Oferta24hs'] = this.Oferta24hs.toString().trim();
    data['OfertaFKID'] = this.OfertaFKID;
    // data['OfertaSemQtd'] = this.OfertaSemQtd.toString().trim();
    // data['OfertaSinalTipo'] = this.OfertaSinalTipo.toString().trim();
    // data['OfertaPrecoAPartir'] = this.OfertaPrecoAPartir.toString().trim();
    data['OfertaPrecoCombinar'] = this.OfertaPrecoCombinar.toString().trim();
    data['SegDispo'] = this.SegDispo.toString().trim();
    data['TerDispo'] = this.TerDispo.toString().trim();
    data['QuaDispo'] = this.QuaDispo.toString().trim();
    data['QuiDispo'] = this.QuiDispo.toString().trim();
    data['SexDispo'] = this.SexDispo.toString().trim();
    data['SabDispo'] = this.SabDispo.toString().trim();
    data['DomDispo'] = this.DomDispo.toString().trim();
    data['SegDas'] = this.SegDas.toString().trim();
    data['SegAs'] = this.SegAs.toString().trim();
    data['TerDas'] = this.TerDas.toString().trim();
    data['TerAs'] = this.TerAs.toString().trim();
    data['QuaDas'] = this.QuaDas.toString().trim();
    data['QuaAs'] = this.QuaAs.toString().trim();
    data['QuiDas'] = this.QuiDas.toString().trim();
    data['QuiAs'] = this.QuiAs.toString().trim();
    data['SexDas'] = this.SexDas.toString().trim();
    data['SexAs'] = this.SexAs.toString().trim();
    data['SabDas'] = this.SabDas.toString().trim();
    data['SabAs'] = this.SabAs.toString().trim();
    data['DomDas'] = this.DomDas.toString().trim();
    data['DomAs'] = this.DomAs.toString().trim();
    data['OfertaFKID'] = this.OfertaFKID;

    //data['OfertaPontoMenos'] = this.OfertaPontoMenos.toString();
    //data['OfertaPontoMenos'] = this.OfertaPontoMenos.toString();
    //data['OfertaQtdVendida'] = this.OfertaQtdVendida.toString();
    // data['LojaID'] = this.LojaID.toString().trim();
    data['LojaNome'] = this.LojaNome.toString().trim();
    // data['OfertaAceitaAuto'] = this.OfertaAceitaAuto.toString().trim();
    // data['OfertaMostraReview'] = this.OfertaMostraReview.toString().trim();
    return data;
  }

}
