// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:poraki/services/termosvc.dart';
// import 'package:poraki/shared/modelos/termos.dart';
//
// class testeCloud extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Teste Cloud',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Color(0xff543B7A),
//       ),
//       home: meuTesteCloud(),
//     );
//   }
// }
//
// class meuTesteCloud extends StatefulWidget {
//   @override
//   _meuTesteCloud createState() => _meuTesteCloud();
// }
//
// class _meuTesteCloud extends State<meuTesteCloud> {
//   late List<Termo> items;
//   FirestoreService fireServ = new FirestoreService();
//   late StreamSubscription<QuerySnapshot> streamtermos;
//
//   get fill => null;
//
//   @override
//   void initState() {
//     super.initState();
//
//     items = new List.filled(1, fill);
//
//     streamtermos?.cancel();
//     streamtermos = fireServ.getTermos().listen((QuerySnapshot snapshot) {
//       final List<Termo> tasks = snapshot.docs.single.data() as List<Termo>;
//       // .map((documentSnapshot) => Task.fromMap(documentSnapshot.data))
//       // .toList();
//
//       setState(() {
//         this.items = tasks;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: <Widget>[
//           //_myAppBar(context),
//           Container(
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width,
//             height: MediaQuery
//                 .of(context)
//                 .size
//                 .height - 80,
//             child: ListView.builder(
//                 itemCount: 1, //items.length,
//                 itemBuilder: (context, index) {
//                   return Stack(children: <Widget>[
//                     // The containers in the background
//                     Column(children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(left: 8.0, right: 8.0),
//                         child: Container(
//                           width: MediaQuery
//                               .of(context)
//                               .size
//                               .width,
//                           height: 80.0,
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//                             child: Material(
//                               color: Colors.white,
//                               elevation: 14.0,
//                               shadowColor: Color(0x802196F3),
//                               child: Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Text(
//                                         '${items[index].termotexto}',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 20.0),
//                                       ),
//                                       Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                         children: <Widget>[
//                                           Text(
//                                             '${items[index].termotexto}',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18.0,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Text(
//                                             '${items[index].termotexto}',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 16.0),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ]);
//                 }),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color(0xFFFA7397),
//         // child: Icon(
//         //   //FontAwesomeIcons.listUl,
//         //   color: Color(0xFFFDDE42),
//         // ),
//         onPressed: () {
//           //Navigator.push(context,MaterialPageRoute(builder: (context) => TaskScreen()),
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //       builder: (context) => TaskScreen(Task('', '', '', '', '')),
//           //       fullscreenDialog: true),
//           // );
//         },
//       ),
//     );
//   }
// }
