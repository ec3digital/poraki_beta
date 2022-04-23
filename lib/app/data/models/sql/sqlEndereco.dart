class sqlEndereco {
  late final String  enderecoGuid;
  final String  usuEmail;
  final String  usuGuid;
  final String  enderecoCEP;
  final String  enderecoLogra;
  final String  enderecoNumero;
  final String? enderecoCompl;
  final String  enderecoTipo;
  final bool     enderecoAtual;
  final String? enderecoUltData;
  //final String? enderecoDesde;
  final String? enderecoLat;
  final String? enderecoLong;

  sqlEndereco(this.enderecoGuid, this.usuEmail, this.usuGuid, this.enderecoCEP, this.enderecoLogra, this.enderecoNumero, this.enderecoCompl, this.enderecoTipo, this.enderecoAtual, this.enderecoUltData, this.enderecoLat, this.enderecoLong);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "enderecoGuid": enderecoGuid.toString(),
      "usuEmail": usuEmail.toString(),
      "usuGuid": usuGuid.toString(),
      "enderecoCEP": enderecoCEP.toString(),
      "enderecoLogra": enderecoLogra.toString(),
      "enderecoNumero": enderecoNumero.toString(),
      "enderecoCompl": enderecoCompl.toString(),
      "enderecoTipo": enderecoTipo.toString(),
      "enderecoAtual": true, //enderecoAtual.toString(),
      "enderecoUltData": '',
      "enderecoLatitude": enderecoLat.toString(),
      "enderecoLongitude": enderecoLong.toString(),
    };
  }
}