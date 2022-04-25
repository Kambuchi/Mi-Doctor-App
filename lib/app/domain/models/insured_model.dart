class InsuredModel {
  String tipoAsegurado;
  int nrocontrato;
  int nrocedula;
  String nombreAsegurado;
  String plan;
  int planId;
  String estado;
  List? adherentes;
  String negocioId;

  InsuredModel({
    required this.tipoAsegurado,
    required this.nrocontrato,
    required this.nrocedula,
    required this.nombreAsegurado,
    required this.plan,
    required this.planId,
    required this.estado,
    this.adherentes,
    required this.negocioId,
  });

  factory InsuredModel.fromMap(Map<String, dynamic> json) {
    return InsuredModel(
      tipoAsegurado: json["tipo_asegurado"],
      nrocontrato: json["nrocontrato"],
      nrocedula: json["nrocedula"],
      nombreAsegurado: json["nombre_asegurado"],
      plan: json["plan"],
      planId: json["codigo"],
      estado: json["estado"],
      negocioId: json["unidad_negocio_id"],
    );
  }

  Map<String, dynamic> toMap() => {
        "tipo_asegurado": tipoAsegurado,
        "nrocontrato": nrocontrato,
        "nrocedula": nrocedula,
        "nombre_asegurado": nombreAsegurado,
        "plan": plan,
        "plan_id": planId,
        "estado": estado,
        "unidad_negocio_id": negocioId,
      };
}

class InsuredList {
  final List<InsuredModel> insureds;

  InsuredList({required this.insureds});

  factory InsuredList.fromJson(List<dynamic> parsedJson) {
    List<InsuredModel> insureds = [];
    insureds = parsedJson.map((e) => InsuredModel.fromMap(e)).toList();

    return InsuredList(insureds: insureds);
  }
}
