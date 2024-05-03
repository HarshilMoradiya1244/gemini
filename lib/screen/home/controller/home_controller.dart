import 'package:flutter/material.dart';
import 'package:gemini/screen/home/model/home_model.dart';
import 'package:gemini/utils/api_helper/api_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rxn<HomeModel>? homeModel = Rxn();
  RxList<String> dataList = <String>[].obs;
  ValueNotifier<bool> isLoading = ValueNotifier(false);


  Future<void> getHomeData(String data) async {
    APIHelper apiHelper = APIHelper();
    HomeModel? h1 = await apiHelper.geminiCall(data);
    homeModel?.value = h1;
    if (homeModel!.value != null) {
      dataList.add(homeModel!.value!.candidateList![0].content!.partsList![0].text!);
    }
    isLoading.value = false;
  }
}