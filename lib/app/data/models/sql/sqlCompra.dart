class sqlCompra {
  final int compraId;
  final String? pedidoGUID;
  final String? compraVendedorGUID;
  final String compraVendedorEmail;
  final String compraEm;
  final String compraValorTotal;
  final String? compraFormaPagto;
  final int? compraCancelada;
  final String compraPagtoEm;
  final String compraPessoaNome;
  final String compraPessoaEmail;
  final String? compraUsuGUID;
  final int? compraAval;
  final String? compraAvalEm;
  final String? compraMoeda;
  final String compraCEP;
  final String? compraEndereco;
  final String? compraNumero;
  final String? compraCompl;
  final String? compraAutoriza;
  final String? compraInstituicao;
  final String? compraEntregaPrevista;
  final String? compraEntregaRealizadaEm;
  final String? compraEntregaPorUsuEmail;
  final String? compraEntregaPorUsuNome;

  sqlCompra(this.compraId, this.pedidoGUID, this.compraVendedorGUID, this.compraVendedorEmail, this.compraEm, this.compraValorTotal, this.compraFormaPagto, this.compraCancelada, this.compraPagtoEm, this.compraPessoaNome, this.compraPessoaEmail, this.compraUsuGUID, this.compraAval, this.compraAvalEm, this.compraMoeda, this.compraCEP, this.compraEndereco, this.compraNumero, this.compraCompl, this.compraAutoriza, this.compraInstituicao, this.compraEntregaPrevista, this.compraEntregaRealizadaEm, this.compraEntregaPorUsuEmail, this.compraEntregaPorUsuNome);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "compraId": compraId,
      "pedidoGUID": pedidoGUID,
      "compraVendedorGUID": compraVendedorGUID,
      "compraVendedorEmail": compraVendedorEmail,
      "compraEm": compraEm,
      "compraValorTotal": compraValorTotal,
      "compraFormaPagto": compraFormaPagto,
      "compraCancelada": compraCancelada,
      "compraPagtoEm": compraPagtoEm,
      "compraPessoaNome": compraPessoaNome,
      "compraPessoaEmail": compraPessoaEmail,
      "compraUsuGUID": compraUsuGUID,
      "compraAval": compraAval,
      "compraAvalEm": compraAvalEm,
      "compraMoeda": compraMoeda,
      "compraCEP": compraCEP,
      "compraEndereco": compraEndereco,
      "compraNumero": compraNumero,
      "compraCompl": compraCompl,
      "compraAutoriza": compraAutoriza,
      "compraInstituicao": compraInstituicao,
      "compraEntregaPrevista": compraEntregaPrevista,
      "compraEntregaRealizadaEm": compraEntregaRealizadaEm,
      "compraEntregaPorUsuEmail": compraEntregaPorUsuEmail,
      "compraEntregaPorUsuNome": compraEntregaPorUsuNome
    };
  }

}