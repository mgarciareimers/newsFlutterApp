class SourceModel {
  String id;
  String name;

  SourceModel({
    this.id,
    this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
    id: json['id'] == null ? null : json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id == null ? null : id,
    'name': name,
  };
}