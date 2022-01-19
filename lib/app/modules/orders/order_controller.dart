
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:poraki/app/data/models/sql/sqlPedido.dart';
import 'package:poraki/app/data/models/sql/sqlPedidoItem.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_pedido_service.dart';

class OrderController extends GetxController {

  var listaPedidos = [];
  List<sqlPedidoItem> listaPedidosItems = [];
  sqlPedido? pedido;
  bool isLoading = false;

  @override
  void onInit() async {
    super.onInit();
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Future<void> listaTodosPedidos(String userGUID) async {
    listaPedidos.clear();

    List<sqlPedido> pedidos = await sqlPorakiPedidoService().listOrders(userGUID);
    print('qtd pedidos: ' + pedidos.length.toString());
    pedidos.forEach((element) {
      listaPedidos.add(new sqlPedido(
          element.pedidoGUID,
          element.pedidoVendedorGUID,
          element.pedidoVendedorEmail,
          element.pedidoEm,
          element.pedidoValorTotal,
          element.pedidoFormaPagto,
          element.pedidoCancelada,
          element.pedidoPagtoEm,
          element.pedidoPessoaNome,
          element.pedidoPessoaEmail,
          element.pedidoUsuGUID,
          element.pedidoAval,
          element.pedidoAvalEm,
          element.pedidoMoeda,
          element.pedidoCEP,
          element.pedidoEndereco,
          element.pedidoNumero,
          element.pedidoCompl,
          element.pedidoAutoriza,
          element.pedidoInstituicao,
          element.pedidoEntregaPrevista,
          element.pedidoEntregaRealizadaEm,
          element.pedidoEntregaPorUsuEmail,
          element.pedidoEntregaPorUsuNome
      ));
    });

  }

  Future<void> buscaPedido(String pedidoGUID) async {
    print('entrou no buscaPedido');
    listaPedidosItems = await sqlPorakiPedidoService().listOrderItems(pedidoGUID);

    //listaPedidosItems = sqlPorakiPedidoService().pedidoItems;
    print('busca pedido items: ' + listaPedidosItems.length.toString());

    pedido = await sqlPorakiPedidoService().getOrder(pedidoGUID);


  }

  Future<void> apagaPedido(String pedidoGUID) async {
    await sqlPorakiPedidoService().deleteOrder(pedidoGUID);
  }

  Future<void> atualizaPedido(sqlPedido pedido) async {
    await sqlPorakiPedidoService().updateOrder(pedido);
  }

  Future<void> buscaPedidoItems(String pedidoGUID) async {
    await sqlPorakiPedidoService().listOrderItems(pedidoGUID);
  }

}