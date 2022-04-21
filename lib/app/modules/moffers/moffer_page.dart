import 'dart:convert';
import 'dart:io';
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

class MOfferPage extends StatefulWidget {
  //final String? offerGuid;
  final Oferta? offer;
  final CategoriesController categoriesController = Get.find();
  final MofferController mofferController = Get.find();
  // final LoginController loginController = Get.find();
  //final MofferController mofferController = Get.put(MofferController());
  final String tipo = 'G';
  late Categorias categSelecionada = new Categorias();
  late String imgcloud = '';
  late String offerGuid = '';
  late bool imgEdited = false;
  late bool editMode = false;

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
  bool isEditing = false;

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;
  var listaCategs = ['selecione']; // pegar da API
  var listaTempoEntregaTipo = ['selecione', 'minutos', 'horas', 'dias'];
  var listaFormaFechamento = [
    'selecione',
    'mensagem no aplicativo (seguro)',
    'whatsapp',
    'pagamento no aplicativo (seguro)'
  ]; // pegar da API
  var listaFormaEntrega = ['selecione', 'vendedor', 'comprador', 'parceiro'];
  var listaFormaEntrega2 = ['selecione', 'vendedor', 'comprador'];
  var listaParceiros = ['selecione']; // pegar da API
  var valueSel = 'selecione';
  late String categSel = 'selecione';
  var tempoEntregaTipoSel = 'selecione';
  var agenteEntregaSel = 'selecione';
  var formaFechSel = 'selecione';
  var materialSel = 'selecione';
  var voltagemSel = 'selecione';
  var categoriaSel = 'selecione';
  var labelEntrega = 'Entrega';
  var labelValidade = 'Validade';
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
  bool valQtd = true;
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

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImageUrl);
    super.initState();
    _manageCampos();
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
    LoginController _loginController = Get.find();
    Color textColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return FutureBuilder(
        future:
            carregaObjs(), // widget.categoriesController.getCategoriesNames(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting &&
              widget.categoriesController.listaCategorias == null) {
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
                  backgroundColor: _loginController.colorFromHex(
                      _loginController
                          .listCore
                          .where(
                              (coreItem) => coreItem.coreChave == 'backLight')
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
                        key: _form,
                        child: ListView(
                          children: [
                            SizedBox(height: 20),

                            ListTile(
                              leading: Text('Categoria'),
                              trailing: DropdownButton<String>(
                                items: widget
                                    .categoriesController.listaCategorias
                                    ?.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: categoriaSel,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    categoriaSel = newValue!;
                                    widget.categSelecionada = widget
                                        .categoriesController
                                        .selecionaCategoriaPorNome(
                                            categoriaSel)!;
                                    _manageCampos();
                                  });
                                },
                              ),
                            ),

                            SizedBox(height: 20),

                            if (showCamposBasicos)
                              Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller:
                                        widget.mofferController.txtTitulo,
                                    decoration:
                                        InputDecoration(labelText: 'Titulo'),
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
                                  TextFormField(
                                    controller:
                                        widget.mofferController.txtDescricao,
                                    decoration:
                                        InputDecoration(labelText: 'Descrição'),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: this.valPrecoCombinar,
                                        onChanged: (val) {
                                          setState(() {
                                            this.valPrecoCombinar = val!;
                                          });
                                        },
                                        activeColor: Colors.blue,
                                      ),
                                      SizedBox(width: 20),
                                      Text('Preco à combinar'),
                                      SizedBox(height: 20)
                                    ],
                                  ),
                                ],
                              ),

                            if (showPreco && !valPrecoCombinar)
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Switch(
                                          value: valPrecoInicial,
                                          onChanged: (bool val) {
                                            setState(() {
                                              valPrecoInicial = val;
                                            });
                                          }),
                                      SizedBox(width: 20),
                                      Text(valPrecoInicial
                                          ? 'Preco à partir de'
                                          : 'Preço fechado'),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                  TextFormField(
                                    controller:
                                        widget.mofferController.txtPreco,
                                    decoration:
                                        InputDecoration(labelText: 'Preço'),
                                    textInputAction: TextInputAction.next,
                                    focusNode: _priceFocusNode,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_descriptionFocusNode);
                                    },
                                    // validator: (value) {
                                    //   bool emptydUrl = value.trim().isEmpty;
                                    //   var newPrice = double.tryParse(value);
                                    //   bool isValid = newPrice == null || newPrice <= 0;
                                    //   if (emptydUrl || isValid) {
                                    //     return 'Informe um preço valido';
                                    //   }
                                    // },
                                  ),

                                  if (showTxtValorSinalOrc)
                                    Column(children: <Widget>[
                                      SizedBox(width: 20),
                                      Row(
                                        children: <Widget>[
                                          Switch(
                                              value: valSinalPercentual,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  valSinalPercentual = val;
                                                });
                                              }),
                                          SizedBox(width: 20),
                                          Text(valSinalPercentual
                                              ? 'Sinal em Percentual'
                                              : 'Sinal em valor cheio'),
                                          SizedBox(height: 20)
                                        ],
                                      ),
                                      TextFormField(
                                          controller: widget.mofferController
                                              .txtValorSinalOrc,
                                          decoration: InputDecoration(
                                              labelText:
                                                  'Valor Sinal/Orçamento'),
                                          keyboardType: TextInputType.number),
                                      SizedBox(width: 20),
                                    ]),

                                  if (showAceitaProposta)
                                    Row(
                                      children: <Widget>[
                                        Switch(
                                            value: valAceitaProposta,
                                            onChanged: (bool val) {
                                              setState(() {
                                                valAceitaProposta = val;
                                              });
                                            }),
                                        SizedBox(width: 20),
                                        Text('Aceita contra proposta'),
                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  if (valAceitaProposta)
                                    TextFormField(
                                      controller:
                                          widget.mofferController.txtValorMin,
                                      decoration: InputDecoration(
                                          labelText: 'Valor mín'),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                    ),

                                  // if (showTxtValorSinalOrc)
                                ],
                              ),

                            if (showCamposBasicos)
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Switch(
                                          value: valQtd,
                                          onChanged: (bool val) {
                                            setState(() {
                                              valQtd = val;
                                            });
                                          }),
                                      SizedBox(width: 20),
                                      Text(valQtd
                                          ? 'Controla quantidade'
                                          : 'Sem controle de quantidade'),
                                      SizedBox(height: 20)
                                    ],
                                  ),
                                  if (valQtd)
                                    TextFormField(
                                      controller:
                                          widget.mofferController.txtQtdDispo,
                                      decoration: InputDecoration(
                                          labelText: 'Qtd disponível'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  if (valQtd)
                                    TextFormField(
                                      controller: widget
                                          .mofferController.txtQtdMaxPorVenda,
                                      decoration: InputDecoration(
                                          labelText: 'Qtd máxima por venda'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  if (valQtd)
                                    TextFormField(
                                      controller:
                                          widget.mofferController.txtQtdAviso,
                                      decoration: InputDecoration(
                                          labelText: 'Qtd aviso acabando'),
                                      keyboardType: TextInputType.number,
                                    ),
                                ],
                              ),

                            if (showTxtPesoPorcao)
                              TextFormField(
                                  controller:
                                      widget.mofferController.txtPesoPorcao,
                                  decoration:
                                      InputDecoration(labelText: 'Peso/Porção'),
                                  keyboardType: TextInputType.text),
                            if (showTxtPesoPorcaoUn)
                              TextFormField(
                                  controller:
                                      widget.mofferController.txtPesoPorcaoUn,
                                  decoration: InputDecoration(
                                      labelText: 'Peso/Porção Unidade'),
                                  keyboardType: TextInputType.text),
                            // if (showTxtSabor)
                            //   TextFormField(
                            //       controller: widget.mofferController.txtSabor,
                            //       decoration: InputDecoration(labelText: 'Sabores divididos por /'),
                            //       keyboardType: TextInputType.multiline),
                            if (showTxtValidade)
                              TextFormField(
                                  controller:
                                      widget.mofferController.txtValidade,
                                  decoration: InputDecoration(
                                      labelText: '$labelValidade (ex: 5 dias)'),
                                  keyboardType: TextInputType.number),

                            if (showTxtCep)
                              TextFormField(
                                controller: widget.mofferController.txtCep,
                                decoration:
                                    InputDecoration(labelText: 'Cep da oferta'),
                                keyboardType: TextInputType.number,
                              ),

                            if (showTxtOfertaCepDistancia && showCamposBasicos)
                              TextFormField(
                                controller:
                                    widget.mofferController.txtCepDistancia,
                                decoration: InputDecoration(
                                    labelText:
                                        'Distância de $labelEntrega em Km'),
                                keyboardType: TextInputType.number,
                              ),

                            if (showTxtMarca)
                              TextFormField(
                                  controller: widget.mofferController.txtMarca,
                                  decoration:
                                      InputDecoration(labelText: 'Marca'),
                                  keyboardType: TextInputType.text),
                            if (showTxtCodigoAlt)
                              TextFormField(
                                  controller:
                                      widget.mofferController.txtCodigoAlt,
                                  decoration: InputDecoration(
                                      labelText: 'Código da revenda'),
                                  keyboardType: TextInputType.text),

                            SizedBox(height: 20),
                            if (showTxtCores)
                              TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Cores (separadas por /)'),
                                  controller: widget.mofferController.txtCores,
                                  keyboardType: TextInputType.multiline),
                            SizedBox(height: 20),
                            if (showTxtTamanhos)
                              TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Tamanhos (separados por /)'),
                                  controller:
                                      widget.mofferController.txtTamanhos,
                                  keyboardType: TextInputType.multiline),
                            SizedBox(height: 20),
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
                                Text('Informações adicionais'),
                                TextFormField(
                                    controller:
                                        widget.mofferController.txtDetalhes,
                                    keyboardType: TextInputType.multiline),
                              ]),

                            if (showDispoImediata)
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: valDispoImediata,
                                      onChanged: (bool val) {
                                        setState(() {
                                          valDispoImediata = val;
                                        });
                                      }),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Text(valDispoImediata
                                        ? 'Disponibilidade imediata (o tempo todo)'
                                        : 'Disponibilidade agendada'),
                                  ),
                                  SizedBox(height: 20)
                                ],
                              ),

                            if (!valDispoImediata)
                              Column(children: <Widget>[
                                Checkbox(
                                  value: this.valSeg,
                                  onChanged: (val) {
                                    setState(() {
                                      this.valSeg = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                Text('segunda '),
                                TextFormField(
                                  controller: widget.mofferController.txtSegDas,
                                  decoration: InputDecoration(labelText: 'Das'),
                                  keyboardType: TextInputType.number,
                                ),
                                TextFormField(
                                  controller: widget.mofferController.txtSegAs,
                                  decoration: InputDecoration(labelText: 'às'),
                                  keyboardType: TextInputType.number,
                                ),
                                Checkbox(
                                  value: this.valTer,
                                  onChanged: (val) {
                                    setState(() {
                                      this.valTer = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                Text('terça '),
                                TextFormField(
                                  controller: widget.mofferController.txtTerDas,
                                  decoration: InputDecoration(labelText: 'Das'),
                                  keyboardType: TextInputType.number,
                                ),
                                TextFormField(
                                  controller: widget.mofferController.txtTerAs,
                                  decoration: InputDecoration(labelText: 'às'),
                                  keyboardType: TextInputType.number,
                                ),
                                Checkbox(
                                  value: this.valQua,
                                  onChanged: (val) {
                                    setState(() {
                                      this.valQua = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                Text('quarta '),
                                TextFormField(
                                  controller: widget.mofferController.txtQuaDas,
                                  decoration: InputDecoration(labelText: 'Das'),
                                  keyboardType: TextInputType.number,
                                ),
                                TextFormField(
                                  controller: widget.mofferController.txtQuaAs,
                                  decoration: InputDecoration(labelText: 'às'),
                                  keyboardType: TextInputType.number,
                                ),
                                Checkbox(
                                  value: this.valQui,
                                  onChanged: (val) {
                                    setState(() {
                                      this.valQui = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                Text('quinta '),
                                TextFormField(
                                  controller: widget.mofferController.txtQuiDas,
                                  decoration: InputDecoration(labelText: 'Das'),
                                  keyboardType: TextInputType.number,
                                ),
                                TextFormField(
                                  controller: widget.mofferController.txtQuiAs,
                                  decoration: InputDecoration(labelText: 'às'),
                                  keyboardType: TextInputType.number,
                                ),
                                Checkbox(
                                  value: this.valSex,
                                  onChanged: (val) {
                                    setState(() {
                                      this.valSex = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                Text('sexta '),
                                TextFormField(
                                  controller: widget.mofferController.txtSexDas,
                                  decoration: InputDecoration(labelText: 'Das'),
                                  keyboardType: TextInputType.number,
                                ),
                                TextFormField(
                                  controller: widget.mofferController.txtSexAs,
                                  decoration: InputDecoration(labelText: 'às'),
                                  keyboardType: TextInputType.number,
                                ),
                                Checkbox(
                                  value: this.valSab,
                                  onChanged: (val) {
                                    setState(() {
                                      this.valSab = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                Text('sábado '),
                                TextFormField(
                                  controller: widget.mofferController.txtSabDas,
                                  decoration: InputDecoration(labelText: 'Das'),
                                  keyboardType: TextInputType.number,
                                ),
                                TextFormField(
                                  controller: widget.mofferController.txtSabAs,
                                  decoration: InputDecoration(labelText: 'às'),
                                  keyboardType: TextInputType.number,
                                ),
                                Checkbox(
                                  value: this.valDom,
                                  onChanged: (val) {
                                    setState(() {
                                      this.valDom = val!;
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                Text('domingo '),
                                TextFormField(
                                  controller: widget.mofferController.txtDomDas,
                                  decoration: InputDecoration(labelText: 'Das'),
                                  keyboardType: TextInputType.number,
                                ),
                                TextFormField(
                                  controller: widget.mofferController.txtDomAs,
                                  decoration: InputDecoration(labelText: 'às'),
                                  keyboardType: TextInputType.number,
                                ),
                              ]),

                            if (showMostraReview)
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: valMostraReview,
                                      onChanged: (bool val) {
                                        setState(() {
                                          valMostraReview = val;
                                        });
                                      }),
                                  SizedBox(width: 20),
                                  Text('Mostrar opiniões'),
                                  SizedBox(height: 20)
                                ],
                              ),

                            if (showAceiteAuto)
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: valAceiteAuto,
                                      onChanged: (bool val) {
                                        setState(() {
                                          valAceiteAuto = val;
                                        });
                                      }),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                        'Aceite automático dentro do horário'),
                                  ),
                                  SizedBox(height: 20)
                                ],
                              ),

                            if (showAceitaEncomenda)
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: valAceitaEncomenda,
                                      onChanged: (bool val) {
                                        setState(() {
                                          valAceitaEncomenda = val;
                                          print('valAceitaEncomenda: ' +
                                              valAceitaEncomenda.toString());
                                        });
                                      }),
                                  SizedBox(width: 20),
                                  Text('Aceita encomenda'),
                                ],
                              ),
                            if (valAceitaEncomenda)
                              Column(children: <Widget>[
                                SizedBox(width: 20),
                                TextFormField(
                                  controller: widget
                                      .mofferController.txtEncomendasAPartir,
                                  decoration: InputDecoration(
                                      labelText: 'Encomendas a partir de:'),
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 20),
                                // Switch(
                                //     value: valSomenteEncomenda,
                                //     onChanged: (bool val) {
                                //       setState(() {
                                //         valSomenteEncomenda = val;
                                //       });
                                //     }),
                                // Text('Somente encomenda'),
                                // SizedBox(height: 20),
                              ]),

                            if (show24hs)
                              Row(
                                children: <Widget>[
                                  Switch(
                                      value: val24hs,
                                      onChanged: (bool val) {
                                        setState(() {
                                          val24hs = val;
                                        });
                                      }),
                                  SizedBox(width: 20),
                                  Text('24hs'),
                                  SizedBox(height: 20),
                                ],
                              ),

                            if (showCamposBasicos)
                              Column(
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Text('Forma de Fechamento'),
                                  DropdownButton<String>(
                                    items: listaFormaFechamento
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: formaFechSel,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        formaFechSel = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),

                            SizedBox(height: 20),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     SizedBox(height: 20),
                            //     Divider(),
                            //   ],
                            // ),

                            if (showCamposEntrega)
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Disponibilidade de " + labelEntrega,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Text('Agente'),
                                  DropdownButton<String>(
                                    items:
                                        listaFormaEntrega.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: agenteEntregaSel,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        agenteEntregaSel = newValue!;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: widget
                                        .mofferController.txtEntregasAPartir,
                                    decoration: InputDecoration(
                                        labelText:
                                            labelEntrega + ' a partir de:'),
                                    keyboardType: TextInputType.number,
                                  ),
                                  Text("Horário de " + labelEntrega),
                                  TextFormField(
                                    controller:
                                        widget.mofferController.txtEntregaDas,
                                    decoration:
                                        InputDecoration(labelText: 'Das'),
                                    keyboardType: TextInputType.number,
                                  ),
                                  TextFormField(
                                    controller:
                                        widget.mofferController.txtEntregaAs,
                                    decoration:
                                        InputDecoration(labelText: 'às'),
                                    keyboardType: TextInputType.number,
                                  ),
                                  if (labelEntrega == 'Entrega')
                                    Column(
                                      children: <Widget>[
                                        SizedBox(height: 20),
                                        Text(
                                          "Taxas de Entrega",
                                          textAlign: TextAlign.left,
                                        ),
                                        TextFormField(
                                          controller: widget
                                              .mofferController.txtValorTaxa1km,
                                          decoration: InputDecoration(
                                              labelText: 'Até 1km'),
                                          textInputAction: TextInputAction.next,
                                          //focusNode: _priceFocusNode,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                        TextFormField(
                                          controller: widget
                                              .mofferController.txtValorTaxa2km,
                                          decoration: InputDecoration(
                                              labelText: 'Entre 1km e 2km'),
                                          textInputAction: TextInputAction.next,
                                          //focusNode: _priceFocusNode,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                        TextFormField(
                                          controller: widget.mofferController
                                              .txtValorTaxaMaisQue2km,
                                          decoration: InputDecoration(
                                              labelText: 'Acima de 2km'),
                                          textInputAction: TextInputAction.next,
                                          //focusNode: _priceFocusNode,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                        ),
                                        SizedBox(height: 20),
                                        Text('Tempo de Entrega após aceite'),
                                        TextFormField(
                                            //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                                            keyboardType: TextInputType.number),
                                        DropdownButton<String>(
                                          items: listaTempoEntregaTipo
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          value: tempoEntregaTipoSel,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              tempoEntregaTipoSel = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              ),

                            if (showCamposBasicos)
                              Column(children: <Widget>[
                                SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () => pegarImagemGaleria(),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                      _loginController.colorFromHex(
                                          _loginController
                                              .listCore
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
                                SizedBox(height: 20),
                                if (widget.imgcloud != '')
                                  FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/pholder.png',
                                    image: widget.imgcloud,
                                    imageErrorBuilder: (context, url, error) =>
                                        new Icon(Icons.local_offer_outlined),
                                    height: 250,
                                  ),
                                if (image != null)
                                  Image.file(
                                    image!,
                                    fit: BoxFit.contain,
                                  ),
                                SizedBox(height: 20),
                                ButtonOffer(
                                    text: 'Salvar',
                                    colorText: _loginController.colorFromHex(
                                        _loginController.listCore
                                            .where((coreItem) =>
                                                coreItem.coreChave ==
                                                'textLight')
                                            .first
                                            .coreValor
                                            .toString()),
                                    colorButton: _loginController.colorFromHex(
                                        _loginController.listCore
                                            .where((coreItem) =>
                                                coreItem.coreChave ==
                                                'iconColor')
                                            .first
                                            .coreValor
                                            .toString()),
                                    onPressed: () => uploadFoto(
                                        image == null ? null : image,
                                        _loginController.usuGuid.toString())),
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

  uploadFoto(File? foto, String usuGuid) async {
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
    showSnackBar("Oferta salva! - " + widget.offerGuid, Duration(seconds: 3));
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
    var formaFechto = '';
    switch (formaFechSel) {
      case 'mensagem no aplicativo (seguro)':
        formaFechto = 'chatapp';
        break;
      case 'pagamento no aplicativo (seguro)':
        formaFechto = 'gatewayapi';
        break;
      default:
        formaFechto = formaFechSel;
    }

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
        widget.mofferController.txtCep.text.replaceAll('-', ''),
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
        valMostraReview,
        valAceiteAuto,
        valAceitaEncomenda,
        valSomenteEncomenda,
        valAceitaProposta,
        int.parse(widget.mofferController.txtTempoEntrega
            .text), //int.parse(widget.mofferController.txtTempoEntrega.text),
        tempoEntregaTipoSel,
        formaFechto,
        agenteEntregaSel,
        '',
        '',
        widget.mofferController.txtMarca.text,
        widget.mofferController.txtCores.text,
        widget.mofferController.txtTamanhos.text,
        val24hs,
        int.parse(widget.mofferController.txtCepDistancia.text),
        0.00, // double.parse(widget.mofferController.txtValorSinalOrc.text),
        widget.mofferController.txtEncomendasAPartir.text,
        widget.mofferController.txtEntregasAPartir.text,
        widget.mofferController.txtCodigoAlt.text,
        double.parse(widget.mofferController.txtValorTaxa1km.text),
        double.parse(widget.mofferController.txtValorTaxa2km.text),
        double.parse(widget.mofferController.txtValorTaxaMaisQue2km.text),
        valQtd,
        valSinalPercentual ? "P" : "V",
        valPrecoInicial,
        valPrecoCombinar,
        valSeg,
        valTer,
        valQua,
        valQui,
        valSex,
        valSab,
        valDom,
        widget.mofferController.txtSegDas.text,
        widget.mofferController.txtSegAs.text,
        widget.mofferController.txtTerDas.text,
        widget.mofferController.txtTerAs.text,
        widget.mofferController.txtQuaDas.text,
        widget.mofferController.txtQuaAs.text,
        widget.mofferController.txtQuiDas.text,
        widget.mofferController.txtQuiAs.text,
        widget.mofferController.txtSexDas.text,
        widget.mofferController.txtSexAs.text,
        widget.mofferController.txtSabDas.text,
        widget.mofferController.txtSabAs.text,
        widget.mofferController.txtDomDas.text,
        widget.mofferController.txtDomAs.text,
        null);

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
    //print('manageCampos: ' + widget.categSelecionada.secao.toString());
    if (widget.categSelecionada.secao == null) {
      labelEntrega = 'Entrega';
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
      // showListaTempoEntregaTipo = false;
      // showTxtTempoEntrega = false;
      showTxtCores = false;
      showTxtTamanhos = false;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = false;
      showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-SERV-CASA' ||
        widget.categSelecionada.secao == 'SEC-SERV-FRETE' ||
        widget.categSelecionada.secao == 'SEC-SERV-VOCE' ||
        widget.categSelecionada.secao == 'SEC-SERV-CARRO' ||
        widget.categSelecionada.secao == 'SEC-SERV-PET') {
      labelEntrega = 'Atendimento';
      labelValidade = 'Garantia';
      showCamposBasicos = true;
      showPreco = true;
      showTxtQtdDispo = false;
      showTxtValorMin = false;
      showTxtMarca = false;
      showTxtCep = true;
      valQtd = false;
      // showTxtQtdMaxPorVenda = false;
      // showTxtQtdAviso = false;
      show24hs = true;
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
      //showListaTempoEntregaTipo = false;
      // showTxtTempoEntrega = false;
      showTxtCores = false;
      showTxtTamanhos = false;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = true;
      showTxtValorSinalOrc = true;
      // showTxtEntregaTaxas = false;
      showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-DESAPEGO') {
      labelEntrega = 'Entrega';
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
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-ACHADOPERDIDO') {
      labelEntrega = 'Entrega';
      showCamposBasicos = true;
      showPreco = false;
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
      showCamposEntrega = false;
      // showListaFormaEntrega = false;
      // showListaFormaEntrega2 = false;
      // showListaParceiros = true;
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = false;
      showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-BELEZA') {
      labelEntrega = 'Entrega';
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
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = true;
      showTxtPesoPorcaoUn = true;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = true;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-COMIDA') {
      labelEntrega = 'Entrega';
      labelValidade = 'Validade';
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
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = false;
      showTxtTamanhos = false;
      showTxtPesoPorcao = true;
      showTxtPesoPorcaoUn = true;
      showTxtValidade = true;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-OBJETO') {
      labelEntrega = 'Entrega';
      labelValidade = 'Validade';
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
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = true;
      showTxtPesoPorcaoUn = true;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = false;
    }
    if (widget.categSelecionada.secao == 'SEC-PROD-VEST') {
      labelEntrega = 'Entrega';
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
      // showListaTempoEntregaTipo = true;
      // showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
      // showTxtEntregaTaxas = true;
      showTxtCodigoAlt = false;
    }
  }

  Future<void> carregaObjs() async {
    if (ModalRoute.of(context)?.settings.arguments != null) {
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
      categoriaSel = widget.categSelecionada.categoriaNome!;
      _manageCampos();

      widget.mofferController.txtEncomendasAPartir.text =
          oferta.OfertaEncomendasAPartirDe.toString();
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
      widget.mofferController.txtEntregasAPartir.text =
          oferta.OfertaEntregasAPartirDe.toString();
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
      widget.mofferController.txtMarca.text =
      oferta.OfertaMarcaRevenda! == 'null'
          ? ''
          : oferta.OfertaMarcaRevenda!;
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
    } else {
      isEditing = false;
      var nowFormatted = '01' + '03' + '2022';
      var dia = DateTime.now().day < 10
          ? '0' + DateTime.now().day.toString()
          : DateTime.now().day.toString();
      var mes = DateTime.now().month < 10
          ? '0' + DateTime.now().month.toString()
          : DateTime.now().month.toString();
      var ano = DateTime.now().year.toString();
      nowFormatted = dia + mes + ano;
      print('nowFormatted: ' + nowFormatted);
      widget.mofferController.txtEntregasAPartir.text = nowFormatted;
      widget.mofferController.txtEncomendasAPartir.text = nowFormatted;

      widget.mofferController.txtTitulo.text = '';
      widget.mofferController.txtEncomendasAPartir.text = '';
      widget.mofferController.txtValorTaxa1km.text = '0.00';
      widget.mofferController.txtValorTaxaMaisQue2km.text = '0.00';
      widget.mofferController.txtValorTaxa2km.text = '0.00';
      widget.mofferController.txtCodigoAlt.text = '';
      widget.mofferController.txtCepDistancia.text = '0';
      widget.mofferController.txtValorSinalOrc.text = '0.00';
      widget.mofferController.txtValidade.text = '0';
      widget.mofferController.txtPesoPorcao.text = '0.00';
      widget.mofferController.txtPesoPorcaoUn.text = '';
      widget.mofferController.txtDescricao.text = '';
      widget.mofferController.txtDetalhes.text = '';
      widget.mofferController.txtTamanhos.text = '';
      widget.mofferController.txtCores.text = '';
      widget.mofferController.txtPreco.text = '0.00';
      widget.mofferController.txtValorMin.text = '0.00';
      widget.mofferController.txtMarca.text = '';
      widget.mofferController.txtQtdMaxPorVenda.text = '0';
      widget.mofferController.txtQtdDispo.text = '0';
      widget.mofferController.txtQtdAviso.text = '0';
    }
  }


}
