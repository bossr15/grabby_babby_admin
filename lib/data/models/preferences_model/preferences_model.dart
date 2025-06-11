import '../../../core/utils/utils.dart';

class PreferencesModel {
  int? id;
  String? name;
  String? url;
  List<PreferencesModel>? subPreferences;
  PreferencesModel({
    this.id,
    this.name,
    this.url,
    this.subPreferences,
  });

  factory PreferencesModel.fromJson(Map<String, dynamic> json) =>
      PreferencesModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        subPreferences:
            parseList(json["subPreferences"], PreferencesModel.fromJson),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "subPreferences": subPreferences?.map((x) => x.toUpdateJson()).toList(),
      };

  Map<String, dynamic> toUpdateJson() => {
        "id": id,
        "name": name,
        "url": url,
        "subPreferences": subPreferences?.map((x) => x.toUpdateJson()).toList(),
      };

  PreferencesModel copyWith({
    int? id,
    String? name,
    String? url,
    List<PreferencesModel>? subPreferences,
  }) {
    return PreferencesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      subPreferences: subPreferences ?? this.subPreferences,
    );
  }
}
