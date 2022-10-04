class PessoaNome {
  String? pessoaNome;
  String? pessoaFirebaseID;

  PessoaNome({this.pessoaNome,
    this.pessoaFirebaseID});

  PessoaNome.fromJson(Map<String, dynamic> json) {
    //print(json);
    pessoaNome = json['PessoaNome'];
    pessoaFirebaseID = json['PessoaFirebaseID'];
  }

}