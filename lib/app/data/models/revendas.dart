class Revendas {
  String? RevendaNome;
  String? RevendaLogoPath;

  Revendas(this.RevendaNome,this.RevendaLogoPath);

  Revendas.fromJson(Map<String, dynamic> json) {
    RevendaNome = json['RevendaNome'].toString().trim();
    RevendaLogoPath = json['RevendaLogoPath'].toString().trim();
  }
}
