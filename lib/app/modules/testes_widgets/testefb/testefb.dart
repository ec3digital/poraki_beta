import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/data/models/usuario.dart';

import '../../../services/fbporaki_service.dart';

class TesteFb extends StatefulWidget {
  @override
  _TesteFb createState() => _TesteFb();
}

class _TesteFb extends State<TesteFb> {
  List<String> listStrings = <String>["Nenhum registro carregado"];
  Uri url = Uri.https("ec3digrepo-default-rtdb.firebaseio.com", "/words.json");
  Uri urlAkiChats = Uri.https("ec3digrepo-default-rtdb.firebaseio.com", "/akichats.json");

  TextEditingController _textController = TextEditingController();
  bool _isLoading = false;



  // bool isLoading = false;

//var url =
//   "https://ec3digrepo-default-rtdb.firebaseio.com/";

// var url = Uri.https(
//     "realtimedb-test-bfe20-default-rtdb.firebaseio.com",
//     "/words",
//     {'q': '{http}'},
//   );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: Container(
          //height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: (_isLoading) ? CircularProgressIndicator() :
            RefreshIndicator(onRefresh: () => _getInfoFromBack(),
              child: ListView(
                children: [
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "Digite uma palavra: "),
                    textAlign: TextAlign.center,
                    controller: _textController,
                  ),
                  ElevatedButton(
                      onPressed: () => _addOferta(), // _addUsuario(), // _addStringToBack(),
                      child: Text("Salvar"),
                  ),
                  for (String s in listStrings) Text(s, textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _addText() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   http.post(url, body: json.encode({"word": _textController.text})).then(
  //         (value) {
  //       _getInformation(context).then((value) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         _textController.text = "";
  //       });
  //     },
  //   );
  // }

  Future<void> _getInfoFromBack(){
    return http.get(url).then((response) {
     Map<String, dynamic> map = json.decode(response.body);
     listStrings = [];
     map.forEach((key, value) {
       setState(() {
         listStrings.add(map["word"]);
       });
     });
    });
  }

  void _addUsuario() async {
    FirebaseFirestore? _fbInstance;
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    print('_addUsuario antes');
    _fbInstance = FirebaseFirestore.instance;
    var user = new Usuario(whatsapp: '123456', email: 'fulano@email.com', cpf: '11111111', cep: '05735030',sobrenome: 'da Silva',nome: 'Fulano');
    await _fbInstance.collection('akiusuarios').doc().set(user.toFirestore()).then((value) => print('_addUsuario depois'));
  }

  void _addOferta() async {
    FirebaseFirestore? _fbInstance;
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    print('_addOferta antes');
    _fbInstance = FirebaseFirestore.instance;
    var offer = new Oferta(null, 'CONGELADOS', 'eyCv21RfaURoMn0SUndCg6LPyJP2', 'Nhoque', 'Batata', 20, null, null, null, null, 1, '05735-030', null, null, 0, 0, 0, 50, null, '1231321321', 0, 0, 0, 0, 'KG', 10, 0, false, false, true, false, false, 50, 'minutos', 'whatsapp', null, null, null, null, null, null, false, 5, null, null, null, null, null, null, null, true, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, false, false, false, false, false, true);

    await _fbInstance.collection('akiofertas').doc('057').collection('ofertas').add(offer.toJsonPost()); // .set(offer.toJsonPost()).then((value) => print('_addOferta depois'));
  }

  void _addStringToBack() {
    setState(() {
      this._isLoading = true;
    });
    http
        .post(
          url,
          body: json.encode({"word": _textController.text}),
        )
        .then((value) {
      _getInfoFromBack().then((value) {
        setState(() {
          this._isLoading = false;
        });

        _textController.text = "";

        final snackBar = SnackBar(
          content: Text("Palavra gravada com sucesso !"),
          action: SnackBarAction(
            label: "Dispensar",
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    });
  }
}
//
//   Future<void> _getInformation(BuildContext context) async {
//     //await Future.delayed(Duration(seconds: 2));
//     return http.get(Uri.parse(url)).then((value) {
//       Map<String, dynamic> map = json.decode(value.body);
//       this.listString = [];
//       for (String key in map.keys) {
//         setState(() {
//           this.listString.add(map[key]["word"]);
//         });
//       }
//     });
//   }
// }
