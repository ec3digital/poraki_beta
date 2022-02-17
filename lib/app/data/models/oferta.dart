class Oferta {
  int? OfertaID;
  String? CategoriaChave;
  int? OfertaFKID;
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
    CategoriaChave = json['CategoriaChave'];
    OfertaCEP = json['OfertaCEP'];
    OfertaDetalhe = json['OfertaDetalhe'];
    OfertaDispoDesde = json['OfertaDispoDesde'];
    OfertaID = json['OfertaID'];
    OfertaImgPath = json['OfertaImgPath'];
    OfertaPreco = double.parse(json['OfertaPreco'].toString());
    OfertaTitulo = json['OfertaTitulo'];
    OfertaFKID = json['OfertaFKID'];
    OfertaDesativID = json['OfertaDesativID'];
    OfertaDesativAdminID = json['OfertaDesativAdminID'];
    OfertaDesativEm = json['OfertaDesativEm'];
    OfertaDispoTipo = json['OfertaDispoTipo'];
    OfertaDispoAte = json['OfertaDispoAte'];
    OfertaPontoMenos = json['OfertaPontoMenos'];
    OfertaPontoMenos = json['OfertaPontoMenos'];
    OfertaQtdVendida = json['OfertaQtdVendida'];
    OfertaPrazoEntregaMinutos = json['OfertaPrazoEntregaMinutos'];
    LojaID = json['LojaID'];
    OfertaGUID = json['OfertaGUID'];
    OfertaQtdDispo = json['OfertaQtdDispo'];
    OfertaQtdMaxVenda = json['OfertaQtdMaxVenda'];
    OfertaQtdAviso = json['OfertaQtdAviso'];
    OfertaPeso = json['OfertaPeso'];
    OfertaPesoUnidade = json['OfertaPesoUnidade'];
    OfertaDiasValidade = json['OfertaDiasValidade'];
    OfertaPrecoMin = json['OfertaPrecoMin'];
    OfertaMostraAval = json['OfertaMostraAval'];
    OfertaAceitaAuto = json['OfertaAceitaAuto'];
    OfertaAceitaEncomenda = json['OfertaAceitaEncomenda'];
    OfertaAceitaProposta = json['OfertaAceitaProposta'];
    OfertaTempoEntrega = json['OfertaTempoEntrega'];
    OfertaTempoEntregaUnidade = json['OfertaTempoEntregaUnidade'];
    OfertaFormaFechamento = json['OfertaFormaFechamento'];
    OfertaAgenteEntrega = json['OfertaAgenteEntrega'];
    OfertaAgenteEntregaNome = json['OfertaAgenteEntregaNome'];
    OfertaAgenteEntregaID = json['OfertaAgenteEntregaID'];
    OfertaMarcaRevenda = json['OfertaMarcaRevenda'];
    OfertaCores = json['OfertaCores'];
    OfertaTamanhos = json['OfertaTamanhos'];
    Oferta24hs = json['Oferta24hs'];
    OfertaDistanciaKm = json['OfertaDistanciaKm'];
    OfertaSinal = json['OfertaSinal'];
    OfertaEncomendasAPartirDe = json['OfertaEncomendasAPartirDe'];
    OfertaEntregasAPartirDe = json['OfertaEntregasAPartirDe'];
    OfertaCodigoAlt = json['OfertaCodigoAlt'];
    ValorEntregaAte1 = json['ValorEntregaAte1'];
    ValorEntregaAte2 = json['ValorEntregaAte2'];
    ValorEntregaMaisDe2 = json['ValorEntregaMaisDe2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaChave'] = this.CategoriaChave;
    data['OfertaCEP'] = this.OfertaCEP;
    data['OfertaDetalhe'] = this.OfertaDetalhe;
    data['OfertaDispoDesde'] = this.OfertaDispoDesde;
    data['OfertaID'] = this.OfertaID;
    data['OfertaImgPath'] = this.OfertaImgPath;
    data['OfertaPreco'] = this.OfertaPreco;
    data['OfertaTitulo'] = this.OfertaTitulo;
    data['OfertaFKID'] = this.OfertaFKID;
    data['OfertaDesativID'] = this.OfertaDesativID;
    data['OfertaDesativAdminID'] = this.OfertaDesativAdminID;
    data['OfertaDesativEm'] = this.OfertaDesativEm;
    data['OfertaDispoTipo'] = this.OfertaDispoTipo;
    data['OfertaDispoAte'] = this.OfertaDispoAte;
    data['OfertaPontoMenos'] = this.OfertaPontoMenos;
    data['OfertaPontoMenos'] = this.OfertaPontoMenos;
    data['OfertaQtdVendida'] = this.OfertaQtdVendida;
    data['OfertaPrazoEntregaMinutos'] = this.OfertaPrazoEntregaMinutos;
    data['LojaID'] = this.LojaID ;
    data['OfertaGUID'] = this.OfertaGUID;
    data['OfertaQtdDispo'] = this.OfertaQtdDispo;
    data['OfertaQtdMaxVenda'] = this.OfertaQtdMaxVenda;
    data['OfertaQtdAviso'] = this.OfertaQtdAviso;
    data['OfertaPeso'] = this.OfertaPeso;
    data['OfertaPesoUnidade'] = this.OfertaPesoUnidade;
    data['OfertaDiasValidade'] = this.OfertaDiasValidade;
    data['OfertaPrecoMin'] = this.OfertaPrecoMin;
    data['OfertaMostraAval'] = this.OfertaMostraAval;
    data['OfertaAceitaAuto'] = this.OfertaAceitaAuto;
    data['OfertaAceitaEncomenda'] = this.OfertaAceitaEncomenda;
    data['OfertaAceitaProposta'] = this.OfertaAceitaProposta;
    data['OfertaTempoEntrega'] = this.OfertaTempoEntrega;
    data['OfertaTempoEntregaUnidade'] = this.OfertaTempoEntregaUnidade;
    data['OfertaFormaFechamento'] = this.OfertaFormaFechamento;
    data['OfertaAgenteEntrega'] = this.OfertaAgenteEntrega;
    data['OfertaAgenteEntregaNome'] = this.OfertaAgenteEntregaNome;
    data['OfertaAgenteEntregaID'] = this.OfertaAgenteEntregaID;
    data['OfertaMarcaRevenda'] = OfertaMarcaRevenda;
    data['OfertaCores'] = this.OfertaCores;
    data['OfertaTamanhos'] = this.OfertaTamanhos;
    data['Oferta24hs'] = this.Oferta24hs;
    data['OfertaDistanciaKm'] = this.OfertaDistanciaKm;
    data['OfertaSinal'] = this.OfertaSinal;
    data['OfertaEncomendasAPartirDe'] = this.OfertaEncomendasAPartirDe;
    data['OfertaEntregasAPartirDe'] = this.OfertaEntregasAPartirDe;
    data['OfertaCodigoAlt'] = this.OfertaCodigoAlt;
    data['ValorEntregaAte1'] = this.ValorEntregaAte1;
    data['ValorEntregaAte2'] = this.ValorEntregaAte2;
    data['ValorEntregaMaisDe2'] = this.ValorEntregaMaisDe2;
    return data;
  }
}