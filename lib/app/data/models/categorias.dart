class Categorias {
  String? categoriaNome;
  String? categoriaChave;
  String? secao;
  String? iconcode;
  String? categoriaNomeLista;
  bool? categoriaRevisao;

  Categorias({this.categoriaNome, this.categoriaChave, this.secao, this.iconcode, this.categoriaNomeLista, this.categoriaRevisao});

  Categorias.fromJson(Map<String, dynamic> json) {
    categoriaNome = json['CategoriaNome'];
    categoriaChave = json['CategoriaChave'];
    secao = json['Secao'];
    iconcode = json['iconcode'];
    categoriaNomeLista = json['categoriaNomeLista'];
    categoriaRevisao = json['categoriaRevisao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaNome'] = this.categoriaNome;
    data['CategoriaChave'] = this.categoriaChave;
    data['Secao'] = this.secao;
    data['iconcode'] = this.iconcode;
    data['categoriaNomeLista'] = this.categoriaNomeLista;
    data['categoriaRevisao'] = this.categoriaRevisao;
    return data;
  }
}
