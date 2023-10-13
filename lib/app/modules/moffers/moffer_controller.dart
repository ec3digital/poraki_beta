import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';
import 'package:poraki/app/data/repositories/store_repository.dart';
import '../../data/models/categorias.dart';
import '../../data/repositories/categories_repository.dart';
import '../auth/login/login_controller.dart';

class MofferController extends GetxController {
  final LoginController _loginController = Get.find();
  final TextEditingController   txtTitulo               = TextEditingController();
  final TextEditingController   txtDescricao            = TextEditingController();
  final TextEditingController   txtQtdDispo             = TextEditingController();
  final TextEditingController   txtQtdMaxPorVenda       = TextEditingController();
  final TextEditingController   txtQtdAviso             = TextEditingController();
  //final MaskedTextController    txtCEP                  = MaskedTextController(mask: '00000-000');
  final TextEditingController   txtCepDistancia         = TextEditingController();
  final TextEditingController   txtMarca                = TextEditingController();
  final TextEditingController   txtTempoEntrega         = TextEditingController();
  final TextEditingController   txtUrlMainImage         = TextEditingController();
  final TextEditingController   txtCores                = TextEditingController();
  final TextEditingController   txtTamanhos             = TextEditingController();
  final TextEditingController   txtDetalhes             = TextEditingController();
  final TextEditingController   txtPesoPorcaoUn         = TextEditingController();
  final TextEditingController   txtSabor                = TextEditingController();
  final TextEditingController   txtValidade             = TextEditingController();
  final TextEditingController   txtCodigoAlt            = TextEditingController();
  final TextEditingController   txtValorSinalOrc        = TextEditingController();
  final TextEditingController   txtValorMin             = TextEditingController();
  final TextEditingController   txtValorTaxa1km         = TextEditingController();
  final TextEditingController   txtValorTaxa2km         = TextEditingController();
  final TextEditingController   txtValorTaxaMaisQue2km  = TextEditingController();
  final TextEditingController   txtPesoPorcao           = TextEditingController();
  final TextEditingController   txtCEP                  = TextEditingController();
  final TextEditingController   txtPreco                = TextEditingController();


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
    // print('getMoffers / sellerGuid = ' + sellerGuid);
    try {
      changeLoading(true);
      moffers = await offerRepository.getOfferBySellerGuid(sellerGuid);
      // print('getMoffers result - ' + moffers.toString());
    } catch (e) {
      changeLoading(false);
      print('Erro no getMOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getMoffersByStore(String storeGuid) async {
    print('getMoffersByStore / storeGuid = ' + storeGuid);
    try {
      changeLoading(true);
      moffers = await offerRepository.getOffersByStore(storeGuid);
      // print('getMoffers result - ' + moffers.toString());
    } catch (e) {
      changeLoading(false);
      // print('Erro no getMOffers() controller ${e.toString()}');
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

  // Future<void> getMoffer() async {
  //   try {
  //     changeLoading(true);
  //     moffers = await offerRepository.getOfferBySellerGuid(SellerGuid)
  //     print('getMoffers result - ' + moffers.toString());
  //   } catch (e) {
  //     changeLoading(false);
  //     print('Erro no getMOffers() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Future<void> apagaMoffer(String OfertaGuid) async {
    print('apagaMoffer / OfertaGuid = ' + OfertaGuid);
    try {
      changeLoading(true);
      await offerRepository.deleteOfferByGuidFromApi(OfertaGuid);
      // print('getMoffers result - ' + moffers.toString());
    } catch (e) {
      changeLoading(false);
      // print('Erro no getMOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }

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

  Future<void> markOfferSold(String? ofertaGuid) async {
    try {
      changeLoading(true);
      print('entrou no markOfferSold $ofertaGuid');
      await offerRepository.markOfferAsSold(ofertaGuid.toString());
      this.refresh();
    } catch (e) {
      print('Erro no markOfferSold() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> markOfferAvailable(String? ofertaGuid) async {
    try {
      changeLoading(true);
      print('entrou no markOfferAvailable $ofertaGuid');
      await offerRepository.reactivateOffer(ofertaGuid.toString());
      this.refresh();
    } catch (e) {
      print('Erro no markOfferSold() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

}