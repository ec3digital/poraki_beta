import 'package:flutter/material.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:poraki/app/app_widget.dart';
import 'package:poraki/app/data/models/sql/sqlCore.dart';
import 'package:poraki/app/services/fbporaki_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_core_service.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'package:poraki/app/modules/auth/sign_up/sign_up_page.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<List<Map<String,dynamic>>> buscaSqlUserData() async {
  // var termos = await fbPorakiService().getValueFromFirebase('akitermos', 'termos', 'ptbr');
  // print('termos new: ' + termos.toString());

  //aproveita e carrega os dados de sqlCore
  // verifica tabela core local
  await sqlPorakiCoreService().verificaTabela();

  var sqlSvc = new sqlPorakiLoginService();
  await sqlSvc.openCreateDB();
  return await sqlSvc.buscaUsuDados();
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController _mailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();

  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();
  List<Map<String,dynamic>>? listUser; // = futuro.data as List<Map<String, dynamic>>?;

  @override
  Widget build(BuildContext context) {
    // _mailInputController.text = 'test';
    return FutureBuilder(future: buscaSqlUserData(),
      builder: (context, futuro) {
        if (!futuro.hasData) {
          return Scaffold();
        } else {
          listUser = futuro.data as List<Map<String, dynamic>>?;
          //late String? userEmail = "";
          // if (listUser != null) {
            for(var u in listUser!) //{
              listUser!.forEach((element) { _mailInputController.text = element["usuEmail"].toString(); });
            // }
          // }

          print('email: ' + _mailInputController.text.isEmpty.toString());
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryBackground,
                    AppColors.secondaryBackground
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                          bottom: 7,
                        ),
                        child: new Container(
                            child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/poraki250.png',
                                image: 'http://poraki-assets.ec3.digital/wp-content/uploads/2021/11/poraki250.png'
                            )
                        )
                    ),
                    Text(
                      "Entrar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 5) {
                                return "Esse e-mail parece curto demais";
                              } else if (!value.contains("@")) {
                                return "Esse e-mail está meio estranho, não?";
                              }
                              return null;
                            },
                            controller: _mailInputController,
                            autofocus: _mailInputController.text.isEmpty,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 6) {
                                return "A senha deve ter pelo menos 6 caracteres";
                              }
                              return null;
                            },
                            autofocus: _mailInputController.text.isNotEmpty,
                            obscureText: _obscurePassword,
                            controller: _passwordInputController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Icon(
                                Icons.vpn_key_sharp,
                                color: Colors.white,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Esqueceu a senha?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: this._obscurePassword,
                          onChanged: (newValue) {
                            setState(() {
                              this._obscurePassword = newValue!;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        Text(
                          "Mostrar senha",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _doLogin(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF116530),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Ainda não tem uma conta?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text("Cadastre-se"),
                        color: Color(0xFFA3EBB1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      });
  }

  void _doLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // //add email address to the shared prefs
      // PorAkiPrefs.savePrefStr("userEmail", _mailInputController.text);
      //
      // //TODO: pegar o cep, lastLogin, endereço padrao e jogar no shared prefs
      // PorAkiPrefs.savePrefStr("userCep", "05735-030");
      //
      // //pega param do firebase
      // String param = new fbPorakiService().getTermos() as String;
      // print("termos: " + param);
      //
      // LoginService().login(_mailInputController.text, _passwordInputController.text);

      LoginController _loginController = Get.put(LoginController());
      await _loginController.runCore();
      //TODO: tratar a resposta do login

      // // salva usuario no hive, cria instancia do hive e abre a box
      // // new hivePorakiUserService().SetUserEmail(_mailInputController.text.trim());
      // // recupera os dados do SQLite e joga no Hive para facilitar as buscas no app
      // listUser = await buscaSqlUserData();
      // for(var u in listUser!) //{
      //   listUser!.forEach((element) {
      //     // hivePorakiUserService().SetUserName(element["usuNome"].toString());
      //     // hivePorakiUserService().SetLastLogin(DateTime.now().toString());
      //     // hivePorakiUserService().SetUserCep(element["usuCEP"].toString());
      //     // // hivePorakiUserService().SetUserCep('05735-030');
      //     // hivePorakiUserService().SetUserUID('eyCv21RfaURoMn0SUndCg6LPyJP2');
      //   });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppWidget(),
        ),
      );
    } else {
      print("invalido");
    }
  }

// Future<LoginModel> _getSavedUser() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String jsonUser = prefs.getString(PreferencesKeys.activeUser);
//   print(jsonUser);

//   Map<String, dynamic> mapUser = json.decode(jsonUser);
//   LoginModel user = LoginModel.fromJson(mapUser);
//   return user;
// }
}

// WIDGETS
// BoxDecoration
// LinearGradient
// MediaQuery.of(context).size.width
// SingleChildScrollView
// Column
// Form
// TextFormField
// InputDecoration
// GestureDectector



// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:poraki/app/routes/app_pages.dart';
// import 'package:poraki/app/routes/app_routes.dart';
// import 'package:poraki/app/theme/app_theme.dart';
//
// import 'widgets/body_login.dart';
//
// // class LoginPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(body: BodyLogin());
// //   }
// // }
//
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'PorAki',
//       // getPages: AppPages.routes,
//       // theme: AppTheme.light(),
//       themeMode: ThemeMode.light,
//       initialRoute: AppRoutes.login,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
