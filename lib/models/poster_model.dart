class PosterModel {
  String? id;
  String? title;
  String? image;

  PosterModel({required this.id, required this.title, required this.image});

  PosterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        image = json['image'];
}
