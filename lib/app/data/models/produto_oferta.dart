import 'package:poraki/app/data/models/sql/sqlLoja.dart';

class ProdutoOferta {
  String? categoriaChave;
  String? ofertaCEP;
  String? ofertaDetalhe;
  String? ofertaDispoDesde;
  String? ofertaID;
  String? ofertaImgPath;
  double? ofertaPreco;
  String? ofertaTitulo;
  String? ofertaGUID;
  String? ofertaFKID;
  String? lojaID;
  int? ofertaQtdMaxVenda;
  String? ofertaPeso;
  String? ofertaPesoUnidade;
  int? ofertaDiasValidade;
  double? ofertaPrecoMin;
  bool? ofertaMostraAval;
  bool? ofertaAceitaAuto;
  bool? ofertaAceitaProposta;
  bool? ofertaAceitaEncomenda;
  bool? ofertaSomenteEncomenda;
  int? ofertaTempoEntrega;
  String? ofertaTempoEntregaUnidade;
  String? ofertaFormaFechamento;
  String? ofertaMarcaRevenda;
  String? ofertaCores;
  String? ofertaTamanhos;
  bool? oferta24hs;
  int? ofertaDistanciaKm;
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
  String? segDas;
  String? segAs;
  String? terDas;
  String? terAs;
  String? quaDas;
  String? quaAs;
  String? quiDas;
  String? quiAs;
  String? sexDas;
  String? sexAs;
  String? sabDas;
  String? sabAs;
  String? domDas;
  String? domAs;
  String? ofertaDispoAte;
  String? ofertaDispoTipo;
  int? ofertaQtdAviso;
  int? ofertaQtdDispo;
  bool? ofertaSemQtd;
  String? lojaNome;
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
      this.ofertaDiasValidade,
      this.ofertaDistanciaKm,
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
      this.ofertaQtdMaxVenda,
      this.ofertaSinal,
      this.ofertaSinalTipo,
      this.ofertaSomenteEncomenda,
      this.ofertaTamanhos,
      this.ofertaTempoEntrega,
      this.ofertaTempoEntregaUnidade,
      // this.ofertaTotalAval,
      this.valorEntregaAte1,
      this.valorEntregaAte2,
      this.valorEntregaMaisDe2,
      this.ofertaDispoAte,
      this.ofertaDispoTipo,
      this.ofertaQtdAviso,
      this.ofertaQtdDispo,
      this.ofertaSemQtd,
      this.segDas,
      this.segAs,
      this.terDas,
      this.terAs,
      this.quaDas,
      this.quaAs,
      this.quiDas,
      this.quiAs,
      this.sexDas,
      this.sexAs,
      this.sabDas,
      this.sabAs,
      this.domDas,
      this.domAs,
      this.lojaNome});

  ProdutoOferta.fromJson(Map<String, dynamic> json) {
    //print('ofertaGUID from Json:' + json['OfertaGUID'].toString());
    ofertaGUID = json['OfertaGUID'].toString();
    categoriaChave = json['CategoriaChave'].toString();
    ofertaCEP = json['OfertaCEP'].toString();
    ofertaDetalhe = json['OfertaDetalhe'].toString() == 'null' ? '' : json['OfertaDetalhe'].toString();
    //ofertaDispoDesde = json['OfertaDispoDesde'];
    ofertaID = json['OfertaID'].toString();
    ofertaImgPath = json['OfertaImgPath'].toString();
    ofertaPreco = double.parse(json['OfertaPreco'].toString());
    ofertaTitulo = json['OfertaTitulo'].toString();
    ofertaFKID = json['OfertaFKID'].toString();
    lojaID = json['LojaID'].toString();

    oferta24hs = json['Oferta24hs'].toString() == 'true' ? true : false;
    ofertaAceitaAuto =
        json['OfertaAceitaAuto'].toString() == 'true' ? true : false;
    ofertaAceitaEncomenda =
        json['OfertaAceitaEncomenda'].toString() == 'true' ? true : false;
    ofertaSomenteEncomenda =
        json['ofertaSomenteEncomenda'].toString() == 'true' ? true : false;
    ofertaPrecoCombinar =
        json['ofertaPrecoCombinar'].toString() == 'true' ? true : false;
    ofertaPrecoAPartir =
        json['ofertaPrecoAPartir'].toString() == 'true' ? true : false;
    ofertaMostraReview =
        json['ofertaMostraReview'].toString() == 'true' ? true : false;
    ofertaMostraAval =
        json['ofertaMostraAval'].toString() == 'true' ? true : false;
    ofertaAceitaEntregaComprador =
        json['OfertaAceitaEntregaComprador'].toString() == 'true'
            ? true
            : false;
    ofertaAceitaEntregaParceiro =
        json['OfertaAceitaEntregaParceiro'].toString() == 'true' ? true : false;
    ofertaAceitaEntregaVendedor =
        json['OfertaAceitaEntregaVendedor'].toString() == 'true' ? true : false;
    ofertaAceitaProposta =
        json['OfertaAceitaProposta'].toString() == 'true' ? true : false;

    ofertaCodigoAlt = json['OfertaCodigoAlt'].toString();
    ofertaCores = json['OfertaCores'].toString();
    ofertaDiasValidade = json['OfertaDiasValidade'] == null
        ? 0
        : int.parse(json['OfertaDiasValidade'].toString());
    ofertaDistanciaKm = json['OfertaDistanciaKm'] == null
        ? 0
        : int.parse(json['OfertaDistanciaKm'].toString());
    ofertaEncomendasAPartirDe = json['OfertaEncomendasAPartirDe'].toString();
    ofertaEntregasAPartirDe = json['OfertaEntregasAPartirDe'].toString();
    // ofertaFormaFechamento = json['OfertaFormaFechamento'];
    ofertaMarcaRevenda = json['OfertaMarcaRevenda'].toString();
    ofertaMostraAval =
        json['OfertaMostraAval'].toString() == 'true' ? true : false;
    ofertaMostraReview =
        json['OfertaMostraReview'].toString() == 'true' ? true : false;
    ofertaPeso = json['OfertaPeso'].toString();
    ofertaPesoUnidade = json['OfertaPesoUnidade'].toString();
    ofertaTamanhos = json['OfertaTamanhos'].toString();

    // ofertaPrecoMin = json['OfertaPrecoMin'];
    // // ofertaQtdAval = json['OfertaQtdAval'];
    ofertaQtdMaxVenda = json['OfertaQtdMaxVenda'] == null
        ? 0
        : int.parse(json['OfertaQtdMaxVenda'].toString());
    // ofertaSinal = json['OfertaSinal'];
    // ofertaSinalTipo = json['OfertaSinalTipo'];
    // ofertaSomenteEncomenda = json['OfertaSomenteEncomenda'];

    ofertaTempoEntrega = json['OfertaTempoEntrega'] == null
        ? 0
        : int.parse(json['OfertaTempoEntrega'].toString());
    ofertaTempoEntregaUnidade = json['OfertaTempoEntregaUnidade'].toString();
    // // ofertaTotalAval = json['OfertaTotalAval'];

    // valorEntregaAte1 = json['ValorEntregaAte1'] == null
    //     ? 0
    //     : double.parse(json['ValorEntregaAte1'].toString());
    // valorEntregaAte2 = json['ValorEntregaAte2'] == null
    //     ? 0
    //     : double.parse(json['ValorEntregaAte2'].toString());
    // valorEntregaMaisDe2 = json['ValorEntregaMaisDe2'] == null
    //     ? 0
    //     : double.parse(json['ValorEntregaMaisDe2'].toString());

    ofertaDispoAte = json['OfertaDispoAte'].toString();
    ofertaDispoTipo = json['OfertaDispoTipo'].toString();
    ofertaQtdAviso = json['OfertaQtdAviso'] == null
        ? 0
        : int.parse(json['OfertaQtdAviso'].toString());
    ofertaQtdDispo = json['OfertaQtdDispo'] == null
        ? 0
        : int.parse(json['OfertaQtdDispo'].toString());
    ofertaSemQtd = json['OfertaSemQtd'].toString() == 'true' ? true : false;
    segDas = json['SegDas'].toString();
    segAs = json['SegAs'].toString();
    terDas = json['TerDas'].toString();
    terAs = json['TerAs'].toString();
    quaDas = json['QuaDas'].toString();
    quaAs = json['QuaAs'].toString();
    quiDas = json['QuiDas'].toString();
    quiAs = json['QuiAs'].toString();
    sexDas = json['SexDas'].toString();
    sexAs = json['SexAs'].toString();
    sabDas = json['SabDas'].toString();
    sabAs = json['SabAs'].toString();
    domDas = json['DomDas'].toString();
    domAs = json['DomAs'].toString();
    lojaNome = json['LojaNome'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaChave'] = this.categoriaChave;
    data['OfertaCEP'] = this.ofertaCEP;
    data['OfertaDetalhe'] = this.ofertaDetalhe;
    data['OfertaDispoDesde'] = this.ofertaDispoDesde;
    data['OfertaID'] = this.ofertaID.toString();
    data['OfertaImgPath'] = this.ofertaImgPath.toString();
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
    data['LojaNome'] = this.lojaNome;

    return data;
  }
}
