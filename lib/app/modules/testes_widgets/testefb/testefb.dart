import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesteFb extends StatefulWidget {
  @override
  _TesteFb createState() => _TesteFb();
}

class _TesteFb extends State<TesteFb> {
  List<String> listStrings = <String>["Nenhum registro carregado"];
  Uri url = Uri.https("ec3digrepo-default-rtdb.firebaseio.com", "/words.json");

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
                      onPressed: () => _addStringToBack(),
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
