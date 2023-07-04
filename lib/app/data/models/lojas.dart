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
    LojaNome = json['LojaNome'].toString().trim();
    LojaCEP = json['LojaCEP'].toString().trim();
    LojaSlogan = json['LojaSlogan'].toString().trim();
    LojaGUID = json['LojaGUID'].toString();
    VendedorID = json['VendedorID'].toString().trim();
    LojaCNPJ = json['LojaCNPJ'].toString().trim();
    LojaRazao = json['LojaRazao'].toString().trim();
    Categorias = json['Categorias'].toString().trim();
    LojaLogra = json['LojaLogra'].toString().trim();
    LojaNumero = json['LojaNumero'].toString().trim();
    LojaCompl = json['LojaCompl'].toString().trim();
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
    data['LojaNome'] = this.LojaNome.toString().trim();
    data['LojaCEP'] = this.LojaCEP.toString().trim();
    data['LojaSlogan'] = this.LojaSlogan.toString().trim();

    data['LojaCNPJ'] = this.LojaCNPJ.toString().trim();
    data['LojaRazao'] = this.LojaRazao.toString().trim();
    //data['Categorias'] = this.Categorias;
    //data['LojaConfigs'] = this.LojaConfigs;
    data['LojaLogra'] = this.LojaLogra.toString().trim();
    data['LojaNumero'] = this.LojaNumero.toString().trim();
    data['LojaCompl'] = this.LojaCompl.toString().trim();

    //if(this.LojaGUID != null) {
      data['LojaGUID'] = this.LojaGUID;
    //} else {
    //  data['VendedorID'] = this.VendedorID;
    //}

    return data;
  }

}
