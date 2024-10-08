import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';
import '../auth/login/login_controller.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class MofferController extends GetxController {
  final LoginController _loginController = Get.find();
  final TextEditingController txtTitulo = TextEditingController();
  final TextEditingController txtDescricao = TextEditingController();
  final TextEditingController txtQtdDispo = TextEditingController();
  final TextEditingController txtQtdMaxPorVenda = TextEditingController();
  final TextEditingController txtQtdAviso = TextEditingController();
  //final MaskedTextController    txtCEP                  = MaskedTextController(mask: '00000-000');
  final TextEditingController txtCepDistancia = TextEditingController();
  final TextEditingController txtMarca = TextEditingController();
  final TextEditingController txtTempoEntrega = TextEditingController();
  final TextEditingController txtUrlMainImage = TextEditingController();
  final TextEditingController txtCores = TextEditingController();
  final TextEditingController txtTamanhos = TextEditingController();
  final TextEditingController txtDetalhes = TextEditingController();
  final TextEditingController txtPesoPorcaoUn = TextEditingController();
  final TextEditingController txtSabor = TextEditingController();
  final TextEditingController txtValidade = TextEditingController();
  final TextEditingController txtCodigoAlt = TextEditingController();
  final TextEditingController txtValorSinalOrc = TextEditingController();
  final TextEditingController txtValorMin = TextEditingController();
  final TextEditingController txtValorTaxa1km = TextEditingController();
  final TextEditingController txtValorTaxa2km = TextEditingController();
  final TextEditingController txtValorTaxaMaisQue2km = TextEditingController();
  final TextEditingController txtPesoPorcao = TextEditingController();
  final TextEditingController txtCEP = TextEditingController();
  final TextEditingController txtPreco = TextEditingController();

  String valSegDas = '08:00';
  String valSegAs = '18:00';
  String valTerDas = '08:00';
  String valTerAs = '18:00';
  String valQuaDas = '08:00';
  String valQuaAs = '18:00';
  String valQuiDas = '08:00';
  String valQuiAs = '18:00';
  String valSexDas = '08:00';
  String valSexAs = '18:00';
  String valSabDas = '08:00';
  String valSabAs = '18:00';
  String valDomDas = '08:00';
  String valDomAs = '18:00';

  String valEntregaDas = '08:00';
  String valEntregaAs = '18:00';
  DateTime valEncomendasAPartir = DateTime.now();
  DateTime valEntregasAPartir = DateTime.now();

  // final MaskedTextController   txtSegDas            = MaskedTextController(mask: '08:00');
  // final MaskedTextController   txtSegAs             = MaskedTextController(mask: '18:00');
  // final MaskedTextController   txtTerDas            = MaskedTextController(mask: '08:00');
  // final MaskedTextController   txtTerAs             = MaskedTextController(mask: '18:00');
  // final MaskedTextController   txtQuaDas            = MaskedTextController(mask: '08:00');
  // final MaskedTextController   txtQuaAs             = MaskedTextController(mask: '18:00');
  // final MaskedTextController   txtQuiDas            = MaskedTextController(mask: '08:00');
  // final MaskedTextController   txtQuiAs             = MaskedTextController(mask: '18:00');
  // final MaskedTextController   txtSexDas            = MaskedTextController(mask: '08:00');
  // final MaskedTextController   txtSexAs             = MaskedTextController(mask: '18:00');
  // final MaskedTextController   txtSabDas            = MaskedTextController(mask: '08:00');
  // final MaskedTextController   txtSabAs             = MaskedTextController(mask: '18:00');
  // final MaskedTextController   txtDomDas            = MaskedTextController(mask: '08:00');
  // final MaskedTextController   txtDomAs             = MaskedTextController(mask: '18:00');

  // final MaskedTextController   txtEntregaDas        = MaskedTextController(mask: '08:00');
  // final MaskedTextController   txtEntregaAs         = MaskedTextController(mask: '18:00');
  // final MaskedTextController   txtEncomendasAPartir = MaskedTextController(mask: '00/00/0000');
  // final MaskedTextController   txtEntregasAPartir   = MaskedTextController(mask: '00/00/0000');

  late String? mofferGuid = '';
  late String? lojaGuid = '';
  // late String? lojaNome = '';
  // late Lojas? loja;
  late Oferta? singleOffer;
  bool isLoading = false;
  List<Oferta> moffers = [];
  OfferRepository offerRepository = OfferRepository();

  @override
  void onInit() async {
    // txtCEP.text = _loginController.usuCep.toString();
    super.onInit();
  }

  @override
  void onClose() {
    // searchProductController.dispose();
    super.onClose();
  }

  Future<void> getMoffers(String sellerGuid) async {
    try {
      changeLoading(true);
      moffers = await offerRepository.getOfferBySellerGuid(sellerGuid);
    } catch (e, stackTrace) {
      changeLoading(false);
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
      print('Erro no getMOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getMoffersByStore(String storeGuid) async {
    try {
      changeLoading(true);
      moffers = await offerRepository.getOffersByStore(storeGuid);
    } catch (e, stackTrace) {
      changeLoading(false);
      FirebaseCrashlytics.instance.recordError(
          'Erro no getMoffersByStore() controller ${e.toString()}', stackTrace);
    } finally {
      changeLoading(false);
    }
  }

  Future<List<Lojas>> getStores(String sellerGuid) async {
    //List<Lojas> retLojas = [];

    // try {
    //   changeLoading(true);
    //   retLojas = await StoreRepository().getAllStores(sellerGuid);
    // } catch (e) {
    //   print('Erro no carregaLojas() controller ${e.toString()}');
    // } finally {
    //   changeLoading(false);
    // }

    return _loginController.listLojas;
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Future<void> apagaMoffer(String OfertaGuid) async {
    try {
      changeLoading(true);
      await offerRepository.deleteOfferByGuidFromApi(OfertaGuid);
    } catch (e, stackTrace) {
      changeLoading(false);
      FirebaseCrashlytics.instance.recordError(
          'Erro no apagaMoffer() controller ${e.toString()}', stackTrace);
    } finally {
      changeLoading(false);
    }
  }

  Future<void> markOfferSold(String? ofertaGuid) async {
    try {
      changeLoading(true);
      await offerRepository.markOfferAsSold(ofertaGuid.toString());
      this.refresh();
    } catch (e, stackTrace) {
      changeLoading(false);
      FirebaseCrashlytics.instance.recordError(
          'Erro no markOfferSold() controller ${e.toString()}', stackTrace);
    } finally {
      changeLoading(false);
    }
  }

  Future<void> markOfferAvailable(String? ofertaGuid) async {
    try {
      changeLoading(true);
      await offerRepository.reactivateOffer(ofertaGuid.toString());
      this.refresh();
    } catch (e, stackTrace) {
      changeLoading(false);
      FirebaseCrashlytics.instance.recordError(
          'Erro no markOfferAvailable() controller ${e.toString()}',
          stackTrace);
    } finally {
      changeLoading(false);
    }
  }
}
