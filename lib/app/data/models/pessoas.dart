class Pessoas {
  String? pessoaCEP;
  String? pessoaFirebaseID;
  String? pessoaImgPath;
  String? pessoaNome;
  String? pessoaSexo;
  String? pessoaLogin;

  Pessoas(
      {this.pessoaCEP,
        this.pessoaFirebaseID,
        this.pessoaImgPath,
        this.pessoaNome,
        this.pessoaSexo,
        this.pessoaLogin});

  Pessoas.fromJson(Map<String, dynamic> json) {
    pessoaCEP = json['PessoaCEP'];
    pessoaFirebaseID = json['PessoaFirebaseID'];
    pessoaImgPath = json['PessoaImgPath'];
    pessoaNome = json['PessoaNome'];
    pessoaSexo = json['PessoaSexo'];
    pessoaLogin = json['PessoaLogin'];
  }

  Pessoas.fromJsonChat(Map<String, dynamic> json) {
    pessoaNome = json['PessoaNome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PessoaCEP'] = this.pessoaCEP;
    data['PessoaFirebaseID'] = this.pessoaFirebaseID;
    data['PessoaImgPath'] = this.pessoaImgPath;
    data['PessoaNome'] = this.pessoaNome;
    data['PessoaSexo'] = this.pessoaSexo;
    data['PessoaLogin'] = this.pessoaLogin;
    return data;
  }
}