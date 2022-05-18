class PedidoItem {
  late final String PedidoItemGUID;
  late final String? PedidoGUID;
  late final String OfertaGuid;
  late final String OfertaTitulo;
  late final String OfertaCEP;
  late final String OfertaVendedorGuid;
  late final double OfertaPreco;
  late final double OfertaQtd;
  late final double OfertaTotal;
  late final String? OfertaImgPath;
  late final int? OfertaCancelada;
  late final String? OfertaEntregueEm;
  late final String? CategoriaChave;
  late final String? OfertaDetalhe;
  late final String? OfertaCanceladaEm;
  late final String? OfertaCanceladaPorNome;
  late final String? OfertaCanceladaPorEmail;
  // late final String? OfertaEntregaCodigo;
  late final String? OfertaEntreguePorNome;
  late final String? OfertaEntreguePorEmail;
  late final String? OfertaPrevisaoEntrega;
  late final String? OfertaLojaID;

  PedidoItem(this.PedidoItemGUID, this.PedidoGUID, this.OfertaGuid, this.OfertaTitulo, this.OfertaCEP, this.OfertaVendedorGuid, this.OfertaPreco, this.OfertaQtd, this.OfertaTotal, this.OfertaImgPath, this.OfertaCancelada, this.OfertaEntregueEm, this.CategoriaChave, this.OfertaDetalhe, this.OfertaPrevisaoEntrega, //this.OfertaEntregaCodigo,
      this.OfertaEntreguePorEmail, this.OfertaEntreguePorNome, this.OfertaCanceladaEm, this.OfertaCanceladaPorEmail, this.OfertaCanceladaPorNome, this.OfertaLojaID);

  PedidoItem.fromJson(Map<String, dynamic> json) {
    CategoriaChave = json['CategoriaChave'];
    OfertaCEP = json['OfertaCEP'];
    OfertaCancelada = json['OfertaCancelada'];
    OfertaEntregueEm = json['OfertaEntregueEm'];
    OfertaGuid = json['OfertaGuid'];
    OfertaImgPath = json['OfertaImgPath'];
    OfertaPreco = json['OfertaPreco'];
    OfertaQtd = json['OfertaQtd'];
    OfertaTitulo = json['OfertaTitulo'];
    OfertaTotal = json['OfertaTotal'];
    PedidoGUID = json['PedidoGuid'];
    PedidoItemGUID = json['PedidoItemGuid'];
    OfertaDetalhe = json['OfertaDetalhe'];
    OfertaCanceladaEm = json['OfertaCanceladaEm'];
    OfertaCanceladaPorNome = json['OfertaCanceladaPorNome'];
    OfertaCanceladaPorEmail = json['OfertaCanceladaPorEmail'];
    // OfertaEntregaCodigo = json['OfertaEntregaCodigo'];
    OfertaEntreguePorNome = json['OfertaEntreguePorNome'];
    OfertaEntreguePorEmail = json['OfertaEntreguePorEmail'];
    OfertaPrevisaoEntrega = json['OfertaPrevisaoEntrega'];
    OfertaLojaID = json['OfertaLojaID'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "PedidoItemGUID": PedidoItemGUID,
      "PedidoGUID": PedidoGUID,
      "OfertaGuid": OfertaGuid,
      "OfertaTitulo": OfertaTitulo,
      "OfertaCEP": OfertaCEP,
      "OfertaVendedorGuid": OfertaVendedorGuid,
      "OfertaPreco": OfertaPreco,
      "OfertaQtd": OfertaQtd,
      "OfertaTotal": OfertaTotal,
      "OfertaImgPath": OfertaImgPath,
      "CategoriaChave": CategoriaChave,
      "OfertaCancelada": OfertaCancelada,
      "OfertaEntregueEm": OfertaEntregueEm,
      "OfertaDetalhe": OfertaDetalhe,
      "OfertaCanceladaEm": OfertaCanceladaEm,
      "OfertaCanceladaPorNome": OfertaCanceladaPorNome,
      "OfertaCanceladaPorEmail": OfertaCanceladaPorEmail,
      // "OfertaEntregaCodigo": OfertaEntregaCodigo,
      "OfertaEntreguePorNome": OfertaEntreguePorNome,
      "OfertaEntreguePorEmail": OfertaEntreguePorEmail,
      "OfertaPrevisaoEntrega": OfertaPrevisaoEntrega,
      "OfertaLojaID": OfertaLojaID,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['PedidoItemGUID'] = this.PedidoItemGUID;
    data['PedidoGUID'] = this.PedidoGUID;
    data['OfertaGuid'] = this.OfertaGuid;
    data['OfertaTitulo'] = this.OfertaTitulo;
    data['OfertaCEP'] = this.OfertaCEP;
    data['OfertaVendedorGuid'] = this.OfertaVendedorGuid;
    data['OfertaPreco'] = this.OfertaPreco;
    data['OfertaQtd'] = this.OfertaQtd;
    data['OfertaTotal'] = this.OfertaTotal;
    data['OfertaImgPath'] = this.OfertaImgPath;
    data['CategoriaChave'] = this.CategoriaChave;
    // data['OfertaCancelada'] = this.OfertaCancelada;
    // data['OfertaEntregueEm'] = this.OfertaEntregueEm;
    data['OfertaDetalhe'] = this.OfertaDetalhe;
    // data['OfertaCanceladaEm'] = this.OfertaCanceladaEm;
    // data['OfertaCanceladaPorNome'] = this.OfertaCanceladaPorNome;
    // data['OfertaCanceladaPorEmail'] = this.OfertaCanceladaPorEmail;
    // data['OfertaEntregaCodigo'] = this.OfertaEntregaCodigo;
    // data['OfertaEntreguePorNome'] = this.OfertaEntreguePorNome;
    // data['OfertaEntreguePorEmail'] = this.OfertaEntreguePorEmail;
    // data['OfertaPrevisaoEntrega'] = this.OfertaPrevisaoEntrega; // TODO: ENVIAR DATA PRA API
    data['OfertaLojaID'] = this.OfertaLojaID;
    return data;
  }

}