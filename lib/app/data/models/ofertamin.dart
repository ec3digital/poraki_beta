class OfertaMin {
  String? CategoriaChave;
  String? OfertaFKID;
  String? OfertaTitulo;
  String? OfertaDetalhe;
  double? OfertaPreco;
  String? OfertaWhatsapp;
  String? OfertaDesativEm;
  String? OfertaCEP;
  String? OfertaDispoDesde;
  String? OfertaDispoAte;
  int? LojaID;
  String? OfertaGUID;
  //int? OfertaQtdDispo;
  bool? OfertaAceitaEncomenda;
  bool? OfertaSomenteEncomenda;
  int? OfertaTempoEntrega;
  String? OfertaTempoEntregaUnidade;
  String? OfertaFormaFechamento;
  String? OfertaMarcaRevenda;
  bool? Oferta24hs;
  bool? OfertaPrecoCombinar;
  bool? SegDispo;
  bool? TerDispo;
  bool? QuaDispo;
  bool? QuiDispo;
  bool? SexDispo;
  bool? SabDispo;
  bool? DomDispo;
  String? SegDas;
  String? SegAs;
  String? TerDas;
  String? TerAs;
  String? QuaDas;
  String? QuaAs;
  String? QuiDas;
  String? QuiAs;
  String? SexDas;
  String? SexAs;
  String? SabDas;
  String? SabAs;
  String? DomDas;
  String? DomAs;

  OfertaMin(
      {this.OfertaGUID,
      this.OfertaFKID,
      this.CategoriaChave,
      this.OfertaTitulo,
      this.OfertaDetalhe,
      this.OfertaPreco,
      this.OfertaWhatsapp,
      this.OfertaCEP,
      //this.OfertaQtdDispo,
      this.OfertaFormaFechamento,
      this.LojaID,
      this.OfertaPrecoCombinar,
      this.OfertaMarcaRevenda,
      this.OfertaAceitaEncomenda,
      this.Oferta24hs,
      this.OfertaSomenteEncomenda,
      this.OfertaTempoEntrega,
      this.OfertaTempoEntregaUnidade,
      this.OfertaDispoDesde,
      this.OfertaDispoAte,
      this.SegDispo,
      this.SegDas,
      this.SegAs,
      this.TerDispo,
      this.TerDas,
      this.TerAs,
      this.QuaDispo,
      this.QuaDas,
      this.QuaAs,
      this.QuiDispo,
      this.QuiDas,
      this.QuiAs,
      this.SexDispo,
      this.SexDas,
      this.SexAs,
      this.SabDispo,
      this.SabDas,
      this.SabAs,
      this.DomDispo,
      this.DomDas,
      this.DomAs,
      this.OfertaDesativEm});
}
