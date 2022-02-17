class sqlCategorias {
  final String categoriaChave;
  final String categoriaNome;
  final String secao;
  final int mostraBarra;
  final int iconCode;
  final String categoriaNomeLista;

  sqlCategorias(this.categoriaChave, this.categoriaNome, this.secao, this.mostraBarra, this.iconCode, this.categoriaNomeLista);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "categoriaChave": categoriaChave,
      "categoriaNome": categoriaNome,
      "secao": secao,
      "mostraBarra": mostraBarra,
      "iconCode": iconCode,
      "categoriaNomeLista": categoriaNomeLista
    };
  }
}