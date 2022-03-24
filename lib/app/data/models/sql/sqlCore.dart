class sqlCore {
  String? chave;
  String? valor;
  String? cep;

  sqlCore(this.chave, this.valor, this.cep);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "chave": chave,
      "valor": valor,
      "cep": cep
    };
  }
}