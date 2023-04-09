import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/commands.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tag_model.dart';
import '../../constant/api_constant.dart';
import '../../services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxList<TagModel> tagList = RxList.empty();
  TextEditingController titleController = TextEditingController();
  RxBool loading = false.obs;
  Rx<ArticleInfoModel> articleModel = ArticleInfoModel(
    title: 'اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کن',
    content:
        'من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی',
    image: ' ',
  ).obs;

  @override
  onInit() {
    super.onInit();
    getManageArticle();
  }

  getManageArticle() async {
    loading.value = true;

    // TODO get userId from getStorage ApiConstant.getArticleList+userId
    // var response = await DioService().getMethod(
    //     ApiConstant.getArticlePublishedByMe +
    //         GetStorage().read(StorageKey.userId));
    var userId = GetStorage().read(StorageKey.userId);
   
    var response = await DioService()
        .getMethod('${ApiUrlConstant.getArticlePublishedByMe}$userId');
    if (response.statusCode == 200) {
      response.data.forEach(
          (element) => articleList.add(ArticleModel.fromJson(element)));
    }
    loading.value = false;
    // articleList.clear();
  }

  updateTitle() {
    articleModel.update((val) {
      val!.title = titleController.text;
    });
  }

  storeArticle() async {
    var fileController = Get.find<FilePickerController>();

    loading.value = true;
    Map<String, dynamic> map = {
      ApiArticleKeyConstant.title: articleModel.value.title,
      ApiArticleKeyConstant.content: articleModel.value.content,
      ApiArticleKeyConstant.catId: articleModel.value.catId,
      ApiArticleKeyConstant.userId: GetStorage().read(StorageKey.userId),
      ApiArticleKeyConstant.image:
          await dio.MultipartFile.fromFile(fileController.file.value.path!),
      ApiArticleKeyConstant.command: Commands.store,
      ApiArticleKeyConstant.tagList: "[]",
    };

    var response =
        await DioService().postMethod(map, ApiUrlConstant.articlePost);
    log(response.data.toString());
    loading.value = false;
  }
}

// storeArticle() async {
  

//   var fileController = Get.find<FilePickerController>();
//   loading.value = true;
//   Map<String, dynamic> map = {
//       ApiArticleKeyConstant.title : articleInfoModel.value.title,
//       ApiArticleKeyConstant.content : articleInfoModel.value.content,
//       ApiArticleKeyConstant.catId :articleInfoModel.value.catId,
//       ApiArticleKeyConstant.userId : GetStorage().read(StorageKey.userId),
//       ApiArticleKeyConstant.image : await dio.MultipartFile.fromFile(fileController.file.value.path!),
//       ApiArticleKeyConstant.command : Commands.store,
//       ApiArticleKeyConstant.tagList : "[]"
 
//   };
//   var response = await DioService().postMethod(map, ApiUrlConstant.articlePost);
//   log(response.data.toString());
//   loading.value = false;

// }