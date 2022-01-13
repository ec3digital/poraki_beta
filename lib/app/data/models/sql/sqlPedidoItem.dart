class sqlPedidoItem {
  final String pedidoItemGUID;
  final int pedidoId;
  final String? pedidoGUID;
  final int ofertaId;
  final String ofertaGuid;
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

  sqlPedidoItem(this.pedidoItemGUID, this.pedidoId, this.pedidoGUID, this.ofertaId, this.ofertaGuid, this.ofertaTitulo, this.ofertaCEP, this.ofertaVendedorId, this.ofertaPreco, this.ofertaQtd, this.ofertaTotal, this.ofertaImgPath, this.categoriaChave, this.ofertaCancelada, this.ofertaEntregueEm);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "pedidoItemGUID": pedidoItemGUID,
      "pedidoId": pedidoId,
      "pedidoGUID": pedidoGUID,
      "ofertaId": ofertaId,
      "ofertaGuid": ofertaGuid,
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