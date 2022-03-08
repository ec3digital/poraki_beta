class sqlLoja {
  String? lojaAtivaDesde;
  // String? LojaInativaDesde;
  // String? LojaInativaAdminID;
  String? lojaTemplateChave;
  String? lojaNome;
  String? lojaSlogan;
  String? lojaGUID;
  String? vendedorID;
  String? lojaCNPJ;
  String? lojaRazao;
  String? categorias;
  String? lojaConfigs;

  sqlLoja(this.lojaAtivaDesde, this.lojaTemplateChave, this.lojaNome, this.lojaSlogan, this.lojaGUID, this.vendedorID, this.lojaCNPJ, this.lojaRazao, this.categorias, this.lojaConfigs);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "lojaAtivaDesde": lojaAtivaDesde,
      "lojaTemplateChave": lojaTemplateChave,
      "lojaNome": lojaNome,
      "lojaSlogan": lojaSlogan,
      "lojaGUID": lojaGUID,
      "vendedorID": vendedorID,
      "lojaCNPJ": lojaCNPJ,
      "lojaRazao": lojaRazao,
      "categorias": categorias,
      "lojaConfigs": lojaConfigs
    };
  }

}