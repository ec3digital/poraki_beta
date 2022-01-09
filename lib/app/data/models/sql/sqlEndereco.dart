class sqlEndereco {
  final String  enderecoGuid;
  final String  usuEmail;
  final String  usuGuid;
  final String  enderecoCEP;
  final String  enderecoLogra;
  final String  enderecoNumero;
  final String? enderecoCompl;
  final String  enderecoTipo;
  final int     enderecoAtual;
  final String? enderecoUltData;
  //final String? enderecoDesde;
  // final String? enderecoLat;
  // final String? enderecoLong;

  sqlEndereco(this.enderecoGuid, this.usuEmail, this.usuGuid, this.enderecoCEP, this.enderecoLogra, this.enderecoNumero, this.enderecoCompl, this.enderecoTipo, this.enderecoAtual, this.enderecoUltData); //, this.enderecoDesde);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "enderecoGuid": enderecoGuid,
      "usuEmail": usuEmail,
      "usuGuid": usuGuid,
      "enderecoCEP": enderecoCEP,
      "enderecoLogra": enderecoLogra,
      "enderecoNumero": enderecoNumero,
      "enderecoCompl": enderecoCompl,
      "enderecoTipo": enderecoTipo,
      "enderecoAtual": enderecoAtual,
      "enderecoUltData": enderecoUltData,
      //"enderecoDesde": enderecoDesde,
      // "enderecoLat": enderecoLat,
      // "enderecoLong": enderecoLong,
    };
  }
}