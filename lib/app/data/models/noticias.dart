import 'package:cloud_firestore/cloud_firestore.dart';

class Noticia {
  int? NoticiaID;
  String? NoticiaCEP;
  Timestamp? NoticiaDesde;
  String? NoticiaAte;
  String? NoticiaPor;
  String? NoticiaUID;
  String? NoticiaTitulo;
  String? NoticiaTexto;
  String? NoticiaFonte;

  Noticia(this.NoticiaID,this.NoticiaCEP,this.NoticiaDesde,this.NoticiaAte,this.NoticiaPor,this.NoticiaUID,this.NoticiaTitulo,this.NoticiaTexto,this.NoticiaFonte);

  Noticia.fromJson(Map<String, dynamic> json) {
    NoticiaFonte = json['NoticiaFonte'];
    NoticiaTexto = json['NoticiaTexto'];
    NoticiaTitulo = json['NoticiaTitulo'];
    NoticiaUID = json['NoticiaUID'];
    NoticiaPor = json['NoticiaPor'];
    NoticiaAte = json['NoticiaAte'];
    NoticiaDesde = Timestamp.fromDate(DateTime.parse(json['NoticiaDesde']));
    NoticiaCEP = json['NoticiaCEP'];
    //NoticiaID = int.parse(json['NoticiaID']);
  }

}