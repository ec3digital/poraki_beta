class sqlPedido {
  //final int pedidoId;
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
  final String? pedidoAutoriza;
  final String? pedidoInstituicao;
  final String? pedidoEntregaPrevista;
  final String? pedidoEntregaRealizadaEm;
  final String? pedidoEntregaPorUsuEmail;
  final String? pedidoEntregaPorUsuNome;

  sqlPedido(this.pedidoGUID, this.pedidoVendedorGUID, this.pedidoVendedorEmail, this.pedidoEm, this.pedidoValorTotal, this.pedidoFormaPagto, this.pedidoCancelada, this.pedidoPagtoEm, this.pedidoPessoaNome, this.pedidoPessoaEmail, this.pedidoUsuGUID, this.pedidoAval, this.pedidoAvalEm, this.pedidoMoeda, this.pedidoCEP, this.pedidoEndereco, this.pedidoNumero, this.pedidoCompl, this.pedidoAutoriza, this.pedidoInstituicao, this.pedidoEntregaPrevista, this.pedidoEntregaRealizadaEm, this.pedidoEntregaPorUsuEmail, this.pedidoEntregaPorUsuNome);

  Map<String, String> toMap() {
    return <String, String>{
      // "pedidoId": pedidoId,
      "pedidoGUID": pedidoGUID.toString(),
      "pedidoVendedorGUID": pedidoVendedorGUID.toString(),
      "pedidoVendedorEmail": pedidoVendedorEmail,
      "pedidoEm": pedidoEm,
      "pedidoValorTotal": pedidoValorTotal,
      "pedidoFormaPagto": pedidoFormaPagto.toString(),
      "pedidoCancelada": pedidoCancelada.toString(),
      "pedidoPagtoEm": pedidoPagtoEm,
      "pedidoPessoaNome": pedidoPessoaNome,
      "pedidoPessoaEmail": pedidoPessoaEmail,
      "pedidoUsuGUID": pedidoUsuGUID.toString(),
      "pedidoAval": pedidoAval.toString(),
      "pedidoAvalEm": pedidoAvalEm.toString(),
      "pedidoMoeda": pedidoMoeda.toString(),
      "pedidoCEP": pedidoCEP,
      "pedidoEndereco": pedidoEndereco.toString(),
      "pedidoNumero": pedidoNumero.toString(),
      "pedidoCompl": pedidoCompl.toString(),
      "pedidoAutoriza": pedidoAutoriza.toString(),
      "pedidoInstituicao": pedidoInstituicao.toString(),
      "pedidoEntregaPrevista": pedidoEntregaPrevista.toString(),
      "pedidoEntregaRealizadaEm": pedidoEntregaRealizadaEm.toString(),
      "pedidoEntregaPorUsuEmail": pedidoEntregaPorUsuEmail.toString(),
      "pedidoEntregaPorUsuNome": pedidoEntregaPorUsuNome.toString()
    };
  }

}