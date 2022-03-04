class ProdutoOferta {
  String? categoriaChave;
  String? ofertaCEP;
  String? ofertaDetalhe;
  String? ofertaDispoDesde;
  int? ofertaID;
  String? ofertaImgPath;
  double? ofertaPreco;
  String? ofertaTitulo;

  ProdutoOferta(
      {this.categoriaChave,
        this.ofertaCEP,
        this.ofertaDetalhe,
        this.ofertaDispoDesde,
        this.ofertaID,
        this.ofertaImgPath,
        this.ofertaPreco,
        this.ofertaTitulo});

  ProdutoOferta.fromJson(Map<String, dynamic> json) {
    categoriaChave = json['CategoriaChave'];
    ofertaCEP = json['OfertaCEP'];
    ofertaDetalhe = json['OfertaDetalhe'];
    ofertaDispoDesde = json['OfertaDispoDesde'];
    ofertaID = int.parse(json['OfertaID'].toString());
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
    data['OfertaID'] = this.ofertaID.toString();
    data['OfertaImgPath'] = this.ofertaImgPath;
    data['OfertaPreco'] = this.ofertaPreco.toString();
    data['OfertaTitulo'] = this.ofertaTitulo;
    return data;
  }
}