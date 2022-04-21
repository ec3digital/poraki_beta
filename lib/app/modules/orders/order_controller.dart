
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:poraki/app/data/models/PedidoItem.dart';
import 'package:poraki/app/data/models/pedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedidoItem.dart';
import 'package:poraki/app/data/repositories/order_repository.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_pedido_service.dart';

class OrderController extends GetxController {

  // var listaPedidos = [];
  // var listaPedidosCloud = [];
  // List<sqlPedidoItem> listaPedidosItems = [];
  // List<PedidoItem> listaPedidosItemsCloud = [];
  // sqlPedido? pedido;
  // Pedido? pedidoCloud;

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
    print('qtd items cloud: ' + listaPedidoItemsTemp.length.toString());
    listaPedidoItemsTemp.forEach((item) {listaPedidoItems.add(item);});
    // pedidoItems.forEach((item) {
    //   listaPedidoItems.add(item);
          // new PedidoItem(
          // item.PedidoItemGUID,
          // item.PedidoGUID,
          // item.OfertaGuid,
          // item.OfertaTitulo,
          // item.OfertaCEP,
          // item.OfertaVendedorGuid,
          // item.OfertaPreco,
          // item.OfertaQtd,
          // item.OfertaTotal,
          // item.OfertaImgPath,
          // item.OfertaCancelada,
          // item.OfertaEntregueEm,
          // item.CategoriaChave,
          // item.PedidoItemDetalhe)
     // );
    // });
  }

  Future<void> carregaPedidosFechadosLocal(String userGUID) async {
    listaPedidos.clear();

    List<sqlPedido> pedidos = await sqlPorakiPedidoService().listOrders(userGUID);
    print('qtd pedidos: ' + pedidos.length.toString());
    pedidos.forEach((sqlPed) {
      listaPedidos.add(sqlPorakiPedidoService().convertSqlpedToPedido(sqlPed)
      //     new sqlPedido(
      //     element.pedidoGUID,
      //     element.pedidoVendedorGUID,
      //     element.pedidoVendedorEmail,
      //     element.pedidoEm,
      //     element.pedidoValorTotal,
      //     element.pedidoFormaPagto,
      //     element.pedidoCancelada,
      //     element.pedidoPagtoEm,
      //     element.pedidoPessoaNome,
      //     element.pedidoPessoaEmail,
      //     element.pedidoUsuGUID,
      //     element.pedidoAval,
      //     element.pedidoAvalEm,
      //     element.pedidoMoeda,
      //     element.pedidoCEP,
      //     element.pedidoEndereco,
      //     element.pedidoNumero,
      //     element.pedidoCompl,
      //     element.pedidoAutoriza,
      //     element.pedidoInstituicao,
      //     element.pedidoEntregaPrevista,
      //     element.pedidoEntregaRealizadaEm,
      //     element.pedidoEntregaPorUsuEmail,
      //     element.pedidoEntregaPorUsuNome
      // )
      );
    });
  }

  // Future<void> buscaPedido(String pedidoGUID) async {
  //   print('entrou no buscaPedido');
  //   listaPedidosItems = await sqlPorakiPedidoService().listOrderItems(pedidoGUID);
  //
  //   //listaPedidosItems = sqlPorakiPedidoService().pedidoItems;
  //   print('busca pedido items: ' + listaPedidosItems.length.toString());
  //
  //   pedido = await sqlPorakiPedidoService().getOrder(pedidoGUID);
  // }

  // Future<void> apagaPedido(String pedidoGUID) async {
  //   await sqlPorakiPedidoService().deleteOrder(pedidoGUID);
  // }
  //
  // Future<void> atualizaPedido(sqlPedido pedido) async {
  //   await sqlPorakiPedidoService().updateOrder(pedido);
  // }
  //
  // Future<void> buscaPedidoItems(String pedidoGUID) async {
  //   await sqlPorakiPedidoService().listOrderItems(pedidoGUID);
  // }
  //


  // CLOUD
  Future<Pedido> pegaPedidoCloud(String pedidoGUID) async {
    return await OrdersRepository().getOrder(pedidoGUID);
  }

  Future<void> carregaPedidosPorClienteOpenCloud(String userGUID) async {
    listaPedidos.clear();
    //print('carregaPedidosPorClienteOpenCloud');

    var listaPedidosTemp = await OrdersRepository().getOrdersByCustomerOpen(userGUID);
    print('qtd pedidos cloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });
    // pedidos.forEach((ped) {
    //   listaPedidos.add(ped);
    //   //     new Pedido(
      //     element.PedidoGUID,
      //     element.PedidoVendedorGUID,
      //     element.PedidoVendedorEmail,
      //     element.PedidoEm,
      //     element.PedidoValorTotal,
      //     element.PedidoFormaPagto,
      //     element.PedidoCancelada,
      //     element.PedidoPagtoEm,
      //     element.PedidoPessoaNome,
      //     element.PedidoPessoaEmail,
      //     element.PedidoUsuGUID,
      //     element.PedidoAval,
      //     element.PedidoAvalEm,
      //     element.PedidoMoeda,
      //     element.PedidoCEP,
      //     element.PedidoEndereco,
      //     element.PedidoNumero,
      //     element.PedidoCompl,
      //     element.PedidoAutoriza,
      //     element.PedidoInstituicao,
      //     element.PedidoEntregaPrevista,
      //     element.PedidoEntregaRealizadaEm,
      //     element.PedidoEntregaPorUsuEmail,
      //     element.PedidoEntregaPorUsuNome
      // )
      //);
    //});
  }

  Future<void> carregaPedidosPorVendedorOpenCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersBySellerOpen(userGUID);
    print('qtd pedidos cloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });

    // List<Pedido> pedidos = await OrdersRepository().getOrdersBySellerOpen(userGUID);
    // print('qtd pedidos cloud: ' + pedidos.length.toString());
    // pedidos.forEach((element) {
    //   listaPedidosCloud.add(new Pedido(
    //       element.PedidoGUID,
    //       element.PedidoVendedorGUID,
    //       element.PedidoVendedorEmail,
    //       element.PedidoEm,
    //       element.PedidoValorTotal,
    //       element.PedidoFormaPagto,
    //       element.PedidoCancelada,
    //       element.PedidoPagtoEm,
    //       element.PedidoPessoaNome,
    //       element.PedidoPessoaEmail,
    //       element.PedidoUsuGUID,
    //       element.PedidoAval,
    //       element.PedidoAvalEm,
    //       element.PedidoMoeda,
    //       element.PedidoCEP,
    //       element.PedidoEndereco,
    //       element.PedidoNumero,
    //       element.PedidoCompl,
    //       element.PedidoAutoriza,
    //       element.PedidoInstituicao,
    //       element.PedidoEntregaPrevista,
    //       element.PedidoEntregaRealizadaEm,
    //       element.PedidoEntregaPorUsuEmail,
    //       element.PedidoEntregaPorUsuNome
    //   ));
    // });
  }


  // CLOUD
  Future<void> carregaPedidosPorClienteClosedCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersByCustomerClosed(userGUID);
    print('qtd pedidos cloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });

    // List<Pedido> pedidos = await OrdersRepository().getOrdersByCustomerClosed(userGUID);
    // print('qtd pedidos cloud: ' + pedidos.length.toString());
    // pedidos.forEach((element) {
    //   listaPedidosCloud.add(new Pedido(
    //       element.PedidoGUID,
    //       element.PedidoVendedorGUID,
    //       element.PedidoVendedorEmail,
    //       element.PedidoEm,
    //       element.PedidoValorTotal,
    //       element.PedidoFormaPagto,
    //       element.PedidoCancelada,
    //       element.PedidoPagtoEm,
    //       element.PedidoPessoaNome,
    //       element.PedidoPessoaEmail,
    //       element.PedidoUsuGUID,
    //       element.PedidoAval,
    //       element.PedidoAvalEm,
    //       element.PedidoMoeda,
    //       element.PedidoCEP,
    //       element.PedidoEndereco,
    //       element.PedidoNumero,
    //       element.PedidoCompl,
    //       element.PedidoAutoriza,
    //       element.PedidoInstituicao,
    //       element.PedidoEntregaPrevista,
    //       element.PedidoEntregaRealizadaEm,
    //       element.PedidoEntregaPorUsuEmail,
    //       element.PedidoEntregaPorUsuNome
    //   ));
    // });
  }

  Future<void> carregaPedidosPorVendedorClosedCloud(String userGUID) async {
    listaPedidos.clear();

    var listaPedidosTemp = await OrdersRepository().getOrdersBySellerClosed(userGUID);
    print('qtd pedidos cloud: ' + listaPedidosTemp.length.toString());
    listaPedidosTemp.forEach((ped) {listaPedidos.add(ped); });

    // List<Pedido> pedidos = await OrdersRepository().getOrdersBySellerClosed(userGUID);
    // print('qtd pedidos cloud: ' + pedidos.length.toString());
    // pedidos.forEach((element) {
    //   listaPedidosCloud.add(new Pedido(
    //       element.PedidoGUID,
    //       element.PedidoVendedorGUID,
    //       element.PedidoVendedorEmail,
    //       element.PedidoEm,
    //       element.PedidoValorTotal,
    //       element.PedidoFormaPagto,
    //       element.PedidoCancelada,
    //       element.PedidoPagtoEm,
    //       element.PedidoPessoaNome,
    //       element.PedidoPessoaEmail,
    //       element.PedidoUsuGUID,
    //       element.PedidoAval,
    //       element.PedidoAvalEm,
    //       element.PedidoMoeda,
    //       element.PedidoCEP,
    //       element.PedidoEndereco,
    //       element.PedidoNumero,
    //       element.PedidoCompl,
    //       element.PedidoAutoriza,
    //       element.PedidoInstituicao,
    //       element.PedidoEntregaPrevista,
    //       element.PedidoEntregaRealizadaEm,
    //       element.PedidoEntregaPorUsuEmail,
    //       element.PedidoEntregaPorUsuNome
    //   ));
    // });
  }


  // Future<void> buscaPedidoCloud(String pedidoGUID) async {
  //   print('entrou no buscaPedidoFromCloud');
  //   listaPedidosItemsCloud = await OrdersRepository().g.listOrderItems(pedidoGUID);
  //
  //   //listaPedidosItems = sqlPorakiPedidoService().pedidoItems;
  //   print('busca pedido items: ' + listaPedidosItemsCloud.length.toString());
  //
  //   pedido = await sqlPorakiPedidoService().getOrder(pedidoGUID);
  // }

  // Future<void> apagaPedido(String pedidoGUID) async {
  //   await sqlPorakiPedidoService().deleteOrder(pedidoGUID);
  // }

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

  Future<void> buscaPedidoItemsCloud(String pedidoGUID) async {
    await sqlPorakiPedidoService().listOrderItems(pedidoGUID);
  }

  Future<void> atualizaPedidoLocal(String pedidoGUID) async {
    // pega o pedido da nuvem
    Pedido pedCloud = await pegaPedidoCloud(pedidoGUID);

    if(pedCloud != null) {
      // transforma o pedido da nuvem em pedido local
      var sqlped = new sqlPedido(pedidoGUID, pedCloud.PedidoVendedorGUID, pedCloud.PedidoVendedorEmail, pedCloud.PedidoEm, pedCloud.PedidoValorTotal, pedCloud.PedidoFormaPagto, pedCloud.PedidoCancelada, pedCloud.PedidoPagtoEm, pedCloud.PedidoPessoaNome, pedCloud.PedidoPessoaEmail, pedCloud.PedidoUsuGUID, pedCloud.PedidoAval, pedCloud.PedidoAvalEm, pedCloud.PedidoMoeda, pedCloud.PedidoCEP, pedCloud.PedidoEndereco, pedCloud.PedidoNumero, pedCloud.PedidoCompl, pedCloud.PedidoAutoriza, pedCloud.PedidoInstituicao, pedCloud.PedidoEntregaPrevista, pedCloud.PedidoEntregaRealizadaEm, pedCloud.PedidoEntregaPorUsuEmail, pedCloud.PedidoEntregaPorUsuNome);

      await sqlPorakiPedidoService().deleteOrder(pedidoGUID);
      await sqlPorakiPedidoService().insertOrder(sqlped);
    }
    else {
      //TODO: trata erro
    }

  }


}