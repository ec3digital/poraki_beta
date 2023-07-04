import 'dart:convert';
import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poraki/app/data/models/categorias.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/categories/categories_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/moffers/moffer_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/shared/constants/constants.dart';
import 'package:poraki/app/routes/app_routes.dart';

class BodyMoffer extends StatefulWidget {
  BodyMoffer({Key? key, required this.offer}) : super(key: key);
  final Oferta? offer;
  //final String? _offerGuid;

  @override
  _BodyMoffer createState() => _BodyMoffer();
}

class _BodyMoffer extends State<BodyMoffer> {
  File? image;
  List<String> _listaCategoriasNomes = [];
  final CategoriesController _categoriesController = Get.put(CategoriesController()); // .find();
  final MofferController _mofferController = Get.find();
  var _categSelecionada = new Categorias();
  var _imgcloud = '';
  var _offerGuid = '';
  var _imgEdited = false;
  var _priceFocusNode = FocusNode();
  var _descriptionFocusNode = FocusNode();
  var _imageURLFocusNode = FocusNode();
  var _imageURLController = TextEditingController();
  bool _isEditing = false;
  // var _form = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _load = true;
  var _revendaSel = 'selecione';
  var _categoriaSel = '';

  // var _listaRevendas = ['selecione'];
  //Categorias? catogoria;
  // var listaCategs = ['selecione']; // pegar da API
  // var _listaTempoEntregaTipo = ['selecione', 'minutos', 'horas', 'dias'];
  // var listaFormaFechamento = ['selecione'];
  // var listaFormaEntrega = ['selecione', 'vendedor', 'comprador'];
  // var listaFormaEntrega2 = ['selecione', 'vendedor', 'comprador'];
  // var listaParceiros = ['selecione'];
  // var _valueSel;
  //late String categSel = 'selecione';
  // var tempoEntregaTipoSel = 'selecione';
  // var agenteEntregaSel = 'selecione';
  // var formaFechSel = 'selecione';
  // var parceiroSel = 'escolha o parceiro';
  // var materialSel = 'selecione';
  // var voltagemSel = 'selecione';
  // var _labelEntrega = 'Entrega';
  // var _labelValidade = 'Validade';
  // bool _valAceitaEntregaComprador = false;
  // bool _valAceitaEntregaParceiro = false;
  // bool _valAceitaEntregaVendedor = false;
  //bool _valRevisao = false;
  bool _valDispoImediata = true;
  // bool _valMostraAval = false;
  // bool _valMostraReview = false;
  // bool _valAceiteAuto = false;
  bool _valAceitaEncomenda = false;
  bool _valSomenteEncomenda = false;
  // bool _valAceitaProposta = false;
  bool _val24hs = false;
  bool _valSeg = false;
  bool _valTer = false;
  bool _valQua = false;
  bool _valQui = false;
  bool _valSex = false;
  bool _valSab = false;
  bool _valDom = false;
  // bool _valQtd = false;
  bool _valSinalPercentual = false;
  bool _valPrecoCombinar = false;
  // bool _valPrecoInicial = false;

  bool showPreco = true;
  bool showDispoImediata = false;
  bool showMostraAval = false;
  bool showMostraReview = false;
  bool showAceiteAuto = false;
  bool showAceitaEncomenda = false;
  bool showSomenteEncomenda = false;
  bool showAceitaProposta = false;
  bool show24hs = false;
  // bool show_listaTempoEntregaTipo = false;
  // bool showListaFormaEntrega = false;
  // bool showListaFormaEntrega2 = false;
  // bool showListaParceiros = false;
  bool showQtd = false;
  bool showTxtQtdDispo = false;
  bool showTxtQtdMaxPorVenda = false;
  bool showTxtQtdAviso = false;
  bool showTxtCep = false;
  bool showTxtMarca = true;
  bool showTxtValorMin = false;
  // bool showTxtTempoEntrega = false;
  bool showTxtCores = false;
  bool showTxtTamanhos = false;
  // bool showTxtPesoPorcao = false;
  // bool showTxtPesoPorcaoUn = false;
  bool showTxtSabor = false;
  bool showTxtValidade = false;
  bool showTxtValorSinalOrc = false;
  bool showTxtEncomendasAPartir = false;
  bool showTxtEntregasAPartir = false;
  // bool showTxtEntregaTaxas = false;
  bool showTxtOfertaCepDistancia = true;
  bool showTxtCodigoAlt = false;

  bool showCamposBasicos = false;
  bool showCamposEntrega = false;
  bool showCamposPrecos = false;
  final LoginController _loginController = Get.find();
  late Color? textColor;
  late Color? iconColor;


  // // formatters
  // late TextFormField txtfValorSinalOrc;
  // late TextFormField txtfValorMin;
  // late TextFormField txtfValorTaxa1km;
  // late TextFormField txtfValorTaxa2km;
  // late TextFormField txtfValorTaxaMaisQue2km;
  // late TextFormField txtfPesoPorcao;
  // late TextFormField txtfCEP;
  // late TextFormField txtfPreco;


  @override
  void initState() {
    print('initState moffer');
    _imageURLFocusNode.addListener(_updateImageUrl);

    //   if(_brandsController.revendas.length == 0){
    //     _brandsController.revendas.forEach((rev) {
    //       print(rev.RevendaNome.toString());
    //       _listaRevendas.add(rev.RevendaNome.toString());
    //     });
    //     print('lista revendas: ' + _listaRevendas.length.toString());
    //   }
    // }

    // partnersController.parceiros?.forEach((part) {
    //   print(part.ParceiroEntregaNome.toString());
    //   listaParceiros.add(part.ParceiroEntregaNome.toString());
    // });
    // print('lista parceiros: ' + listaParceiros.length.toString());

    //final LoginController loginController = Get.find();
    _mofferController.txtCEP.text =
        _loginController.usuCep.toString();

    // if(_loginController.listaCategorias.length == 0)
    //   {
    //     print('listaCategorias zero');
    //
    //   }
    _loginController.listaCategorias.forEach((categ) {
      _listaCategoriasNomes.add(categ.categoriaNome!.trimRight());
    });

    //_listaCategoriasNomes.add('selecione');


    _mofferController.txtTitulo.text = '';
    // _mofferController.txtValorTaxa1km.text = '0.00';
    // _mofferController.txtValorTaxaMaisQue2km.text = '0.00';
    // _mofferController.txtValorTaxa2km.text = '0.00';
    _mofferController.txtCodigoAlt.text = '';
    _mofferController.txtCepDistancia.text = '0';
    // _mofferController.txtValorSinalOrc.text = '0.00';
    _mofferController.txtValidade.text = '0';
    // _mofferController.txtPesoPorcao.text = '0.00';
    // _mofferController.txtPesoPorcaoUn.text = '';
    _mofferController.txtDescricao.text = '';
    _mofferController.txtDetalhes.text = '';
    _mofferController.txtTamanhos.text = '';
    _mofferController.txtCores.text = '';
    // _mofferController.txtPreco.text = '0.00';
    // _mofferController.txtValorMin.text = '0.00';
    // _mofferController.txtMarca.text = '';
    _mofferController.txtQtdMaxPorVenda.text = '0';
    _mofferController.txtQtdDispo.text = '0';
    _mofferController.txtQtdAviso.text = '0';

    if (_mofferController.singleOffer == null) _manageCampos();

    //_manageCampos();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageURLFocusNode.removeListener(_updateImageUrl);
    _imageURLFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build moffer');
    //if (ModalRoute.of(context)?.settings.arguments != null) {}

    textColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());
    iconColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'backDark')
        .first
        .coreValor
        .toString());

    if(_mofferController.singleOffer != null) carregaObj();


    // return FutureBuilder(
    //     future: carregaObj(),
    //     // ModalRoute.of(context)?.settings.arguments != null
    //     //     ? carregaObjs()
    //     //     : null, // _categoriesController.getCategoriesNames(),
    //     builder: (context, futuro) {
    //       if (futuro.connectionState == ConnectionState.waiting) {
    //         return Center(
    //             child: CircularProgressIndicator()); //Text('carrinho vazio'));
    //         // } else if (futuro.hasError) {
    //         //   return Center(child: Text(futuro.error.toString()));
    //       } else {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(double.maxFinite, 55),
                child: AppBar(
                  elevation: 0,
                  centerTitle: false,
                  backgroundColor: _loginController.colorFromHex(_loginController.listCore
                      .where((coreItem) => coreItem.coreChave == 'backLight')
                      .first
                      .coreValor
                      .toString()),
                  title: Text(
                    'Minha oferta',
                    style: TextStyle(fontSize: 25, color: textColor),
                  ),
                ),
              ),
              //drawer: DrawerHome(0),
              body: _isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : GradientHeaderHome(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      // key: _form,
                      child: ListView(
                        children: [
                          const SizedBox(height: 20),
                          Text('Categoria'),
                          DropdownButton<String>(
                            items: _listaCategoriasNomes
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _categoriaSel == ''
                                ? null
                                : _categoriaSel,
                            onChanged: (String? newValue) async {
                              print('_categSelecionada: ' + newValue!);
                              if (newValue.isNotEmpty) {
                                _categoriaSel =
                                    newValue.toString();
                                _categSelecionada = await _categoriesController
                                    .selecionaCategoriaPorNome(
                                    newValue.toString())
                                as Categorias;

                                setState(() {
                                  _manageCampos();
                                });
                              }
                            },
                          ),

                          //
                          // ListTile(
                          //   leading: Text('Categoria'),
                          //   trailing: ModalRoute.of(context)
                          //               ?.settings
                          //               .arguments ==
                          //           null
                          //       ? DropdownButton<String>(
                          //           items: _listaCategoriasNomes
                          //               .map((String value) {
                          //             return DropdownMenuItem<String>(
                          //               value: value,
                          //               child: Text(value),
                          //             );
                          //           }).toList(),
                          //           value: _categoriaSel == ''
                          //               ? null
                          //               : _categoriaSel,
                          //           onChanged: (String? newValue) async {
                          //             print('_categSelecionada: ' + newValue!);
                          //             if (newValue.isNotEmpty) {
                          //               _categoriaSel =
                          //                   newValue.toString();
                          //               _categSelecionada = await widget
                          //                       ._categoriesController
                          //                       .selecionaCategoriaPorNome(
                          //                           newValue.toString())
                          //                   as Categorias;
                          //
                          //               setState(() {
                          //                 _manageCampos();
                          //               });
                          //             }
                          //
                          //
                          //           },
                          //         )
                          //       : Text(_categoriaSel.toString()),
                          // ),

                          const SizedBox(height: 20),

                          if (showCamposBasicos)
                            Column(
                              children: <Widget>[
                                TextFormField(
                                  controller:
                                  _mofferController.txtTitulo,
                                  decoration: InputDecoration(
                                      labelText: 'Titulo',
                                      border: OutlineInputBorder(),
                                      filled: true),
                                  // textInputAction: TextInputAction.next,
                                  // onFieldSubmitted: (_) {
                                  //   FocusScope.of(context)
                                  //       .requestFocus(_priceFocusNode);
                                  // },
                                  validator: (value) {
                                    bool isValid =
                                        value.toString().trimRight().length <
                                            3;
                                    if (isValid)
                                      return 'Informe um titulo valido';
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller:
                                  _mofferController.txtDescricao,
                                  decoration: InputDecoration(
                                    labelText: 'Descrição',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                  keyboardType: TextInputType.multiline,
                                ),
                                CheckboxListTile(controlAffinity: ListTileControlAffinity.leading, title: Text('Preco à combinar'), value:
                                _valPrecoCombinar,
                                onChanged: (val) {
                                          setState(() {
                                            _valPrecoCombinar = val!;
                                          });
                                        },
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     Checkbox(
                                //       value: _valPrecoCombinar,
                                //       onChanged: (val) {
                                //         setState(() {
                                //           _valPrecoCombinar = val!;
                                //         });
                                //       },
                                //       activeColor: Colors.blue,
                                //     ),
                                //     const SizedBox(width: 20),
                                //     Text('Preco à combinar'),
                                //     const SizedBox(height: 20)
                                //   ],
                                // ),
                              ],
                            ),

                          if (showPreco && !_valPrecoCombinar)
                            Column(
                              children: <Widget>[
                                // Row(
                                //   children: <Widget>[
                                //     Switch(
                                //         value: valPrecoInicial,
                                //         onChanged: (bool _val) {
                                //           setState(() {
                                //             valPrecoInicial = val;
                                //           });
                                //         }),
                                //     const SizedBox(width: 20),
                                //     Text(valPrecoInicial
                                //         ? 'Preco à partir de'
                                //         : 'Preço fechado'),
                                //     const SizedBox(height: 20),
                                //   ],
                                // ),
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CentavosInputFormatter(),
                                  ],
                                  controller:
                                  _mofferController.txtPreco,
                                  // initialValue: '0',

                                  decoration: InputDecoration(
                                    labelText: 'Preço',
                                    prefix: Text('R\$ '),
                                    border: OutlineInputBorder(),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  focusNode: _priceFocusNode,
                                  keyboardType:
                                  TextInputType.numberWithOptions(
                                      decimal: true),
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(
                                        _descriptionFocusNode);
                                  },
                                  validator: (value) {
                                    double xPreco = double.parse(value
                                        .toString()
                                        .replaceAll('.', '')
                                        .replaceAll(',', '.'));
                                    if (xPreco <= 0 &&
                                        !_valPrecoCombinar)
                                      return 'Valor precisa ser maior do que zero, ou marque como Preço à combinar';
                                    return null;
                                  },
                                ),

                                // if (showTxtValorSinalOrc)
                                //   Column(children: <Widget>[
                                //     const SizedBox(width: 20),
                                //     Row(
                                //       children: <Widget>[
                                //         Switch(
                                //             value: valSinalPercentual,
                                //             onChanged: (bool _val) {
                                //               setState(() {
                                //                 valSinalPercentual =
                                //                     val;
                                //               });
                                //             }),
                                //         const SizedBox(width: 20),
                                //         Text(valSinalPercentual
                                //             ? 'Sinal em Percentual (opcional)'
                                //             : 'Sinal em valor cheio (opcional)'),
                                //         const SizedBox(height: 20)
                                //       ],
                                //     ),
                                //     TextFormField(
                                //         inputFormatters: [
                                //           FilteringTextInputFormatter
                                //               .digitsOnly,
                                //           CentavosInputFormatter(),
                                //         ],
                                //         // initialValue: '0',
                                //         controller: _mofferController
                                //             .txtValorSinalOrc,
                                //         decoration: InputDecoration(
                                //             prefix: Text(
                                //                 valSinalPercentual
                                //                     ? '%'
                                //                     : 'R\$ '),
                                //             border: OutlineInputBorder(),
                                //             labelText:
                                //                 'Valor Sinal/Orçamento'),
                                //         keyboardType: TextInputType.number),
                                //     const SizedBox(width: 20),
                                //   ]),

                                // if (showAceitaProposta)
                                //   Row(
                                //     children: <Widget>[
                                //       Switch(
                                //           value: valAceitaProposta,
                                //           onChanged: (bool _val) {
                                //             setState(() {
                                //               valAceitaProposta = val;
                                //             });
                                //           }),
                                //       const SizedBox(width: 20),
                                //       Text('Aceita contra proposta'),
                                //     ],
                                //   ),
                                //
                                // if (valAceitaProposta)
                                //   Column(children: <Widget>[
                                //     const SizedBox(height: 10),
                                //     TextFormField(
                                //       inputFormatters: [
                                //         FilteringTextInputFormatter
                                //             .digitsOnly,
                                //         CentavosInputFormatter(),
                                //       ],
                                //       // initialValue: '0',
                                //       controller:
                                //           _mofferController.txtValorMin,
                                //       decoration: InputDecoration(
                                //         labelText: 'Valor mín',
                                //         prefix: Text('R\$ '),
                                //         border: OutlineInputBorder(),
                                //       ),
                                //       keyboardType:
                                //           TextInputType.numberWithOptions(
                                //               decimal: true),
                                //     ),
                                //   ]),

                                // if (showTxtValorSinalOrc)
                              ],
                            ),

                          // if (showQtd && showCamposBasicos)
                          //   Column(
                          //     children: <Widget>[
                          //       Row(
                          //         children: <Widget>[
                          //           Switch(
                          //               value: valQtd,
                          //               onChanged: (bool _val) {
                          //                 setState(() {
                          //                   valQtd = val;
                          //                 });
                          //               }),
                          //           const SizedBox(width: 20),
                          //           Text(valQtd
                          //               ? 'Controla quantidade'
                          //               : 'Sem controle de quantidade'),
                          //           const SizedBox(height: 10)
                          //         ],
                          //       ),
                          //       if (valQtd)
                          //         Column(children: <Widget>[
                          //           const SizedBox(height: 10),
                          //           TextFormField(
                          //             controller:
                          //                 _mofferController.txtQtdDispo,
                          //             decoration: InputDecoration(
                          //               labelText: 'Qtd disponível',
                          //               border: OutlineInputBorder(),
                          //             ),
                          //             keyboardType: TextInputType.number,
                          //             validator: (value) {
                          //               int xQtdDispo =
                          //                   int.parse(value.toString());
                          //               if (xQtdDispo <= 0)
                          //                 return 'Quantidade disponível precisa ser maior do que zero, ou marque como Sem controle de quantidade';
                          //               return null;
                          //             },
                          //           ),
                          //           const SizedBox(height: 20),
                          //           TextFormField(
                          //             controller: widget
                          //                 ._mofferController.txtQtdMaxPorVenda,
                          //             decoration: InputDecoration(
                          //               labelText: 'Qtd máxima por venda',
                          //               border: OutlineInputBorder(),
                          //             ),
                          //             keyboardType: TextInputType.number,
                          //           ),
                          //           const SizedBox(
                          //             height: 20,
                          //           ),
                          //           TextFormField(
                          //             controller:
                          //                 _mofferController.txtQtdAviso,
                          //             decoration: InputDecoration(
                          //               labelText: 'Qtd aviso acabando',
                          //               border: OutlineInputBorder(),
                          //             ),
                          //             keyboardType: TextInputType.number,
                          //           ),
                          //         ]),
                          //     ],
                          //   ),
                          //
                          // if (showTxtPesoPorcao)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20),
                          //     TextFormField(
                          //         inputFormatters: [
                          //           FilteringTextInputFormatter.digitsOnly,
                          //           PesoInputFormatter(),
                          //         ],
                          //         controller:
                          //             _mofferController.txtPesoPorcao,
                          //         decoration: InputDecoration(
                          //           labelText: 'Peso/Porção',
                          //           border: OutlineInputBorder(),
                          //         ),
                          //         keyboardType: TextInputType.number),
                          //   ]),
                          //
                          // if (showTxtPesoPorcaoUn)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20),
                          //     TextFormField(
                          //         controller:
                          //             _mofferController.txtPesoPorcaoUn,
                          //         decoration: InputDecoration(
                          //           labelText: 'Peso/Porção Unidade',
                          //           border: OutlineInputBorder(),
                          //         ),
                          //         validator: (value) {
                          //           double xPeso = double.parse(widget
                          //               ._mofferController.txtPesoPorcao
                          //               .toString()
                          //               .replaceAll('.', '')
                          //               .replaceAll(',', '.'));
                          //           if (xPeso > 0 && value.toString() == '')
                          //             return 'Favor informar uma unidade de peso';
                          //           return null;
                          //         },
                          //         keyboardType: TextInputType.text),
                          //
                          //     // if (showTxtSabor)
                          //     //   TextFormField(
                          //     //       controller: _mofferController.txtSabor,
                          //     //       decoration: InputDecoration(labelText: 'Sabores divididos por /'),
                          //     //       keyboardType: TextInputType.multiline),
                          //   ]),
                          //
                          // if (showTxtValidade)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20),
                          //     TextFormField(
                          //         controller:
                          //             _mofferController.txtValidade,
                          //         decoration: InputDecoration(
                          //             suffix: Text('dias'),
                          //             border: OutlineInputBorder(),
                          //             labelText: _labelValidade +
                          //                 ' (ex: 5 dias)'),
                          //         keyboardType: TextInputType.number),
                          //   ]),
                          //
                          // if (showTxtCep)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20),
                          //     TextFormField(
                          //       inputFormatters: [
                          //         FilteringTextInputFormatter.digitsOnly,
                          //         CepInputFormatter(),
                          //       ],
                          //       controller: _mofferController.txtCEP,
                          //       decoration: InputDecoration(
                          //         labelText: 'Cep da oferta',
                          //         fillColor: Colors.redAccent.shade100,
                          //         border: OutlineInputBorder(),
                          //       ),
                          //       keyboardType: TextInputType.number,
                          //     ),
                          //   ]),
                          //
                          // if (showTxtOfertaCepDistancia &&
                          //     showCamposBasicos)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20),
                          //     TextFormField(
                          //       controller:
                          //           _mofferController.txtCepDistancia,
                          //       decoration: InputDecoration(
                          //           suffix: Text('Km '),
                          //           border: OutlineInputBorder(),
                          //           labelText: 'Distância de ' +
                          //               _labelEntrega +
                          //               ' em Km'),
                          //       keyboardType: TextInputType.number,
                          //     ),
                          //   ]),
                          //
                          // // if (showTxtMarca)
                          // //   Column(children: <Widget>[
                          // //     const SizedBox(height: 20),
                          // //     TextFormField(
                          // //         controller:
                          // //             _mofferController.txtMarca,
                          // //         decoration: InputDecoration(
                          // //           labelText: 'Marca',
                          // //           border: OutlineInputBorder(),
                          // //         ),
                          // //         keyboardType: TextInputType.text),
                          // //   ]),

                          if (showTxtMarca)
                            Column(
                              children: <Widget>[
                                const Divider(),
                                const SizedBox(height: 10),
                                Text('Revenda'),
                                const SizedBox(height: 10),
                                DropdownButton<String>(
                                  items: _loginController.listaRevendasNomes
                                      .map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toString(),
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                   value: _revendaSel == ''
                                       ? null
                                       : _revendaSel,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _revendaSel = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),


                          // if (showTxtCodigoAlt)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20),
                          //     TextFormField(
                          //         controller:
                          //             _mofferController.txtCodigoAlt,
                          //         decoration: InputDecoration(
                          //           labelText: 'Código da revenda',
                          //           border: OutlineInputBorder(),
                          //         ),
                          //         keyboardType: TextInputType.text),
                          //   ]),

                          // if (showTxtCores)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20),
                          //     TextFormField(
                          //         decoration: InputDecoration(
                          //           labelText: 'Cores ',
                          //           hintText: '(separadas por /)',
                          //           border: OutlineInputBorder(),
                          //         ),
                          //         controller:
                          //             _mofferController.txtCores,
                          //         keyboardType: TextInputType.multiline),
                          //   ]),
                          //
                          // if (showTxtTamanhos)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20),
                          //     TextFormField(
                          //         decoration: InputDecoration(
                          //           labelText: 'Tamanhos ',
                          //           hintText: '(separados por /)',
                          //           border: OutlineInputBorder(),
                          //         ),
                          //         controller:
                          //             _mofferController.txtTamanhos,
                          //         keyboardType: TextInputType.multiline),
                          //   ]),

                          // SizedBox(height: 20),
                          // Text('Nome 1º campo personalizado'),
                          // TextFormField(
                          //   //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                          //     keyboardType: TextInputType.number),
                          // SizedBox(height: 20),
                          // Text('Valor'),
                          // TextFormField(
                          //   //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                          //     keyboardType: TextInputType.number),
                          // SizedBox(height: 20),

                          if (showCamposBasicos)
                            Column(children: <Widget>[
                              const SizedBox(height: 20),
                              TextFormField(
                                controller:
                                _mofferController.txtDetalhes,
                                decoration: InputDecoration(
                                    labelText: 'Informações adicionais',
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                              ),
                            ]),

                          // if (show24hs)
                          //   // Row(
                          //   //   children: <Widget>[
                          //   //     const SizedBox(height: 20),
                          //   SwitchListTile(controlAffinity: ListTileControlAffinity.leading,title:Text('Sempre disponível'),
                          //   value: _val24hs,
                          //           onChanged: (bool val) {
                          //             setState(() {
                          //               _val24hs = val;
                          //             });
                          //           }),
                          //   //     const SizedBox(width: 20),
                          //   //     Text('24hs'),
                          //   //     const SizedBox(height: 20),
                          //   //   ],
                          //   // ),

                          if (showDispoImediata) // && !show24hs)
                            // Row(
                            //   children: <Widget>[
                            //     const SizedBox(height: 20),
                                SwitchListTile(controlAffinity: ListTileControlAffinity.leading,title: Text(_valDispoImediata
          ? 'Sempre disponível'
              : 'Disponibilidade agendada'),
                                    value: _valDispoImediata,
                                    onChanged: (bool val) {
                                      setState(() {
                                        _valDispoImediata = val;
                                      });
                                    }),
                              //   const SizedBox(width: 20),
                              //   Expanded(
                              //     child: Text(_valDispoImediata
                              //         ? 'Disponibilidade imediata (o tempo todo)'
                              //         : 'Disponibilidade agendada'),
                              //   ),
                              //   const SizedBox(height: 20)
                              // ],
                           // ),

                          if (showDispoImediata && !_valDispoImediata)
                            Column(children: <Widget>[
                              // Row(children: <Widget>[
                              //   const SizedBox(height: 20),
                                // SEGUNDA
                                CheckboxListTile(controlAffinity: ListTileControlAffinity.leading, title: Text('Segunda'), value:
                                   _valSeg,
                                  onChanged: (val) {
                                    setState(() {
                                      _valSeg = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                // Text('segunda '),
                              // ]),

                              //const SizedBox(),
                              if (_valSeg)
                                Row(
                                  children: <Widget>[
                                    const SizedBox(height: 5, width: 5),
                                    Text('Das '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 08, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valSegDas = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valSegDas)
                                          ],
                                        )),
                                    const SizedBox(width: 5),
                                    Text(' às '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 18, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valSegAs = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valSegAs)
                                          ],
                                        )),
                                  ],
                                ),

                              // TERÇA
                              // Row(children: <Widget>[
                                CheckboxListTile(controlAffinity: ListTileControlAffinity.leading, title: Text('terça '),
                                  value: _valTer,
                                  onChanged: (val) {
                                    setState(() {
                                      _valTer = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                // Text('terça ')
                              // ]),

                              //const SizedBox(height: 5),
                              if (_valTer)
                                Row(
                                  children: <Widget>[
                                    const SizedBox(height: 5, width: 5),
                                    Text('Das '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 08, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valTerDas = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valTerDas)
                                          ],
                                        )),
                                    const SizedBox(width: 5),
                                    Text(' às '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 18, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valTerAs = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valTerAs)
                                          ],
                                        )),
                                  ],
                                ),

                              // Row(children: <Widget>[
                              CheckboxListTile(controlAffinity: ListTileControlAffinity.leading, title:Text('quarta '),
                              value: this._valQua,
                                  onChanged: (val) {
                                    setState(() {
                                      this._valQua = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                              //   Text('quarta '),
                              // ]),

                              //const SizedBox(height: 5),
                              if (_valQua)
                                Row(
                                  children: <Widget>[
                                    const SizedBox(height: 5, width: 5),
                                    Text('Das '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 08, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valQuaDas = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valQuaDas)
                                          ],
                                        )),
                                    const SizedBox(width: 5),
                                    Text(' às '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 18, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valQuaAs = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valQuaAs)
                                          ],
                                        )),
                                  ],
                                ),

                              // Row(children: <Widget>[
                              CheckboxListTile(controlAffinity: ListTileControlAffinity.leading, title: Text('quinta '),
                              value: this._valQui,
                                  onChanged: (val) {
                                    setState(() {
                                      this._valQui = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                              //   Text('quinta '),
                              // ]),

                              //const SizedBox(height: 5),
                              if (_valQui)
                                Row(
                                  children: <Widget>[
                                    const SizedBox(height: 5, width: 5),
                                    Text('Das '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 08, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valQuiDas = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valQuiDas)
                                          ],
                                        )),
                                    const SizedBox(width: 5),
                                    Text(' às '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 18, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valQuiAs = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valQuiAs)
                                          ],
                                        )),
                                  ],
                                ),

                              // Row(children: <Widget>[
                              CheckboxListTile(controlAffinity: ListTileControlAffinity.leading, title:Text('sexta '),
                              value: this._valSex,
                                  onChanged: (val) {
                                    setState(() {
                                      this._valSex = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                              //   Text('sexta '),
                              // ]),

                              //const SizedBox(height: 5),
                              if (_valSex)
                                Row(
                                  children: <Widget>[
                                    const SizedBox(height: 5, width: 5),
                                    Text('Das '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 08, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valSexDas = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valSexDas)
                                          ],
                                        )),
                                    const SizedBox(width: 5),
                                    Text(' às '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 18, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valSexAs = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valSexAs)
                                          ],
                                        )),
                                  ],
                                ),

                              // Row(children: <Widget>[
                              CheckboxListTile(controlAffinity: ListTileControlAffinity.leading, title: Text('sábado '),
                              value: this._valSab,
                                  onChanged: (val) {
                                    setState(() {
                                      this._valSab = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                              //   Text('sábado '),
                              // ]),

                              //const SizedBox(height: 5),
                              if (_valSab)
                                Row(
                                  children: <Widget>[
                                    const SizedBox(height: 5, width: 5),
                                    Text('Das '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 08, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valSabDas = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valSabDas)
                                          ],
                                        )),
                                    const SizedBox(width: 5),
                                    Text(' às '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 18, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valSabAs = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valSabAs)
                                          ],
                                        )),
                                  ],
                                ),

                              // Row(children: <Widget>[
                              CheckboxListTile(controlAffinity: ListTileControlAffinity.leading, title: Text('domingo '),
                              value: this._valDom,
                                  onChanged: (val) {
                                    setState(() {
                                      this._valDom = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                              //   Text('domingo '),
                              // ]),

                              //const SizedBox(height: 5),
                              if (_valDom)
                                Row(
                                  children: <Widget>[
                                    const SizedBox(height: 5, width: 5),
                                    Text('Das '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 08, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valDomDas = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valDomDas)
                                          ],
                                        )),
                                    const SizedBox(width: 5),
                                    Text(' às '),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                        onPressed: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: 18, minute: 00))
                                              .then((value) => setState(() {
                                            _mofferController
                                                .valDomAs = value!
                                                .hour
                                                .toString()
                                                .padLeft(2, '0') +
                                                ':' +
                                                value.minute
                                                    .toString()
                                                    .padLeft(2, '0');
                                          }));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<
                                                Color>(
                                              _loginController
                                                  .colorFromHex(_loginController.listCore
                                                  .where((coreItem) =>
                                              coreItem.coreChave ==
                                                  'backDark')
                                                  .first
                                                  .coreValor
                                                  .toString()),
                                            )),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(_mofferController.valDomAs)
                                          ],
                                        )),
                                  ],
                                ),
                            ]),

                          // const SizedBox(height: 10),
                          // const Divider(),
                          // if (showMostraReview)
                          //   Row(
                          //     children: <Widget>[
                          //       Switch(
                          //           value: valMostraReview,
                          //           onChanged: (bool _val) {
                          //             setState(() {
                          //               valMostraReview = val;
                          //             });
                          //           }),
                          //       const SizedBox(width: 20),
                          //       Text('Mostrar opiniões'),
                          //       const SizedBox(height: 20)
                          //     ],
                          //   ),
                          //
                          // if (showAceiteAuto)
                          //   Row(
                          //     children: <Widget>[
                          //       Switch(
                          //           value: valAceiteAuto,
                          //           onChanged: (bool _val) {
                          //             setState(() {
                          //               valAceiteAuto = val;
                          //             });
                          //           }),
                          //       const SizedBox(width: 20),
                          //       Expanded(
                          //         child: Text(
                          //             'Aceite automático dentro do horário'),
                          //       ),
                          //       const SizedBox(height: 20)
                          //     ],
                          //   ),

                          if (showAceitaEncomenda)
                            // Row(
                            //   children: <Widget>[
                            SwitchListTile(controlAffinity: ListTileControlAffinity.leading,title:Text('Aceita encomenda'),
                            value: _valAceitaEncomenda,
                                    onChanged: (bool val) {
                                      setState(() {
                                        _valAceitaEncomenda = val;
                                        print('valAceitaEncomenda: ' +
                                            _valAceitaEncomenda
                                                .toString());
                                      });
                                    }),
                            //     const SizedBox(width: 20),
                            //     Text('Aceita encomenda'),
                            //   ],
                            // ),

                          if (showAceitaEncomenda && _valAceitaEncomenda)
                            // Row(
                            //   children: <Widget>[
                            //     //const SizedBox(width: 40),
                            SwitchListTile(controlAffinity: ListTileControlAffinity.leading,title:Text('Somente encomenda'),
                            value: _valSomenteEncomenda,
                                    onChanged: (bool val) {
                                      setState(() {
                                        _valSomenteEncomenda = val;
                                        print('valSomenteEncomenda: ' +
                                            _valSomenteEncomenda
                                                .toString());
                                      });
                                    }),
                                // const SizedBox(width: 10),
                                // Text('Somente encomenda'),

                                // Row(children: <Widget>[
                                //   const SizedBox(height: 30),
                                //   Text('A partir de: '),
                                // ]),
                                // ElevatedButton(
                                //     onPressed: () {
                                //       showDatePicker(
                                //           context: context,
                                //           initialDate: DateTime.now(),
                                //           firstDate: DateTime.now(),
                                //           lastDate: DateTime.now()
                                //               .add(Duration(days: 1000)))
                                //           .then((value) => setState(() {
                                //         _mofferController
                                //             .valEncomendasAPartir =
                                //         value!;
                                //       }));
                                //     },
                                //     style: ButtonStyle(
                                //         backgroundColor:
                                //         MaterialStateProperty.all<Color>(
                                //           _loginController.colorFromHex(
                                //               _loginController.listCore
                                //                   .where((coreItem) =>
                                //               coreItem.coreChave ==
                                //                   'backDark')
                                //                   .first
                                //                   .coreValor
                                //                   .toString()),
                                //         )),
                                //     child: Row(
                                //       children: [
                                //         Icon(Icons.calendar_today_rounded),
                                //         const SizedBox(
                                //           width: 16,
                                //         ),
                                //         Text(_mofferController
                                //             .valEncomendasAPartir.day
                                //             .toString() +
                                //             '/' +
                                //             _mofferController
                                //                 .valEncomendasAPartir.month
                                //                 .toString() +
                                //             '/' +
                                //             _mofferController
                                //                 .valEncomendasAPartir.year
                                //                 .toString())
                                //       ],
                                //    )
                                //),
                              //   const SizedBox(height: 20),
                              // ],
                            //),

                          // if (showCamposBasicos)
                          //   Column(
                          //     children: <Widget>[
                          //       const Divider(),
                          //       const SizedBox(height: 10),
                          //       Text('Forma de Fechamento'),
                          //       const SizedBox(height: 10),
                          //       DropdownButton<String>(
                          //         items: listaFormaFechamento
                          //             .map((String value) {
                          //           return DropdownMenuItem<String>(
                          //             value: value,
                          //             child: Text(value),
                          //           );
                          //         }).toList(),
                          //         value: formaFechSel,
                          //         onChanged: (String? newValue) {
                          //           setState(() {
                          //             formaFechSel = newValue!;
                          //           });
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          //
                          // const SizedBox(height: 20),

                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     SizedBox(height: 20),
                          //     Divider(),
                          //   ],
                          // ),

                          // if (widget
                          //     .showCamposEntrega) // && _categSelecionada.categoriaFormasEntrega!.contains('other'))
                          //   Column(
                          //     children: <Widget>[
                          //       Text('Agente de ' + _labelEntrega),
                          //       Row(
                          //         children: <Widget>[
                          //           Switch(
                          //               value: valAceitaEntregaComprador,
                          //               onChanged: (bool _val) {
                          //                 setState(() {
                          //                   valAceitaEntregaComprador = val;
                          //                 });
                          //               }),
                          //           const SizedBox(width: 20),
                          //           Text('Entrega por comprador'),
                          //         ],
                          //       ),
                          //       Row(
                          //         children: <Widget>[
                          //           Switch(
                          //               value: valAceitaEntregaVendedor,
                          //               onChanged: (bool _val) {
                          //                 setState(() {
                          //                   valAceitaEntregaVendedor = val;
                          //                 });
                          //               }),
                          //           const SizedBox(width: 20),
                          //           Text('Entrega por vendedor'),
                          //         ],
                          //       ),
                          //       // Row(
                          //       //   children: <Widget>[
                          //       //     Switch(
                          //       //         value: valAceitaEntregaParceiro,
                          //       //         onChanged: (bool _val) {
                          //       //           setState(() {
                          //       //             // configura lista de parceiros
                          //       //                   listaParceiros.clear();
                          //       //                   listaParceiros.add('escolha o parceiro');
                          //       //                   partnersController.parceiros
                          //       //                       ?.forEach((part) {
                          //       //                     print(part.ParceiroEntregaNome
                          //       //                         .toString());
                          //       //                     listaParceiros.add(part
                          //       //                         .ParceiroEntregaNome.toString());
                          //       //                   });
                          //       //             valAceitaEntregaParceiro = val;
                          //       //           });
                          //       //         }),
                          //       //     const SizedBox(width: 20),
                          //       //     Text('Entrega por parceiro'),
                          //       //   ],
                          //       // ),
                          //
                          //       // NAO USAR!
                          //       // DropdownButton<String>(
                          //       //   items: listaFormaEntrega
                          //       //       .map((String value) {
                          //       //     return DropdownMenuItem<String>(
                          //       //       value: value,
                          //       //       child: Text(value),
                          //       //     );
                          //       //   }).toList(),
                          //       //   value: agenteEntregaSel,
                          //       //   onChanged: (String? newValue) {
                          //       //     if (newValue == 'parceiro') {
                          //       //       // configura lista de parceiros
                          //       //       listaParceiros.clear();
                          //       //       listaParceiros.add('escolha o parceiro');
                          //       //       partnersController.parceiros
                          //       //           ?.forEach((part) {
                          //       //         print(part.ParceiroEntregaNome
                          //       //             .toString());
                          //       //         listaParceiros.add(part
                          //       //             .ParceiroEntregaNome.toString());
                          //       //       });
                          //       //       print('lista parceiros: ' +
                          //       //           listaParceiros.length
                          //       //               .toString());
                          //       //     }
                          //       //
                          //       //     setState(() {
                          //       //       agenteEntregaSel = newValue!;
                          //       //     });
                          //       //   },
                          //       // ),
                          //
                          //
                          //       // if (valAceitaEntregaParceiro)
                          //       //   Column(
                          //       //     children: <Widget>[
                          //       //       //const SizedBox(height: 20),
                          //       //       const Divider(),
                          //       //       const SizedBox(height: 10),
                          //       //       // Text('Parceiro'),
                          //       //       // const SizedBox(height: 10),
                          //       //       DropdownButton<String>(
                          //       //         items: listaParceiros
                          //       //             .map((String value) {
                          //       //           return DropdownMenuItem<String>(
                          //       //             value: value,
                          //       //             child: Text(value),
                          //       //           );
                          //       //         }).toList(),
                          //       //         value: parceiroSel,
                          //       //         onChanged: (String? newValue) {
                          //       //           setState(() {
                          //       //             parceiroSel = newValue!;
                          //       //           });
                          //       //         },
                          //       //       ),
                          //       //     ],
                          //       //   ),
                          //       const SizedBox(height: 20),
                          //       Text(
                          //         "Disponibilidade de " +
                          //             _labelEntrega +
                          //             ' à partir de: ',
                          //         textAlign: TextAlign.center,
                          //       ),
                          //       const SizedBox(height: 10),
                          //       ElevatedButton(
                          //           onPressed: () {
                          //             showDatePicker(
                          //                     context: context,
                          //                     initialDate: DateTime.now(),
                          //                     firstDate: DateTime.now(),
                          //                     lastDate: DateTime.now()
                          //                         .add(Duration(days: 1000)))
                          //                 .then((value) => setState(() {
                          //                       _mofferController
                          //                               .valEntregasAPartir =
                          //                           value!;
                          //                     }));
                          //           },
                          //           style: ButtonStyle(
                          //               backgroundColor:
                          //                   MaterialStateProperty.all<Color>(
                          //             _loginController.colorFromHex(
                          //                 _loginController.listCore
                          //                     .where((coreItem) =>
                          //                         coreItem.coreChave ==
                          //                         'backDark')
                          //                     .first
                          //                     .coreValor
                          //                     .toString()),
                          //           )),
                          //           child: Row(
                          //             children: [
                          //               Icon(Icons.calendar_today_rounded),
                          //               const SizedBox(
                          //                 width: 16,
                          //               ),
                          //               Text(_mofferController
                          //                       .valEntregasAPartir.day
                          //                       .toString() +
                          //                   '/' +
                          //                   _mofferController
                          //                       .valEntregasAPartir.month
                          //                       .toString() +
                          //                   '/' +
                          //                   _mofferController
                          //                       .valEntregasAPartir.year
                          //                       .toString())
                          //             ],
                          //           )),
                          //       const SizedBox(height: 20),
                          //
                          //       Text("Horário de " + _labelEntrega),
                          //       const SizedBox(height: 10),
                          //       Row(
                          //         children: <Widget>[
                          //           const SizedBox(width: 5),
                          //           Text('Das '),
                          //           const SizedBox(width: 5),
                          //           ElevatedButton(
                          //               onPressed: () {
                          //                 showTimePicker(
                          //                         context: context,
                          //                         initialTime: TimeOfDay(
                          //                             hour: 08, minute: 00))
                          //                     .then((value) => setState(() {
                          //                           _mofferController
                          //                                   .valEntregaDas =
                          //                               value!.hour
                          //                                       .toString()
                          //                                       .padLeft(
                          //                                           2, '0') +
                          //                                   ':' +
                          //                                   value.minute
                          //                                       .toString()
                          //                                       .padLeft(
                          //                                           2, '0');
                          //                         }));
                          //               },
                          //               style: ButtonStyle(
                          //                   backgroundColor:
                          //                       MaterialStateProperty.all<
                          //                           Color>(
                          //                 _loginController
                          //                     .colorFromHex(widget
                          //                         ._loginController.listCore
                          //                         .where((coreItem) =>
                          //                             coreItem.coreChave ==
                          //                             'backDark')
                          //                         .first
                          //                         .coreValor
                          //                         .toString()),
                          //               )),
                          //               child: Row(
                          //                 children: [
                          //                   Icon(Icons.access_time_outlined),
                          //                   const SizedBox(
                          //                     width: 16,
                          //                   ),
                          //                   Text(_mofferController
                          //                       .valEntregaDas)
                          //                 ],
                          //               )),
                          //           const SizedBox(width: 5),
                          //           Text(' às '),
                          //           const SizedBox(width: 5),
                          //           ElevatedButton(
                          //               onPressed: () {
                          //                 showTimePicker(
                          //                         context: context,
                          //                         initialTime: TimeOfDay(
                          //                             hour: 18, minute: 00))
                          //                     .then((value) => setState(() {
                          //                           _mofferController
                          //                               .valEntregaAs = value!
                          //                                   .hour
                          //                                   .toString()
                          //                                   .padLeft(2, '0') +
                          //                               ':' +
                          //                               value.minute
                          //                                   .toString()
                          //                                   .padLeft(2, '0');
                          //                         }));
                          //               },
                          //               style: ButtonStyle(
                          //                   backgroundColor:
                          //                       MaterialStateProperty.all<
                          //                           Color>(
                          //                 _loginController
                          //                     .colorFromHex(widget
                          //                         ._loginController.listCore
                          //                         .where((coreItem) =>
                          //                             coreItem.coreChave ==
                          //                             'backDark')
                          //                         .first
                          //                         .coreValor
                          //                         .toString()),
                          //               )),
                          //               child: Row(
                          //                 children: [
                          //                   Icon(Icons.access_time_outlined),
                          //                   const SizedBox(
                          //                     width: 16,
                          //                   ),
                          //                   Text(_mofferController
                          //                       .valEntregaAs)
                          //                 ],
                          //               )),
                          //         ],
                          //       ),
                          //       if (_labelEntrega == 'Entrega')
                          //         Column(
                          //           children: <Widget>[
                          //             const SizedBox(height: 20),
                          //             Text(
                          //               "Taxas de Entrega",
                          //               textAlign: TextAlign.left,
                          //             ),
                          //             const SizedBox(height: 20),
                          //             TextFormField(
                          //               inputFormatters: [
                          //                 FilteringTextInputFormatter
                          //                     .digitsOnly,
                          //                 CentavosInputFormatter(),
                          //               ],
                          //               // initialValue: '0',
                          //               controller: widget
                          //                   ._mofferController.txtValorTaxa1km,
                          //               decoration: InputDecoration(
                          //                   prefix: Text('R\$ '),
                          //                   border: OutlineInputBorder(),
                          //                   labelText: 'Até 1km'),
                          //               textInputAction: TextInputAction.next,
                          //               //focusNode: _priceFocusNode,
                          //               keyboardType:
                          //                   TextInputType.numberWithOptions(
                          //                       decimal: true),
                          //             ),
                          //             const SizedBox(height: 20),
                          //             TextFormField(
                          //               inputFormatters: [
                          //                 FilteringTextInputFormatter
                          //                     .digitsOnly,
                          //                 CentavosInputFormatter(),
                          //               ],
                          //               // initialValue: '0',
                          //               controller: widget
                          //                   ._mofferController.txtValorTaxa2km,
                          //               decoration: InputDecoration(
                          //                   prefix: Text('R\$ '),
                          //                   border: OutlineInputBorder(),
                          //                   labelText: 'Entre 1km e 2km'),
                          //               textInputAction: TextInputAction.next,
                          //               //focusNode: _priceFocusNode,
                          //               keyboardType:
                          //                   TextInputType.numberWithOptions(
                          //                       decimal: true),
                          //             ),
                          //             const SizedBox(height: 20),
                          //             TextFormField(
                          //               inputFormatters: [
                          //                 FilteringTextInputFormatter
                          //                     .digitsOnly,
                          //                 CentavosInputFormatter(),
                          //               ],
                          //               // initialValue: '0',
                          //               controller: _mofferController
                          //                   .txtValorTaxaMaisQue2km,
                          //               decoration: InputDecoration(
                          //                   prefix: Text('R\$ '),
                          //                   border: OutlineInputBorder(),
                          //                   labelText: 'Acima de 2km'),
                          //               textInputAction: TextInputAction.next,
                          //               //focusNode: _priceFocusNode,
                          //               keyboardType:
                          //                   TextInputType.numberWithOptions(
                          //                       decimal: true),
                          //             ),
                          //             const SizedBox(height: 20),
                          //             // Text('Tempo de Entrega após aceite'),
                          //             TextFormField(
                          //                 decoration: InputDecoration(
                          //                     border: OutlineInputBorder(),
                          //                     labelText:
                          //                         'Tempo de entrega após aceite'),
                          //                 keyboardType: TextInputType.number),
                          //             const SizedBox(height: 20),
                          //             Text('Unidade de Tempo'),
                          //             DropdownButton<String>(
                          //               items: _listaTempoEntregaTipo
                          //                   .map((String value) {
                          //                 return DropdownMenuItem<String>(
                          //                   value: value,
                          //                   child: Text(value),
                          //                 );
                          //               }).toList(),
                          //               value: tempoEntregaTipoSel,
                          //               onChanged: (String? newValue) {
                          //                 setState(() {
                          //                   tempoEntregaTipoSel =
                          //                       newValue!;
                          //                 });
                          //               },
                          //             ),
                          //           ],
                          //         ),
                          //     ],
                          //   ),

                          if (showCamposBasicos)
                            Column(children: <Widget>[
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () => pegarImagemGaleria(),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                        _loginController.colorFromHex(
                                            _loginController.listCore
                                                .where((coreItem) =>
                                            coreItem.coreChave ==
                                                'backDark')
                                                .first
                                                .coreValor
                                                .toString()),
                                      )),
                                  child: Row(
                                    children: [
                                      Icon(Icons.photo_album),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text('Adicionar Foto')
                                    ],
                                  )),
                              const SizedBox(height: 20),
                              if (_imgcloud != '')
                                CachedNetworkImage(
                                  imageUrl: _imgcloud,
                                  progressIndicatorBuilder: (context, url,
                                      downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.local_offer_outlined),
                                  height: 250,
                                ),

                              // FadeInImage.assetNetwork(
                              //   placeholder: 'assets/images/pholder.png',
                              //   image: _imgcloud,
                              //   imageErrorBuilder: (context, url, error) =>
                              //       new Icon(Icons.local_offer_outlined),
                              //   height: 250,
                              // ),

                              if (image != null)
                                Image.file(
                                  image!,
                                  fit: BoxFit.contain,
                                ),
                              const SizedBox(height: 20),
                              ButtonOffer(
                                  text: 'Salvar',
                                  colorText: _loginController
                                      .colorFromHex(_loginController.listCore
                                      .where((coreItem) =>
                                  coreItem.coreChave ==
                                      'textLight')
                                      .first
                                      .coreValor
                                      .toString()),
                                  colorButton: _loginController
                                      .colorFromHex(_loginController.listCore
                                      .where((coreItem) =>
                                  coreItem.coreChave ==
                                      'iconColor')
                                      .first
                                      .coreValor
                                      .toString()),
                                  onPressed: () {
                                    uploadFoto(
                                        image == null ? null : image,
                                        _loginController.usuGuid
                                            .toString())
                                        .then((value) => Get.offAndToNamed(
                                        AppRoutes.mOffers));
                                  }),
                              if (_mofferController.singleOffer != null)
                                ButtonOffer(
                                  onPressed: () async {
                                    await _mofferController.apagaMoffer(
                                        _mofferController.singleOffer!
                                            .OfertaGUID
                                            .toString());

                                    Get.defaultDialog(
                                        title: "Aviso",
                                        middleText:
                                        "Oferta removida");

                                    Get.offAndToNamed(AppRoutes.mOffers);
                                  },
                                  colorText: _loginController
                                      .colorFromHex(_loginController.listCore
                                      .where((coreItem) =>
                                  coreItem.coreChave ==
                                      'textDark')
                                      .first
                                      .coreValor
                                      .toString()),
                                  text: 'Apagar Oferta',
                                  colorButton: _loginController
                                      .colorFromHex(_loginController.listCore
                                      .where((coreItem) =>
                                  coreItem.coreChave ==
                                      'textLight')
                                      .first
                                      .coreValor
                                      .toString()),
                                ),
                            ])
                        ],
                      ),
                    ),
                  )),
            );
          }
        //});
  //}

  Future pegarImagemGaleria() async {
    try {
      final foto = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 70, maxHeight: 300);
      if (foto == null) return;

      final imageTemp = File(foto.path);

      setState(() => this.image = imageTemp);

      _imgEdited = true;
    } on PlatformException catch (e) {
      print('erro tentando abrir album de fotos: $e');
    }
  }

  Future<void> uploadFoto(File? foto, String usuGuid) async {
    await _saveForm(usuGuid);

    if (_imgEdited && foto != null) {
      await Firebase.initializeApp();

      print('passou no upload');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("ofertas")
          .child(_offerGuid + '.jpg');

      await ref.putFile(image!);
      //var downloadURL = await ref.getDownloadURL();
    }
    //showSnackBar("Oferta salva! - " + _offerGuid, Duration(seconds: 3));

    Get.defaultDialog(
        title: "Aviso", middleText: "Informações atualizadas com sucesso!");
  }

  //snackbar for  showing error
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _updateImageUrl() {
    if (isValidImageUrl(_imageURLController.text)) {
      setState(() {});
    }
  }

  // Future<void> inicia() async {
  //   _manageCampos();
  // }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endWithPng = url.toLowerCase().endsWith('.png');
    bool endWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endWithJpeg = url.toLowerCase().endsWith('.jpeg');

    return (startWithHttp || startWithHttps) &&
        (endWithPng || endWithJpg || endWithJpeg);
  }

  Future<void> _saveForm(String usuGuid) async {
    print('usuGuid: ' + usuGuid);

    // var formaFechto = '';
    // switch (formaFechSel) {
    //   case 'mensagem no aplicativo (seguro)':
    //     formaFechto = 'chatapp';
    //     break;
    //   case 'pagamento no aplicativo (seguro)':
    //     formaFechto = 'gatewayapi';
    //     break;
    //   default:
    //     formaFechto = formaFechSel;
    // }

    double valPreco = 0.0;
    if (_categSelecionada.categoriaChave != 'DOACAO')
      valPreco =
          double.parse(_mofferController.txtPreco.text.removeAllWhitespace
          // .replaceFirst('.', '')
              .replaceFirst(',', '.'));

    assert(valPreco is double);
    print(valPreco.runtimeType);

    // var offerToSend = new Oferta(
    //   null,
    //   _categSelecionada.categoriaChave,
    //   usuGuid,
    //   _mofferController.txtTitulo.text,
    //   _mofferController.txtDetalhes.text,
    //   //double.parse(_mofferController.txtPreco.text.replaceAll('.', '').replaceAll(',', '.')),
    //   valPreco,
    //   null,
    //   null,
    //   null,
    //   '',
    //   1,
    //   _mofferController.txtCEP.text.replaceAll('-', ''),
    //   null,
    //   null,
    //   0,
    //   0,
    //   0,
    //   0,
    //   null,
    //   _mofferController.mofferGuid == null
    //       ? null
    //       : _mofferController.mofferGuid.toString(),
    //   0, // int.parse(_mofferController.txtQtdDispo.text),
    //   0, // int.parse(_mofferController.txtQtdMaxPorVenda.text),
    //   0, // int.parse(_mofferController.txtQtdAviso.text),
    //   0.00, //double.parse(_mofferController.txtPesoPorcao.text),
    //   // _mofferController.txtPesoPorcaoUn.text,
    //   0, //  int.parse(_mofferController.txtValidade.text),
    //   0.00, //double.parse(_mofferController.txtValorMin.text),
    //   false, // valMostraReview,
    //   false, // valAceiteAuto,
    //   false, // valAceitaEncomenda,
    //   false, // valSomenteEncomenda,
    //   false, // valAceitaProposta,
    //   0, //int.parse(_mofferController.txtTempoEntrega.text), //int.parse(_mofferController.txtTempoEntrega.text),
    //   '', //tempoEntregaTipoSel,
    //   '', //formaFechto,
    //   '', //agenteEntregaSel,
    //   '',
    //   '',
    //   //_mofferController.txtMarca.text,
    //   _revendaSel,
    //   _mofferController.txtCores.text,
    //   _mofferController.txtTamanhos.text,
    //   true, //val24hs,
    //   0, //int.parse(_mofferController.txtCepDistancia.text),
    //   0.00, // double.parse(_mofferController.txtValorSinalOrc.text),
    //   _mofferController.valEncomendasAPartir.toString(),
    //   _mofferController.valEntregasAPartir.toString(),
    //   _mofferController.txtCodigoAlt.text,
    //   0.00, // double.parse(_mofferController.txtValorTaxa1km.text),
    //   0.00, // double.parse(_mofferController.txtValorTaxa2km.text),
    //   0.00, // double.parse(_mofferController.txtValorTaxaMaisQue2km.text),
    //   true, // valQtd,
    //   _valSinalPercentual ? "P" : "V",
    //   false, // valPrecoInicial,
    //   false, // valPrecoCombinar,
    //   false, // valSeg,
    //   false, // _valTer,
    //   false, // _valQua,
    //   false, // _valQui,
    //   false, // _valSex,
    //   false, // _valSab,
    //   false, // _valDom,
    //   _mofferController.valSegDas,
    //   _mofferController.valSegAs,
    //   _mofferController.valTerDas,
    //   _mofferController.valTerAs,
    //   _mofferController.valQuaDas,
    //   _mofferController.valQuaAs,
    //   _mofferController.valQuiDas,
    //   _mofferController.valQuiAs,
    //   _mofferController.valSexDas,
    //   _mofferController.valSexAs,
    //   _mofferController.valSabDas,
    //   _mofferController.valSabAs,
    //   _mofferController.valDomDas,
    //   _mofferController.valDomAs,
    //   false, // null,
    //   false, // null,
    //   false, // null,
    //   false, // null,
    //   false, // null,
    //   false, // null
    // );

    var offerToSend = new Oferta(null, _categSelecionada.categoriaChave, usuGuid, _mofferController.txtTitulo.text, _mofferController.txtDetalhes.text, valPreco, null, null, null, null, null,
        _mofferController.txtCEP.text.replaceAll('-', ''), null, null, _mofferController.mofferGuid.toString().isEmpty ? null : _mofferController.mofferGuid.toString(),
        _valAceitaEncomenda, _valSomenteEncomenda, _revendaSel, _val24hs, _mofferController.valEncomendasAPartir.toString(), _mofferController.valEntregasAPartir.toString(), _valPrecoCombinar,
        _valSeg, _valTer, _valQua, _valQui, _valSex, _valSab, _valDom, _mofferController.valSegDas, _mofferController.valSegAs, _mofferController.valTerDas, _mofferController.valTerAs, _mofferController.valQuaDas,
        _mofferController.valQuaAs, _mofferController.valQuiDas, _mofferController.valQuiAs, _mofferController.valSexDas, _mofferController.valSexAs, _mofferController.valSabDas, _mofferController.valSabAs,
        _mofferController.valDomDas, _mofferController.valDomAs, _mofferController.mofferGuid.toString().isEmpty ? false : true, true);

    // Uri url = Uri.https("ec3digrepo-default-rtdb.firebaseio.com", "/words.json");
    print(offerToSend.toJsonPost());

    if (_mofferController.mofferGuid.toString() == '') {
      var response = await post(
        Uri.parse('${Constants.baseUrl}moffer'),
        headers: Constants.headers,
        body: offerToSend.toJsonPost(),
      );

      print(response.body);

      // var jsonResp = jsonDecode(response.body);
      // var strGuid = jsonResp['insert_Ofertas_one']['OfertaGUID'];

      // _offerGuid = strGuid;
      // print('guid: ' + strGuid);
    } else {
      print(offerToSend.toJsonPut());
      var response = await put(
        Uri.parse('${Constants.baseUrl}moffer'),
        headers: Constants.headers,
        body: offerToSend.toJsonPut(),
      );

      print(response.body);

      // var jsonResp = jsonDecode(response.body);
      // var strGuid = jsonResp['update_Ofertas']['returning'][0]['OfertaGUID'];

      // print('guid: ' + strGuid);
    }
  }

  // somente para testes - em producao virá a partir do Firebase
  void _manageCampos() {
    print('manageCampos: ' + _categSelecionada.secao.toString());
    if (_categSelecionada.secao == null) {
      // _labelEntrega = 'Entrega';
      showQtd = false;
      showCamposBasicos = false;
      showCamposEntrega = false;
      showPreco = false;
      showTxtQtdDispo = false;
      showTxtValorMin = false;
      showTxtMarca = false;
      showTxtCep = false;
      //showTxtQtdMaxPorVenda = false;
      //showTxtQtdAviso = false;
      show24hs = false;
      showAceitaProposta = false;
      showSomenteEncomenda = false;
      showAceitaEncomenda = false;
      showAceiteAuto = false;
      showMostraAval = false;
      showMostraReview = false;
      showDispoImediata = false;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = false;
      // show_listaTempoEntregaTipo = false;
      // showTxtTempoEntrega = false;
      showTxtCores = false;
      showTxtTamanhos = false;
      // showTxtPesoPorcao = false;
      // showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = false;
      showTxtCodigoAlt = false;
    }
    if (_categSelecionada.secao == 'SEC-SERV-CASA' ||
        _categSelecionada.secao == 'SEC-SERV-FRETE' ||
        _categSelecionada.secao == 'SEC-SERV-VOCE' ||
        _categSelecionada.secao == 'SEC-SERV-CARRO' ||
        _categSelecionada.secao == 'SEC-SERV-PET') {
      // _labelEntrega = 'Atendimento';
      // _labelValidade = 'Garantia';
      showQtd = false;
      showCamposBasicos = true;
      showPreco = true;
      showTxtQtdDispo = false;
      showTxtValorMin = false;
      showTxtMarca = false;
      showTxtCep = true;
      // _valQtd = false;
      // showTxtQtdMaxPorVenda = false;
      // showTxtQtdAviso = false;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = false;
      showAceitaEncomenda = false;
      showAceiteAuto = false;
      showMostraAval = true;
      showMostraReview = true;
      showDispoImediata = true;
      showCamposEntrega = false;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = false;
      //show_listaTempoEntregaTipo = false;
      // showTxtTempoEntrega = false;
      showTxtCores = false;
      showTxtTamanhos = false;
      // showTxtPesoPorcao = false;
      // showTxtPesoPorcaoUn = false;
      showTxtValidade = true;
      showTxtValorSinalOrc = true;
      // showTxtEntregaTaxas = false;
      showTxtCodigoAlt = false;
    }
    if (_categSelecionada.secao == 'SEC-PROD-DESAPEGO') {
      // _labelEntrega = 'Entrega';
      showQtd = false;
      showCamposBasicos = true;
      showCamposEntrega = true;
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtValorMin = false;
      showTxtMarca = true;
      showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = false;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = false;
      showAceitaEncomenda = false;
      showAceiteAuto = true;
      showMostraAval = false;
      showMostraReview = false;
      showDispoImediata = true;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = true;
      // show_listaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      // showTxtPesoPorcao = false;
      // showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = false;
    }
    if (_categSelecionada.secao == 'SEC-PROD-ACHADOPERDIDO') {
      // _labelEntrega = 'Entrega';
      showQtd = false;
      showCamposBasicos = true;
      showPreco = false;
      showTxtQtdDispo = true;
      showTxtValorMin = false;
      showTxtMarca = false;
      showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = false;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = false;
      showAceitaEncomenda = false;
      showAceiteAuto = true;
      showMostraAval = false;
      showMostraReview = false;
      showDispoImediata = true;
      showCamposEntrega = false;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = true;
      // show_listaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      // showTxtPesoPorcao = false;
      // showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = false;
      showTxtCodigoAlt = false;
    }
    if (_categSelecionada.secao == 'SEC-PROD-BELEZA') {
      // _labelEntrega = 'Entrega';
      showQtd = true;
      showCamposBasicos = true;
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtValorMin = true;
      showTxtMarca = true;
      showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = true;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = true;
      showAceitaEncomenda = true;
      showAceiteAuto = true;
      showMostraAval = true;
      showMostraReview = true;
      showDispoImediata = true;
      showCamposEntrega = true;
      // showListaFormaEntrega = true;
      // showListaFormaEntrega2 = true;
      // showListaParceiros = true;
      // show_listaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      // showTxtPesoPorcao = true;
      // showTxtPesoPorcaoUn = true;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = true;
    }
    if (_categSelecionada.secao == 'SEC-PROD-COMIDA') {
      // _labelEntrega = 'Entrega';
      // _labelValidade = 'Validade';
      showQtd = true;
      showCamposBasicos = true;
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtValorMin = true;
      showTxtMarca = false;
      showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = true;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = true;
      showAceitaEncomenda = true;
      showAceiteAuto = true;
      showMostraAval = true;
      showMostraReview = true;
      showDispoImediata = true;
      showCamposEntrega = true;
      // showListaFormaEntrega = true;
      // showListaFormaEntrega2 = true;
      // showListaParceiros = true;
      // show_listaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = false;
      showTxtTamanhos = false;
      // showTxtPesoPorcao = true;
      // showTxtPesoPorcaoUn = true;
      showTxtValidade = true;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = false;
    }
    if (_categSelecionada.secao == 'SEC-PROD-OBJETO') {
      // _labelEntrega = 'Entrega';
      // _labelValidade = 'Validade';
      showQtd = true;
      showCamposBasicos = true;
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtValorMin = true;
      showTxtMarca = true;
      showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = true;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = true;
      showAceitaEncomenda = true;
      showAceiteAuto = true;
      showMostraAval = true;
      showMostraReview = true;
      showDispoImediata = true;
      showCamposEntrega = true;
      // showListaFormaEntrega = true;
      // showListaFormaEntrega2 = true;
      // showListaParceiros = true;
      // show_listaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      // showTxtPesoPorcao = true;
      // showTxtPesoPorcaoUn = true;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = false;
    }
    if (_categSelecionada.secao == 'SEC-PROD-VEST') {
      // _labelEntrega = 'Entrega';
      showQtd = true;
      showCamposBasicos = true;
      showPreco = true;
      // showTxtQtdDispo = true;
      // showTxtQtdAviso = true;
      showTxtValorMin = true;
      showTxtMarca = true;
      showTxtCep = true;
      showTxtQtdMaxPorVenda = true;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = true;
      showAceitaEncomenda = true;
      showAceiteAuto = true;
      showMostraAval = true;
      showMostraReview = true;
      showDispoImediata = true;
      showCamposEntrega = true;
      // showListaFormaEntrega = true;
      // showListaFormaEntrega2 = true;
      // showListaParceiros = true;
      // show_listaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      // showTxtPesoPorcao = false;
      // showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = false;
    }

    // //if (showTxtMarca) {
    //   //configura lista de revendas
    //   _listaRevendas.clear();
    //   _listaRevendas.add('selecione');
    //   _listaRevendas.add('outra');
    //   BrandsController.revendas.forEach((rev) {
    //     print(rev.RevendaNome.toString());
    //     _listaRevendas.add(rev.RevendaNome.toString());
    //   });
    // //}

    // print('_categSelecionada: ' + _categSelecionada.categoriaFormasEntrega.toString());
    // print(_categSelecionada.categoriaFormasFechto.toString());

    // // configura forma de entrega por categoria
    // listaFormaEntrega.clear();
    // listaFormaEntrega.add('selecione');

    // verifica se existem parceiros de entrega disponíveis na regiao

    // if (_categSelecionada.categoriaFormasEntrega.toString().contains('/'))
    //   _categSelecionada.categoriaFormasEntrega?.split('/').forEach((fe) {
    //     print(fe.toString());
    //
    //     // if(fe.toString() == 'parceiro' && partnersController.parceiros!.length > 0)
    //     //   listaFormaEntrega.add(fe.toString());
    //   });
    // else
    //   listaFormaEntrega
    //       .add(_categSelecionada.categoriaFormasEntrega.toString());

    // // configura forma de fechamento por categoria
    // listaFormaFechamento.clear();
    // listaFormaFechamento.add('selecione');

    // if (_categSelecionada.categoriaFormasFechto
    //     .toString()
    //     .contains('/')) {
    //   _categSelecionada.categoriaFormasFechto?.split('/').forEach((ff) {
    //     print(ff.toString());
    //     if (ff.contains('chatapp'))
    //       listaFormaFechamento.add('mensagem no aplicativo (seguro)');
    //     if (ff.contains('whatsapp'))
    //       listaFormaFechamento.add('whatsapp');
    //     if (ff.contains('gatewayapi'))
    //       listaFormaFechamento.add('pagamento no aplicativo (seguro)');
    //   });
    // } else {
    //   if (_categSelecionada.categoriaFormasFechto.toString() == 'chatapp')
    //     listaFormaFechamento.add('mensagem no aplicativo (seguro)');
    //   if (_categSelecionada.categoriaFormasFechto.toString() ==
    //       'whatsapp') listaFormaFechamento.add('whatsapp');
    //   if (_categSelecionada.categoriaFormasFechto.toString() ==
    //       'gatewayapi')
    //     listaFormaFechamento.add('pagamento no aplicativo (seguro)');
    // }

    //se for doacao, remove o preço
    if (_categSelecionada.categoriaChave == 'DOACAO')
      showPreco = false;
  }

  Future<void> carregaObj() async {
    print('carregaObj');

    // if (ModalRoute.of(context)?.settings.arguments != null) {
    //   var args = ModalRoute.of(context)?.settings.arguments
    //       as List<Map<String, Oferta>>;
    //
    //   Oferta oferta = args.first.values.first;

    if(_load) {
      _load = false;
      print('_load: true');

      if (_mofferController.singleOffer != null) {
        print('singleOffer');
        Oferta? oferta = _mofferController.singleOffer;

        _isEditing = true;
        _imgcloud =
            _loginController.listCore
                .where((coreItem) => coreItem.coreChave == 'imgpath')
                .first
                .coreValor
                .toString() +
                oferta!.OfertaID.toString() +
                _loginController.listCore
                    .where(
                        (coreItem) => coreItem.coreChave == 'imgpathsuffix')
                    .first
                    .coreValor
                    .toString();

        print('_imgcloud: ' + _imgcloud);


        print('guidOffer: ' + oferta.OfertaGUID.toString());
        _mofferController.mofferGuid = oferta.OfertaGUID.toString();
        print(
            'widget guidOffer: ' +
                _mofferController.mofferGuid.toString());
        _mofferController.txtTitulo.text = oferta.OfertaTitulo.toString();

        // if (_loginController.listaCategorias.isEmpty)
        //   await _loginController.getCategories();

        // print(oferta.OfertaTitulo);
        // print(oferta.CategoriaChave);
        _categSelecionada = _categoriesController
            .selecionaCategoriaPorChave(oferta.CategoriaChave.toString())!;
        _categoriaSel = _categSelecionada.categoriaNome!;

        print('_categSelecionada: ' +
            _categSelecionada.categoriaNome.toString());
        print('categSel:' + _categoriaSel);
        print('preco 1: ' + oferta.OfertaPreco.toString());

        // _mofferController.valEncomendasAPartir =
        //     DateTime.parse(oferta.OfertaEncomendasAPartirDe.toString());
        // _mofferController.txtValorTaxa1km.text =
        //     oferta.ValorEntregaAte1 == null
        //         ? '0'
        //         : oferta.ValorEntregaAte1.toString();
        // _mofferController.txtValorTaxaMaisQue2km.text =
        //     oferta.ValorEntregaMaisDe2 == null
        //         ? '0'
        //         : oferta.ValorEntregaMaisDe2.toString();
        // _mofferController.txtValorTaxa2km.text =
        //     oferta.ValorEntregaAte2 == null
        //         ? '0'
        //         : oferta.ValorEntregaAte2.toString();
        // _mofferController.valEntregasAPartir =
        //     DateTime.parse(oferta.OfertaEntregasAPartirDe.toString());

        _mofferController.txtCodigoAlt.text =
        // oferta.OfertaCodigoAlt! == 'null'
        //     ? ''
        //     : oferta.OfertaCodigoAlt.toString();
        // oferta.OfertaDistanciaKm == null
        //     ? '0'
        //     : oferta.OfertaDistanciaKm.toString();
        //_mofferController.txtEntregaAs.text = oferta.Ate.toString();
        _mofferController.txtValorSinalOrc.text =
        // oferta.OfertaSinal == null ? '0' : oferta.OfertaSinal.toString();
        // _mofferController.txtValidade.text =
        // oferta.OfertaDiasValidade == null
        //     ? '0'
        //     : oferta.OfertaDiasValidade.toString();
        // _mofferController.txtPesoPorcao.text =
        // oferta.OfertaPeso == null ? '0' : oferta.OfertaPeso.toString();
        //_mofferController.txtPesoPorcaoUn.text =oferta.OfertaPesoUnidade == 'null' ? '' :  oferta.OfertaPesoUnidade.toString();
        _mofferController.txtDescricao.text =
        oferta.OfertaDetalhe! == 'null'
            ? ''
            : oferta.OfertaDetalhe.toString();
        _mofferController.txtDetalhes.text =
        oferta.OfertaDetalhe! == 'null'
            ? ''
            : oferta.OfertaDetalhe.toString();
        // _mofferController.txtTamanhos.text =
        // oferta.OfertaTamanhos! == 'null'
        //     ? ''
        //     : oferta.OfertaTamanhos.toString();
        // _mofferController.txtCores.text =
        // oferta.OfertaCores! == 'null' ? '' : oferta.OfertaCores.toString();
        // _mofferController.txtValorMin.text = oferta.OfertaPrecoMin == null
        //     ? '0'
        //     : oferta.OfertaPrecoMin.toString();
        // _mofferController.txtMarca.text =
        //     oferta.OfertaMarcaRevenda! == 'null'
        //         ? ''
        //         : oferta.OfertaMarcaRevenda!;

        // _revendaSel = oferta.OfertaMarcaRevenda!;

        print('oferta.OfertaMarcaRevenda: ' + oferta.OfertaMarcaRevenda.toString());
        _revendaSel = oferta.OfertaMarcaRevenda.toString() == 'null' ? '' : oferta.OfertaMarcaRevenda.toString();

        // _mofferController.txtQtdMaxPorVenda.text =
        // oferta.OfertaQtdMaxVenda == null
        //     ? '0'
        //     : oferta.OfertaQtdMaxVenda.toString();
        // _mofferController.txtQtdDispo.text = oferta.OfertaQtdDispo == null
        //     ? '0'
        //     : oferta.OfertaQtdDispo.toString();
        // _mofferController.txtQtdAviso.text = oferta.OfertaQtdAviso == null
        //     ? '0'
        //     : oferta.OfertaQtdAviso.toString();

        print('preco 2: ' + oferta.OfertaPreco.toString());
        _mofferController.txtPreco.text =
        oferta.OfertaPreco == null ? '0.00' : oferta.OfertaPreco.toString();
        _mofferController.txtTempoEntrega.text =
        // oferta.OfertaTempoEntrega == null
        //     ? '0'
        //     : oferta.OfertaTempoEntrega.toString();

        _offerGuid = _mofferController.mofferGuid!;

        _mofferController.valSegDas = oferta.SegDas.toString();
        _mofferController.valSegAs = oferta.SegAs.toString();
        _mofferController.valTerDas = oferta.TerDas.toString();
        _mofferController.valTerAs = oferta.TerAs.toString();
        _mofferController.valQuaDas = oferta.QuaDas.toString();
        _mofferController.valQuaAs = oferta.QuaAs.toString();
        _mofferController.valQuiDas = oferta.QuiDas.toString();
        _mofferController.valQuiAs = oferta.QuiAs.toString();
        _mofferController.valSexDas = oferta.SexDas.toString();
        _mofferController.valSexAs = oferta.SexAs.toString();
        _mofferController.valSabDas = oferta.SabDas.toString();
        _mofferController.valSabAs = oferta.SabAs.toString();
        _mofferController.valDomDas = oferta.DomDas.toString();
        _mofferController.valDomAs = oferta.DomAs.toString();

        _manageCampos();
      } else {
        _isEditing = false;
      }
    }
  }

  Categorias? selecionaCategoriaPorNome(String categName) {
    if (_listaCategoriasNomes.isEmpty) {
      return null;
    } else {
      return _loginController.listaCategorias
          .where((categ) => categ.categoriaNome == categName)
          .first;
    }
  }
}
