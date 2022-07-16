class sqlCarrinho {
  final String ofertaId;
  final String ofertaGUID;
  final String ofertaTitulo;
  final String ofertaCEP;
  final String ofertaVendedorGUID;
  final String ofertaPreco;
  final String ofertaQtd;
  final String ofertaImgPath;
  final String categoriaChave;
  late String? ofertaEntregaPrevEm;
  final String? ofertaLojaGUID;
  late String? ofertaDetalhe;

  sqlCarrinho(this.ofertaId, this.ofertaGUID, this.ofertaTitulo, this.ofertaCEP, this.ofertaVendedorGUID, this.ofertaPreco, this.ofertaQtd, this.ofertaImgPath, this.categoriaChave, this.ofertaEntregaPrevEm, this.ofertaLojaGUID, this.ofertaDetalhe);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "ofertaId": ofertaId,
      "ofertaGUID": ofertaGUID,
      "ofertaTitulo": ofertaTitulo,
      "ofertaCEP": ofertaCEP,
      "ofertaVendedorGUID": ofertaVendedorGUID,
      "ofertaLojaGUID": ofertaLojaGUID,
      "ofertaPreco": ofertaPreco,
      "ofertaQtd": ofertaQtd,
      "ofertaImgPath": ofertaImgPath,
      "categoriaChave": categoriaChave,
      "ofertaEntregaPrevEm": ofertaEntregaPrevEm,
      "ofertaDetalhe": ofertaDetalhe
    };
  }

}