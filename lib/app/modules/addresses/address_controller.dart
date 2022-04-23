import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/enderecos.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:poraki/app/data/repositories/address_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_address_service.dart';

class AddressController extends GetxController {
  // enderecoGuid;
  // final String  usuEmail;
  // final String  usuGuid;
  MaskedTextController txtCEP = MaskedTextController(mask: '00000-000');
  final TextEditingController txtEnderecoLogra = TextEditingController();
  final TextEditingController txtEnderecoNumero = TextEditingController();
  final TextEditingController? txtEnderecoCompl = TextEditingController();
  final TextEditingController txtEnderecoTipo = TextEditingController();
  // final int     txtEnderecoAtual;
  // final String? txtEnderecoUltData;
  // final String? txtEnderecoDesde;

  // AddressRepository addressRepository = AddressRepository();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  List<sqlEndereco> enderecos = [];
  late sqlEndereco enderecoSingle;
  late Enderecos selEndereco;
  AddressRepository repo = new AddressRepository();
  LoginController _login = Get.find();

  // Future<void> getAllCategories() async {
  //   try {
  //     changeLoading(true);
  //     categorias = await categoriesRepository.getAllCategories();
  //   } catch (e) {
  //     print('Erro no getAllCategories() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }

  @override
  void initState() {

  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  // @override
  // void onInit() async {
  //   await carregaUsuario();
  //   super.onInit();
  // }

  Future<void> bindEndereco(String? endGuid) async {
    if(endGuid!.isNotEmpty) {
      enderecoSingle = enderecos.where((end) => end.enderecoGuid == endGuid).first;
      txtEnderecoLogra.text = enderecoSingle.enderecoLogra.toString();
      txtEnderecoNumero.text = enderecoSingle.enderecoNumero.toString();
      txtEnderecoTipo.text = enderecoSingle.enderecoTipo.toString();
      txtCEP.text = enderecoSingle.enderecoCEP.toString();
    }
    else {
      txtEnderecoLogra.text = '';
      txtEnderecoNumero.text = '';
      txtEnderecoTipo.text = '';
      txtCEP.text = '';
    }
  }

  Future<void> carregaEnderecos() async {
    print('carregaEnderecos');
    enderecos.clear();

    // var flag = 1;
    // if(flag == 1){
    //   //await sqlPorakiAddressService().verificaTabela();
    //   await sqlPorakiAddressService().deleteEnderecos();
    //
    // }

    // await sqlPorakiAddressService().initDB();

    var lista = await sqlPorakiAddressService().buscaEnderecos(false);
    lista.forEach((item) {
      print('item endereco atual: ' + item.enderecoAtual.toString());
      var endereco = new sqlEndereco(
          item.enderecoGuid.toString(),
          item.usuEmail.toString(),
          item.usuGuid.toString(),
          item.enderecoCEP.toString(),
          item.enderecoLogra.toString(),
          item.enderecoNumero.toString(),
          item.enderecoCompl.toString(),
          item.enderecoTipo.toString(),
          item.enderecoAtual,
          item.enderecoUltData.toString(), "",""
          // item.enderecoLat,
          // item.enderecoLong.toString()
          //item.enderecoDesde.toString(),
          );

      enderecos.add(endereco);
    });

    print('enderecos empty? - ' + enderecos.isEmpty.toString());
    // se a tabela estiver vazia no sqlite, busca da nuvem
    if (enderecos.isEmpty)
      {
        sqlPorakiAddressService().verificaTabela();
        print('enderecos empty - usuGuid: ' + _login.usuGuid.toString());
        var lista = await repo.getAllAddresses();
        print('lista endereco nuvem qtd: ' + lista.length.toString());
        lista.forEach((itemApi) {
          print('itemApi end atual: ' + itemApi.EnderecoCEP.toString() + ' = ' + itemApi.EnderecoAtual.toString());
          var endereco = new sqlEndereco(
              itemApi.EnderecoGuid.toString(),
              itemApi.UsuEmail.toString(),
              itemApi.UsuGuid.toString(),
              itemApi.EnderecoCEP.toString(),
              itemApi.EnderecoLogra.toString(),
              itemApi.EnderecoNumero.toString(),
              itemApi.EnderecoCompl.toString(),
              itemApi.EnderecoTipo.toString(),
              itemApi.EnderecoAtual,
              '',
              itemApi.EnderecoLat,
              itemApi.EnderecoLong.toString()
            //item.enderecoDesde.toString(),
          );

          enderecos.add(endereco);

          // adiciona na base local
          sqlPorakiAddressService().insertEndereco(endereco);
        });
      }

    // forca a atualizacao do endereço local pq no fetch SIMPLESMENTE NAO FUNCIONA
    var end = enderecos.where((_end) => _end.enderecoCEP == _login.usuCep).first;
    await sqlPorakiAddressService().updateEnderecoAtual(end.enderecoGuid);

    await sqlPorakiAddressService().closeDB();
  }

  Future<sqlEndereco> retornaEnderecoAtualSqlLocal() async {
    print('carregaEnderecoAtual');

    var lista = await sqlPorakiAddressService().buscaEnderecos(true);
    late sqlEndereco endereco;
    lista.forEach((item) {
      endereco = new sqlEndereco(
          item.enderecoGuid.toString(),
          item.usuEmail.toString(),
          item.enderecoGuid.toString(),
          item.enderecoCEP.toString(),
          item.enderecoLogra.toString(),
          item.enderecoNumero.toString(),
          item.enderecoCompl.toString(),
          item.enderecoTipo.toString(),
          item.enderecoAtual,
          item.enderecoUltData.toString(),'',''
          // item.enderecoLat,
          // item.enderecoLong.toString()
          //item.enderecoDesde.toString(),
          );
    });

    return endereco;
  }

  Future<String> getCepAtualLocal() async {
    var lista = await sqlPorakiAddressService().buscaEnderecos(true);
    late sqlEndereco endereco;
    lista.forEach((item) {
      endereco = new sqlEndereco(
          item.enderecoGuid.toString(),
          item.usuEmail.toString(),
          item.enderecoGuid.toString(),
          item.enderecoCEP.toString(),
          item.enderecoLogra.toString(),
          item.enderecoNumero.toString(),
          item.enderecoCompl.toString(),
          item.enderecoTipo.toString(),
          item.enderecoAtual,
          item.enderecoUltData.toString(),"",""
          // item.enderecoLat,
          // item.enderecoLong.toString()
        //item.enderecoDesde.toString(),
      );
    });

    print('cep atual: ' + endereco.enderecoCEP);

    return endereco.enderecoCEP;
  }

  Future<String?> getCepAtualCloud() async {
    var endereco = await repo.getCurrentAddress();
    return endereco.EnderecoCEP;
  }

  Future<void> carregaEnderecoSingle(String enderecoGuid) async {
    print('carregaEnderecoSingle');

    var lista =
        await sqlPorakiAddressService().buscaEnderecoSingle(enderecoGuid);
    lista.forEach((item) {
      enderecoSingle = new sqlEndereco(
          item.enderecoGuid.toString(),
          item.usuEmail.toString(),
          item.enderecoGuid.toString(),
          item.enderecoCEP.toString(),
          item.enderecoLogra.toString(),
          item.enderecoNumero.toString(),
          item.enderecoCompl.toString(),
          item.enderecoTipo.toString(),
          item.enderecoAtual,
          item.enderecoUltData.toString(),
          item.enderecoLat,
          item.enderecoLong.toString()
          //item.enderecoDesde.toString(),
          );
    });

    txtCEP.text = enderecoSingle.enderecoCEP;
    txtEnderecoLogra.text = enderecoSingle.enderecoLogra;
    txtEnderecoNumero.text = enderecoSingle.enderecoNumero;
    txtEnderecoCompl!.text = enderecoSingle.enderecoCompl!;
    txtEnderecoTipo.text = enderecoSingle.enderecoTipo;
  }

  Future<void> atualizaEndereco(Enderecos endereco) async {
    //endereco.EnderecoUltData = DateTime.now().toString();
    var resp = await repo.putAddress(endereco);

    //if (resp.isEmpty)
    var sqlEnd = new sqlEndereco(endereco.EnderecoGuid.toString(), endereco.UsuEmail.toString(), endereco.UsuGuid.toString(), endereco.EnderecoCEP.toString(),
        endereco.EnderecoLogra.toString(), endereco.EnderecoNumero.toString(), endereco.EnderecoCompl, endereco.EnderecoTipo.toString(), endereco.EnderecoAtual,
        DateTime.now().toString(), endereco.EnderecoLat, endereco.EnderecoLong);

    await sqlPorakiAddressService().updateEndereco(sqlEnd);
    // await carregaUsuario();
  }

  Future<void> adicionaEndereco(Enderecos endereco) async {
    await repo.postAddress(endereco);

    //if (resp.isEmpty)
    var sqlEnd = new sqlEndereco(endereco.EnderecoGuid.toString(), endereco.UsuEmail.toString(), endereco.UsuGuid.toString(), endereco.EnderecoCEP.toString(),
        endereco.EnderecoLogra.toString(), endereco.EnderecoNumero.toString(), endereco.EnderecoCompl, endereco.EnderecoTipo.toString(), endereco.EnderecoAtual,
        DateTime.now().toString(), endereco.EnderecoLat, endereco.EnderecoLong);

    await sqlPorakiAddressService().insertEndereco(sqlEnd);
    // await carregaUsuario();
  }

  Future<void> apagaEndereco(Enderecos endereco) async {
    endereco.EnderecoTipo = 'Inativo';
    var resp = await repo.putAddress(endereco);

    var sqlEnd = new sqlEndereco(endereco.EnderecoGuid.toString(), endereco.UsuEmail.toString(), endereco.UsuGuid.toString(), endereco.EnderecoCEP.toString(),
        endereco.EnderecoLogra.toString(), endereco.EnderecoNumero.toString(), endereco.EnderecoCompl, endereco.EnderecoTipo.toString(), endereco.EnderecoAtual,
        DateTime.now().toString(), endereco.EnderecoLat, endereco.EnderecoLong);

    if (resp.isNotEmpty)
      await sqlPorakiAddressService().deleteEndereco(endereco.EnderecoGuid.toString());
    // await carregaUsuario();
  }

  Future<void> tornarEnderecoAtual(String enderecoGuid) async {
    print('tornarEnderecoAtual');
    var resp = await repo.putCurrentAddress(enderecoGuid);
    print('resp current address: ' + resp.toString());

    if (resp.isNotEmpty) {
      var respn = await repo.putCurrentNAddress(enderecoGuid);
      print('resp current naddress: ' + respn.toString());

      if (respn.isNotEmpty)
        await sqlPorakiAddressService().updateEnderecoAtual(enderecoGuid);
    }

    // await carregaUsuario();
  }

}