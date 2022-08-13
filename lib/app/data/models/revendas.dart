class Revendas {
  String? RevendaNome;
  String? RevendaLogoPath;

  Revendas(this.RevendaNome,this.RevendaLogoPath);

  Revendas.fromJson(Map<String, dynamic> json) {
    RevendaNome = json['RevendaNome'].toString();
    RevendaLogoPath = json['RevendaLogoPath'].toString();
  }
}
