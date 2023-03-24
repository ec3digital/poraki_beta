class Usuario {
  final String? nome;
  final String? sobrenome;
  final String? cpf;
  final String? email;
  final String? whatsapp;
  final String? cep;

  Usuario(
      {this.nome,
      this.sobrenome,
      this.cpf,
      this.email,
      this.whatsapp,
      this.cep});

  // factory Usuario.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options,
  //     ) {
  //   final data = snapshot.data();
  //   return City(
  //       name: data?['name'],
  //   );
  // }

  factory Usuario.fromJson(Map<String, dynamic> elem){
    return Usuario(
      nome: elem['Nome'],
      sobrenome: elem['Sobrenome'],
      cep:  elem['CEP'],
      cpf:  elem['CPF'],
      email:  elem['Email'],
      whatsapp:  elem['Whatsapp']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nome != null) "Nome": nome,
      if (sobrenome != null) "Sobrenome": sobrenome,
      if (cpf != null) "CPF": cpf,
      if (email != null) "Email": email,
      if (whatsapp != null) "Whatsapp": whatsapp,
      if (cep != null) "CEP": cep,
    };
  }
}
