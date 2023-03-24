import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/chats/chat_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import '../../data/models/chats.dart';
import '../../routes/app_routes.dart';
import '../home/home_controller.dart';
import '../home/widgets/app_bar_home.dart';
import '../home/widgets/drawer_home.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final HomeController controller = Get.find();
  // final LoginController _loginController = Get.find();
  final ChatController _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.find();
    final Color colorText = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());
    final Color backColor = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());

    Widget _buildRow(Chats chat) {
      return Column(children: [
        ListTile(
          onTap: () {
            Get.toNamed(AppRoutes
                .chat); // arguments: [ {'enderecoGuid': endereco.enderecoGuid} ]);
          },
          leading: Icon(Icons.message),
          title: Text(
            chat.chatName.toString(),
            style: TextStyle(fontSize: 16, color: colorText),
            // style: _biggerFont,
          ),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Text(
                'Desde ' +
                    DateFormat("dd/MM/yyyy").format(chat.chatStart!.toDate()) +
                    ' às ' +
                    DateFormat("hh:mm").format(chat.chatStart!.toDate()),
                style: TextStyle(fontSize: 13, color: colorText)),
            const SizedBox(height: 10),
            Text(
              chat.pessoaSeller!.pessoaFirebaseID == _loginController.usuGuid
                  ? chat.pessoaCustomer!.pessoaNome.toString()
                  : chat.pessoaSeller!.pessoaNome.toString(),
              style: TextStyle(
                  fontSize: 16, color: colorText, fontWeight: FontWeight.w900),
            ),
            //const Divider(),
          ]),
          // trailing: Column(
          //   children: [
          //     Expanded(
          //         child: Text(
          //       chat.customerId.toString(),
          //       style: TextStyle(
          //           fontSize: 16,
          //           color: colorText,
          //           fontWeight: FontWeight.w900),
          //     )),
          //   ],
          // ),
          //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
        ),
        // const SizedBox(height: 5),
        // const Divider(),
        // const SizedBox(height: 5),
      ]);
    }

    Future<void> pegaChats() async {
      await _chatController.getAllBySellerId();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: FutureBuilder(
          future: pegaChats(),
          builder: (context, futuro) {
            if (futuro.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); //Text('carrinho vazio'));
              // } else if (futuro.hasError) {
              //   return Center(child: Text(futuro.error.toString()));
            } else {
              // print('qt chats: ' + _chatController.listChats.length.toString());
              return SingleChildScrollView(

                  //child: GradientHeaderHome(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    const SizedBox(height: 15),
                    Center(
                        child: Text(
                      "Mensagens",
                      style: TextStyle(fontSize: 24),
                    )),
                    const SizedBox(height: 15),
                    if (_chatController.listChats.length == 0)
                      Container(
                          child: Center(
                              child: Text(
                                  "Ops, nenhuma mensagem poraki neste momento... ;-)")))
                    else
                      Container(padding: const EdgeInsets.all(5),margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: backColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: backColor,
                        ),
                        //color: backColor,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          //scrollDirection: Axis.vertical,
                          // padding: const EdgeInsets.all(16.0),
                          itemCount: _chatController.listChats.length,
                          itemBuilder: (BuildContext context, int index) {
                            //if (index.isOdd) return const Divider();
                            //index = index ~/ 2 + 1;
                            Chats chat = _chatController.listChats[index];
                            return _buildRow(chat);
                          },
                        ),
                      )
                  ])
                  // )
                  );
            }
          }),
      drawer: DrawerHome(0),
      backgroundColor: _loginController.colorFromHex(_loginController.listCore
          .where((coreItem) => coreItem.coreChave == 'backDark')
          .first
          .coreValor
          .toString()),
    );
  }
}
