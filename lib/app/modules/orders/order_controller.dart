
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:poraki/app/data/models/PedidoItem.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedidoItem.dart';
import 'package:poraki/app/data/repositories/order_repository.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_pedido_service.dart';

class OrderController extends GetxController {

  Pedido? selPedido;
  List<Pedido> listaPedidos = [];
  List<PedidoItem> listaPedidoItems = [];
  bool isLoading = false;

  @override
  void onInit() async {
    super.onInit();
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Future<void> carregaPedidoLocalItems(String pedidoGUID) async {
    listaPedidoItems.clear();

    List<sqlPedidoItem> sqlPedidoItems = await sqlPorakiPedidoService().listOrderItems(pedidoGUID);
    print('qtd items sql: ' + sqlPedidoItems.length.toString());
    sqlPedidoItems.forEach((item) {
      listaPedidoItems.add(sqlPorakiPedidoService().convertSqlpedItemToPedidoItem(item));
    });
  }

  Future<void> carregaPedidoCloudItems(String pedidoGUID) async {
    print('carregaPedidoCloudItems');
    listaPedidoItems.clear();

    var listaPedidoItemsTemp = await OrdersRepository().getOrderItems(pedidoGUID);
    print('qtd items cloud - carregaPedidoCloudItems: ' + listaPedidoItemsTemp.length.toString());
    listaPedidoItemsTemp.forEach((item) {listaPedidoItems.add(item);});
  }

  Future<void> carregaPedidosFechadosLocal(String userGUID) async {
    listaPedidos.clear();

    List<sqlPedido> pedidos = await sqlPorakiPedidoService().listOrders(userGUID);
    print('qtd pedidos: ' + pedidos.length.toString());
    // pedidos.forEach((sqlPed) {
    //   listaPedidos.add(sqlPorakiPedidoService().convertSqlpedToPedido(sqlPed)
    //   );
    // });
  }

  Future<void> carregaPedidosPorClienteOpenCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersByCustomerOpen(userGUID);
    print('qtd pedidos cloud - carregaPedidosPorClienteOpenCloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });
  }

  Future<void> carregaPedidosPorVendedorOpenCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersBySellerOpen(userGUID);
    print('qtd pedidos cloud - carregaPedidosPorVendedorOpenCloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });
  }

  Future<void> carregaPedidosPorVendedorOpenDeliveryCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersBySellerDeliveryOpen(userGUID);
    print('qtd pedidos cloud - carregaPedidosPorVendedorOpenDeliveryCloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });
  }

  Future<void> carregaPedidosPorClienteClosedCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersByCustomerClosed(userGUID);
    print('qtd pedidos cloud - carregaPedidosPorClienteClosedCloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });
  }

  Future<void> carregaPedidosPorVendedorClosedCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersBySellerClosed(userGUID);
    print('qtd pedidos cloud - carregaPedidosPorVendedorClosedCloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });
  }

  Future<void> carregaPedidosPorVendedorClosedDeliveryCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersBySellerDeliveryClosed(userGUID);
    print('qtd pedidos cloud - carregaPedidosPorVendedorClosedDeliveryCloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });
  }

  Future<Pedido> pegaPedidoCloud(String pedidoGUID) async {
    return await OrdersRepository().getOrder(pedidoGUID);
  }

  Future<void> avaliaPedidoCloud(String pedidoGuid, int score) async {
    await OrdersRepository().putOrderEval(pedidoGuid, score);
  }

  Future<void> cancelaPedidoCloud(String pedidoGuid, String usuGuid, String motivo) async {
    await OrdersRepository().putOrderCancel(pedidoGuid, usuGuid, motivo);
  }

  Future<void> entregaPedidoCloud(String pedidoGuid, String usuGuid, String usuEmail, String usuNome, String lat, String long) async {
    await OrdersRepository().putOrderDeliver(pedidoGuid, usuGuid, usuEmail, usuNome, lat, long);
  }

  Future<void> pagaPedidoCloud(String pedidoGuid, String Autoriza, String Entidade) async {
    await OrdersRepository().putOrderPayment(pedidoGuid, Autoriza, Entidade);
  }

  Future<void> aceitaPedidoCloud(String pedidoGuid, String usuNome) async {
    await OrdersRepository().putOrderAcceptedBy(pedidoGuid, usuNome);
  }

  Future<void> recebePedidoCloud(String pedidoGuid, String usuNome) async {
    await OrdersRepository().putOrderReceivedBy(pedidoGuid, usuNome);
  }

  Future<void> buscaPedidoItemsCloud(String pedidoGUID) async {
    await sqlPorakiPedidoService().listOrderItems(pedidoGUID);
  }

  Future<void> atualizaPedidoLocal(String pedidoGUID) async {
    // pega o pedido da nuvem
    Pedido pedCloud = await pegaPedidoCloud(pedidoGUID);

    if(pedCloud != null) {
      // transforma o pedido da nuvem em pedido local
      var sqlped = new sqlPedido(
          pedidoGUID,
          pedCloud.PedidoVendedorGUID,
          pedCloud.PedidoVendedorEmail,
          pedCloud.PedidoEm,
          pedCloud.PedidoValorTotal,
          pedCloud.PedidoFormaPagto,
          pedCloud.PedidoCancelada,
          pedCloud.PedidoPagtoEm.toString(),
          pedCloud.PedidoPessoaNome,
          pedCloud.PedidoPessoaEmail,
          pedCloud.PedidoUsuGUID,
          pedCloud.PedidoAval,
          pedCloud.PedidoAvalEm,
          pedCloud.PedidoMoeda,
          pedCloud.PedidoCEP,
          pedCloud.PedidoEndereco,
          pedCloud.PedidoNumero,
          pedCloud.PedidoCompl,
          pedCloud.PedidoAutoriza,
          pedCloud.PedidoInstituicao,
          pedCloud.PedidoEntregaPrevista,
          pedCloud.PedidoEntregaRealizadaEm,
          pedCloud.PedidoEntregaPorUsuEmail,
          pedCloud.PedidoEntregaPorUsuNome,
          pedCloud.PedidoDetalhe,
          pedCloud.PedidoEntregaDetalhe,
          // pedCloud.PedidoEntregaEm,
          // pedCloud.PedidoEntregaPorEmail,
          // pedCloud.PedidoEntregaPorNome,
          pedCloud.RecebidoPor,
          pedCloud.PedidoLojaID,
        pedCloud.PedidoEntregaCodigo
      );

      await sqlPorakiPedidoService().deleteOrder(pedidoGUID);
      await sqlPorakiPedidoService().insertOrder(sqlped);
    }
    else {
      //TODO: trata erro
    }

  }


}