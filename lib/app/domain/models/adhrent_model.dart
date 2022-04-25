class AdherentModel {
  String nombreAdherente;
  String parentesco;

  AdherentModel({
    required this.nombreAdherente,
    required this.parentesco,
  });

  factory AdherentModel.fromMap(Map<String, dynamic> json) {
    return AdherentModel(
      nombreAdherente: json["adherentes"],
      parentesco: json["parentesco"],
    );
  }

  Map<String, dynamic> toList() => {
        "adherentes": nombreAdherente,
        "parentesco": parentesco,
      };
}

class AdherentList {
  final List<AdherentModel> insureds;

  AdherentList({required this.insureds});

  factory AdherentList.fromJson(List<dynamic> parsedJson) {
    List<AdherentModel> insureds = [];
    insureds = parsedJson.map((e) => AdherentModel.fromMap(e)).toList();

    return AdherentList(insureds: insureds);
  }
}
