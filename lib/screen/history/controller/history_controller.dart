import 'package:gemini/screen/history/model/history_model.dart';
import 'package:gemini/utils/database/database_helper.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController{
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;

  Future<void>getData()async{
    List<HistoryModel> history = await DbHelper.helper.readData();
    historyList.value = history;
  }
}