import 'package:get/get.dart';
import 'package:poraki/app/data/models/PedidoItem.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';
import '../models/pedido.dart';

class OrdersRepository extends GetConnect {
  LoginController _loginController = Get.find();
  // String url = '${Constants.baseUrl}categorias';
  // String urlBarra = '${Constants.baseUrl}categoriasbarra';

  Future<Pedido> getOrder(String orderGuid) async {
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedido').first.coreValor.toString()}/' + orderGuid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().getOrder()';
    return (response.body['Pedidos'] as List)
        .map((pedidos) => Pedido.fromJson(pedidos)).first;
  }

  Future<List<Pedido>> getOrdersBySellerOpen(String sellerGuid) async {
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidosPorVendedorOpen').first.coreValor.toString()}/' + sellerGuid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().getOrdersBySellerOpen()';
    return (response.body['Pedidos'] as List)
        .map((pedidos) => Pedido.fromJson(pedidos))
        .toList();
  }

  Future<List<Pedido>> getOrdersByCustomerOpen(String usuGuid) async {
    print('url: ' + '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidosPorClienteOpen').first.coreValor.toString()}/' + usuGuid);
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidosPorClienteOpen').first.coreValor.toString()}/' + usuGuid, headers: Constants.headers);
    print(response.bodyString);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().getOrdersByCustomerOpen()';
    return (response.body['Pedidos'] as List)
        .map((pedidos) => Pedido.fromJson(pedidos))
        .toList();
  }

  Future<List<Pedido>> getOrdersBySellerClosed(String sellerGuid) async {
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidosPorVendedor').first.coreValor.toString()}/' + sellerGuid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().getOrdersBySellerClosed()';
    return (response.body['Pedidos'] as List)
        .map((pedidos) => Pedido.fromJson(pedidos))
        .toList();
  }

  Future<List<Pedido>> getOrdersByCustomerClosed(String usuGuid) async {
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidosPorCliente').first.coreValor.toString()}/' + usuGuid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().getOrdersByCustomerClosed()';
    return (response.body['Pedidos'] as List)
        .map((pedidos) => Pedido.fromJson(pedidos))
        .toList();
  }

  Future<String> putOrderEval(String orderGuid, int score) async {
    var response = await put('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidoAvalia').first.coreValor.toString() + '/' + orderGuid  + '/' + score.toString()}', '', headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().putOrderEval()';
    return response.bodyString.toString();
  }

  Future<String> putOrderCancel(String orderGuid, String usuGuid, String Reason) async {
    var response = await put('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidoCancela').first.coreValor.toString() + '/' + orderGuid + '/' + usuGuid + '/' + Reason}', '', headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().putOrderCancel()';
    return response.bodyString.toString();
  }

  Future<String> putOrderDeliver(String orderGuid, String usuGuid, String usuEmail, String usuName, String lat, String long) async {
    var response = await put('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidoEntrega').first.coreValor.toString() + '/' + orderGuid + '/' + usuGuid + '/' + usuEmail + '/' + usuName + '/' + lat + '/' + long}', '', headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().putOrderDeliver()';
    return response.bodyString.toString();
  }

  Future<String> putOrderPayment(String orderGuid, String Auth, String Bank) async {
    var response = await put('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidoPagto').first.coreValor.toString() + '/' + orderGuid + '/' + Auth + '/' + Bank}', '', headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().putOrderPayment()';
    return response.bodyString.toString();
  }

  Future<String> postOrder(Pedido pedido) async {
    var response = await post('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidoPagto').first.coreValor.toString()}', pedido.toJson(), headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().postOrder()';
    return response.bodyString.toString();
  }

  Future<List<PedidoItem>> getOrderItems(String orderGuid) async {
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidoItens').first.coreValor.toString()}/' + orderGuid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().getOrder()';
    return (response.body['PedidoItens'] as List)
        .map((pedidoitem) => PedidoItem.fromJson(pedidoitem)).toList();
  }

  Future<String> postOrderItem(PedidoItem pedidoItem) async {
    var response = await post('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiPedidoItens').first.coreValor.toString()}', pedidoItem.toJson(), headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OrdersRepository().postOrderItem()';
    return response.bodyString.toString();
  }

}