class sqlPedido {
  final String? pedidoGUID;
  final String? pedidoVendedorGUID;
  final String pedidoVendedorEmail;
  final String pedidoEm;
  final String pedidoValorTotal;
  final String? pedidoFormaPagto;
  final int? pedidoCancelada;
  final String pedidoPagtoEm;
  final String pedidoPessoaNome;
  final String pedidoPessoaEmail;
  final String? pedidoUsuGUID;
  final int? pedidoAval;
  final String? pedidoAvalEm;
  final String? pedidoMoeda;
  final String pedidoCEP;
  final String? pedidoEndereco;
  final String? pedidoNumero;
  final String? pedidoCompl;
  late String? pedidoAutoriza;
  late String? pedidoInstituicao;
  late String? pedidoEntregaPrevista;
  late String? pedidoEntregaRealizadaEm;
  late String? pedidoEntregaPorUsuEmail;
  late String? pedidoEntregaPorUsuNome;
  late String? pedidoEntregaDetalhe;
  // late String? pedidoEntregaPorEmail;
  // late String? pedidoEntregaPorNome;
  // late String? pedidoEntregaEm;
  late String? pedidoDetalhe;
  late String? pedidoRecebidoPor;
  late String? pedidoLojaId;
  late String? pedidoEntregaCodigo;

  sqlPedido(
      this.pedidoGUID,
      this.pedidoVendedorGUID,
      this.pedidoVendedorEmail,
      this.pedidoEm,
      this.pedidoValorTotal,
      this.pedidoFormaPagto,
      this.pedidoCancelada,
      this.pedidoPagtoEm,
      this.pedidoPessoaNome,
      this.pedidoPessoaEmail,
      this.pedidoUsuGUID,
      this.pedidoAval,
      this.pedidoAvalEm,
      this.pedidoMoeda,
      this.pedidoCEP,
      this.pedidoEndereco,
      this.pedidoNumero,
      this.pedidoCompl,
      this.pedidoAutoriza,
      this.pedidoInstituicao,
      this.pedidoEntregaPrevista,
      this.pedidoEntregaRealizadaEm,
      this.pedidoEntregaPorUsuEmail,
      this.pedidoEntregaPorUsuNome,
      this.pedidoDetalhe,
      this.pedidoEntregaDetalhe,
      // this.pedidoEntregaEm,
      // this.pedidoEntregaPorEmail,
      // this.pedidoEntregaPorNome,
      this.pedidoRecebidoPor,
      this.pedidoLojaId,
      this.pedidoEntregaCodigo);

  Map<String, String> toMap() {
    return <String, String>{
      "PedidoGUID": pedidoGUID.toString(),
      "PedidoVendedorGUID": pedidoVendedorGUID.toString(),
      "PedidoVendedorEmail": pedidoVendedorEmail,
      "PedidoEm": pedidoEm,
      "PedidoValorTotal": pedidoValorTotal,
      "PedidoFormaPagto": pedidoFormaPagto.toString(),
      "PedidoCancelada": pedidoCancelada.toString(),
      "PedidoPagtoEm": pedidoPagtoEm,
      "PedidoPessoaNome": pedidoPessoaNome,
      "PedidoPessoaEmail": pedidoPessoaEmail,
      "PedidoUsuGUID": pedidoUsuGUID.toString(),
      "PedidoAval": pedidoAval.toString(),
      "PedidoAvalEm": pedidoAvalEm.toString(),
      "PedidoMoeda": pedidoMoeda.toString(),
      "PedidoCEP": pedidoCEP,
      "PedidoEndereco": pedidoEndereco.toString(),
      "PedidoNumero": pedidoNumero.toString(),
      "PedidoCompl": pedidoCompl.toString(),
      "PedidoAutoriza": pedidoAutoriza.toString(),
      "PedidoInstituicao": pedidoInstituicao.toString(),
      "PedidoEntregaPrevista": pedidoEntregaPrevista.toString(),
      "PedidoEntregaRealizadaEm": pedidoEntregaRealizadaEm.toString(),
      "PedidoEntregaPorUsuEmail": pedidoEntregaPorUsuEmail.toString(),
      "PedidoEntregaPorUsuNome": pedidoEntregaPorUsuNome.toString(),
      "PedidoEntregaDetalhe": pedidoEntregaDetalhe.toString(),
      // "PedidoEntregaPorEmail": pedidoEntregaPorEmail.toString(),
      // "PedidoEntregaPorNome": pedidoEntregaPorNome.toString(),
      // "PedidoEntregaEm": pedidoEntregaEm.toString(),
      "PedidoDetalhe": pedidoDetalhe.toString(),
      "PedidoRecebidoPor": pedidoRecebidoPor.toString(),
      "PedidoLojaId": pedidoLojaId.toString(),
      "PedidoEntregaCodigo": pedidoEntregaCodigo.toString()
    };
  }
}
