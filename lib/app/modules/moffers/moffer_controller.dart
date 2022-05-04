import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';
import 'package:poraki/app/data/repositories/store_repository.dart';
import '../../data/models/categorias.dart';
import '../../data/repositories/categories_repository.dart';

class MofferController extends GetxController {

  final TextEditingController   txtTitulo               = TextEditingController();
  final TextEditingController   txtDescricao            = TextEditingController();
  final TextEditingController   txtPreco                = TextEditingController();
  final TextEditingController   txtQtdDispo             = TextEditingController();
  final TextEditingController   txtQtdMaxPorVenda       = TextEditingController();
  final TextEditingController   txtQtdAviso             = TextEditingController();
  final TextEditingController   txtCep                  = TextEditingController();
  final TextEditingController   txtCepDistancia         = TextEditingController();
  final TextEditingController   txtMarca                = TextEditingController();
  final TextEditingController   txtValorMin             = TextEditingController();
  final TextEditingController   txtValorTaxa1km         = TextEditingController();
  final TextEditingController   txtValorTaxa2km         = TextEditingController();
  final TextEditingController   txtValorTaxaMaisQue2km  = TextEditingController();
  final TextEditingController   txtTempoEntrega         = TextEditingController();
  final TextEditingController   txtUrlMainImage         = TextEditingController();
  final TextEditingController   txtCores                = TextEditingController();
  final TextEditingController   txtTamanhos             = TextEditingController();
  final TextEditingController   txtDetalhes             = TextEditingController();
  final TextEditingController   txtPesoPorcao           = TextEditingController();
  final TextEditingController   txtPesoPorcaoUn         = TextEditingController();
  final TextEditingController   txtSabor                = TextEditingController();
  final TextEditingController   txtValidade             = TextEditingController();
  final TextEditingController   txtValorSinalOrc        = TextEditingController();
  final TextEditingController   txtCodigoAlt            = TextEditingController();

  final MaskedTextController   txtSegDas            = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtSegAs             = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtTerDas            = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtTerAs             = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtQuaDas            = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtQuaAs             = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtQuiDas            = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtQuiAs             = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtSexDas            = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtSexAs             = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtSabDas            = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtSabAs             = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtDomDas            = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtDomAs             = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtEntregaDas        = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtEntregaAs         = MaskedTextController(mask: '00:00');
  final MaskedTextController   txtEncomendasAPartir = MaskedTextController(mask: '00/00/0000');
  final MaskedTextController   txtEntregasAPartir   = MaskedTextController(mask: '00/00/0000');

  late String? mofferGuid = '';
  late Oferta? singleOffer;
  bool isLoading = false;
  List<Oferta> moffers = [];
  OfferRepository offerRepository = OfferRepository();

  MofferController();


  @override
  void onClose() {
    // searchProductController.dispose();
    super.onClose();
  }

  Future<void> getMoffers(String sellerGuid) async {
    print('getMoffers / sellerGuid = ' + sellerGuid);
    try {
      changeLoading(true);
      moffers = await offerRepository.getOfferBySellerGuid(sellerGuid);
      // print('getMoffers result - ' + moffers.toString());
    } catch (e) {
      changeLoading(false);
      // print('Erro no getMOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getMoffersByStore(String storeGuid) async {
    print('getMoffersByStore / storeGuid = ' + storeGuid);
    try {
      changeLoading(true);
      moffers = await offerRepository.getOfferByStoreGuid(storeGuid);
      // print('getMoffers result - ' + moffers.toString());
    } catch (e) {
      changeLoading(false);
      // print('Erro no getMOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<List<Lojas>> getStores(String sellerGuid) async {
    List<Lojas> retLojas = [];
    try {
      changeLoading(true);
      retLojas = await StoreRepository().getAllStores(sellerGuid);
    } catch (e) {
      print('Erro no carregaLojas() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }

    return retLojas;
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


}