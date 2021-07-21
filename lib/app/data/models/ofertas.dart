class Ofertas {
  String? categoriaChave;
  String? ofertaCEP;
  String? ofertaDetalhe;
  DateTime? ofertaDispoDesde;
  int? ofertaID;
  String? ofertaImgPath;
  double? ofertaPreco;
  String? ofertaTitulo;

  Ofertas(
      {this.categoriaChave,
        this.ofertaCEP,
        this.ofertaDetalhe,
        this.ofertaDispoDesde,
        this.ofertaID,
        this.ofertaImgPath,
        this.ofertaPreco,
        this.ofertaTitulo});

  Ofertas.fromJson(Map<String, dynamic> json) {
    categoriaChave = json['CategoriaChave'];
    ofertaCEP = json['OfertaCEP'];
    ofertaDetalhe = json['OfertaDetalhe'];
    ofertaDispoDesde = json['OfertaDispoDesde'];
    ofertaID = json['OfertaID'];
    ofertaImgPath = json['OfertaImgPath'];
    ofertaPreco = double.parse(json['OfertaPreco'].toString());
    ofertaTitulo = json['OfertaTitulo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaChave'] = this.categoriaChave;
    data['OfertaCEP'] = this.ofertaCEP;
    data['OfertaDetalhe'] = this.ofertaDetalhe;
    data['OfertaDispoDesde'] = this.ofertaDispoDesde;
    data['OfertaID'] = this.ofertaID;
    data['OfertaImgPath'] = this.ofertaImgPath;
    data['OfertaPreco'] = this.ofertaPreco;
    data['OfertaTitulo'] = this.ofertaTitulo;
    return data;
  }
}