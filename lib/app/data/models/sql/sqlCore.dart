class sqlCore {
  String? coreChave;
  String? coreValor;
  // String? cep;

  sqlCore(this.coreChave, this.coreValor); //, this.cep);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "coreChave": coreChave,
      "coreValor": coreValor,
      // "cep": cep
    };
  }
}