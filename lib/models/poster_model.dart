import 'package:tec/constant/api_constant.dart';

class PosterModel {
  String? id;
  String? title;
  String? image;

  PosterModel({this.id, this.title, this.image});

  PosterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        image = ApiConstant.hostDlUrl + json['image'];
}
