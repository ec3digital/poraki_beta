class Pedido {
  late final String? PedidoGUID;
  late final String? PedidoVendedorGUID;
  late final String PedidoVendedorEmail;
  late final String PedidoEm;
  late final String PedidoValorTotal;
  late final String? PedidoFormaPagto;
  late final int? PedidoCancelada;
  late final String? PedidoPagtoEm;
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
  late final String? PedidoCanceladoEm;
  late final String? PedidoCanceladoPor;
  late final String? PedidoCanceladoMotivo;
  late final String? PedidoEntregaPorGuid;
  late final String? PedidoEntregaLat;
  late final String? PedidoEntregaLong;
  late final String? PedidoEntregaToken;
  late final String? PedidoEntregaParceiro;
  late final String? PedidoEntregadorID;
  late final String? PedidoAceitoEm;
  late final String? PedidoAceitoPor;
  late final String? PedidoCEPVendedor;
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
      this.RecebidoPor,
      this.PedidoLojaID,
      this.PedidoEntregaCodigo,
      this.PedidoAceitoEm,
      this.PedidoAceitoPor,
      this.PedidoCanceladoEm,
      this.PedidoCanceladoMotivo,
      this.PedidoCanceladoPor,
      this.PedidoCEPVendedor,
      this.PedidoEntregadorID,
      this.PedidoEntregaLat,
      this.PedidoEntregaLong,
      this.PedidoEntregaParceiro,
      this.PedidoEntregaPorGuid,
      this.PedidoEntregaToken
      );

  Pedido.fromJson(Map<String, dynamic> json) {
    PedidoGUID = json['PedidoGuid'].toString();
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
    RecebidoPor = json['RecebidoPor'].toString();
    PedidoLojaID = json['PedidoLojaID'].toString();
    PedidoEntregaCodigo = json['PedidoEntregaCodigo'].toString();
    PedidoAceitoEm = json['PedidoAceitoEm'].toString();
    PedidoAceitoPor = json['PedidoAceitoPor'].toString();
    PedidoCanceladoEm = json['PedidoCanceladoEm'].toString();
    PedidoCanceladoMotivo = json['PedidoCanceladoMotivo'].toString();
    PedidoCanceladoPor = json['PedidoCanceladoPor'].toString();
    PedidoCEPVendedor = json['PedidoCEPVendedor'].toString();
    PedidoEntregadorID = json['PedidoEntregadorID'].toString();
    PedidoEntregaLat = json['PedidoEntregaLat'].toString();
    PedidoEntregaLong = json['PedidoEntregaLong'].toString();
    PedidoEntregaParceiro = json['PedidoEntregaParceiro'].toString();
    PedidoEntregaPorGuid = json['PedidoEntregaPorGuid'].toString();
    PedidoEntregaToken = json['PedidoEntregaToken'].toString();
  }

  Map<String, String> toMap() {
    print('tomap pessoanome: ' + PedidoPessoaNome);
    print('tomap PedidoVendedorGUID: ' + PedidoVendedorGUID.toString());
    return <String, String>{
      // "PedidoId": PedidoId,
      "PedidoGUID": PedidoGUID.toString(),
      "PedidoVendedorGUID": PedidoVendedorGUID.toString(),
      "PedidoVendedorEmail": PedidoVendedorEmail,
      "PedidoEm": PedidoEm,
      "PedidoValorTotal": PedidoValorTotal.toString(),
      "PedidoFormaPagto": PedidoFormaPagto.toString(),
      "PedidoCancelada": PedidoCancelada.toString(),
      "PedidoPagtoEm": PedidoPagtoEm.toString(),
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
      "RecebidoPor": RecebidoPor.toString(),
      "PedidoLojaID": PedidoLojaID.toString(),
      "PedidoEntregaCodigo": PedidoEntregaCodigo.toString(),
      "PedidoAceitoEm": PedidoAceitoEm.toString(),
      "PedidoAceitoPor": PedidoAceitoPor.toString(),
      "PedidoCanceladoEm": PedidoCanceladoEm.toString(),
      "PedidoCanceladoMotivo": PedidoCanceladoMotivo.toString(),
      "PedidoCanceladoPor": PedidoCanceladoPor.toString(),
      "PedidoCEPVendedor": PedidoCEPVendedor.toString(),
      "PedidoEntregadorID": PedidoEntregadorID.toString(),
      "PedidoEntregaLat": PedidoEntregaLat.toString(),
      "PedidoEntregaLong": PedidoEntregaLong.toString(),
      "PedidoEntregaParceiro": PedidoEntregaParceiro.toString(),
      "PedidoEntregaPorGuid": PedidoEntregaPorGuid.toString(),
      "PedidoEntregaToken": PedidoEntregaToken.toString()
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
