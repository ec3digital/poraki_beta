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
  final String? ofertaEntregaPrevEm;

  sqlCarrinho(this.ofertaId, this.ofertaGUID, this.ofertaTitulo, this.ofertaCEP, this.ofertaVendedorGUID, this.ofertaPreco, this.ofertaQtd, this.ofertaImgPath, this.categoriaChave, this.ofertaEntregaPrevEm);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "ofertaId": ofertaId,
      "ofertaGUID": ofertaGUID,
      "ofertaTitulo": ofertaTitulo,
      "ofertaCEP": ofertaCEP,
      "ofertaVendedorGUID": ofertaVendedorGUID,
      "ofertaPreco": ofertaPreco,
      "ofertaQtd": ofertaQtd,
      "ofertaImgPath": ofertaImgPath,
      "categoriaChave": categoriaChave,
      "ofertaEntregaPrevEm": ofertaEntregaPrevEm,
    };
  }

}