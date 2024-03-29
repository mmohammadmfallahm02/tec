import 'package:tec/constant/api_constant.dart';

class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? view;
  String? status;
  // String? isFavorite;
  String? createdAt;

  ArticleModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.catId,
      required this.catName,
      required this.author,
      required this.view,
      required this.status,
      // this.isFavorite,
      required this.createdAt});

  ArticleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        image = ApiUrlConstant.hostDlUrl + json['image'],
        catId = json['cat_id'],
        catName = json['cat_name'],
        author = json['author'] ?? 'ساسان صفری',
        view = json['view'],
        status = json['status'],
        createdAt = json['created_at'];
}
