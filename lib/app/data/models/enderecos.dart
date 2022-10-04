class Enderecos {
  String? EnderecoGuid;
  String? UsuEmail;
  String? UsuGuid;
  String? EnderecoCEP;
  String? EnderecoLogra;
  String? EnderecoNumero;
  String? EnderecoCompl;
  String? EnderecoTipo;
  bool    EnderecoAtual = false;
  String? EnderecoUltData;
  String? EnderecoDesde;
  String? EnderecoLat;
  String? EnderecoLong;

  Enderecos(this.EnderecoGuid, this.UsuEmail, this.UsuGuid, this.EnderecoCEP, this.EnderecoLogra, this.EnderecoNumero, this.EnderecoCompl, this.EnderecoTipo, this.EnderecoAtual, this.EnderecoUltData, this.EnderecoDesde, this.EnderecoLat, this.EnderecoLong);

  Enderecos.fromJson(Map<String, dynamic> json) {
    EnderecoGuid = json['EnderecoGUID'].toString();
    UsuEmail = json['UsuEmail'].toString();
    UsuGuid = json['UsuGuid'].toString();
    EnderecoCEP = json['EnderecoCEP'].toString();
    EnderecoLogra = json['EnderecoLogra'].toString();
    EnderecoNumero = json['EnderecoNumero'].toString();
    EnderecoCompl = json['EnderecoCompl'].toString();
    EnderecoTipo = json['EnderecoTipo'].toString();
    EnderecoAtual = json['EnderecoAtual'].toString().toLowerCase() == 'true';
    EnderecoUltData = json['EnderecoUltData'].toString();
    EnderecoDesde = json['EnderecoDesde'].toString();
    EnderecoLat = json['EnderecoLat'].toString();
    EnderecoLong = json['EnderecoLong'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EnderecoGUID'] = this.EnderecoGuid;
    data['UsuEmail'] = this.UsuEmail;
    data['UsuGuid'] = this.UsuGuid;
    data['EnderecoCEP'] = this.EnderecoCEP;
    data['EnderecoLogra'] = this.EnderecoLogra;
    data['EnderecoNumero'] = this.EnderecoNumero;
    data['EnderecoCompl'] = this.EnderecoCompl;
    data['EnderecoTipo'] = this.EnderecoTipo;
    data['EnderecoAtual'] = this.EnderecoAtual.toString();
    // data['EnderecoUltData'] = this.EnderecoUltData;
    // data['EnderecoDesde'] = this.EnderecoDesde;
    data['EnderecoLat'] = this.EnderecoLat;
    data['EnderecoLong'] = this.EnderecoLong;
    return data;
  }
}