class Lojas {
  DateTime? LojaAtivaDesde;
  // String? LojaInativaDesde;
  // String? LojaInativaAdminID;
  String? LojaTemplateChave;
  String? LojaNome;
  String? LojaCEP;
  String? LojaSlogan;
  String? LojaGUID;
  String? VendedorID;
  String? LojaCNPJ;
  String? LojaRazao;
  String? Categorias;
  String? LojaConfigs;
  String? LojaLogra;
  String? LojaNumero;
  String? LojaCompl;

  Lojas(this.LojaAtivaDesde, this.LojaTemplateChave, this.LojaNome, this.LojaCEP, this.LojaSlogan, this.LojaGUID, this.VendedorID, this.LojaCNPJ, this.LojaRazao, this.Categorias, this.LojaConfigs, this.LojaLogra, this.LojaNumero, this.LojaCompl);

  Lojas.fromJson(Map<String, dynamic> json) {
    LojaAtivaDesde = DateTime.now(); // json['LojaAtivaDesde'];
    //LojaTemplateChave = json['LojaTemplateChave'];
    LojaNome = json['LojaNome'].toString();
    LojaCEP = json['LojaCEP'].toString();
    LojaSlogan = json['LojaSlogan'].toString();
    LojaGUID = json['LojaGUID'].toString();
    VendedorID = json['VendedorID'].toString();
    LojaCNPJ = json['LojaCNPJ'].toString();
    LojaRazao = json['LojaRazao'].toString();
    Categorias = json['Categorias'].toString();
    LojaLogra = json['LojaLogra'].toString();
    LojaNumero = json['LojaNumero'].toString();
    LojaCompl = json['LojaCompl'].toString();
  }

  // Lojas.listFromJson(List<Map<String, dynamic>> json) {
  //   //List<Lojas> retList = new List<Lojas>();
  //   json.forEach((element) {
  //
  //   });
  //   LojaAtivaDesde = json['LojaAtivaDesde'];
  //   LojaTemplateChave = json['LojaTemplateChave'];
  //   LojaNome = json['LojaNome'];
  //   LojaCEP = json['LojaCEP'];
  //   LojaSlogan = json['LojaSlogan'];
  //   LojaGUID = json['LojaGUID'];
  //   VendedorID = json['VendedorID'];
  //   LojaCNPJ = json['LojaCNPJ'];
  //   LojaRazao = json['LojaRazao'];
  //   Categorias = json['Categorias'];
  //   LojaConfigs = json['LojaConfigs'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    //data['LojaAtivaDesde'] = this.LojaAtivaDesde;
    //data['LojaTemplateChave'] = this.LojaTemplateChave;
    data['LojaNome'] = this.LojaNome;
    data['LojaCEP'] = this.LojaCEP;
    data['LojaSlogan'] = this.LojaSlogan;

    data['LojaCNPJ'] = this.LojaCNPJ;
    data['LojaRazao'] = this.LojaRazao;
    //data['Categorias'] = this.Categorias;
    //data['LojaConfigs'] = this.LojaConfigs;
    data['LojaLogra'] = this.LojaLogra;
    data['LojaNumero'] = this.LojaNumero;
    data['LojaCompl'] = this.LojaCompl;

    //if(this.LojaGUID != null) {
      data['LojaGUID'] = this.LojaGUID;
    //} else {
    //  data['VendedorID'] = this.VendedorID;
    //}

    return data;
  }

}
