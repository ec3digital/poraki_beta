import 'package:flutter/material.dart';
import 'package:poraki/app/app_widget.dart';
import 'package:poraki/app/modules/auth/login/login_service.dart';
import 'package:poraki/app/theme/custom_colors.dart';
import 'package:poraki/app/modules/auth/sign_up/sign_up_page.dart';

// import 'package:poraki/paginas/login/login_service.dart';
// import 'package:poraki/paginas/sign_up/sign_up_page.dart';
// import 'package:poraki/paginas/home/home_page.dart';
// import 'package:poraki/paginas/testefb/testefb.dart';
// import 'package:poraki/paginas/testeofer/telaofer.dart';
// import 'package:poraki/shared/constants/custom_colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors().getGradientMainColor(),
              CustomColors().getGradientSecondaryColor(),
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
                // child: Image.network(
                //   "http://poraki-assets.ec3.digital/wp-content/uploads/2021/11/poraki250.png",
                //   height: 250,
                // ),
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
                      autofocus: true,
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
                    CustomColors().getActivePrimaryButtonColor(),
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
                  color: CustomColors().getActiveSecondaryButton(),
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

  void _doLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      LoginService().login(_mailInputController.text, _passwordInputController.text);

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
