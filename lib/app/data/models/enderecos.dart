class Enderecos {
  String? EnderecoGuid;
  String? UsuEmail;
  String? UsuGuid;
  String? EnderecoCEP;
  String? EnderecoLogra;
  String? EnderecoNumero;
  String? EnderecoCompl;
  String? EnderecoTipo;
  int?    EnderecoAtual;
  String? EnderecoUltData;
  String? EnderecoDesde;
  String? EnderecoLat;
  String? EnderecoLong;

  Enderecos(this.EnderecoGuid, this.UsuEmail, this.UsuGuid, this.EnderecoCEP, this.EnderecoLogra, this.EnderecoNumero, this.EnderecoCompl, this.EnderecoTipo, this.EnderecoAtual, this.EnderecoUltData, this.EnderecoDesde, this.EnderecoLat, this.EnderecoLong);

  Enderecos.fromJson(Map<String, dynamic> json) {
    EnderecoGuid = json['EnderecoGuid'];
    UsuEmail = json['UsuEmail'];
    UsuGuid = json['UsuGuid'];
    EnderecoCEP = json['EnderecoCEP'];
    EnderecoLogra = json['EnderecoLogra'];
    EnderecoNumero = json['EnderecoNumero'];
    EnderecoCompl = json['EnderecoCompl'];
    EnderecoTipo = json['EnderecoTipo'];
    EnderecoAtual = json['EnderecoAtual'];
    EnderecoUltData = json['EnderecoUltData'];
    EnderecoDesde = json['EnderecoDesde'];
    EnderecoLat = json['EnderecoLat'];
    EnderecoLong = json['EnderecoLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EnderecoGuid'] = this.EnderecoGuid;
    data['UsuEmail'] = this.UsuEmail;
    data['UsuGuid'] = this.UsuGuid;
    data['EnderecoCEP'] = this.EnderecoCEP;
    data['EnderecoLogra'] = this.EnderecoLogra;
    data['EnderecoNumero'] = this.EnderecoNumero;
    data['EnderecoCompl'] = this.EnderecoCompl;
    data['EnderecoTipo'] = this.EnderecoTipo;
    data['EnderecoAtual'] = this.EnderecoAtual;
    data['EnderecoUltData'] = this.EnderecoUltData;
    data['EnderecoDesde'] = this.EnderecoDesde;
    data['EnderecoLat'] = this.EnderecoLat;
    data['EnderecoLong'] = this.EnderecoLong;
    return data;
  }
}