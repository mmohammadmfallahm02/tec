import 'package:tec/constant/api_constant.dart';

class PodcastFileModel {
  String? id;
  String? podcastId;
  String? file;
  String? title;
  String? length;

  PodcastFileModel();

  PodcastFileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        podcastId = json['podcast_id'],
        file = ApiUrlConstant.hostDlUrl + json['file'],
        title = json['title'],
        length = json['length'];
}
