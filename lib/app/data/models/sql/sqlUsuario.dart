class sqlUsuarios {
  final String usuEmail;
  // final String usuNome;
  // final String? usuSobreNome;
  // final String? usuCPF;
  // final String? usuTelefone;
  // final String? usuCEP;
  // final String? usuEndereco;
  // final String? usuNumero;
  // final String? usuCompl;
  // // final String? usuDtNasc;
  // final String? usuLastLogin;
  // final String? usuTermosEm;
  // final String? usuVersao;
  final String? usuRegiao;

  sqlUsuarios(this.usuEmail, this.usuRegiao);
  //sqlUsuarios(this.usuEmail, this.usuNome, this.usuSobreNome, this.usuCPF, this.usuTelefone, this.usuCEP, this.usuEndereco, this.usuNumero, this.usuCompl, this.usuLastLogin, this.usuTermosEm, this.usuVersao);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "usuEmail": usuEmail,
      "usuRegiao": usuRegiao
      // "usuNome": usuNome,
      // "usuSobreNome": usuSobreNome,
      // "usuCPF": usuCPF,
      // "usuTelefone": usuTelefone,
      // "usuCEP": usuCEP,
      // "usuEndereco": usuEndereco,
      // "usuNumero": usuNumero,
      // "usuCompl": usuCompl,
      // "usuLastLogin": usuLastLogin,
      // "usuTermosEm": usuTermosEm,
      // "usuVersao": usuVersao
    };
  }

  // //NUNCA deve ser usado para criar a tabela
  // Map<String, dynamic> toMapBasic() {
  //   return <String, dynamic> {
  //     "usuEmail": usuEmail,
  //     "usuNome": usuNome,
  //     "usuSobreNome": usuSobreNome,
  //     "usuTelefone": usuTelefone,
  //     "usuCEP": usuCEP,
  //     "usuLastLogin": usuLastLogin,
  //     "usuVersao": usuVersao,
  //   };
  // }
  //
  // //NUNCA deve ser usado para criar a tabela
  // Map<String, dynamic> toMapEnderecoAtual() {
  //   return <String, dynamic> {
  //     "usuEmail": usuEmail,
  //     "usuCEP": usuCEP,
  //     "usuEndereco": usuEndereco,
  //     "usuNumero": usuNumero,
  //     "usuCompl": usuCompl,
  //   };
  // }

}

