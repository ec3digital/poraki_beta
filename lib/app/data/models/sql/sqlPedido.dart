class sqlPedido {
  final int pedidoId;
  final String? pedidoGUID;
  final String pedidoTipo;
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

  sqlPedido(this.pedidoId, this.pedidoGUID, this.pedidoTipo, this.pedidoVendedorGUID, this.pedidoVendedorEmail, this.pedidoEm, this.pedidoValorTotal, this.pedidoFormaPagto, this.pedidoCancelada, this.pedidoPagtoEm, this.pedidoPessoaNome, this.pedidoPessoaEmail, this.pedidoUsuGUID, this.pedidoAval, this.pedidoAvalEm, this.pedidoMoeda, this.pedidoCEP, this.pedidoEndereco, this.pedidoNumero, this.pedidoCompl, this.pedidoAutoriza, this.pedidoInstituicao, this.pedidoEntregaPrevista, this.pedidoEntregaRealizadaEm, this.pedidoEntregaPorUsuEmail, this.pedidoEntregaPorUsuNome);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "pedidoId": pedidoId,
      "pedidoGUID": pedidoGUID,
      "pedidoVendedorGUID": pedidoVendedorGUID,
      "pedidoVendedorEmail": pedidoVendedorEmail,
      "pedidoEm": pedidoEm,
      "pedidoValorTotal": pedidoValorTotal,
      "pedidoFormaPagto": pedidoFormaPagto,
      "pedidoCancelada": pedidoCancelada,
      "pedidoPagtoEm": pedidoPagtoEm,
      "pedidoPessoaNome": pedidoPessoaNome,
      "pedidoPessoaEmail": pedidoPessoaEmail,
      "pedidoUsuGUID": pedidoUsuGUID,
      "pedidoAval": pedidoAval,
      "pedidoAvalEm": pedidoAvalEm,
      "pedidoMoeda": pedidoMoeda,
      "pedidoCEP": pedidoCEP,
      "pedidoEndereco": pedidoEndereco,
      "pedidoNumero": pedidoNumero,
      "pedidoCompl": pedidoCompl,
      "pedidoAutoriza": pedidoAutoriza,
      "pedidoInstituicao": pedidoInstituicao,
      "pedidoEntregaPrevista": pedidoEntregaPrevista,
      "pedidoEntregaRealizadaEm": pedidoEntregaRealizadaEm,
      "pedidoEntregaPorUsuEmail": pedidoEntregaPorUsuEmail,
      "pedidoEntregaPorUsuNome": pedidoEntregaPorUsuNome
    };
  }

}