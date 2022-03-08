class Lojas {
  String? LojaAtivaDesde;
  // String? LojaInativaDesde;
  // String? LojaInativaAdminID;
  String? LojaTemplateChave;
  String? LojaNome;
  String? LojaSlogan;
  String? LojaGUID;
  String? VendedorID;
  String? LojaCNPJ;
  String? LojaRazao;
  String? Categorias;
  String? LojaConfigs;

  Lojas(this.LojaAtivaDesde, this.LojaTemplateChave, this.LojaNome, this.LojaSlogan, this.LojaGUID, this.VendedorID, this.LojaCNPJ, this.LojaRazao, this.Categorias, this.LojaConfigs);

  Lojas.fromJson(Map<String, dynamic> json) {
    LojaAtivaDesde = json['LojaAtivaDesde'];
    LojaTemplateChave = json['LojaTemplateChave'];
    LojaNome = json['LojaNome'];
    LojaSlogan = json['LojaSlogan'];
    LojaGUID = json['LojaGUID'];
    VendedorID = json['VendedorID'];
    LojaCNPJ = json['LojaCNPJ'];
    LojaRazao = json['LojaRazao'];
    Categorias = json['Categorias'];
    LojaConfigs = json['LojaConfigs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LojaAtivaDesde'] = this.LojaAtivaDesde;
    data['LojaTemplateChave'] = this.LojaTemplateChave;
    data['LojaNome'] = this.LojaNome;
    data['LojaSlogan'] = this.LojaSlogan;
    data['LojaGUID'] = this.LojaGUID;
    data['VendedorID'] = this.VendedorID;
    data['LojaCNPJ'] = this.LojaCNPJ;
    data['LojaRazao'] = this.LojaRazao;
    data['Categorias'] = this.Categorias;
    data['LojaConfigs'] = this.LojaConfigs;
    return data;
  }

}
