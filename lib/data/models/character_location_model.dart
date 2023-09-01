class LocationModel {
  late String name;
  late String type;
  late String dimension;

  LocationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    dimension = json['dimension'];
  }
}
