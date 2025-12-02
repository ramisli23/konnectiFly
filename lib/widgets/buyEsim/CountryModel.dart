class CountryModel {
  final int id;
  final String name;
  final String imageUrl;

  CountryModel({required this.id, required this.name, required this.imageUrl});
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
