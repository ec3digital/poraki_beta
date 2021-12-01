class CategoryModel {
  String? categoriaNome;
  String? categoriaChave;
  String? secao;
  int? iconcode;

  CategoryModel({this.categoriaNome, this.categoriaChave, this.secao, this.iconcode});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoriaNome = json['CategoriaNome'];
    categoriaChave = json['CategoriaChave'];
    secao = json['Secao'];
    iconcode = json['iconcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaNome'] = this.categoriaNome;
    data['CategoriaChave'] = this.categoriaChave;
    data['Secao'] = this.secao;
    data['iconcode'] = this.iconcode;
    return data;
  }
}