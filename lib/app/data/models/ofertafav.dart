class OfertasFavs {
  String? OfertaGUID;
  String? usuGUID;


  OfertasFavs(this.OfertaGUID, this.usuGUID);

  OfertasFavs.fromJson(Map<String, dynamic> json) {
    OfertaGUID = json['OfertaGUID'].toString();
    usuGUID = json['usuGUID'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OfertaGUID'] = this.OfertaGUID;
    data['usuGUID'] = this.usuGUID;
    return data;
  }
}
