import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poraki/app/data/models/categorias.dart';
import 'package:poraki/app/modules/categories/categories_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/moffers/moffer_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/theme/app_theme.dart';
//import 'package:simple_s3/simple_s3.dart';
//import 'package:simple_s3_example/Credentials.dart';

class MOfferPageTest extends StatefulWidget {
  final HomeController homeController = Get.find();
  final CategoriesController categoriesController = Get.find();
  final MofferController mofferController = Get.put(MofferController());

  // Function? addProduct;

  final String tipo = 'G';

  MOfferPageTest();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MOfferPageTest();
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  double? unitPrice;

  // Product({this.name, this.description, this.unitPrice});
  // Product.withId({this.id, this.name, this.description, this.unitPrice});
  //
  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["name"] = name;
  //   map["description"] = description;
  //   map["unitPrice"] = unitPrice;
  //   if (id != null) {
  //     map["id"] = id;
  //   }
  //   return map;
  // }

}

class _MOfferPageTest extends State<MOfferPageTest> {
  File? image;
  Categorias categSelecionada = new Categorias();

  // OPTION 5 - GOOD
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _form = GlobalKey<FormState>();
  // final _formData = Map<String, Object>();
  bool _isLoading = false;
  var listaCategs = ['selecione']; // pegar da API
  var listaTempoEntregaTipo = ['selecione', 'minutos', 'horas', 'dias'];
  var listaFormaFechamento = [
    'selecione',
    'mensagem',
    'pagamento no aplicativo'
  ]; // pegar da API
  var listaFormaEntrega = ['selecione', 'vendedor', 'comprador', 'parceiro'];
  var listaFormaEntrega2 = ['selecione', 'vendedor', 'comprador'];
  var listaParceiros = ['selecione']; // pegar da API
  var listaMaterias = [
    'selecione',
    'Plástico',
    'Ferro',
    'Cobre',
    'Alumínio',
    'Metal'
  ]; // pegar da API
  var listaVoltagem = [
    'selecione',
    '110v',
    '220v',
    'bivolt',
    'bivolt auto',
    'nenhum'
  ];
  var valueSel = 'selecione';
  var categSel = 'selecione';
  var tempoEntregaTipoSel = 'selecione';
  var agenteEntregaSel = 'selecione';
  var formaFechSel = 'selecione';
  var materialSel = 'selecione';
  var voltagemSel = 'selecione';
  var categoriaSel = 'selecione';
  bool valDispoImediata = true;
  bool valMostraAval = false;
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

  bool showPreco = false;
  bool showDispoImediata = false;
  bool showMostraAval = false;
  bool showAceiteAuto = false;
  bool showAceitaEncomenda = false;
  bool showSomenteEncomenda = false;
  bool showAceitaProposta = false;
  bool show24hs = false;
  bool showListaTempoEntregaTipo = false;
  bool showListaFormaEntrega = false;
  bool showListaFormaEntrega2 = false;
  bool showListaParceiros = false;
  bool showListaMaterias = false;
  bool showListaVoltagem = false;
  bool showTxtQtdDispo = false;
  bool showTxtQtdMaxPorVenda = false;
  bool showTxtQtdAviso = false;
  bool showTxtCep = false;
  bool showTxtMarca = true;
  bool showTxtValorMin = false;
  bool showTxtTempoEntrega = false;
  bool showTxtCores = false;
  bool showTxtTamanhos = false;
  bool showTxtPesoPorcao = false;
  bool showTxtPesoPorcaoUn = false;
  bool showTxtSabor = false;
  bool showTxtValidade = false;
  bool showTxtValorSinalOrc = false;
  bool showTxtEncomendasAPartir = false;
  bool showTxtEntregasAPartir = false;
  bool showTxtEntregaTaxas = false;
  bool showTxtOfertaCepDistancia = true;
  bool showTxtCodigoAlt = false;

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImageUrl);
    super.initState();
    _manageCampos();
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

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageURLFocusNode.removeListener(_updateImageUrl);
    _imageURLFocusNode.dispose();
  }

  Future<void> _saveForm() async {
    // if (!_form.currentState.validate()) return;
    //
    // _form.currentState.save();
    // final product = ProductProvider.Product(
    //   id: _formData['id'],
    //   title: _formData['title'],
    //   price: _formData['price'],
    //   description: _formData['description'],
    //   imageUrl: _formData['imageUrl'],
    // );
    //
    // setState(() {
    //   _isLoading = true;
    // });
    //
    // final products =
    // Provider.of<ProductsProvider.Products>(context, listen: false);
    // try {
    //   if (_formData['id'] == null) {
    //     await products.addProduct(product);
    //   } else {
    //     await products.updateProduct(product);
    //   }
    //   Navigator.of(context).pop();
    // } catch (e) {
    //   await showDialog<Null>(
    //     context: context,
    //     builder: (ctx) => AlertDialog(
    //       title: Text('Ocorreu um erro'),
    //       content: Text('Erro inesperado ao salvar '),
    //       actions: [
    //         FlatButton(
    //           child: Text('Fechar'),
    //           onPressed: () => Navigator.of(context).pop(),
    //         ),
    //       ],
    //     ),
    //   );
    // } finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  // somente para testes - em producao virá a partir do Firebase
  void _manageCampos() {
    print('manageCampos: ' + categSelecionada.secao.toString());
    if (categSelecionada.secao == 'SEC-SERV-CASA' ||
        categSelecionada.secao == 'SEC-SERV-FRETE' ||
        categSelecionada.secao == 'SEC-SERV-VOCE' ||
        categSelecionada.secao == 'SEC-SERV-CARRO' ||
        categSelecionada.secao == 'SEC-SERV-PET') {
      showPreco = true;
      showTxtQtdDispo = false;
      showTxtValorMin = false;
      showTxtMarca = false;
      showTxtCep = true;
      showTxtQtdMaxPorVenda = false;
      showTxtQtdAviso = false;
      show24hs = true;
      showAceitaProposta = true;
      showSomenteEncomenda = false;
      showAceitaEncomenda = false;
      showAceiteAuto = false;
      showMostraAval = true;
      showDispoImediata = true;
      showListaFormaEntrega = false;
      showListaFormaEntrega2 = false;
      showListaMaterias = false;
      showListaParceiros = false;
      showListaTempoEntregaTipo = false;
      showListaVoltagem = false;
      showTxtTempoEntrega = false;
      showTxtCores = false;
      showTxtTamanhos = false;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = true;
    }
    if (categSelecionada.secao == 'SEC-PROD-DESAPEGO') {
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtValorMin = false;
      showTxtMarca = true;
      showTxtCep = true;
      showTxtQtdMaxPorVenda = true;
      showTxtQtdAviso = false;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = false;
      showAceitaEncomenda = false;
      showAceiteAuto = true;
      showMostraAval = false;
      showDispoImediata = true;
      showListaFormaEntrega = false;
      showListaFormaEntrega2 = false;
      showListaMaterias = true;
      showListaParceiros = true;
      showListaTempoEntregaTipo = true;
      showListaVoltagem = true;
      showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
    }
    if (categSelecionada.secao == 'SEC-PROD-ACHADOPERDIDO') {
      showPreco = false;
      showTxtQtdDispo = true;
      showTxtValorMin = false;
      showTxtMarca = true;
      showTxtCep = true;
      showTxtQtdMaxPorVenda = true;
      showTxtQtdAviso = false;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = false;
      showAceitaEncomenda = false;
      showAceiteAuto = true;
      showMostraAval = false;
      showDispoImediata = true;
      showListaFormaEntrega = false;
      showListaFormaEntrega2 = false;
      showListaMaterias = true;
      showListaParceiros = true;
      showListaTempoEntregaTipo = true;
      showListaVoltagem = true;
      showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
    }
    if (categSelecionada.secao == 'SEC-PROD-BELEZA') {
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtValorMin = true;
      showTxtMarca = true;
      showTxtCep = true;
      showTxtQtdMaxPorVenda = true;
      showTxtQtdAviso = true;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = true;
      showAceitaEncomenda = true;
      showAceiteAuto = true;
      showMostraAval = true;
      showDispoImediata = true;
      showListaFormaEntrega = true;
      showListaFormaEntrega2 = true;
      showListaMaterias = false;
      showListaParceiros = true;
      showListaTempoEntregaTipo = true;
      showListaVoltagem = false;
      showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = true;
      showTxtPesoPorcaoUn = true;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
    }
    if (categSelecionada.secao == 'SEC-PROD-COMIDA') {
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtValorMin = true;
      showTxtMarca = false;
      showTxtCep = true;
      showTxtQtdMaxPorVenda = true;
      showTxtQtdAviso = true;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = true;
      showAceitaEncomenda = true;
      showAceiteAuto = true;
      showMostraAval = true;
      showDispoImediata = true;
      showListaFormaEntrega = true;
      showListaFormaEntrega2 = true;
      showListaMaterias = false;
      showListaParceiros = true;
      showListaTempoEntregaTipo = true;
      showListaVoltagem = false;
      showTxtTempoEntrega = true;
      showTxtCores = false;
      showTxtTamanhos = false;
      showTxtPesoPorcao = true;
      showTxtPesoPorcaoUn = true;
      showTxtValidade = true;
      showTxtValorSinalOrc = false;
    }
    if (categSelecionada.secao == 'SEC-PROD-OBJETO') {
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtValorMin = true;
      showTxtMarca = true;
      showTxtCep = true;
      showTxtQtdMaxPorVenda = true;
      showTxtQtdAviso = true;
      show24hs = false;
      showAceitaProposta = true;
      showSomenteEncomenda = true;
      showAceitaEncomenda = true;
      showAceiteAuto = true;
      showMostraAval = true;
      showDispoImediata = true;
      showListaFormaEntrega = true;
      showListaFormaEntrega2 = true;
      showListaMaterias = true;
      showListaParceiros = true;
      showListaTempoEntregaTipo = true;
      showListaVoltagem = true;
      showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = true;
      showTxtPesoPorcaoUn = true;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
    }
    if (categSelecionada.secao == 'SEC-PROD-VEST') {
      showPreco = true;
      showTxtQtdDispo = true;
      showTxtQtdAviso = true;
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
      showDispoImediata = true;
      showListaFormaEntrega = true;
      showListaFormaEntrega2 = true;
      showListaMaterias = false;
      showListaParceiros = true;
      showListaTempoEntregaTipo = true;
      showListaVoltagem = false;
      showTxtTempoEntrega = true;
      showTxtCores = true;
      showTxtTamanhos = true;
      showTxtPesoPorcao = false;
      showTxtPesoPorcaoUn = false;
      showTxtValidade = false;
      showTxtValorSinalOrc = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: widget.categoriesController.getCategoriesNames(),
    //     builder: (context, futuro) {
    //       if (futuro.connectionState == ConnectionState.waiting) {
    //         return Center(
    //             child: CircularProgressIndicator()); //Text('carrinho vazio'));
    //         // } else if (futuro.hasError) {
    //         //   return Center(child: Text(futuro.error.toString()));
    //       }
    //       else {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Formulário produto'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.save),
      //       onPressed: () {
      //         _saveForm();
      //       },
      //     )
      //   ],
      // ),
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: widget.homeController),
      ),
      drawer: DrawerHome(0),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    SizedBox(height: 20),

                    ListTile(
                      leading: Text('Categoria'),
                      trailing: DropdownButton<String>(
                        items: widget.categoriesController.listaCategorias
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
                            categSelecionada = widget.categoriesController
                                .selecionaCategoria(categoriaSel)!;
                            _manageCampos();
                          });
                        },
                      ),
                    ),

                    //Divider(),

                    SizedBox(height: 20),

                    TextFormField(
                      controller: widget.mofferController.txtTitulo,
                      // initialValue: 'Titulo Produto',
                      decoration: InputDecoration(labelText: 'Titulo'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      // onSaved: (value) => _formData['title'] = value,
                      validator: (value) {
                        bool isValid = value.toString().trimRight().length < 3;
                        //if (value.isEmpty) return 'Informe um titulo valido';
                        if (isValid) return 'Informe um titulo valido';
                        return null;
                      },
                    ),

                    //Divider(),

                    TextFormField(
                      controller: widget.mofferController.txtDescricao,
                      // initialValue: 'Descricao', // _formData['description'],
                      decoration: InputDecoration(labelText: 'Descrição'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),

                    //Divider(),

                    if (showPreco)
                      TextFormField(
                        controller: widget.mofferController.txtPreco,
                        // initialValue: '0',
                        // _formData['price'].toString(),
                        decoration: InputDecoration(labelText: 'Preço'),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocusNode,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        // onSaved: (value) =>
                        // _formData['price'] = double.parse(value),
                        // validator: (value) {
                        //   bool emptydUrl = value.trim().isEmpty;
                        //   var newPrice = double.tryParse(value);
                        //   bool isValid = newPrice == null || newPrice <= 0;
                        //   if (emptydUrl || isValid) {
                        //     return 'Informe um preço valido';
                        //   }
                        //
                        //   return null;
                        // },
                      ),

                    if (showTxtQtdDispo)
                      TextFormField(
                        controller: widget.mofferController.txtQtdDispo,
                        // initialValue: '1', // _formData['description'],
                        decoration:
                            InputDecoration(labelText: 'Qtd disponível'),
                        keyboardType: TextInputType.number,
                      ),
                    if (showTxtQtdMaxPorVenda)
                      TextFormField(
                        controller: widget.mofferController.txtQtdMaxPorVenda,
                        // initialValue: '1', // _formData['description'],
                        decoration:
                            InputDecoration(labelText: 'Qtd máxima por venda'),
                        keyboardType: TextInputType.number,
                      ),
                    if (showTxtQtdAviso)
                      TextFormField(
                        controller: widget.mofferController.txtQtdAviso,
                        // initialValue: '1', // _formData['description'],
                        decoration:
                            InputDecoration(labelText: 'Qtd aviso acabando'),
                        keyboardType: TextInputType.number,
                      ),
                    if (showTxtCep)
                      TextFormField(
                        controller: widget.mofferController.txtCep,
                        // initialValue: '05735-030', // _formData['description'],
                        decoration: InputDecoration(labelText: 'Cep da oferta'),
                        keyboardType: TextInputType.text,
                      ),
                    if (showTxtOfertaCepDistancia)
                      TextFormField(
                        controller: widget.mofferController.txtCepDistancia,
                        // initialValue: '05735-030', // _formData['description'],
                        decoration: InputDecoration(
                            labelText: 'Distância de entrega em Km'),
                        keyboardType: TextInputType.number,
                      ),
                    if (showPreco)
                      Row(
                        children: <Widget>[
                          Text("Taxas de Entrega"),
                          TextFormField(
                            controller: widget.mofferController.txtValorTaxa1km,
                            // initialValue: '0',
                            // _formData['price'].toString(),
                            decoration: InputDecoration(labelText: 'Até 1km'),
                            textInputAction: TextInputAction.next,
                            focusNode: _priceFocusNode,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                          TextFormField(
                            controller: widget.mofferController.txtValorTaxa2km,
                            // initialValue: '0',
                            // _formData['price'].toString(),
                            decoration:
                                InputDecoration(labelText: 'Entre 1km e 2km'),
                            textInputAction: TextInputAction.next,
                            focusNode: _priceFocusNode,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                          TextFormField(
                            controller:
                                widget.mofferController.txtValorTaxaMaisQue2km,
                            // initialValue: '0',
                            // _formData['price'].toString(),
                            decoration:
                                InputDecoration(labelText: 'Acima de 2km'),
                            textInputAction: TextInputAction.next,
                            focusNode: _priceFocusNode,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                        ],
                      ),
                    if (showTxtMarca)
                      TextFormField(
                          controller: widget.mofferController.txtMarca,
                          decoration: InputDecoration(labelText: 'Marca'),
                          keyboardType: TextInputType.text),
                    if (showTxtCodigoAlt)
                      TextFormField(
                          controller: widget.mofferController.txtCodigoAlt,
                          decoration:
                              InputDecoration(labelText: 'Código revenda'),
                          keyboardType: TextInputType.text),
                    if (showTxtPesoPorcao)
                      TextFormField(
                          controller: widget.mofferController.txtPesoPorcao,
                          decoration: InputDecoration(labelText: 'Peso/Porção'),
                          keyboardType: TextInputType.text),
                    if (showTxtPesoPorcaoUn)
                      TextFormField(
                          controller: widget.mofferController.txtPesoPorcaoUn,
                          decoration:
                              InputDecoration(labelText: 'Peso/Porção Unidade'),
                          keyboardType: TextInputType.text),
                    // if (showTxtSabor)
                    //   TextFormField(
                    //       controller: widget.mofferController.txtSabor,
                    //       decoration: InputDecoration(labelText: 'Sabores divididos por /'),
                    //       keyboardType: TextInputType.multiline),
                    if (showTxtValidade)
                      TextFormField(
                          controller: widget.mofferController.txtValidade,
                          decoration: InputDecoration(
                              labelText:
                                  'Validade (ex: 5 dias após fabricação)'),
                          keyboardType: TextInputType.text),
                    if (showTxtValorSinalOrc)
                      TextFormField(
                          controller: widget.mofferController.txtValorSinalOrc,
                          decoration: InputDecoration(
                              labelText: 'Valor Sinal/Orçamento'),
                          keyboardType: TextInputType.number),
                    if (showTxtValorMin)
                      TextFormField(
                        controller: widget.mofferController.txtValorMin,
                        decoration: InputDecoration(labelText: 'Valor mín'),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
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
                            child:
                                Text('Disponibilidade imediata (tempo todo)'),
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

                    Text("Horário de entrega: "),
                    TextFormField(
                      controller: widget.mofferController.txtEntregaDas,
                      decoration: InputDecoration(labelText: 'Das'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: widget.mofferController.txtEntregaAs,
                      decoration: InputDecoration(labelText: 'às'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: widget.mofferController.txtEntregasAPartir,
                      decoration: InputDecoration(
                          labelText: 'Entregas a partir da data:'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: widget.mofferController.txtEncomendasAPartir,
                      decoration: InputDecoration(
                          labelText: 'Encomendas a partir da data:'),
                      keyboardType: TextInputType.number,
                    ),

                    if (showMostraAval)
                      Row(
                        children: <Widget>[
                          Switch(
                              value: valMostraAval,
                              onChanged: (bool val) {
                                setState(() {
                                  valMostraAval = val;
                                });
                              }),
                          SizedBox(width: 20),
                          Text('Mostrar avaliações'),
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
                            child: Text('Aceite automático dentro do horário'),
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
                                });
                              }),
                          SizedBox(width: 20),
                          Text('Aceita encomenda'),
                          SizedBox(height: 20)
                        ],
                      ),
                    if (showSomenteEncomenda)
                      Row(
                        children: <Widget>[
                          Switch(
                              value: valSomenteEncomenda,
                              onChanged: (bool val) {
                                setState(() {
                                  valSomenteEncomenda = val;
                                });
                              }),
                          SizedBox(width: 20),
                          Text('Somente encomenda'),
                          SizedBox(height: 20)
                        ],
                      ),
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
                          SizedBox(height: 20)
                        ],
                      ),
                    Text('Tempo de Entrega após aceite'),
                    TextFormField(
                        // initialValue: '1',
                        // _formData['description'],
                        //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                        keyboardType: TextInputType.number),
                    DropdownButton<String>(
                      items: listaTempoEntregaTipo.map((String value) {
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
                    SizedBox(height: 20),
                    Text('Forma de Fechamento'),
                    DropdownButton<String>(
                      items: listaFormaFechamento.map((String value) {
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
                    SizedBox(height: 20),
                    Text('Agente de Entrega'),
                    DropdownButton<String>(
                      items: listaFormaEntrega.map((String value) {
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
                    // SizedBox(height: 20),
                    // Text('Material predominante'),
                    // DropdownButton<String>(
                    //   items: listaMaterias.map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   value: materialSel,
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       materialSel = newValue!;
                    //     });
                    //   },
                    // ),
                    // SizedBox(height: 20),
                    // Text('Voltagem'),
                    // DropdownButton<String>(
                    //   items: listaVoltagem.map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   value: voltagemSel,
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       voltagemSel = newValue!;
                    //     });
                    //   },
                    // ),
                    if (showTxtCores)
                      TextFormField(
                          // initialValue: '1',
                          // _formData['description'],
                          decoration: InputDecoration(
                              labelText: 'Cores (separadas por /)'),
                          controller: widget.mofferController.txtCores,
                          keyboardType: TextInputType.multiline),
                    SizedBox(height: 20),
                    if (showTxtTamanhos)
                      TextFormField(
                          // initialValue: '1',
                          // _formData['description'],
                          decoration: InputDecoration(
                              labelText: 'Tamanhos (separados por /)'),
                          controller: widget.mofferController.txtTamanhos,
                          keyboardType: TextInputType.multiline),
                    SizedBox(height: 20),
                    // Text('Nome 1º campo personalizado'),
                    // TextFormField(
                    //   // initialValue: '1',
                    //   // _formData['description'],
                    //   //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                    //     keyboardType: TextInputType.number),
                    // SizedBox(height: 20),
                    // Text('Valor'),
                    // TextFormField(
                    //   // initialValue: '1',
                    //   // _formData['description'],
                    //   //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                    //     keyboardType: TextInputType.number),
                    // SizedBox(height: 20),
                    // Text('Nome 2º campo personalizado'),
                    // TextFormField(
                    //   // initialValue: '1',
                    //   // _formData['description'],
                    //   //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                    //     keyboardType: TextInputType.number),
                    // SizedBox(height: 20),
                    // Text('Valor'),
                    // TextFormField(
                    //   // initialValue: '1',
                    //   // _formData['description'],
                    //   //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                    //     keyboardType: TextInputType.number),
                    // SizedBox(height: 20),
                    Text('Informações adicionais'),
                    TextFormField(
                        // initialValue: '1',
                        // _formData['description'],
                        //decoration: InputDecoration(labelText: 'Tempo de entrega após aceite'),
                        controller: widget.mofferController.txtDetalhes,
                        keyboardType: TextInputType.multiline),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20),

                        Divider(),
                        if (image != null)
                          Image.file(
                            image!,
                            fit: BoxFit.contain,
                          ),

                        // Expanded(
                        //   child: TextFormField(
                        //     decoration:
                        //         InputDecoration(labelText: 'URL imagem'),
                        //     keyboardType: TextInputType.url,
                        //     textInputAction: TextInputAction.done,
                        //     focusNode: _imageURLFocusNode,
                        //     controller: _imageURLController,
                        //     onTap: () {},
                        //     // onFieldSubmitted: (_) {
                        //     //   _saveForm();
                        //     // },
                        //     // onSaved: (value) => _formData['imageUrl'] = value,
                        //     // validator: (value) {
                        //     //   bool emptyUrl = value.trim().isEmpty;
                        //     //   bool invalidUrl = !isValidImageUrl(value);
                        //     //
                        //     //   if (emptyUrl || invalidUrl) {
                        //     //     return 'Informe uma URL valida';
                        //     //   }
                        //     //
                        //     //   return null;
                        //     // },
                        //   ),
                        // ),
                        // Container(
                        //   height: 100,
                        //   width: 100,
                        //   margin: EdgeInsets.only(
                        //     top: 8,
                        //     left: 10,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.grey,
                        //       width: 1,
                        //     ),
                        //   ),
                        //   alignment: Alignment.center,
                        //   child: _imageURLController.text.isEmpty
                        //       ? Text('Informe a URL')
                        //       : Image.network(
                        //           _imageURLController.text,
                        //           fit: BoxFit.cover,
                        //         ),
                        // )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () => pegarImagemGaleria(),
                        child: Row(
                          children: [
                            Icon(Icons.photo_album),
                            const SizedBox(
                              width: 16,
                            ),
                            Text('Adicionar Foto')
                          ],
                        )),
                    SizedBox(height: 230),

                    SizedBox(height: 20),
                    ButtonOffer(
                        text: 'Salvar',
                        colorText: AppColors.grayBlueButton,
                        onPressed: () => uploadFoto(image!)),
                  ],
                ),
              ),
            ),
    );
  }

  Future pegarImagemGaleria() async {
    try {
      final foto = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 70, maxHeight: 300);
      if (foto == null) return;

      final imageTemp = File(foto.path);

      setState(() => this.image = imageTemp);
      final tamanho = imageTemp.readAsBytesSync().lengthInBytes;
      print('tam: ' + tamanho.toString());
    } on PlatformException catch (e) {
      print('erro tentando abrir album de fotos: $e');
    }
  }

  uploadFoto(File foto) async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    await Firebase.initializeApp();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    Reference ref =
        FirebaseStorage.instance.ref().child("ofertas").child("post_$postID");

    await ref.putFile(image!);
    var downloadURL = await ref.getDownloadURL();
    showSnackBar("Image enviada! - " + downloadURL, Duration(seconds: 2));
  }

  //snackbar for  showing error
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

//);
//}
//}

// OPTION 4
// String productName = '', productDescription = '';
// double productPrice = 0.00;
// @override
// Widget build(BuildContext context) {
//   return Scaffold(body: Container(
//     margin: EdgeInsets.all(10.0),
//     child: ListView(
//       children: <Widget>[
//         TextField(
//           decoration: InputDecoration(labelText: "Product Title"),
//           autocorrect: true,
//           autofocus: true,
//           onChanged: (String textValue) {
//             productName=textValue;
//           },
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: "Product Description"),
//           maxLines: 4,
//           autocorrect: true,
//           autofocus: true,
//           onChanged: (String textValue) {
//             productDescription=textValue;
//           },
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: "Product Price"),
//           autocorrect: true,
//           autofocus: true,
//           keyboardType: TextInputType.number,
//           onChanged: (String textValue) {
//             productPrice=double.parse(textValue);
//           },
//         ),
//         SizedBox(
//           height: 10.0,
//         ),
//         RaisedButton(
//             child: Text("Save"),
//             onPressed: () {
//               final Map<String,dynamic> item = {
//                 'title':productName,
//                 'description': productDescription,
//                 'image': 'assets/food.jpg',
//                 'price': productPrice
//               };
//
//               // widget.addProduct(item);
//               // Navigator.pushReplacementNamed(context, "/home");
//             }
//         )
//       ],
//     ),
//   ));
// }

// OPTION 3
// // var dbHelper = DbHelper();
//
// var txtName = TextEditingController();
// var txtDescription = TextEditingController();
// var txtUnitPrice = TextEditingController();
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Add new product"),
//     ),
//     body: Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         children: <Widget>[
//           buildNameField(),
//           buildDescriptionField(),
//           buildUnitPriceField(),
//           buildSaveButton()
//         ],
//       ),
//     ),
//   );
// }
//
// Widget buildNameField() {
//   return TextField(
//     decoration: InputDecoration(labelText: "Name"),
//     controller: txtName,
//   );
// }
//
// buildDescriptionField() {
//   return TextField(
//     decoration: InputDecoration(labelText: "Description"),
//     controller: txtDescription,
//   );
// }
//
// buildUnitPriceField() {
//   return TextField(
//     decoration: InputDecoration(labelText: "Unit Price "),
//     controller: txtUnitPrice,
//   );
// }
//
// buildSaveButton() {
//   return ElevatedButton(
//       onPressed: () {
//         // addProduct();
//       },
//       child: Text("Add"));
// }
//
//
// // void selectProcess(Options options) async {
// //   switch (options) {
// //     case Options.delete:
// //       await dbHelper.delete(product.id);
// //       Navigator.pop(context, true);
// //       break;
// //     case Options.update:
// //       await dbHelper.update(Product.withId(
// //           id: product.id,
// //           name: txtName.text,
// //           description: txtDescription.text,
// //           unitPrice: double.tryParse(txtUnitPrice.text)));
// //       Navigator.pop(context, true);
// //       break;
// //     default:
// //   }
// // }

// OPTION 1
// String? _titleValue;
// String? _descriptionValue;
// double? _priceValue;
//
// Widget _buildTitleTextField() {
//   return TextField(
//     decoration: InputDecoration(labelText: 'Product Title'),
//     onChanged: (String value) {
//       setState(() {
//         _titleValue = value;
//       });
//     },
//   );
// }
//
// Widget _buildDescriptionTextField() {
//   return TextField(
//     decoration: InputDecoration(labelText: 'Product Description'),
//     maxLines: 4,
//     onChanged: (String value) {
//       setState(() {
//         _descriptionValue = value;
//       });
//     },
//   );
// }
//
// Widget _buildPriceTextField() {
//   return TextField(
//     decoration: InputDecoration(labelText: 'Product Price'),
//     keyboardType: TextInputType.number,
//     onChanged: (String value) {
//       setState(() {
//         _priceValue = double.parse(value);
//       });
//     },
//   );
// }
//
// void _submitForm() {
//   final Map<String, dynamic> product = {
//     'title': _titleValue,
//     'description': _descriptionValue,
//     'price': _priceValue,
//     'image': 'assets/ninja2.jpg'
//   };
//   //widget.addProduct(product);
//   Navigator.pushReplacementNamed(context, '/products');
// }
//
// @override
// Widget build(BuildContext context) {
//   final double deviceWidth = MediaQuery.of(context).size.width;
//   final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
//   final double targetPadding = deviceWidth - targetWidth;
//
//   // TODO: implement build
//   return Scaffold(body: Container(
//     margin: EdgeInsets.all(10.0),
//     child: ListView(
//       padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
//       children: <Widget>[
//         _buildTitleTextField(),
//         _buildDescriptionTextField(),
//         _buildPriceTextField(),
//         SizedBox(
//           height: 10.0,
//         ),
//         ElevatedButton(
//             child: Text('Save'),
//             //color: Colors.white,
//             onPressed: _submitForm)
//       ],
//     ),
//   ));
// }

// OPTION 2
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             header(),
//             hero(),
//             Expanded(child: section()),
//             bottomButton()
//           ],
//         ),
//       ));
// }
//
// Widget header() {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Image.asset("assets/images/back_button.png"),
//         Column(
//           children: [
//             Text("MEN'S ORIGINAL",
//                 style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16)),
//             Text("Smith Shoes",
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
//           ],
//         ),
//         Image.asset(
//           "assets/images/bag_button.png",
//           height: 34,
//           width: 34,
//         ),
//       ],
//     ),
//   );
// }
//
// Widget hero() {
//   return Container(
//     child: Stack(
//       children: [
//         // Image.asset(imagePath[colors.indexOf(selectedColor)]),
//         Positioned(
//             bottom: 10,
//             right: 20,
//             child: FloatingActionButton(
//               backgroundColor: Colors.white,
//               onPressed: () {} //{
//                 // setState(() {
//                 //   isFavourite = !isFavourite;
//                 //}
//                 ,
//               //},
//               child: Image.asset("assets/images/heart_icon.png",
//                 //isFavourite ? "images/heart_icon.png" : "images/heart_icon_disabled.png",
//                 height: 34,
//                 width: 34,
//               ))),
//             //))
//       ],
//     ),
//   );
// }
//
// Widget section() {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//     child: Column(
//       children: [
//         Text(
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In "
//               "rutrum at ex non eleifend. Aenean sed eros a purus "
//               "gravida scelerisque id in orci. Mauris elementum id "
//               "nibh et dapibus. Maecenas lacinia volutpat magna",
//           textAlign: TextAlign.justify,
//           style:
//           TextStyle(color: AppColors.secondaryColor, fontSize: 14, height: 1.5),
//         ),
//         SizedBox(height: 20),
//         property()
//       ],
//     ),
//   );
// }
//
// Widget property() {
//   return Container(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Color",
//                 style: TextStyle(
//                     color: AppColors.secondaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16)),
//             SizedBox(height: 10),
//             Row(
//               children: List.generate(
//                   4,
//                       (index) => GestureDetector(
//                     onTap: (){
//                       print("index $index clicked");
//                       // setState(() {
//                       //   selectedColor = colors[index];
//                       // });
//                     },
//                     child: Container(
//                       padding:EdgeInsets.all(8),
//                       margin: EdgeInsets.only(right: 10),
//                       height: 34,
//                       width: 34,
//                       //child: selectedColor == colors[index]? Image.asset("images/checker.png") : SizedBox(),
//                       decoration: BoxDecoration(
//                           color: AppColors.secondaryColor,
//                           borderRadius: BorderRadius.circular(17)),
//                     ),
//                   )),
//             )
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Size",
//                 style: TextStyle(
//                     color: AppColors.secondaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16)),
//             SizedBox(height: 10),
//             Container(
//                 padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                 color: AppColors.primaryColor.withOpacity(0.10),
//                 child: Text(
//                   "10.2",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ))
//           ],
//         )
//       ],
//     ),
//   );
// }
//
// Widget bottomButton() {
//   return Container(
//     padding: EdgeInsets.only(right: 20),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         FlatButton(
//             onPressed: () {},
//             child: Text(
//               "Add to Bag +",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//             )),
//         Text(r"$95", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28))
//       ],
//     ),
//   );
// }
