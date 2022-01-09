import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:poraki/app/modules/addresses/address_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';

class ListAddresses extends StatelessWidget {
  final AddressController controller = Get.put(AddressController());

  ListAddresses({Key? key}) : super(key: key);

  Icon retIcon(String enderecoTipo) {
    if (enderecoTipo == "Casa") {
      return Icon(Icons.home);
    }
    if (enderecoTipo == "Trabalho") {
      return Icon(Icons.work);
    } else {
      return Icon(Icons.map);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildRow(
        String enderecoGuid,
        String enderecoCep,
        String enderecoLogra,
        String enderecoNro,
        String enderecoCompl,
        String enderecoTipo) {
      return ListTile(
        leading: retIcon(enderecoTipo),
        onTap: () => Get.toNamed(AppRoutes.address, arguments: [
          {'enderecoGuid': enderecoGuid}
        ]),
        title: Text(
          enderecoCep,
          // style: _biggerFont,
        ),
        subtitle: Text(enderecoLogra),
        //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
      );
    }

    return FutureBuilder(
        future: controller.carregaEnderecos(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
        print('qt ends: ' + controller.enderecos.length.toString());
        return SingleChildScrollView(
            child: GradientHeaderHome(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              SizedBox(height: 20),
              Center(child: Text("Meus endereços")),
              SizedBox(height: 20),
              ButtonOffer(
                onPressed: () {
                  Get.toNamed(AppRoutes.address);
                },
                colorText: AppColors.yellowComum,
                text: 'Adicionar novo',
                colorButton: AppColors.primaryColor,
              ),
              Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //scrollDirection: Axis.vertical,
                  // padding: const EdgeInsets.all(16.0),
                  itemCount: controller.enderecos.length,
                  itemBuilder: (BuildContext context, int index) {
                    //if (index.isOdd) return const Divider();
                    //index = index ~/ 2 + 1;
                    sqlEndereco endereco = controller.enderecos[index];
                    return _buildRow(
                        endereco.enderecoGuid,
                        endereco.enderecoCEP,
                        endereco.enderecoLogra,
                        endereco.enderecoNumero,
                        endereco.enderecoCompl!,
                        endereco.enderecoTipo);
                  },
                ),
              )
            ])));
      }
    });
  }
}
