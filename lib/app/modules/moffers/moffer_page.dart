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
import 'package:poraki/app/modules/moffers/brands_controller.dart';
import 'package:poraki/app/modules/moffers/moffer_controller.dart';
import 'package:poraki/app/modules/moffers/partners_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/shared/constants/constants.dart';
import 'package:poraki/app/routes/app_routes.dart';

class MOfferPage extends StatefulWidget {
  //final String? offerGuid;
  final Oferta? offer;
  final CategoriesController categoriesController = Get.find();
  final MofferController mofferController = Get.find();
  final BrandsController brandsController = Get.find();
  final PartnersController partnersController = Get.find();
  // final LoginController loginController = Get.find();
  //final MofferController mofferController = Get.put(MofferController());
  final String tipo = 'G';
  late Categorias categSelecionada = new Categorias();
  late String imgcloud = '';
  late String offerGuid = '';
  late bool imgEdited = false;
  late bool editMode = false;

  bool isEditing = false;

  var _priceFocusNode = FocusNode();
  var _descriptionFocusNode = FocusNode();
  var _imageURLFocusNode = FocusNode();
  var _imageURLController = TextEditingController();
  var _form = GlobalKey<FormState>();

  bool _isLoading = false;
  //Categorias? catogoria;
  // var listaCategs = ['selecione']; // pegar da API
  var listaTempoEntregaTipo = ['selecione', 'minutos', 'horas', 'dias'];
  var listaFormaFechamento = ['selecione'];
  var listaFormaEntrega = ['selecione', 'vendedor', 'comprador'];
  var listaRevendas = ['selecione'];
  // var listaFormaEntrega2 = ['selecione', 'vendedor', 'comprador'];
  var listaParceiros = ['selecione']; //TODO: pegar da API
  var valueSel = 'selecione';
  //late String categSel = 'selecione';
  var tempoEntregaTipoSel = 'selecione';
  var agenteEntregaSel = 'selecione';
  var formaFechSel = 'selecione';
  var revendaSel = 'selecione';
  var parceiroSel = 'escolha o parceiro';
  // var materialSel = 'selecione';
  // var voltagemSel = 'selecione';
  var categoriaSel = 'selecione';
  var labelEntrega = 'Entrega';
  var labelValidade = 'Validade';

  bool valAceitaEntregaComprador = false;
  bool valAceitaEntregaParceiro = false;
  bool valAceitaEntregaVendedor = false;
  //bool valRevisao = false;
  bool valDispoImediata = true;
  bool valMostraAval = false;
  bool valMostraReview = false;
  bool valAceiteAuto = false;
  bool valAceitaEncomenda = false;
  bool valSomenteEncomenda = false;
  bool valAceitaProposta = false;
  bool val24hs = false;
  bool valSeg = false;
  bool valTer = false;
  bool valQua = false;
  bool valQui = false;
  bool valSex = false;
  bool valSab = false;
  bool valDom = false;
  bool valQtd = false;
  bool valSinalPercentual = false;
  bool valPrecoCombinar = false;
  bool valPrecoInicial = false;

  bool showPreco = true;
  bool showDispoImediata = false;
  bool showMostraAval = false;
  bool showMostraReview = false;
  bool showAceiteAuto = false;
  bool showAceitaEncomenda = false;
  bool showSomenteEncomenda = false;
  bool showAceitaProposta = false;
  bool show24hs = false;
  // bool showListaTempoEntregaTipo = false;
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
  bool showTxtPesoPorcao = false;
  bool showTxtPesoPorcaoUn = false;
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

  //Get.put(MofferController());

  // Function? addProduct;
  MOfferPage({Key? key, required this.offer}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MOfferPage();
  }
}

class _MOfferPage extends State<MOfferPage> {
  File? image;

  // // formatters
  // late TextFormField txtfValorSinalOrc;
  // late TextFormField txtfValorMin;
  // late TextFormField txtfValorTaxa1km;
  // late TextFormField txtfValorTaxa2km;
  // late TextFormField txtfValorTaxaMaisQue2km;
  // late TextFormField txtfPesoPorcao;
  // late TextFormField txtfCEP;
  // late TextFormField txtfPreco;
  //

  @override
  void initState() {
    widget._imageURLFocusNode.addListener(_updateImageUrl);

    //var brandController = new BrandsController();
    widget.brandsController.revendas?.forEach((rev) {
      print(rev.RevendaNome.toString());
      widget.listaRevendas.add(rev.RevendaNome.toString());
    });
    print('lista revendas: ' + widget.listaRevendas.length.toString());

    widget.partnersController.parceiros?.forEach((part) {
      print(part.ParceiroEntregaNome.toString());
      widget.listaParceiros.add(part.ParceiroEntregaNome.toString());
    });
    print('lista parceiros: ' + widget.listaParceiros.length.toString());

    widget.textColor = widget._loginController.colorFromHex(widget
        ._loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());
    widget.iconColor = widget._loginController.colorFromHex(widget
        ._loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'backDark')
        .first
        .coreValor
        .toString());

    widget.mofferController.txtTitulo.text = '';
    // widget.mofferController.txtValorTaxa1km.text = '0.00';
    // widget.mofferController.txtValorTaxaMaisQue2km.text = '0.00';
    // widget.mofferController.txtValorTaxa2km.text = '0.00';
    widget.mofferController.txtCodigoAlt.text = '';
    widget.mofferController.txtCepDistancia.text = '0';
    // widget.mofferController.txtValorSinalOrc.text = '0.00';
    widget.mofferController.txtValidade.text = '0';
    // widget.mofferController.txtPesoPorcao.text = '0.00';
    widget.mofferController.txtPesoPorcaoUn.text = '';
    widget.mofferController.txtDescricao.text = '';
    widget.mofferController.txtDetalhes.text = '';
    widget.mofferController.txtTamanhos.text = '';
    widget.mofferController.txtCores.text = '';
    // widget.mofferController.txtPreco.text = '0.00';
    // widget.mofferController.txtValorMin.text = '0.00';
    // widget.mofferController.txtMarca.text = '';
    widget.mofferController.txtQtdMaxPorVenda.text = '0';
    widget.mofferController.txtQtdDispo.text = '0';
    widget.mofferController.txtQtdAviso.text = '0';

    //final LoginController loginController = Get.find();
    widget.mofferController.txtCEP.text =
        widget._loginController.usuCep.toString();

    _manageCampos();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget._priceFocusNode.dispose();
    widget._descriptionFocusNode.dispose();
    widget._imageURLFocusNode.removeListener(_updateImageUrl);
    widget._imageURLFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('build');
    //if (ModalRoute.of(context)?.settings.arguments != null) {}

    return FutureBuilder(
        future: ModalRoute.of(context)?.settings.arguments != null
            ? carregaObjs()
            : null, // widget.categoriesController.getCategoriesNames(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(double.maxFinite, 55),
                child: AppBar(
                  elevation: 0,
                  centerTitle: false,
                  backgroundColor: widget._loginController.colorFromHex(widget
                      ._loginController.listCore
                      .where((coreItem) => coreItem.coreChave == 'backLight')
                      .first
                      .coreValor
                      .toString()),
                  title: Text(
                    'Minha oferta',
                    style: TextStyle(fontSize: 25, color: widget.textColor),
                  ),
                ),
              ),
              //drawer: DrawerHome(0),
              body: widget._isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GradientHeaderHome(
                      child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: widget._form,
                        child: ListView(
                          children: [
                            const SizedBox(height: 20),

                            ListTile(
                              leading: Text('Categoria'),
                              trailing:
                                  ModalRoute.of(context)?.settings.arguments ==
                                          null
                                      ? DropdownButton<String>(
                                          items: widget.categoriesController
                                              .listaCategorias
                                              ?.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          value: widget.categoriaSel,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              widget.categoriaSel = newValue!;
                                              widget.categSelecionada = widget
                                                  .categoriesController
                                                  .selecionaCategoriaPorNome(
                                                      widget.categoriaSel)!;

                                              _manageCampos();
                                            });
                                          },
                                        )
                                      : Text(widget.categoriaSel),
                            ),

                            const SizedBox(height: 20),

                            if (widget.showCamposBasicos)
                              Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller:
                                        widget.mofferController.txtTitulo,
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
                                        widget.mofferController.txtDescricao,
                                    decoration: InputDecoration(
                                      labelText: 'Descrição',
                                      border: OutlineInputBorder(),
                                    ),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: this.widget.valPrecoCombinar,
                                        onChanged: (val) {
                                          setState(() {
                                            this.widget.valPrecoCombinar = val!;
                                          });
                                        },
                                        activeColor: Colors.blue,
                                      ),
                                      const SizedBox(width: 20),
                                      Text('Preco à combinar'),
                                      const SizedBox(height: 20)
                                    ],
                                  ),
                                ],
                              ),

                            if (widget.showPreco && !widget.valPrecoCombinar)
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Switch(
                                          value: widget.valPrecoInicial,
                                          onChanged: (bool val) {
                                            setState(() {
                                              widget.valPrecoInicial = val;
                                            });
                                          }),
                                      const SizedBox(width: 20),
                                      Text(widget.valPrecoInicial
                                          ? 'Preco à partir de'
                                          : 'Preço fechado'),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                  TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CentavosInputFormatter(),
                                    ],
                                    controller:
                                        widget.mofferController.txtPreco,
                                    // initialValue: '0',

                                    decoration: InputDecoration(
                                      labelText: 'Preço',
                                      prefix: Text('R\$ '),
                                      border: OutlineInputBorder(),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    focusNode: widget._priceFocusNode,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).requestFocus(
                                          widget._descriptionFocusNode);
                                    },
                                    validator: (value) {
                                      double xPreco = double.parse(value
                                          .toString()
                                          .replaceAll('.', '')
                                          .replaceAll(',', '.'));
                                      if (xPreco <= 0 &&
                                          !widget.valPrecoCombinar)
                                        return 'Valor precisa ser maior do que zero, ou marque como Preço à combinar';
                                      return null;
                                    },
                                  ),

                                  if (widget.showTxtValorSinalOrc)
                                    Column(children: <Widget>[
                                      const SizedBox(width: 20),
                                      Row(
                                        children: <Widget>[
                                          Switch(
                                              value: widget.valSinalPercentual,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  widget.valSinalPercentual =
                                                      val;
                                                });
                                              }),
                                          const SizedBox(width: 20),
                                          Text(widget.valSinalPercentual
                                              ? 'Sinal em Percentual (opcional)'
                                              : 'Sinal em valor cheio (opcional)'),
                                          const SizedBox(height: 20)
                                        ],
                                      ),
                                      TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CentavosInputFormatter(),
                                          ],
                                          // initialValue: '0',
                                          controller: widget.mofferController
                                              .txtValorSinalOrc,
                                          decoration: InputDecoration(
                                              prefix: Text(
                                                  widget.valSinalPercentual
                                                      ? '%'
                                                      : 'R\$ '),
                                              border: OutlineInputBorder(),
                                              labelText:
                                                  'Valor Sinal/Orçamento'),
                                          keyboardType: TextInputType.number),
                                      const SizedBox(width: 20),
                                    ]),

                                  if (widget.showAceitaProposta)
                                    Row(
                                      children: <Widget>[
                                        Switch(
                                            value: widget.valAceitaProposta,
                                            onChanged: (bool val) {
                                              setState(() {
                                                widget.valAceitaProposta = val;
                                              });
                                            }),
                                        const SizedBox(width: 20),
                                        Text('Aceita contra proposta'),
                                      ],
                                    ),

                                  if (widget.valAceitaProposta)
                                    Column(children: <Widget>[
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CentavosInputFormatter(),
                                        ],
                                        // initialValue: '0',
                                        controller:
                                            widget.mofferController.txtValorMin,
                                        decoration: InputDecoration(
                                          labelText: 'Valor mín',
                                          prefix: Text('R\$ '),
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                    ]),

                                  // if (showTxtValorSinalOrc)
                                ],
                              ),

                            if (widget.showQtd && widget.showCamposBasicos)
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Switch(
                                          value: widget.valQtd,
                                          onChanged: (bool val) {
                                            setState(() {
                                              widget.valQtd = val;
                                            });
                                          }),
                                      const SizedBox(width: 20),
                                      Text(widget.valQtd
                                          ? 'Controla quantidade'
                                          : 'Sem controle de quantidade'),
                                      const SizedBox(height: 10)
                                    ],
                                  ),
                                  if (widget.valQtd)
                                    Column(children: <Widget>[
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller:
                                            widget.mofferController.txtQtdDispo,
                                        decoration: InputDecoration(
                                          labelText: 'Qtd disponível',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          int xQtdDispo =
                                              int.parse(value.toString());
                                          if (xQtdDispo <= 0)
                                            return 'Quantidade disponível precisa ser maior do que zero, ou marque como Sem controle de quantidade';
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        controller: widget
                                            .mofferController.txtQtdMaxPorVenda,
                                        decoration: InputDecoration(
                                          labelText: 'Qtd máxima por venda',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller:
                                            widget.mofferController.txtQtdAviso,
                                        decoration: InputDecoration(
                                          labelText: 'Qtd aviso acabando',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ]),
                                ],
                              ),

                            if (widget.showTxtPesoPorcao)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      PesoInputFormatter(),
                                    ],
                                    controller:
                                        widget.mofferController.txtPesoPorcao,
                                    decoration: InputDecoration(
                                      labelText: 'Peso/Porção',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number),
                              ]),

                            if (widget.showTxtPesoPorcaoUn)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                    controller:
                                        widget.mofferController.txtPesoPorcaoUn,
                                    decoration: InputDecoration(
                                      labelText: 'Peso/Porção Unidade',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      double xPeso = double.parse(widget
                                          .mofferController.txtPesoPorcao
                                          .toString()
                                          .replaceAll('.', '')
                                          .replaceAll(',', '.'));
                                      if (xPeso > 0 && value.toString() == '')
                                        return 'Favor informar uma unidade de peso';
                                      return null;
                                    },
                                    keyboardType: TextInputType.text),

                                // if (showTxtSabor)
                                //   TextFormField(
                                //       controller: widget.mofferController.txtSabor,
                                //       decoration: InputDecoration(labelText: 'Sabores divididos por /'),
                                //       keyboardType: TextInputType.multiline),
                              ]),

                            if (widget.showTxtValidade)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                    controller:
                                        widget.mofferController.txtValidade,
                                    decoration: InputDecoration(
                                        suffix: Text('dias'),
                                        border: OutlineInputBorder(),
                                        labelText: widget.labelValidade +
                                            ' (ex: 5 dias)'),
                                    keyboardType: TextInputType.number),
                              ]),

                            if (widget.showTxtCep)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CepInputFormatter(),
                                  ],
                                  controller: widget.mofferController.txtCEP,
                                  decoration: InputDecoration(
                                    labelText: 'Cep da oferta',
                                    fillColor: Colors.redAccent.shade100,
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ]),

                            if (widget.showTxtOfertaCepDistancia &&
                                widget.showCamposBasicos)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller:
                                      widget.mofferController.txtCepDistancia,
                                  decoration: InputDecoration(
                                      suffix: Text('Km '),
                                      border: OutlineInputBorder(),
                                      labelText: 'Distância de ' +
                                          widget.labelEntrega +
                                          ' em Km'),
                                  keyboardType: TextInputType.number,
                                ),
                              ]),

                            // if (widget.showTxtMarca)
                            //   Column(children: <Widget>[
                            //     const SizedBox(height: 20),
                            //     TextFormField(
                            //         controller:
                            //             widget.mofferController.txtMarca,
                            //         decoration: InputDecoration(
                            //           labelText: 'Marca',
                            //           border: OutlineInputBorder(),
                            //         ),
                            //         keyboardType: TextInputType.text),
                            //   ]),

                            if (widget.showTxtMarca)
                              Column(
                                children: <Widget>[
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Text('Revenda'),
                                  const SizedBox(height: 10),
                                  DropdownButton<String>(
                                    items: widget.listaRevendas
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: widget.revendaSel,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        widget.revendaSel = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),

                            if (widget.showTxtCodigoAlt)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                    controller:
                                        widget.mofferController.txtCodigoAlt,
                                    decoration: InputDecoration(
                                      labelText: 'Código da revenda',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.text),
                              ]),

                            if (widget.showTxtCores)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Cores ',
                                      hintText: '(separadas por /)',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller:
                                        widget.mofferController.txtCores,
                                    keyboardType: TextInputType.multiline),
                              ]),

                            if (widget.showTxtTamanhos)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Tamanhos ',
                                      hintText: '(separados por /)',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller:
                                        widget.mofferController.txtTamanhos,
                                    keyboardType: TextInputType.multiline),
                              ]),

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

                            if (widget.showCamposBasicos)
                              Column(children: <Widget>[
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller:
                                      widget.mofferController.txtDetalhes,
                                  decoration: InputDecoration(
                                      labelText: 'Informações adicionais',
                                      border: OutlineInputBorder()),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                ),
                              ]),

                            if (widget.show24hs)
                              Row(
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Switch(
                                      value: widget.val24hs,
                                      onChanged: (bool val) {
                                        setState(() {
                                          widget.val24hs = val;
                                        });
                                      }),
                                  const SizedBox(width: 20),
                                  Text('24hs'),
                                  const SizedBox(height: 20),
                                ],
                              ),

                            if (widget.showDispoImediata && !widget.show24hs)
                              Row(
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Switch(
                                      value: widget.valDispoImediata,
                                      onChanged: (bool val) {
                                        setState(() {
                                          widget.valDispoImediata = val;
                                        });
                                      }),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(widget.valDispoImediata
                                        ? 'Disponibilidade imediata (o tempo todo)'
                                        : 'Disponibilidade agendada'),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),

                            if (!widget.valDispoImediata)
                              Column(children: <Widget>[
                                Row(children: <Widget>[
                                  const SizedBox(height: 20),
                                  // SEGUNDA
                                  Checkbox(
                                    value: this.widget.valSeg,
                                    onChanged: (val) {
                                      setState(() {
                                        this.widget.valSeg = val!;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text('segunda '),
                                ]),

                                //const SizedBox(),
                                if (widget.valSeg)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valSegDas)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valSegAs)
                                            ],
                                          )),
                                    ],
                                  ),

                                // TERÇA
                                Row(children: <Widget>[
                                  Checkbox(
                                    value: this.widget.valTer,
                                    onChanged: (val) {
                                      setState(() {
                                        this.widget.valTer = val!;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text('terça ')
                                ]),

                                //const SizedBox(height: 5),
                                if (widget.valTer)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valTerDas)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valTerAs)
                                            ],
                                          )),
                                    ],
                                  ),

                                Row(children: <Widget>[
                                  Checkbox(
                                    value: this.widget.valQua,
                                    onChanged: (val) {
                                      setState(() {
                                        this.widget.valQua = val!;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text('quarta '),
                                ]),

                                //const SizedBox(height: 5),
                                if (widget.valQua)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valQuaDas)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valQuaAs)
                                            ],
                                          )),
                                    ],
                                  ),

                                Row(children: <Widget>[
                                  Checkbox(
                                    value: this.widget.valQui,
                                    onChanged: (val) {
                                      setState(() {
                                        this.widget.valQui = val!;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text('quinta '),
                                ]),

                                //const SizedBox(height: 5),
                                if (widget.valQui)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valQuiDas)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valQuiAs)
                                            ],
                                          )),
                                    ],
                                  ),

                                Row(children: <Widget>[
                                  Checkbox(
                                    value: this.widget.valSex,
                                    onChanged: (val) {
                                      setState(() {
                                        this.widget.valSex = val!;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text('sexta '),
                                ]),

                                //const SizedBox(height: 5),
                                if (widget.valSex)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valSexDas)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valSexAs)
                                            ],
                                          )),
                                    ],
                                  ),

                                Row(children: <Widget>[
                                  Checkbox(
                                    value: this.widget.valSab,
                                    onChanged: (val) {
                                      setState(() {
                                        this.widget.valSab = val!;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text('sábado '),
                                ]),

                                //const SizedBox(height: 5),
                                if (widget.valSab)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valSabDas)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valSabAs)
                                            ],
                                          )),
                                    ],
                                  ),

                                Row(children: <Widget>[
                                  Checkbox(
                                    value: this.widget.valDom,
                                    onChanged: (val) {
                                      setState(() {
                                        this.widget.valDom = val!;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text('domingo '),
                                ]),

                                //const SizedBox(height: 5),
                                if (widget.valDom)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valDomDas)
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
                                                      widget.mofferController
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget
                                                  .mofferController.valDomAs)
                                            ],
                                          )),
                                    ],
                                  ),
                              ]),

                            const SizedBox(height: 10),
                            const Divider(),
                            if (widget.showMostraReview)
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: widget.valMostraReview,
                                      onChanged: (bool val) {
                                        setState(() {
                                          widget.valMostraReview = val;
                                        });
                                      }),
                                  const SizedBox(width: 20),
                                  Text('Mostrar opiniões'),
                                  const SizedBox(height: 20)
                                ],
                              ),

                            if (widget.showAceiteAuto)
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: widget.valAceiteAuto,
                                      onChanged: (bool val) {
                                        setState(() {
                                          widget.valAceiteAuto = val;
                                        });
                                      }),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                        'Aceite automático dentro do horário'),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),

                            if (widget.showAceitaEncomenda)
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: widget.valAceitaEncomenda,
                                      onChanged: (bool val) {
                                        setState(() {
                                          widget.valAceitaEncomenda = val;
                                          print('valAceitaEncomenda: ' +
                                              widget.valAceitaEncomenda
                                                  .toString());
                                        });
                                      }),
                                  const SizedBox(width: 20),
                                  Text('Aceita encomenda'),
                                ],
                              ),

                            if (widget.valAceitaEncomenda)
                              Row(
                                children: <Widget>[
                                  const SizedBox(width: 40),
                                  Switch(
                                      value: widget.valSomenteEncomenda,
                                      onChanged: (bool val) {
                                        setState(() {
                                          widget.valSomenteEncomenda = val;
                                          print('valSomenteEncomenda: ' +
                                              widget.valSomenteEncomenda
                                                  .toString());
                                        });
                                      }),
                                  const SizedBox(width: 10),
                                  Text('Somente encomenda'),
                                  Row(children: <Widget>[
                                    const SizedBox(height: 30),
                                    Text('A partir de: '),
                                  ]),
                                  ElevatedButton(
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 1000)))
                                            .then((value) => setState(() {
                                                  widget.mofferController
                                                          .valEncomendasAPartir =
                                                      value!;
                                                }));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                        widget._loginController.colorFromHex(
                                            widget._loginController.listCore
                                                .where((coreItem) =>
                                                    coreItem.coreChave ==
                                                    'backDark')
                                                .first
                                                .coreValor
                                                .toString()),
                                      )),
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_today_rounded),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(widget.mofferController
                                                  .valEncomendasAPartir.day
                                                  .toString() +
                                              '/' +
                                              widget.mofferController
                                                  .valEncomendasAPartir.month
                                                  .toString() +
                                              '/' +
                                              widget.mofferController
                                                  .valEncomendasAPartir.year
                                                  .toString())
                                        ],
                                      )),
                                  const SizedBox(height: 20),
                                ],
                              ),

                            if (widget.showCamposBasicos)
                              Column(
                                children: <Widget>[
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Text('Forma de Fechamento'),
                                  const SizedBox(height: 10),
                                  DropdownButton<String>(
                                    items: widget.listaFormaFechamento
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: widget.formaFechSel,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        widget.formaFechSel = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),

                            const SizedBox(height: 20),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     SizedBox(height: 20),
                            //     Divider(),
                            //   ],
                            // ),

                            if (widget
                                .showCamposEntrega) // && widget.categSelecionada.categoriaFormasEntrega!.contains('other'))
                              Column(
                                children: <Widget>[
                                  Text('Agente de ' + widget.labelEntrega),
                                  Row(
                                    children: <Widget>[
                                      Switch(
                                          value: widget.valAceitaEntregaComprador,
                                          onChanged: (bool val) {
                                            setState(() {
                                              widget.valAceitaEntregaComprador = val;
                                            });
                                          }),
                                      const SizedBox(width: 20),
                                      Text('Entrega por comprador'),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Switch(
                                          value: widget.valAceitaEntregaVendedor,
                                          onChanged: (bool val) {
                                            setState(() {
                                              widget.valAceitaEntregaVendedor = val;
                                            });
                                          }),
                                      const SizedBox(width: 20),
                                      Text('Entrega por vendedor'),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Switch(
                                          value: widget.valAceitaEntregaParceiro,
                                          onChanged: (bool val) {
                                            setState(() {
                                              // configura lista de parceiros
                                                    widget.listaParceiros.clear();
                                                    widget.listaParceiros.add('escolha o parceiro');
                                                    widget.partnersController.parceiros
                                                        ?.forEach((part) {
                                                      print(part.ParceiroEntregaNome
                                                          .toString());
                                                      widget.listaParceiros.add(part
                                                          .ParceiroEntregaNome.toString());
                                                    });
                                              widget.valAceitaEntregaParceiro = val;
                                            });
                                          }),
                                      const SizedBox(width: 20),
                                      Text('Entrega por parceiro'),
                                    ],
                                  ),

                                  // DropdownButton<String>(
                                  //   items: widget.listaFormaEntrega
                                  //       .map((String value) {
                                  //     return DropdownMenuItem<String>(
                                  //       value: value,
                                  //       child: Text(value),
                                  //     );
                                  //   }).toList(),
                                  //   value: widget.agenteEntregaSel,
                                  //   onChanged: (String? newValue) {
                                  //     if (newValue == 'parceiro') {
                                  //       // configura lista de parceiros
                                  //       widget.listaParceiros.clear();
                                  //       widget.listaParceiros.add('escolha o parceiro');
                                  //       widget.partnersController.parceiros
                                  //           ?.forEach((part) {
                                  //         print(part.ParceiroEntregaNome
                                  //             .toString());
                                  //         widget.listaParceiros.add(part
                                  //             .ParceiroEntregaNome.toString());
                                  //       });
                                  //       print('lista parceiros: ' +
                                  //           widget.listaParceiros.length
                                  //               .toString());
                                  //     }
                                  //
                                  //     setState(() {
                                  //       widget.agenteEntregaSel = newValue!;
                                  //     });
                                  //   },
                                  // ),
                                  if (widget.valAceitaEntregaParceiro)
                                    Column(
                                      children: <Widget>[
                                        //const SizedBox(height: 20),
                                        const Divider(),
                                        const SizedBox(height: 10),
                                        // Text('Parceiro'),
                                        // const SizedBox(height: 10),
                                        DropdownButton<String>(
                                          items: widget.listaParceiros
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          value: widget.parceiroSel,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              widget.parceiroSel = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Disponibilidade de " +
                                        widget.labelEntrega +
                                        ' à partir de: ',
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 1000)))
                                            .then((value) => setState(() {
                                                  widget.mofferController
                                                          .valEntregasAPartir =
                                                      value!;
                                                }));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                        widget._loginController.colorFromHex(
                                            widget._loginController.listCore
                                                .where((coreItem) =>
                                                    coreItem.coreChave ==
                                                    'backDark')
                                                .first
                                                .coreValor
                                                .toString()),
                                      )),
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_today_rounded),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(widget.mofferController
                                                  .valEntregasAPartir.day
                                                  .toString() +
                                              '/' +
                                              widget.mofferController
                                                  .valEntregasAPartir.month
                                                  .toString() +
                                              '/' +
                                              widget.mofferController
                                                  .valEntregasAPartir.year
                                                  .toString())
                                        ],
                                      )),
                                  const SizedBox(height: 20),

                                  Text("Horário de " + widget.labelEntrega),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      const SizedBox(width: 5),
                                      Text('Das '),
                                      const SizedBox(width: 5),
                                      ElevatedButton(
                                          onPressed: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime: TimeOfDay(
                                                        hour: 08, minute: 00))
                                                .then((value) => setState(() {
                                                      widget.mofferController
                                                              .valEntregaDas =
                                                          value!.hour
                                                                  .toString()
                                                                  .padLeft(
                                                                      2, '0') +
                                                              ':' +
                                                              value.minute
                                                                  .toString()
                                                                  .padLeft(
                                                                      2, '0');
                                                    }));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget.mofferController
                                                  .valEntregaDas)
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
                                                      widget.mofferController
                                                          .valEntregaAs = value!
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
                                            widget._loginController
                                                .colorFromHex(widget
                                                    ._loginController.listCore
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
                                              Text(widget.mofferController
                                                  .valEntregaAs)
                                            ],
                                          )),
                                    ],
                                  ),
                                  if (widget.labelEntrega == 'Entrega')
                                    Column(
                                      children: <Widget>[
                                        const SizedBox(height: 20),
                                        Text(
                                          "Taxas de Entrega",
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CentavosInputFormatter(),
                                          ],
                                          // initialValue: '0',
                                          controller: widget
                                              .mofferController.txtValorTaxa1km,
                                          decoration: InputDecoration(
                                              prefix: Text('R\$ '),
                                              border: OutlineInputBorder(),
                                              labelText: 'Até 1km'),
                                          textInputAction: TextInputAction.next,
                                          //focusNode: _priceFocusNode,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CentavosInputFormatter(),
                                          ],
                                          // initialValue: '0',
                                          controller: widget
                                              .mofferController.txtValorTaxa2km,
                                          decoration: InputDecoration(
                                              prefix: Text('R\$ '),
                                              border: OutlineInputBorder(),
                                              labelText: 'Entre 1km e 2km'),
                                          textInputAction: TextInputAction.next,
                                          //focusNode: _priceFocusNode,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CentavosInputFormatter(),
                                          ],
                                          // initialValue: '0',
                                          controller: widget.mofferController
                                              .txtValorTaxaMaisQue2km,
                                          decoration: InputDecoration(
                                              prefix: Text('R\$ '),
                                              border: OutlineInputBorder(),
                                              labelText: 'Acima de 2km'),
                                          textInputAction: TextInputAction.next,
                                          //focusNode: _priceFocusNode,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                        const SizedBox(height: 20),
                                        // Text('Tempo de Entrega após aceite'),
                                        TextFormField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Tempo de entrega após aceite'),
                                            keyboardType: TextInputType.number),
                                        const SizedBox(height: 20),
                                        Text('Unidade de Tempo'),
                                        DropdownButton<String>(
                                          items: widget.listaTempoEntregaTipo
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          value: widget.tempoEntregaTipoSel,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              widget.tempoEntregaTipoSel =
                                                  newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              ),

                            if (widget.showCamposBasicos)
                              Column(children: <Widget>[
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () => pegarImagemGaleria(),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                      widget._loginController.colorFromHex(
                                          widget._loginController.listCore
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
                                if (widget.imgcloud != '')
                                  CachedNetworkImage(
                                    imageUrl: widget.imgcloud,
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
                                //   image: widget.imgcloud,
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
                                    colorText: widget._loginController
                                        .colorFromHex(widget
                                            ._loginController.listCore
                                            .where((coreItem) =>
                                                coreItem.coreChave ==
                                                'textLight')
                                            .first
                                            .coreValor
                                            .toString()),
                                    colorButton: widget._loginController
                                        .colorFromHex(widget
                                            ._loginController.listCore
                                            .where((coreItem) =>
                                                coreItem.coreChave ==
                                                'iconColor')
                                            .first
                                            .coreValor
                                            .toString()),
                                    onPressed: () {
                                      uploadFoto(
                                              image == null ? null : image,
                                              widget._loginController.usuGuid
                                                  .toString())
                                          .then((value) => Get.offAndToNamed(
                                              AppRoutes.mOffers));
                                    }),
                              ])
                          ],
                        ),
                      ),
                    )),
            );
          }
        });
  }

  Future pegarImagemGaleria() async {
    try {
      final foto = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 70, maxHeight: 300);
      if (foto == null) return;

      final imageTemp = File(foto.path);

      setState(() => this.image = imageTemp);

      widget.imgEdited = true;
    } on PlatformException catch (e) {
      print('erro tentando abrir album de fotos: $e');
    }
  }

  Future<void> uploadFoto(File? foto, String usuGuid) async {
    await _saveForm(usuGuid);

    if (widget.imgEdited && foto != null) {
      await Firebase.initializeApp();

      print('passou no upload');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("ofertas")
          .child(widget.offerGuid + '.jpg');

      await ref.putFile(image!);
      //var downloadURL = await ref.getDownloadURL();
    }
    //showSnackBar("Oferta salva! - " + widget.offerGuid, Duration(seconds: 3));

    Get.defaultDialog(
        title: "Aviso", middleText: "Informações atualizadas com sucesso!");
  }

  //snackbar for  showing error
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _updateImageUrl() {
    if (isValidImageUrl(widget._imageURLController.text)) {
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
    var formaFechto = '';
    switch (widget.formaFechSel) {
      case 'mensagem no aplicativo (seguro)':
        formaFechto = 'chatapp';
        break;
      case 'pagamento no aplicativo (seguro)':
        formaFechto = 'gatewayapi';
        break;
      default:
        formaFechto = widget.formaFechSel;
    }

    double valPreco = 0.0;
    if (widget.categSelecionada.categoriaChave != 'DOACAO')
      valPreco = double.parse(widget.mofferController.txtPreco.text
          .replaceAll('.', '')
          .replaceAll(',', '.'));

    var offerToSend = new Oferta(
        0,
        widget.categSelecionada.categoriaChave,
        usuGuid,
        widget.mofferController.txtTitulo.text,
        widget.mofferController.txtDetalhes.text,
        double.parse(widget.mofferController.txtPreco.text),
        null,
        null,
        null,
        '',
        1,
        widget.mofferController.txtCEP.text.replaceAll('-', ''),
        null,
        null,
        0,
        0,
        0,
        0,
        null,
        widget.mofferController.mofferGuid == null
            ? null
            : widget.mofferController.mofferGuid.toString(),
        int.parse(widget.mofferController.txtQtdDispo.text),
        int.parse(widget.mofferController.txtQtdMaxPorVenda.text),
        int.parse(widget.mofferController.txtQtdAviso.text),
        double.parse(widget.mofferController.txtPesoPorcao.text),
        widget.mofferController.txtPesoPorcaoUn.text,
        int.parse(widget.mofferController.txtValidade.text),
        double.parse(widget.mofferController.txtValorMin.text),
        widget.valMostraReview,
        widget.valAceiteAuto,
        widget.valAceitaEncomenda,
        widget.valSomenteEncomenda,
        widget.valAceitaProposta,
        int.parse(widget.mofferController.txtTempoEntrega
            .text), //int.parse(widget.mofferController.txtTempoEntrega.text),
        widget.tempoEntregaTipoSel,
        formaFechto,
        widget.agenteEntregaSel,
        '',
        '',
        //widget.mofferController.txtMarca.text,
        widget.revendaSel,
        widget.mofferController.txtCores.text,
        widget.mofferController.txtTamanhos.text,
        widget.val24hs,
        int.parse(widget.mofferController.txtCepDistancia.text),
        0.00, // double.parse(widget.mofferController.txtValorSinalOrc.text),
        widget.mofferController.valEncomendasAPartir.toString(),
        widget.mofferController.valEntregasAPartir.toString(),
        widget.mofferController.txtCodigoAlt.text,
        double.parse(widget.mofferController.txtValorTaxa1km.text),
        double.parse(widget.mofferController.txtValorTaxa2km.text),
        double.parse(widget.mofferController.txtValorTaxaMaisQue2km.text),
        widget.valQtd,
        widget.valSinalPercentual ? "P" : "V",
        widget.valPrecoInicial,
        widget.valPrecoCombinar,
        widget.valSeg,
        widget.valTer,
        widget.valQua,
        widget.valQui,
        widget.valSex,
        widget.valSab,
        widget.valDom,
        widget.mofferController.valSegDas,
        widget.mofferController.valSegAs,
        widget.mofferController.valTerDas,
        widget.mofferController.valTerAs,
        widget.mofferController.valQuaDas,
        widget.mofferController.valQuaAs,
        widget.mofferController.valQuiDas,
        widget.mofferController.valQuiAs,
        widget.mofferController.valSexDas,
        widget.mofferController.valSexAs,
        widget.mofferController.valSabDas,
        widget.mofferController.valSabAs,
        widget.mofferController.valDomDas,
        widget.mofferController.valDomAs,
        null,
      null,null,null,null,null
    );

    // Uri url = Uri.https("ec3digrepo-default-rtdb.firebaseio.com", "/words.json");

    if (widget.mofferController.mofferGuid == null) {
      var response = await post(
        Uri.parse('${Constants.baseUrl}mofferadd'),
        headers: Constants.headers,
        body: offerToSend.toJsonPost(),
      );

      print(response.body);

      var jsonResp = jsonDecode(response.body);
      var strGuid = jsonResp['insert_Ofertas_one']['OfertaGUID'];

      widget.offerGuid = strGuid;
      print('guid: ' + strGuid);
    } else {
      print(offerToSend.toJsonPut());
      var response = await put(
        Uri.parse('${Constants.baseUrl}mofferupd'),
        headers: Constants.headers,
        body: offerToSend.toJsonPut(),
      );

      print(response.body);

      var jsonResp = jsonDecode(response.body);
      var strGuid = jsonResp['update_Ofertas']['returning'][0]['OfertaGUID'];

      print('guid: ' + strGuid);
    }
  }

  // somente para testes - em producao virá a partir do Firebase
  void _manageCampos() {
    print('manageCampos: ' + widget.categSelecionada.secao.toString());
    if (widget.categSelecionada.secao == null) {
      widget.labelEntrega = 'Entrega';
      widget.showQtd = false;
      widget.showCamposBasicos = false;
      widget.showCamposEntrega = false;
      widget.showPreco = false;
      widget.showTxtQtdDispo = false;
      widget.showTxtValorMin = false;
      widget.showTxtMarca = false;
      widget.showTxtCep = false;
      //showTxtQtdMaxPorVenda = false;
      //showTxtQtdAviso = false;
      widget.show24hs = false;
      widget.showAceitaProposta = false;
      widget.showSomenteEncomenda = false;
      widget.showAceitaEncomenda = false;
      widget.showAceiteAuto = false;
      widget.showMostraAval = false;
      widget.showMostraReview = false;
      widget.showDispoImediata = false;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = false;
      // showListaTempoEntregaTipo = false;
      // showTxtTempoEntrega = false;
      widget.showTxtCores = false;
      widget.showTxtTamanhos = false;
      widget.showTxtPesoPorcao = false;
      widget.showTxtPesoPorcaoUn = false;
      widget.showTxtValidade = false;
      widget.showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = false;
      widget.showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-SERV-CASA' ||
        widget.categSelecionada.secao == 'SEC-SERV-FRETE' ||
        widget.categSelecionada.secao == 'SEC-SERV-VOCE' ||
        widget.categSelecionada.secao == 'SEC-SERV-CARRO' ||
        widget.categSelecionada.secao == 'SEC-SERV-PET') {
      widget.labelEntrega = 'Atendimento';
      widget.labelValidade = 'Garantia';
      widget.showQtd = false;
      widget.showCamposBasicos = true;
      widget.showPreco = true;
      widget.showTxtQtdDispo = false;
      widget.showTxtValorMin = false;
      widget.showTxtMarca = false;
      widget.showTxtCep = true;
      widget.valQtd = false;
      // showTxtQtdMaxPorVenda = false;
      // showTxtQtdAviso = false;
      widget.show24hs = true;
      widget.showAceitaProposta = true;
      widget.showSomenteEncomenda = false;
      widget.showAceitaEncomenda = false;
      widget.showAceiteAuto = false;
      widget.showMostraAval = true;
      widget.showMostraReview = true;
      widget.showDispoImediata = true;
      widget.showCamposEntrega = false;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = false;
      //showListaTempoEntregaTipo = false;
      // showTxtTempoEntrega = false;
      widget.showTxtCores = false;
      widget.showTxtTamanhos = false;
      widget.showTxtPesoPorcao = false;
      widget.showTxtPesoPorcaoUn = false;
      widget.showTxtValidade = true;
      widget.showTxtValorSinalOrc = true;
      // showTxtEntregaTaxas = false;
      widget.showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-DESAPEGO') {
      widget.labelEntrega = 'Entrega';
      widget.showQtd = false;
      widget.showCamposBasicos = true;
      widget.showCamposEntrega = true;
      widget.showPreco = true;
      widget.showTxtQtdDispo = true;
      widget.showTxtValorMin = false;
      widget.showTxtMarca = true;
      widget.showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = false;
      widget.show24hs = false;
      widget.showAceitaProposta = true;
      widget.showSomenteEncomenda = false;
      widget.showAceitaEncomenda = false;
      widget.showAceiteAuto = true;
      widget.showMostraAval = false;
      widget.showMostraReview = false;
      widget.showDispoImediata = true;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = true;
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      widget.showTxtCores = true;
      widget.showTxtTamanhos = true;
      widget.showTxtPesoPorcao = false;
      widget.showTxtPesoPorcaoUn = false;
      widget.showTxtValidade = false;
      widget.showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      widget.showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-ACHADOPERDIDO') {
      widget.labelEntrega = 'Entrega';
      widget.showQtd = false;
      widget.showCamposBasicos = true;
      widget.showPreco = false;
      widget.showTxtQtdDispo = true;
      widget.showTxtValorMin = false;
      widget.showTxtMarca = true;
      widget.showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = false;
      widget.show24hs = false;
      widget.showAceitaProposta = true;
      widget.showSomenteEncomenda = false;
      widget.showAceitaEncomenda = false;
      widget.showAceiteAuto = true;
      widget.showMostraAval = false;
      widget.showMostraReview = false;
      widget.showDispoImediata = true;
      widget.showCamposEntrega = false;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = true;
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      widget.showTxtCores = true;
      widget.showTxtTamanhos = true;
      widget.showTxtPesoPorcao = false;
      widget.showTxtPesoPorcaoUn = false;
      widget.showTxtValidade = false;
      widget.showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = false;
      widget.showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-BELEZA') {
      widget.labelEntrega = 'Entrega';
      widget.showQtd = true;
      widget.showCamposBasicos = true;
      widget.showPreco = true;
      widget.showTxtQtdDispo = true;
      widget.showTxtValorMin = true;
      widget.showTxtMarca = true;
      widget.showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = true;
      widget.show24hs = false;
      widget.showAceitaProposta = true;
      widget.showSomenteEncomenda = true;
      widget.showAceitaEncomenda = true;
      widget.showAceiteAuto = true;
      widget.showMostraAval = true;
      widget.showMostraReview = true;
      widget.showDispoImediata = true;
      widget.showCamposEntrega = true;
      // showListaFormaEntrega = true;
      // showListaFormaEntrega2 = true;
      // showListaParceiros = true;
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      widget.showTxtCores = true;
      widget.showTxtTamanhos = true;
      widget.showTxtPesoPorcao = true;
      widget.showTxtPesoPorcaoUn = true;
      widget.showTxtValidade = false;
      widget.showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      widget.showTxtCodigoAlt = true;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-COMIDA') {
      widget.labelEntrega = 'Entrega';
      widget.labelValidade = 'Validade';
      widget.showQtd = true;
      widget.showCamposBasicos = true;
      widget.showPreco = true;
      widget.showTxtQtdDispo = true;
      widget.showTxtValorMin = true;
      widget.showTxtMarca = false;
      widget.showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = true;
      widget.show24hs = false;
      widget.showAceitaProposta = true;
      widget.showSomenteEncomenda = true;
      widget.showAceitaEncomenda = true;
      widget.showAceiteAuto = true;
      widget.showMostraAval = true;
      widget.showMostraReview = true;
      widget.showDispoImediata = true;
      widget.showCamposEntrega = true;
      // showListaFormaEntrega = true;
      // showListaFormaEntrega2 = true;
      // showListaParceiros = true;
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      widget.showTxtCores = false;
      widget.showTxtTamanhos = false;
      widget.showTxtPesoPorcao = true;
      widget.showTxtPesoPorcaoUn = true;
      widget.showTxtValidade = true;
      widget.showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      widget.showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-OBJETO') {
      widget.labelEntrega = 'Entrega';
      widget.labelValidade = 'Validade';
      widget.showQtd = true;
      widget.showCamposBasicos = true;
      widget.showPreco = true;
      widget.showTxtQtdDispo = true;
      widget.showTxtValorMin = true;
      widget.showTxtMarca = true;
      widget.showTxtCep = true;
      // showTxtQtdMaxPorVenda = true;
      // showTxtQtdAviso = true;
      widget.show24hs = false;
      widget.showAceitaProposta = true;
      widget.showSomenteEncomenda = true;
      widget.showAceitaEncomenda = true;
      widget.showAceiteAuto = true;
      widget.showMostraAval = true;
      widget.showMostraReview = true;
      widget.showDispoImediata = true;
      widget.showCamposEntrega = true;
      // showListaFormaEntrega = true;
      // showListaFormaEntrega2 = true;
      // showListaParceiros = true;
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      widget.showTxtCores = true;
      widget.showTxtTamanhos = true;
      widget.showTxtPesoPorcao = true;
      widget.showTxtPesoPorcaoUn = true;
      widget.showTxtValidade = false;
      widget.showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      widget.showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-VEST') {
      widget.labelEntrega = 'Entrega';
      widget.showQtd = true;
      widget.showCamposBasicos = true;
      widget.showPreco = true;
      // showTxtQtdDispo = true;
      // showTxtQtdAviso = true;
      widget.showTxtValorMin = true;
      widget.showTxtMarca = true;
      widget.showTxtCep = true;
      widget.showTxtQtdMaxPorVenda = true;
      widget.show24hs = false;
      widget.showAceitaProposta = true;
      widget.showSomenteEncomenda = true;
      widget.showAceitaEncomenda = true;
      widget.showAceiteAuto = true;
      widget.showMostraAval = true;
      widget.showMostraReview = true;
      widget.showDispoImediata = true;
      widget.showCamposEntrega = true;
      // showListaFormaEntrega = true;
      // showListaFormaEntrega2 = true;
      // showListaParceiros = true;
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      widget.showTxtCores = true;
      widget.showTxtTamanhos = true;
      widget.showTxtPesoPorcao = false;
      widget.showTxtPesoPorcaoUn = false;
      widget.showTxtValidade = false;
      widget.showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      widget.showTxtCodigoAlt = false;
    }

    if (widget.showTxtMarca) {
      //configura lista de revendas
      widget.listaRevendas.clear();
      widget.listaRevendas.add('selecione');
      widget.listaRevendas.add('outra');
      widget.brandsController.revendas?.forEach((rev) {
        print(rev.RevendaNome.toString());
        widget.listaRevendas.add(rev.RevendaNome.toString());
      });
    }

    print(widget.categSelecionada.categoriaFormasEntrega.toString());
    print(widget.categSelecionada.categoriaFormasFechto.toString());

    // configura forma de entrega por categoria
    widget.listaFormaEntrega.clear();
    widget.listaFormaEntrega.add('selecione');

    // verifica se existem parceiros de entrega disponíveis na regiao


    if (widget.categSelecionada.categoriaFormasEntrega.toString().contains('/'))
      widget.categSelecionada.categoriaFormasEntrega?.split('/').forEach((fe) {
        print(fe.toString());
        if(fe.toString() == 'parceiro' && widget.partnersController.parceiros!.length > 0)
          widget.listaFormaEntrega.add(fe.toString());
      });
    else
      widget.listaFormaEntrega
          .add(widget.categSelecionada.categoriaFormasEntrega.toString());

    // configura forma de fechamento por categoria
    widget.listaFormaFechamento.clear();
    widget.listaFormaFechamento.add('selecione');

    if (widget.categSelecionada.categoriaFormasFechto
        .toString()
        .contains('/')) {
      widget.categSelecionada.categoriaFormasFechto?.split('/').forEach((ff) {
        print(ff.toString());
        if (ff.contains('chatapp'))
          widget.listaFormaFechamento.add('mensagem no aplicativo (seguro)');
        if (ff.contains('whatsapp'))
          widget.listaFormaFechamento.add('whatsapp');
        if (ff.contains('gatewayapi'))
          widget.listaFormaFechamento.add('pagamento no aplicativo (seguro)');
      });
    } else {
      if (widget.categSelecionada.categoriaFormasFechto.toString() == 'chatapp')
        widget.listaFormaFechamento.add('mensagem no aplicativo (seguro)');
      if (widget.categSelecionada.categoriaFormasFechto.toString() ==
          'whatsapp') widget.listaFormaFechamento.add('whatsapp');
      if (widget.categSelecionada.categoriaFormasFechto.toString() ==
          'gatewayapi')
        widget.listaFormaFechamento.add('pagamento no aplicativo (seguro)');
    }

    //se for doacao, remove o preço
    if (widget.categSelecionada.categoriaChave == 'DOACAO')
      widget.showPreco = false;
  }

  Future<void> carregaObjs() async {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      print('carregaObjs');
      var args = ModalRoute.of(context)?.settings.arguments
          as List<Map<String, Oferta>>;

      Oferta oferta = args.first.values.first;
      widget.editMode = true;
      widget.imgcloud =
          'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
              oferta.OfertaGUID.toString() +
              '.jpg?alt=media';

      print('guidOffer: ' + oferta.OfertaGUID.toString());
      widget.mofferController.mofferGuid = oferta.OfertaGUID.toString();
      print(
          'widget guidOffer: ' + widget.mofferController.mofferGuid.toString());
      widget.mofferController.txtTitulo.text = oferta.OfertaTitulo.toString();

      if (widget.categoriesController.listaCategorias == null)
        await widget.categoriesController.getAllCategories();

      widget.categSelecionada = widget.categoriesController
          .selecionaCategoriaPorChave(oferta.CategoriaChave.toString())!;
      widget.categoriaSel = widget.categSelecionada.categoriaNome!;
      _manageCampos();

      widget.mofferController.valEncomendasAPartir =
          DateTime.parse(oferta.OfertaEncomendasAPartirDe.toString());
      widget.mofferController.txtValorTaxa1km.text =
          oferta.ValorEntregaAte1 == null
              ? '0'
              : oferta.ValorEntregaAte1.toString();
      widget.mofferController.txtValorTaxaMaisQue2km.text =
          oferta.ValorEntregaMaisDe2 == null
              ? '0'
              : oferta.ValorEntregaMaisDe2.toString();
      widget.mofferController.txtValorTaxa2km.text =
          oferta.ValorEntregaAte2 == null
              ? '0'
              : oferta.ValorEntregaAte2.toString();
      widget.mofferController.valEntregasAPartir =
          DateTime.parse(oferta.OfertaEntregasAPartirDe.toString());
      widget.mofferController.txtCodigoAlt.text =
          oferta.OfertaCodigoAlt! == 'null'
              ? ''
              : oferta.OfertaCodigoAlt.toString();
      oferta.OfertaDistanciaKm == null
          ? '0'
          : oferta.OfertaDistanciaKm.toString();
      //widget.mofferController.txtEntregaAs.text = oferta.Ate.toString();
      widget.mofferController.txtValorSinalOrc.text =
          oferta.OfertaSinal == null ? '0' : oferta.OfertaSinal.toString();
      widget.mofferController.txtValidade.text =
          oferta.OfertaDiasValidade == null
              ? '0'
              : oferta.OfertaDiasValidade.toString();
      widget.mofferController.txtPesoPorcao.text =
          oferta.OfertaPeso == null ? '0' : oferta.OfertaPeso.toString();
      //widget.mofferController.txtPesoPorcaoUn.text =oferta.OfertaPesoUnidade == 'null' ? '' :  oferta.OfertaPesoUnidade.toString();
      widget.mofferController.txtDescricao.text =
          oferta.OfertaDetalhe! == 'null'
              ? ''
              : oferta.OfertaDetalhe.toString();
      widget.mofferController.txtDetalhes.text = oferta.OfertaDetalhe! == 'null'
          ? ''
          : oferta.OfertaDetalhe.toString();
      widget.mofferController.txtTamanhos.text =
          oferta.OfertaTamanhos! == 'null'
              ? ''
              : oferta.OfertaTamanhos.toString();
      widget.mofferController.txtCores.text =
          oferta.OfertaCores! == 'null' ? '' : oferta.OfertaCores.toString();
      widget.mofferController.txtValorMin.text = oferta.OfertaPrecoMin == null
          ? '0'
          : oferta.OfertaPrecoMin.toString();
      // widget.mofferController.txtMarca.text =
      //     oferta.OfertaMarcaRevenda! == 'null'
      //         ? ''
      //         : oferta.OfertaMarcaRevenda!;
      widget.revendaSel = oferta.OfertaMarcaRevenda!;
      widget.mofferController.txtQtdMaxPorVenda.text =
          oferta.OfertaQtdMaxVenda == null
              ? '0'
              : oferta.OfertaQtdMaxVenda.toString();
      widget.mofferController.txtQtdDispo.text = oferta.OfertaQtdDispo == null
          ? '0'
          : oferta.OfertaQtdDispo.toString();
      widget.mofferController.txtQtdAviso.text = oferta.OfertaQtdAviso == null
          ? '0'
          : oferta.OfertaQtdAviso.toString();
      widget.mofferController.txtPreco.text =
          oferta.OfertaPreco == null ? '0.00' : oferta.OfertaPreco.toString();
      widget.mofferController.txtTempoEntrega.text =
          oferta.OfertaTempoEntrega == null
              ? '0'
              : oferta.OfertaTempoEntrega.toString();

      widget.offerGuid = widget.mofferController.mofferGuid!;

      widget.mofferController.valSegDas = oferta.SegDas.toString();
      widget.mofferController.valSegAs = oferta.SegAs.toString();
      widget.mofferController.valTerDas = oferta.TerDas.toString();
      widget.mofferController.valTerAs = oferta.TerAs.toString();
      widget.mofferController.valQuaDas = oferta.QuaDas.toString();
      widget.mofferController.valQuaAs = oferta.QuaAs.toString();
      widget.mofferController.valQuiDas = oferta.QuiDas.toString();
      widget.mofferController.valQuiAs = oferta.QuiAs.toString();
      widget.mofferController.valSexDas = oferta.SexDas.toString();
      widget.mofferController.valSexAs = oferta.SexAs.toString();
      widget.mofferController.valSabDas = oferta.SabDas.toString();
      widget.mofferController.valSabAs = oferta.SabAs.toString();
      widget.mofferController.valDomDas = oferta.DomDas.toString();
      widget.mofferController.valDomAs = oferta.DomAs.toString();
    } else {
      widget.isEditing = false;
    }
  }
}
