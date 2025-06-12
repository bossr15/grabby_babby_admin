import '../../../core/utils/utils.dart';

class PreferencesModel {
  int? id;
  String? name;
  String? url;
  List<ChildPreferences>? subPreferences;
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
        subPreferences: parseList(
            json["childParentPreferences"], ChildPreferences.fromJson),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "subPreferences": subPreferences?.map((x) => x.toJson()).toList(),
      };

  Map<String, dynamic> toUpdateJson() => {
        "id": id,
        "name": name,
        "url": url,
        "subPreferences": subPreferences?.map((x) => x.toJson()).toList(),
      };

  PreferencesModel copyWith({
    int? id,
    String? name,
    String? url,
    List<ChildPreferences>? subPreferences,
  }) {
    return PreferencesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      subPreferences: subPreferences ?? this.subPreferences,
    );
  }
}

class ChildPreferences {
  int? id;
  int? parentId;
  int? childId;
  PreferencesModel? child;
  ChildPreferences({
    this.id,
    this.parentId,
    this.childId,
    this.child,
  });

  factory ChildPreferences.fromJson(Map<String, dynamic> json) =>
      ChildPreferences(
        id: json["id"],
        parentId: json["parentId"],
        childId: json["childId"],
        child: json["child"] != null && json["child"] is Map
            ? PreferencesModel.fromJson(json["child"])
            : null,
      );

  Map<String, dynamic> toJson() => {"id": id};
}
