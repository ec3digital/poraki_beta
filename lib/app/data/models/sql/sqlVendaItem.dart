class sqlVendaItem {
  final int vendaItemId;
  final int vendaId;
  final String pedidoGUID;
  final int ofertaId;
  final String ofertaTitulo;
  final String ofertaCEP;
  final int ofertaVendedorId;
  final double ofertaPreco;
  final int ofertaQtd;
  final double ofertaTotal;
  final String? ofertaImgPath;
  final String categoriaChave;
  final int? ofertaCancelada;
  final String? ofertaEntregueEm;

  sqlVendaItem(this.vendaItemId, this.vendaId, this.pedidoGUID, this.ofertaId, this.ofertaTitulo, this.ofertaCEP, this.ofertaVendedorId, this.ofertaPreco, this.ofertaQtd, this.ofertaTotal, this.ofertaImgPath, this.categoriaChave, this.ofertaCancelada, this.ofertaEntregueEm);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "vendaItemId": vendaItemId,
      "vendaId": vendaId,
      "pedidoGUID": pedidoGUID,
      "ofertaId": ofertaId,
      "ofertaTitulo": ofertaTitulo,
      "ofertaCEP": ofertaCEP,
      "ofertaVendedorId": ofertaVendedorId,
      "ofertaPreco": ofertaPreco,
      "ofertaQtd": ofertaQtd,
      "ofertaTotal": ofertaTotal,
      "ofertaImgPath": ofertaImgPath,
      "categoriaChave": categoriaChave,
      "ofertaCancelada": ofertaCancelada,
      "ofertaEntregueEm": ofertaEntregueEm
    };
  }

}