class Usuario {
  final String? nome;
  final String? apelido;
  final String? cpf;
  final String? email;
  final String? whatsapp;
  final String? cep;
  final bool? cpfValidado;
  final DateTime? dataNascimento;

  Usuario(
      {this.nome,
      this.apelido,
      this.cpf,
      this.email,
      this.whatsapp,
      this.cep,
      this.cpfValidado,
      this.dataNascimento});

  // factory Usuario.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options,
  //     ) {
  //   final data = snapshot.data();
  //   return City(
  //       name: data?['name'],
  //   );
  // }

  factory Usuario.fromJson(Map<String, dynamic> elem) {
    return Usuario(
        nome: elem['Nome'],
        apelido: elem['Apelido'],
        cep: elem['CEP'],
        cpf: elem['CPF'],
        email: elem['Email'],
        whatsapp: elem['Whatsapp'],
        cpfValidado: elem['cpfValidado'].toString() == 'true' ? true : false);
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      if (nome != null) "Nome": nome,
      if (apelido != null) "Apelido": apelido,
      if (cpf != null) "CPF": cpf,
      if (email != null) "Email": email,
      if (whatsapp != null) "Whatsapp": whatsapp,
      if (cep != null) "CEP": cep,
      "cpfValidado": 'false'
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      if (nome != null) "Nome": nome,
      if (apelido != null) "Apelido": apelido,
      if (whatsapp != null) "Whatsapp": whatsapp,
      if (cep != null) "CEP": cep,
    };
  }
}
