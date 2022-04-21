class Pedido {
  late final String? PedidoGUID;
  late final String? PedidoVendedorGUID;
  late final String PedidoVendedorEmail;
  late final String PedidoEm;
  late final String PedidoValorTotal;
  late final String? PedidoFormaPagto;
  late final int? PedidoCancelada;
  late final String PedidoPagtoEm;
  late final String PedidoPessoaNome;
  late final String PedidoPessoaEmail;
  late final String? PedidoUsuGUID;
  late final int? PedidoAval;
  late final String? PedidoAvalEm;
  late final String? PedidoMoeda;
  late final String PedidoCEP;
  late final String? PedidoEndereco;
  late final String? PedidoNumero;
  late final String? PedidoCompl;
  late final String? PedidoAutoriza;
  late final String? PedidoInstituicao;
  late final String? PedidoEntregaPrevista;
  late final String? PedidoEntregaRealizadaEm;
  late final String? PedidoEntregaPorUsuEmail;
  late final String? PedidoEntregaPorUsuNome;

  Pedido(this.PedidoGUID, this.PedidoVendedorGUID, this.PedidoVendedorEmail, this.PedidoEm, this.PedidoValorTotal, this.PedidoFormaPagto, this.PedidoCancelada, this.PedidoPagtoEm, this.PedidoPessoaNome, this.PedidoPessoaEmail, this.PedidoUsuGUID, this.PedidoAval, this.PedidoAvalEm, this.PedidoMoeda, this.PedidoCEP, this.PedidoEndereco, this.PedidoNumero, this.PedidoCompl, this.PedidoAutoriza, this.PedidoInstituicao, this.PedidoEntregaPrevista, this.PedidoEntregaRealizadaEm, this.PedidoEntregaPorUsuEmail, this.PedidoEntregaPorUsuNome);

  Pedido.fromJson(Map<String, dynamic> json) {
    PedidoGUID = json['PedidoGUID'].toString();
    PedidoVendedorGUID = json['PedidoVendedorGUID'].toString();
    PedidoVendedorEmail = json['PedidoVendedorEmail'].toString();
    PedidoEm = json['PedidoEm'].toString();
    PedidoValorTotal = json['PedidoValorTotal'].toString();
    PedidoFormaPagto = json['PedidoFormaPagto'].toString();
    PedidoCancelada = int.parse(json['PedidoCancelada'].toString());
    PedidoPagtoEm = json['PedidoPagtoEm'].toString();
    PedidoPessoaNome = json['PedidoPessoaNome'].toString();
    PedidoPessoaEmail = json['PedidoPessoaEmail'].toString();
    PedidoUsuGUID = json['PedidoUsuGUID'];
    PedidoAval = int.parse(json['PedidoAval'].toString());
    PedidoAvalEm = json['PedidoAvalEm'].toString();
    PedidoMoeda = json['PedidoMoeda'].toString();
    PedidoCEP = json['PedidoCEP'].toString();
    PedidoEndereco = json['PedidoEndereco'].toString();
    PedidoNumero = json['PedidoNumero'].toString();
    PedidoCompl = json['PedidoCompl'].toString();
    PedidoAutoriza = json['PedidoAutoriza'].toString();
    PedidoInstituicao = json['PedidoInstituicao'].toString();
    PedidoEntregaPrevista = json['PedidoEntregaPrevista'].toString();
    PedidoEntregaRealizadaEm = json['PedidoEntregaRealizadaEm'].toString();
    PedidoEntregaPorUsuEmail = json['PedidoEntregaPorUsuEmail'].toString();
    PedidoEntregaPorUsuNome = json['PedidoEntregaPorUsuNome'].toString();
  }

  Map<String, String> toMap() {
    return <String, String>{
      // "PedidoId": PedidoId,
      "PedidoGUID": PedidoGUID.toString(),
      "PedidoVendedorGUID": PedidoVendedorGUID.toString(),
      "PedidoVendedorEmail": PedidoVendedorEmail,
      "PedidoEm": PedidoEm,
      "PedidoValorTotal": PedidoValorTotal.toString(),
      "PedidoFormaPagto": PedidoFormaPagto.toString(),
      "PedidoCancelada": PedidoCancelada.toString(),
      "PedidoPagtoEm": PedidoPagtoEm,
      "PedidoPessoaNome": PedidoPessoaNome,
      "PedidoPessoaEmail": PedidoPessoaEmail,
      "PedidoUsuGUID": PedidoUsuGUID.toString(),
      "PedidoAval": PedidoAval.toString(),
      "PedidoAvalEm": PedidoAvalEm.toString(),
      "PedidoMoeda": PedidoMoeda.toString(),
      "PedidoCEP": PedidoCEP,
      "PedidoEndereco": PedidoEndereco.toString(),
      "PedidoNumero": PedidoNumero.toString(),
      "PedidoCompl": PedidoCompl.toString(),
      "PedidoAutoriza": PedidoAutoriza.toString(),
      "PedidoInstituicao": PedidoInstituicao.toString(),
      "PedidoEntregaPrevista": PedidoEntregaPrevista.toString(),
      "PedidoEntregaRealizadaEm": PedidoEntregaRealizadaEm.toString(),
      "PedidoEntregaPorUsuEmail": PedidoEntregaPorUsuEmail.toString(),
      "PedidoEntregaPorUsuNome": PedidoEntregaPorUsuNome.toString()
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PedidoGUID'] = PedidoGUID.toString();
    data["PedidoVendedorGUID"] = PedidoVendedorGUID.toString();
    data["PedidoVendedorEmail"] = PedidoVendedorEmail;
    data["PedidoEm"] = PedidoEm;
    data["PedidoValorTotal"] = PedidoValorTotal.toString();
    data["PedidoFormaPagto"] = PedidoFormaPagto.toString();
    data["PedidoCancelada"] = PedidoCancelada.toString();
    data["PedidoPagtoEm"] = PedidoPagtoEm;
    data["PedidoPessoaNome"] = PedidoPessoaNome;
    data["PedidoPessoaEmail"] = PedidoPessoaEmail;
    data["PedidoUsuGUID"] = PedidoUsuGUID.toString();
    data["PedidoAval"] = PedidoAval.toString();
    data["PedidoAvalEm"] = PedidoAvalEm.toString();
    data["PedidoMoeda"] = PedidoMoeda.toString();
    data["PedidoCEP"] = PedidoCEP;
    data["PedidoEndereco"] = PedidoEndereco.toString();
    data["PedidoNumero"] = PedidoNumero.toString();
    data["PedidoCompl"] = PedidoCompl.toString();
    data["PedidoAutoriza"] = PedidoAutoriza.toString();
    data["PedidoInstituicao"] = PedidoInstituicao.toString();
    data["PedidoEntregaPrevista"] = PedidoEntregaPrevista.toString();
    data["PedidoEntregaRealizadaEm"] = PedidoEntregaRealizadaEm.toString();
    data["PedidoEntregaPorUsuEmail"] = PedidoEntregaPorUsuEmail.toString();
    data["PedidoEntregaPorUsuNome"] = PedidoEntregaPorUsuNome.toString();
    return data;
  }

}