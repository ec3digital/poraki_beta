class CepApiBrasil {
  String? cep;
  String? state;
  String? city;
  String? neighborhood;
  String? street;
  String? service;
  // final List location;

  CepApiBrasil({
    this.cep,
    this.state,
    this.city,
    this.neighborhood,
    this.street,
    this.service, //this.location
  });

  CepApiBrasil.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    state = json['state'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    street = json['street'];
    service = json['service'];
  }
}
