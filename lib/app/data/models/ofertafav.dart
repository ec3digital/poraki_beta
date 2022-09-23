class OfertasFavs {
  String? OfertaGUID;
  String? usuGUID;
  bool add = false;
  bool del = false;

  OfertasFavs(this.OfertaGUID, this.usuGUID, this.add, this.del);

  OfertasFavs.fromJson(Map<String, dynamic> json) {
    OfertaGUID = json['OfertaGUID'].toString();
    usuGUID = json['usuGUID'].toString();
    add = false;
    del = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OfertaGUID'] = this.OfertaGUID;
    data['usuGUID'] = this.usuGUID;
    return data;
  }
}
