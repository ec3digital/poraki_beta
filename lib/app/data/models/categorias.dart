class Categorias {
  String? categoriaNome;
  String? categoriaChave;
  String? secao;

  Categorias({this.categoriaNome, this.categoriaChave, this.secao});

  Categorias.fromJson(Map<String, dynamic> json) {
    categoriaNome = json['CategoriaNome'];
    categoriaChave = json['CategoriaChave'];
    secao = json['Secao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaNome'] = this.categoriaNome;
    data['CategoriaChave'] = this.categoriaChave;
    data['Secao'] = this.secao;
    return data;
  }
}
