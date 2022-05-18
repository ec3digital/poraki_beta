// ignore: camel_case_types
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
  late String? ofertaDetalhe;
  late String? ofertaCanceladaEm;
  late String? ofertaCanceladaPorNome;
  late String? ofertaCanceladaPorEmail;
  late String? ofertaEntregaCodigo;
  late String? ofertaEntregueEm;
  late String? ofertaEntreguePorNome;
  late String? ofertaEntreguePorEmail;
  late String? ofertaPrevisaoEntrega;
  late String? ofertaLojaID;

  sqlPedidoItem(this.pedidoItemGUID, this.pedidoGUID, this.ofertaGuid, this.ofertaTitulo, this.ofertaCEP, this.ofertaVendedorGuid, this.ofertaPreco, this.ofertaQtd, this.ofertaTotal, this.ofertaImgPath, this.categoriaChave, this.ofertaDetalhe, this.ofertaPrevisaoEntrega, this.ofertaEntregaCodigo, this.ofertaEntregueEm, this.ofertaEntreguePorNome, this.ofertaEntreguePorEmail, this.ofertaCanceladaEm, this.ofertaCanceladaPorNome, this.ofertaCanceladaPorEmail, this.ofertaLojaID);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "PedidoItemGUID": pedidoItemGUID,
      "PedidoGUID": pedidoGUID,
      "OfertaGuid": ofertaGuid,
      "OfertaTitulo": ofertaTitulo,
      "OfertaCEP": ofertaCEP,
      "OfertaVendedorGuid": ofertaVendedorGuid,
      "OfertaPreco": ofertaPreco,
      "OfertaQtd": ofertaQtd,
      "OfertaTotal": ofertaTotal,
      "OfertaImgPath": ofertaImgPath,
      "CategoriaChave": categoriaChave,
      "OfertaCanceladaEm": ofertaCanceladaEm,
      "OfertaCanceladaPorNome": ofertaCanceladaPorNome,
      "OfertaCanceladaPorEmail": ofertaCanceladaPorEmail,
      "OfertaEntregueEm": ofertaEntregueEm,
      "OfertaDetalhe": ofertaDetalhe,
      "OfertaEntregaCodigo": ofertaEntregaCodigo,
      "OfertaEntregueEm": ofertaEntregueEm,
      "OfertaEntreguePorNome": ofertaEntreguePorNome,
      "OfertaEntreguePorEmail": ofertaEntreguePorEmail,
      "OfertaPrevisaoEntrega": ofertaPrevisaoEntrega,
      "OfertaLojaID": ofertaLojaID
    };
  }

}