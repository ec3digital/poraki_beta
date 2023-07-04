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
        nome: elem['Nome'].toString().trim(),
        apelido: elem['Apelido'].toString().trim(),
        cep: elem['CEP'].toString().trim(),
        cpf: elem['CPF'].toString().trim(),
        email: elem['Email'].toString().trim(),
        whatsapp: elem['Whatsapp'].toString().trim(),
        cpfValidado: elem['cpfValidado'].toString().trim() == 'true' ? true : false);
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      if (nome != null) "Nome": nome.toString().trim(),
      if (apelido != null) "Apelido": apelido.toString().trim(),
      if (cpf != null) "CPF": cpf.toString().trim(),
      if (email != null) "Email": email.toString().trim(),
      if (whatsapp != null) "Whatsapp": whatsapp.toString().trim(),
      if (cep != null) "CEP": cep.toString().trim(),
      "cpfValidado": 'false'
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      if (nome != null) "Nome": nome.toString().trim(),
      if (apelido != null) "Apelido": apelido.toString().trim(),
      if (whatsapp != null) "Whatsapp": whatsapp.toString().trim(),
      if (cep != null) "CEP": cep.toString().trim(),
    };
  }
}
