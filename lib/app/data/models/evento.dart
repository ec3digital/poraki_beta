class Evento {
  String? EventoGUID;
  String? EventoNome;
  DateTime? EventoData;
  String? EventoHora;
  String? EventoLocal;
  String? EventoEndereco;
  String? EventoDetalhes;
  String? EventoUID;
  String? EventoPor;

  Evento(this.EventoGUID, this.EventoNome, this.EventoData, this.EventoHora, this.EventoLocal, this.EventoEndereco, this.EventoDetalhes, this.EventoUID, this.EventoPor);

  Evento.fromJson(Map<String, dynamic> json) {
    print('eventoData: ' + json['EventoData'].toString().trim());
    EventoGUID = json['EventoGUID'].toString();
    EventoNome = json['EventoNome'].toString().trim();
    // EventoData = Timestamp.fromMillisecondsSinceEpoch(json['EventoData']['seconds']).toDate(); //DateTime.now(); // json['EventoData'].toString().trim();
    EventoData = DateTime.now();
    EventoDetalhes = json['EventoDetalhes'].toString().trim();
    EventoUID = json['EventoUID'].toString().trim();
    EventoPor = json['EventoPor'].toString().trim();
    EventoLocal = json['EventoLocal'].toString().trim();
    EventoEndereco = json['EventoEndereco'].toString().trim();
    EventoHora = json['EventoHora'].toString().trim();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventoGUID'] = this.EventoGUID.toString().trim();
    data['EventoNome'] = this.EventoNome.toString().trim();
    data['EventoData'] = this.EventoData.toString().trim();
    data['EventoHora'] = this.EventoHora.toString().trim();
    data['EventoLocal'] = this.EventoLocal.toString().trim();
    data['EventoEndereco'] = this.EventoEndereco.toString().trim();
    data['EventoDetalhes'] = this.EventoDetalhes.toString().trim();
    data['EventoUID'] = this.EventoUID.toString().trim();
    data['EventoPor'] = this.EventoPor.toString().trim();

    return data;
  }
}