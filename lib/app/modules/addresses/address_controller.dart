import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/enderecos.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:poraki/app/data/repositories/address_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_address_service.dart';

class AddressController extends GetxController {
  // enderecoGuid;
  // final String  usuEmail;
  // final String  usuGuid;
  MaskedTextController txtCEP = MaskedTextController(mask: '00000-000');
  final TextEditingController txtEnderecoLogra = TextEditingController();
  final TextEditingController txtEnderecoNumero = TextEditingController();
  final TextEditingController? txtEnderecoCompl = TextEditingController();
  final TextEditingController txtEnderecoTipo = TextEditingController();
  // final int     txtEnderecoAtual;
  // final String? txtEnderecoUltData;
  // final String? txtEnderecoDesde;

  // AddressRepository addressRepository = AddressRepository();
  bool isLoading = false;
  // final formKey = GlobalKey<FormState>();

  //List<Enderecos> listaEnderecos = [];
  //late sqlEndereco enderecoSingle;
  Enderecos? enderecoSingle;
  late FirebaseFirestore? fbInstance;
  // late Enderecos selEndereco;
  AddressRepository repo = new AddressRepository();
  LoginController _login = Get.find();

  // Future<void> getAllCategories() async {
  //   try {
  //     changeLoading(true);
  //     categorias = await categoriesRepository.getAllCategories();
  //   } catch (e) {
  //     print('Erro no getAllCategories() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }

  @override
  void initState() {}

  @override
  void onInit() async {
    super.onInit();

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    fbInstance = _login.fbInstance;

  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  // @override
  // void onInit() async {
  //   await carregaUsuario();
  //   super.onInit();
  // }

  Future<void> bindEndereco(String? endGuid) async {
    if (endGuid!.isNotEmpty) {
      // enderecoSingle = enderecos.where((end) => end.enderecoGuid == endGuid).first;
      // txtEnderecoLogra.text = enderecoSingle.enderecoLogra.toString();
      // txtEnderecoNumero.text = enderecoSingle.enderecoNumero.toString();
      // txtEnderecoTipo.text = enderecoSingle.enderecoTipo.toString();
      // txtCEP.text = enderecoSingle.enderecoCEP.toString();

      print('bindEndereco endGuid: ' + endGuid);
      final end = _login.listaEnderecos
          .where((end) => end.EnderecoGuid == endGuid)
          .first;
      txtEnderecoLogra.text = enderecoSingle!.EnderecoLogra.toString();
      txtEnderecoNumero.text = enderecoSingle!.EnderecoNumero.toString();
      txtEnderecoTipo.text = enderecoSingle!.EnderecoTipo.toString();
      txtCEP.text = enderecoSingle!.EnderecoCEP.toString();

      enderecoSingle = new Enderecos(end.EnderecoGuid, end.UsuEmail, end.UsuGuid, end.EnderecoCEP, end.EnderecoLogra, end.EnderecoNumero, end.EnderecoCompl, end.EnderecoTipo, end.EnderecoAtual, end.EnderecoUltData, end.EnderecoDesde, end.EnderecoLat, end.EnderecoLong);
    } else {
      txtEnderecoLogra.text = '';
      txtEnderecoNumero.text = '';
      txtEnderecoTipo.text = '';
      txtCEP.text = '';
    }
  }

  // Future<void> carregaEnderecos() async {
  //   listaEnderecos.clear();
  //   await fbInstance!.collection("akienderecos").doc("eyCv21RfaURoMn0SUndCg6LPyJP2").collection("Enderecos").get().then((value) => value.docs.forEach((element) { listaEnderecos.add(Enderecos.fromJson(element.data())); }));
  //
  // }
  //
  // Future<sqlEndereco> retornaEnderecoAtualSqlLocal() async {
  //   print('carregaEnderecoAtual');
  //
  //   var lista = await sqlPorakiAddressService().buscaEnderecos(true);
  //   late sqlEndereco endereco;
  //   lista.forEach((item) {
  //     endereco = new sqlEndereco(
  //         item.enderecoGuid.toString(),
  //         item.usuEmail.toString(),
  //         item.enderecoGuid.toString(),
  //         item.enderecoCEP.toString(),
  //         item.enderecoLogra.toString(),
  //         item.enderecoNumero.toString(),
  //         item.enderecoCompl.toString(),
  //         item.enderecoTipo.toString(),
  //         item.enderecoAtual,
  //         item.enderecoUltData.toString(),'',''
  //         // item.enderecoLat,
  //         // item.enderecoLong.toString()
  //         //item.enderecoDesde.toString(),
  //         );
  //   });
  //
  //   return endereco;
  // }

  // Future<String> getCepAtualLocal() async {
  //   var lista = await sqlPorakiAddressService().buscaEnderecos(true);
  //   late sqlEndereco endereco;
  //   lista.forEach((item) {
  //     endereco = new sqlEndereco(
  //         item.enderecoGuid.toString(),
  //         item.usuEmail.toString(),
  //         item.enderecoGuid.toString(),
  //         item.enderecoCEP.toString(),
  //         item.enderecoLogra.toString(),
  //         item.enderecoNumero.toString(),
  //         item.enderecoCompl.toString(),
  //         item.enderecoTipo.toString(),
  //         item.enderecoAtual,
  //         item.enderecoUltData.toString(),"",""
  //         // item.enderecoLat,
  //         // item.enderecoLong.toString()
  //       //item.enderecoDesde.toString(),
  //     );
  //   });
  //
  //   print('cep atual: ' + endereco.enderecoCEP);
  //
  //   return endereco.enderecoCEP;
  // }
  //
  // Future<String?> getCepAtualCloud() async {
  //   var endereco = await repo.getCurrentAddress();
  //   return endereco.EnderecoCEP;
  // }

  Future<void> carregaEnderecoSingle(String enderecoGuid) async {
    print('carregaEnderecoSingle');
    enderecoSingle = _login.listaEnderecos.where((end) => end.EnderecoGuid == enderecoGuid).first;
    txtEnderecoLogra.text = enderecoSingle!.EnderecoLogra.toString();
    txtEnderecoNumero.text = enderecoSingle!.EnderecoNumero.toString();
    txtEnderecoTipo.text = enderecoSingle!.EnderecoTipo.toString();
    txtCEP.text = enderecoSingle!.EnderecoCEP.toString();
  }

  Future<String> getCepAtualLocal() async {
    print('getCepAtualLocal');
    return _login.listaEnderecos.where((end) => end.EnderecoAtual).first.EnderecoCEP.toString();
  }

  Future<void> atualizaEndereco(Enderecos endereco) async {
    //var obj = fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").get().then((value) => value.docs.where((end) => end.)

    //TODO: pegar o id do endereço
    String getId = '';
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").where('EnderecoGuid', isEqualTo: enderecoSingle!.EnderecoGuid).get().then((ss) => getId = ss.docs.first.id);
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").doc(getId).set(endereco.toJson());
    
    // //endereco.EnderecoUltData = DateTime.now().toString();
    // var resp = await repo.putAddress(endereco);
    //
    // //if (resp.isEmpty)
    // var sqlEnd = new sqlEndereco(endereco.EnderecoGuid.toString(), endereco.UsuEmail.toString(), endereco.UsuGuid.toString(), endereco.EnderecoCEP.toString(),
    //     endereco.EnderecoLogra.toString(), endereco.EnderecoNumero.toString(), endereco.EnderecoCompl, endereco.EnderecoTipo.toString(), endereco.EnderecoAtual,
    //     DateTime.now().toString(), endereco.EnderecoLat, endereco.EnderecoLong);
    //
    // await sqlPorakiAddressService().updateEndereco(sqlEnd);
    // // await carregaUsuario();
  }


  Future<void> adicionaEndereco(Enderecos endereco) async {
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").add(endereco.toJson());
    
    // await repo.postAddress(endereco);
    //
    // //if (resp.isEmpty)
    // var sqlEnd = new sqlEndereco(endereco.EnderecoGuid.toString(), endereco.UsuEmail.toString(), endereco.UsuGuid.toString(), endereco.EnderecoCEP.toString(),
    //     endereco.EnderecoLogra.toString(), endereco.EnderecoNumero.toString(), endereco.EnderecoCompl, endereco.EnderecoTipo.toString(), endereco.EnderecoAtual,
    //     DateTime.now().toString(), endereco.EnderecoLat, endereco.EnderecoLong);
    //
    // await sqlPorakiAddressService().insertEndereco(sqlEnd);
    // // await carregaUsuario();
  }

  Future<void> apagaEndereco(Enderecos? endereco) async {

//     final docRef = fbInstance!.collection("appointments").doc("FpS9NDSdMD2GeE9GL3i2");
//
// // Remove the 'service' field from the document
//     final updates = <String, dynamic>{
//       "service": FieldValue.delete(),
//     };
//
//     docRef.update(updates);

    String getId = '';
    final objEndereco = { 'EnderecoAtual': true };
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").where('EnderecoGuid', isEqualTo: enderecoSingle!.EnderecoGuid).get().then((ss) => getId = ss.docs.first.id);
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").doc(getId).delete();

    // endereco.EnderecoTipo = 'Inativo';
    // var resp = await repo.putAddress(endereco);
    //
    // var sqlEnd = new sqlEndereco(endereco.EnderecoGuid.toString(), endereco.UsuEmail.toString(), endereco.UsuGuid.toString(), endereco.EnderecoCEP.toString(),
    //     endereco.EnderecoLogra.toString(), endereco.EnderecoNumero.toString(), endereco.EnderecoCompl, endereco.EnderecoTipo.toString(), endereco.EnderecoAtual,
    //     DateTime.now().toString(), endereco.EnderecoLat, endereco.EnderecoLong);
    //
    // if (resp.isNotEmpty)
    //   await sqlPorakiAddressService().deleteEndereco(endereco.EnderecoGuid.toString());
    // // await carregaUsuario();
  }

  Future<void> tornarEnderecoAtual(String enderecoGuid) async {

    String getId = '';
    // print('tornarEnderecoAtual enderecoGuid: ' + enderecoGuid);
    // print('usuGuid: ' + _login.usuGuid.toString());
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").where('EnderecoGuid', isNotEqualTo: enderecoSingle!.EnderecoGuid).get().then((ss) => ss.docs.forEach((doc) { alteraFBEnderecoNAtual(doc.id); }));
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").where('EnderecoGuid', isEqualTo: enderecoSingle!.EnderecoGuid).get().then((ss) => ss.docs.forEach((doc) => getId = doc.id.toString()));
    final objEndereco = { 'EnderecoAtual': true };
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").doc(getId).update(objEndereco);
    await _login.loadAddressData();

    // print('tornarEnderecoAtual');
    // var resp = await repo.putCurrentAddress(enderecoGuid);
    // print('resp current address: ' + resp.toString());
    //
    // if (resp.isNotEmpty) {
    //   var respn = await repo.putCurrentNAddress(enderecoGuid);
    //   print('resp current naddress: ' + respn.toString());
    //
    //   if (respn.isNotEmpty)
    //     await sqlPorakiAddressService().updateEnderecoAtual(enderecoGuid);
    // }
    //
    // // await carregaUsuario();
  }

  Future<void> alteraFBEnderecoNAtual(String docId) async {
    final objEndereco = { 'EnderecoAtual': false };
    await fbInstance!.collection("akienderecos").doc(_login.usuGuid).collection("Enderecos").doc(docId).update(objEndereco);
  }

}
