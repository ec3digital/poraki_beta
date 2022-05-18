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
  late final String? PedidoDetalhe;
  late final String? PedidoEntregaDetalhe;
  // late final String? PedidoEntregaEm;
  // late final String? PedidoEntregaPorEmail;
  // late final String? PedidoEntregaPorNome;
  late final String? RecebidoPor;
  late final String? PedidoLojaID;
  late final String? PedidoEntregaCodigo;

  Pedido(
      this.PedidoGUID,
      this.PedidoVendedorGUID,
      this.PedidoVendedorEmail,
      this.PedidoEm,
      this.PedidoValorTotal,
      this.PedidoFormaPagto,
      this.PedidoCancelada,
      this.PedidoPagtoEm,
      this.PedidoPessoaNome,
      this.PedidoPessoaEmail,
      this.PedidoUsuGUID,
      this.PedidoAval,
      this.PedidoAvalEm,
      this.PedidoMoeda,
      this.PedidoCEP,
      this.PedidoEndereco,
      this.PedidoNumero,
      this.PedidoCompl,
      this.PedidoAutoriza,
      this.PedidoInstituicao,
      this.PedidoEntregaPrevista,
      this.PedidoEntregaRealizadaEm,
      this.PedidoEntregaPorUsuEmail,
      this.PedidoEntregaPorUsuNome,
      this.PedidoDetalhe,
      this.PedidoEntregaDetalhe,
      // this.PedidoEntregaEm,
      // this.PedidoEntregaPorEmail,
      // this.PedidoEntregaPorNome,
      this.RecebidoPor,
      this.PedidoLojaID,
      this.PedidoEntregaCodigo);

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
    PedidoLojaID = json['PedidoLojaID'].toString();
    PedidoDetalhe = json['PedidoDetalhe'].toString();
    PedidoEntregaDetalhe = json['PedidoEntregaDetalhe'].toString();
    // PedidoEntregaEm = json['PedidoEntregaEm'].toString();
    // PedidoEntregaPorEmail = json['PedidoEntregaPorEmail'].toString();
    // PedidoEntregaPorNome = json['PedidoEntregaPorNome'].toString();
    RecebidoPor = json['RecebidoPor'].toString();
    PedidoLojaID = json['PedidoLojaID'].toString();
    PedidoEntregaCodigo = json['PedidoEntregaCodigo'].toString();
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
      "PedidoEntregaPorUsuNome": PedidoEntregaPorUsuNome.toString(),
      "PedidoLojaID": PedidoLojaID.toString(),
      "PedidoDetalhe": PedidoDetalhe.toString(),
      "PedidoEntregaDetalhe": PedidoEntregaDetalhe.toString(),
      // "PedidoEntregaEm": PedidoEntregaEm.toString(),
      // "PedidoEntregaPorEmail": PedidoEntregaPorEmail.toString(),
      // "PedidoEntregaPorNome": PedidoEntregaPorNome.toString(),
      "RecebidoPor": RecebidoPor.toString(),
      "PedidoLojaID": PedidoLojaID.toString(),
      "PedidoEntregaCodigo": PedidoEntregaCodigo.toString()
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['PedidoGUID'] = PedidoGUID.toString();
    data["PedidoVendedorGUID"] = PedidoVendedorGUID.toString();
    data["PedidoVendedorEmail"] = PedidoVendedorEmail;
    //data["PedidoEm"] = PedidoEm;
    data["PedidoValorTotal"] = PedidoValorTotal.toString();
    data["PedidoFormaPagto"] = PedidoFormaPagto.toString();
    data["PedidoCancelada"] = PedidoCancelada.toString();
    // data["PedidoPagtoEm"] = PedidoPagtoEm;
    data["PedidoPessoaNome"] = PedidoPessoaNome;
    data["PedidoPessoaEmail"] = PedidoPessoaEmail;
    data["PedidoUsuGUID"] = PedidoUsuGUID.toString();
    // data["PedidoAval"] = PedidoAval.toString();
    // data["PedidoAvalEm"] = PedidoAvalEm.toString();
    data["PedidoMoeda"] = PedidoMoeda.toString();
    data["PedidoCEP"] = PedidoCEP;
    data["PedidoEndereco"] = PedidoEndereco.toString();
    data["PedidoNumero"] = PedidoNumero.toString();
    data["PedidoCompl"] = PedidoCompl.toString();
    // data["PedidoAutoriza"] = PedidoAutoriza.toString();
    // data["PedidoInstituicao"] = PedidoInstituicao.toString();
    data["PedidoEntregaPrevista"] = PedidoEntregaPrevista.toString();
    // data["PedidoEntregaRealizadaEm"] = PedidoEntregaRealizadaEm.toString();
    data["PedidoEntregaPorUsuEmail"] = '';// PedidoEntregaPorUsuEmail.toString();
    data["PedidoEntregaPorUsuNome"] = ''; // PedidoEntregaPorUsuNome.toString();
    data["PedidoLojaID"] = PedidoLojaID.toString();
    data["PedidoDetalhe"] = PedidoDetalhe.toString();
    data["PedidoEntregaCodigo"] = PedidoEntregaCodigo.toString();
    // data["PedidoEntregaDetalhe"] = PedidoEntregaDetalhe.toString();
    // data["PedidoEntregaEm"] = PedidoEntregaEm.toString();
    // data["PedidoEntregaPorEmail"] = PedidoEntregaPorEmail.toString();
    // data["PedidoEntregaPorNome"] = PedidoEntregaPorNome.toString();
    // data["RecebidoPor"] = RecebidoPor.toString();
    // data["PedidoLojaID"] = PedidoLojaID.toString();
    return data;
  }
}
