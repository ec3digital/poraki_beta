class sqlVenda {
  final String vendaId;
  final String pedidoGUID;
  final String vendaVendedorGUID;
  final String vendaVendedorEmail;
  final String vendaEm;
  final String vendaValorTotal;
  final String vendaFormaPagto;
  final String vendaCancelada;
  final String vendaPagtoEm;
  final String vendaPessoaNome;
  final String vendaPessoaEmail;
  final String vendaUsuGUID;
  final String vendaAval;
  final String vendaAvalEm;
  final String vendaMoeda;
  final String vendaCEP;
  final String vendaEndereco;
  final String vendaNumero;
  final String vendaCompl;
  final String vendaAutoriza;
  final String vendaInstituicao;
  final String vendaEntregaPrevista;
  final String vendaEntregaRealizadaEm;
  final String vendaEntregaPorUsuEmail;
  final String vendaEntregaPorUsuNome;

  sqlVenda(this.vendaId, this.pedidoGUID, this.vendaVendedorGUID, this.vendaVendedorEmail, this.vendaEm, this.vendaValorTotal, this.vendaFormaPagto, this.vendaCancelada, this.vendaPagtoEm, this.vendaPessoaNome, this.vendaPessoaEmail, this.vendaUsuGUID, this.vendaAval, this.vendaAvalEm, this.vendaMoeda, this.vendaCEP, this.vendaEndereco, this.vendaNumero, this.vendaCompl, this.vendaAutoriza, this.vendaInstituicao, this.vendaEntregaPrevista, this.vendaEntregaRealizadaEm, this.vendaEntregaPorUsuEmail, this.vendaEntregaPorUsuNome);

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
     "vendaId": vendaId,
     "pedidoGUID": pedidoGUID,
     "vendaVendedorGUID": vendaVendedorGUID,
     "vendaVendedorEmail": vendaVendedorEmail,
     "vendaEm": vendaEm,
     "vendaValorTotal": vendaValorTotal,
     "vendaFormaPagto": vendaFormaPagto,
     "vendaCancelada": vendaCancelada,
     "vendaPagtoEm": vendaPagtoEm,
     "vendaPessoaNome": vendaPessoaNome,
     "vendaPessoaEmail": vendaPessoaEmail,
     "vendaUsuGUID": vendaUsuGUID,
     "vendaAval": vendaAval,
     "vendaAvalEm": vendaAvalEm,
     "vendaMoeda": vendaMoeda,
     "vendaCEP": vendaCEP,
     "vendaEndereco": vendaEndereco,
     "vendaNumero": vendaNumero,
     "vendaCompl": vendaCompl,
     "vendaAutoriza": vendaAutoriza,
     "vendaInstituicao": vendaInstituicao,
     "vendaEntregaPrevista": vendaEntregaPrevista,
     "vendaEntregaRealizadaEm": vendaEntregaRealizadaEm,
     "vendaEntregaPorUsuEmail": vendaEntregaPorUsuEmail,
     "vendaEntregaPorUsuNome": vendaEntregaPorUsuNome
    };
  }

}