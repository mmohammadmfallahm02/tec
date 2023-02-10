import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/data_models.dart';

// homeposter fake data
Map homePagePosterMap = {
  "ImageAssets": Assets.images.posterTest.path,
  "writer": "ملیکا عزیزی",
  "date": "یک روز پیش",
  "title": "دوازده قدم برنامه نویسی یک دوره ی برنامه نویسی یک دوره ی",
  "view": "251"
};

// tags fake data

List<HashTagModel> tagList = [
  HashTagModel(title: 'جاوا'),
  HashTagModel(title: 'کاتلین'),
  HashTagModel(title: 'وب'),
  HashTagModel(title: 'هوش مصنوعی'),
  HashTagModel(title: 'iot'),
  HashTagModel(title: 'دارت'),
  HashTagModel(title: 'فلاتر')
];

// tags selected data

List<HashTagModel> selectedTagList = [];
