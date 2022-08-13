class Parceiros {
  String? ParceiroEntregaGuid;
  String? ParceiroEntregaCEPs;
  String? ParceiroEntregaDomAs;
  String? ParceiroEntregaDomDas;
  String? ParceiroEntregaNome;
  String? ParceiroEntregaQuaAs;
  String? ParceiroEntregaQuaDas;
  String? ParceiroEntregaQuiAs;
  String? ParceiroEntregaQuiDas;
  String? ParceiroEntregaSabAs;
  String? ParceiroEntregaSabDas;
  String? ParceiroEntregaSegAs;
  String? ParceiroEntregaSegDas;
  String? ParceiroEntregaSexAs;
  String? ParceiroEntregaSexDas;
  String? ParceiroEntregaTerAs;
  String? ParceiroEntregaTerDas;
  String? ParceiroEntregaValorMais3KmFds;
  String? ParceiroEntregaValorMais3Km;
  String? ParceiroEntregaValor3KmFds;
  String? ParceiroEntregaValor3Km;

  Parceiros(
      {this.ParceiroEntregaGuid,
        this.ParceiroEntregaCEPs,
        this.ParceiroEntregaDomAs,
        this.ParceiroEntregaDomDas,
        this.ParceiroEntregaNome,
        this.ParceiroEntregaQuaAs,
        this.ParceiroEntregaQuaDas,
        this.ParceiroEntregaQuiAs,
        this.ParceiroEntregaQuiDas,
        this.ParceiroEntregaSabAs,
        this.ParceiroEntregaSabDas,
        this.ParceiroEntregaSegAs,
        this.ParceiroEntregaSegDas,
        this.ParceiroEntregaSexAs,
        this.ParceiroEntregaSexDas,
        this.ParceiroEntregaTerAs,
        this.ParceiroEntregaTerDas,
        this.ParceiroEntregaValorMais3KmFds,
        this.ParceiroEntregaValorMais3Km,
        this.ParceiroEntregaValor3KmFds,
        this.ParceiroEntregaValor3Km,
      });

  Parceiros.fromJson(Map<String, dynamic> json) {
    ParceiroEntregaGuid = json['ParceiroEntregaGuid'];
    ParceiroEntregaCEPs = json['ParceiroEntregaCEPs'];
    ParceiroEntregaDomAs = json['ParceiroEntregaDomAs'];
    ParceiroEntregaDomDas = json['ParceiroEntregaDomDas'];
    ParceiroEntregaNome = json['ParceiroEntregaNome'];
    ParceiroEntregaQuaAs = json['ParceiroEntregaQuaAs'];
    ParceiroEntregaQuaDas = json['ParceiroEntregaQuaDas'];
    ParceiroEntregaQuiAs = json['ParceiroEntregaQuiAs'];
    ParceiroEntregaQuiDas = json['ParceiroEntregaQuiDas'];
    ParceiroEntregaSabAs = json['ParceiroEntregaSabAs'];
    ParceiroEntregaSabDas = json['ParceiroEntregaSabDas'];
    ParceiroEntregaSegAs = json['ParceiroEntregaSegAs'];
    ParceiroEntregaSegDas = json['ParceiroEntregaSegDas'];
    ParceiroEntregaSexAs = json['ParceiroEntregaSexAs'];
    ParceiroEntregaSexDas = json['ParceiroEntregaSexDas'];
    ParceiroEntregaTerAs = json['ParceiroEntregaTerAs'];
    ParceiroEntregaTerDas = json['ParceiroEntregaTerDas'];
    // ParceiroEntregaValorMais3KmFds = json['ParceiroEntregaValorMais3KmFds'];
    // ParceiroEntregaValorMais3Km = json['ParceiroEntregaValorMais3Km'];
    // ParceiroEntregaValor3KmFds = json['ParceiroEntregaValor3KmFds'];
    // ParceiroEntregaValor3Km = json['ParceiroEntregaValor3Km'];
  }

}