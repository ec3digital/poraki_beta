class sqlPedidoMsg {
  final String pedidoGUID;
  final String NomeVendedor;
  final String NomeComprador;
  final String Mensagem;
  final String MensagemEm;

  sqlPedidoMsg(this.pedidoGUID, this.NomeVendedor, this.NomeComprador, this.Mensagem, this.MensagemEm);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "pedidoGUID": pedidoGUID,
      "NomeVendedor": NomeVendedor,
      "NomeComprador": NomeComprador,
      "Mensagem": Mensagem,
      "MensagemEm": MensagemEm
    };
  }

}