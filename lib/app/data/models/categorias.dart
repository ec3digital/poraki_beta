class Categorias {
  String? categoriaNome;
  String? categoriaChave;
  String? secao;
  String? iconcode;
  String? categoriaNomeLista;
  bool? categoriaRevisao;
  String? categoriaFormasEntrega;
  String? categoriaFormasFechto;

  Categorias({this.categoriaNome, this.categoriaChave, this.secao, this.iconcode, this.categoriaNomeLista, this.categoriaRevisao, this.categoriaFormasEntrega, this.categoriaFormasFechto});

  Categorias.fromJson(Map<String, dynamic> json) {
    categoriaNome = json['CategoriaNome'];
    categoriaChave = json['CategoriaChave'];
    secao = json['Secao'];
    iconcode = json['Iconcode'];
    categoriaNomeLista = json['CategoriaNomeLista'];
    categoriaRevisao = json['CategoriaRevisao'];
    categoriaFormasEntrega = json['CategoriaRevisao'];
    categoriaFormasFechto = json['CategoriaFormasFechto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaNome'] = this.categoriaNome;
    data['CategoriaChave'] = this.categoriaChave;
    data['Secao'] = this.secao;
    data['Iconcode'] = this.iconcode;
    data['CategoriaNomeLista'] = this.categoriaNomeLista;
    data['CategoriaRevisao'] = this.categoriaRevisao;
    data['CategoriaFormasEntrega'] = this.categoriaFormasEntrega;
    data['CategoriaFormasFechto'] = this.categoriaFormasFechto;
    return data;
  }
}
