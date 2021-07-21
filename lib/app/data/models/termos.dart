import 'package:cloud_firestore/cloud_firestore.dart';

class Termo {
  final String termotexto;

  Termo({required this.termotexto});

  factory Termo.fromDocument(DocumentSnapshot doc) {
    return Termo(termotexto: doc['termotexto']);
  }
}
