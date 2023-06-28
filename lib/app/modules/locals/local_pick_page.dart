import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';
import '../../theme/app_theme.dart';

class LocalPickPage extends StatefulWidget {
  @override
  State<LocalPickPage> createState() => _LocalPickPageState();
}

class _LocalPickPageState extends State<LocalPickPage> {
  List<DropdownMenuItem<String>> dropDownMenuItems = [];
  var localSel = '';
  List<String> locais = ['057 - Zona Sul / Região Morumbi', ''];
  final LoginController _loginController = Get.find();

  Future<void> carregaLocais() async {
    // locais.clear();

    await _loginController.fbInstance!
        .doc('akiregioes')
        .collection('ceps/Lista')
        .get()
        .then((value) => value.docs.forEach((element) {
              locais.add(element['Cep'] + ' - ' + element['CepNome']);
            }));
  }

  @override
  Widget build(BuildContext context) {
    dropDownMenuItems = locais
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

    return FutureBuilder(
        future: carregaLocais(),
        builder: (context, futuro) {
          return Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.secondaryBackground,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      FadeInImage.assetNetwork(
                          placeholder: 'assets/images/poraki250.png',
                          image:
                              'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/App%2Fporaki-splash.png?alt=media'),
                      const SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          const Divider(),
                          //const SizedBox(height: 10),
                          Text('Escolha a região para encontrar ofertas',
                              style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 10),
                          DropdownButton<String>(
                            items: locais.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: localSel,
                            onChanged: (String? newValue) {
                              if (newValue != '') {
                                setState(() {
                                  _loginController.cloudId =
                                      newValue!.substring(0, 3);
                                  localSel = newValue;
                                });
                                _loginController.usuCep = localSel;
                                _loginController.cloudId = localSel;
                                new sqlPorakiLoginService().updateUsuarioCEP(
                                    localSel,
                                    _loginController.usuEmail.toString());
                                Get.toNamed(AppRoutes.porakiSplash);
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 80),
                    ])),
          );
        });
  }
}
