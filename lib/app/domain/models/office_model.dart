class OfficeModel {
  int codigo;
  String nombre;
  String telefono;
  String direccion;
  String ubicacion;

  OfficeModel({
    required this.codigo,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.ubicacion,   
  });

  factory OfficeModel.fromMap(Map<String, dynamic> json) {
    return OfficeModel(
      codigo: json["codigo"],
      nombre: json["nombre"],
      telefono: json["telefono"],
      direccion: json["direccion"],
      ubicacion: json["ubicacion"],
    
    );
  }

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "nombre": nombre,
        "telefono": telefono,
        "direccion": direccion,
        "ubicacion": ubicacion,
      };
}

class OfficeList {
  final List<OfficeModel> offices;

  OfficeList({required this.offices});

  factory OfficeList.fromJson(List<dynamic> parsedJson) {
    List<OfficeModel> offices = [];
    offices = parsedJson.map((e) => OfficeModel.fromMap(e)).toList();

    return OfficeList(offices: offices);
  }
}
