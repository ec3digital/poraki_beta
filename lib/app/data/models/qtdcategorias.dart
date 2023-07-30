class qtdcategorias {
  String? CategoriaChave;
  int? qtd;

  qtdcategorias.fromJson(Map<String, dynamic> json) {
    CategoriaChave = json['CategoriaChave'].toString().trim();
    qtd = int.parse(json['qtd'].toString().trim());
  }
}