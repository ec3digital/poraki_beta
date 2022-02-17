class sqlPedidoItem {
  final String pedidoItemGUID;
  final String? pedidoGUID;
  final String ofertaGuid;
  final String ofertaTitulo;
  final String ofertaCEP;
  final String ofertaVendedorGuid;
  final double ofertaPreco;
  final double ofertaQtd;
  final double ofertaTotal;
  final String? ofertaImgPath;
  final String categoriaChave;
  final int? ofertaCancelada;
  final String? ofertaEntregueEm;

  sqlPedidoItem(this.pedidoItemGUID, this.pedidoGUID, this.ofertaGuid, this.ofertaTitulo, this.ofertaCEP, this.ofertaVendedorGuid, this.ofertaPreco, this.ofertaQtd, this.ofertaTotal, this.ofertaImgPath, this.categoriaChave, this.ofertaCancelada, this.ofertaEntregueEm);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "pedidoItemGUID": pedidoItemGUID,
      "pedidoGUID": pedidoGUID,
      "ofertaGuid": ofertaGuid,
      "ofertaTitulo": ofertaTitulo,
      "ofertaCEP": ofertaCEP,
      "ofertaVendedorGuid": ofertaVendedorGuid,
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