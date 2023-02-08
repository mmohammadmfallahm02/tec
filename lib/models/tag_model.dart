class TagModel {
  String? id;
  String? title;

  TagModel({required this.id, required this.title});

  TagModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];
}
