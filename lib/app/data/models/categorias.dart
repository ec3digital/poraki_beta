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
    categoriaNome = json['CategoriaNome'].toString();
    categoriaChave = json['CategoriaChave'].toString();
    secao = json['Secao'].toString();
    iconcode = json['iconcode'].toString();
    categoriaNomeLista = json['CategoriaNomeLista'];
    categoriaRevisao = json['CategoriaRevisao'].toString() == 'true' ? true : false;
    categoriaFormasEntrega = json['CategoriaFormasEntrega'].toString();
    categoriaFormasFechto = json['CategoriaFormasFechto'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoriaNome'] = this.categoriaNome;
    data['CategoriaChave'] = this.categoriaChave;
    data['Secao'] = this.secao;
    data['iconcode'] = this.iconcode;
    data['CategoriaNomeLista'] = this.categoriaNomeLista;
    data['CategoriaRevisao'] = this.categoriaRevisao;
    data['CategoriaFormasEntrega'] = this.categoriaFormasEntrega;
    data['CategoriaFormasFechto'] = this.categoriaFormasFechto;
    return data;
  }
}
