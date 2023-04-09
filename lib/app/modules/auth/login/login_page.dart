import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/app_widget.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_core_service.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'package:poraki/app/modules/auth/sign_up/sign_up_page.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';
import '../../../util/alerta.dart';
import 'login_controller.dart';
import 'login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<List<Map<String, dynamic>>> buscaSqlUserData() async {
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
  bool isLoading = false;
  bool _obscurePassword = false;
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>>? listUser;

  String tempLoginResult =
      'OK'; // = futuro.data as List<Map<String, dynamic>>?;

  @override
  Widget build(BuildContext context) {
    // _mailInputController.text = 'test';
    return FutureBuilder(
        future: buscaSqlUserData(),
        builder: (context, futuro) {
          if (!futuro.hasData) {
            return Scaffold();
          } else {
            listUser = futuro.data as List<Map<String, dynamic>>?;
            listUser!.forEach((element) {
              _mailInputController.text = element["usuEmail"].toString();
            });

            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                          child:  FadeInImage.assetNetwork(
                                  height: 110,imageCacheHeight: 110,placeholderCacheHeight: 110,
                                  placeholder: 'assets/images/poraki250.png',
                                  image:
                                      'http://ec3.digital/wp-content/uploads/2023/03/poraki_pqn.png')),
                      Text(
                        "Entrar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                // RegExp regex = new RegExp(
                                //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                // if (value!.isEmpty || !regex.hasMatch(value))
                                //   return 'Favor informar um endereço de e-mail correto';
                                // else
                                //   return null;

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
                              autofillHints: [AutofillHints.email],
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
                              obscureText: !_obscurePassword,
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
                        padding: EdgeInsets.only(bottom: 6),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Esqueceu a senha?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
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
                        onPressed: () async {
                          if (!isLoading && _formKey.currentState!.validate())
                            tempLoginResult = await _doLogin(context);

                          setState(() {
                            isLoading = true;
                          });

                          if (tempLoginResult == 'OK') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppWidget(),
                              ),
                            );
                          } else {
                            print(tempLoginResult);
                            Alerta(context, tempLoginResult);
                          }

                          setState(() {
                            isLoading = tempLoginResult == 'OK' ? true : false;
                          });
                        },
                        child: (isLoading)
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.5,
                                ))
                            : const Text(
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
                        style: TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        // ignore: deprecated_member_use
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: Text("Cadastre-se"),
                          //color: Color(0xFFA3EBB1),
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                     // ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  Future<String> _doLogin(BuildContext context) async {
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

      var loginResult = await LoginService().loginWithEmailAndPassword(
          _mailInputController.text, _passwordInputController.text);

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

      return loginResult;
    } else {
      print("Tentativa inválida");
    }
    return 'Erro';
  }

  // Alerta(BuildContext context, String msg)
  // {
  //   // configura o button
  //   Widget okButton = ElevatedButton(
  //     child: Text("OK"),
  //     onPressed: () { Navigator.of(context).pop(); },
  //   );
  //   // configura o  AlertDialog
  //   AlertDialog alerta = AlertDialog(
  //     title: Text("Alerta"),
  //     content: Text(msg),
  //     actions: [
  //       okButton,
  //     ],
  //   );
  //   // exibe o dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alerta;
  //     },
  //   );
  // }

// Future<LoginModel> _getSavedUser() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String jsonUser = prefs.getString(PreferencesKeys.activeUser);
//   print(jsonUser);

//   Map<String, dynamic> mapUser = json.decode(jsonUser);
//   LoginModel user = LoginModel.fromJson(mapUser);
//   return user;
// }
}

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
