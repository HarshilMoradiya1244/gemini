import 'package:flutter/material.dart';
import 'package:gemini/screen/history/controller/history_controller.dart';
import 'package:gemini/utils/database/database_helper.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryController controller = Get.put(HistoryController());

  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          title: const Text(
            "History",
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.historyList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete"),
                        content: const Text("Are You Sure To Delete"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                DbHelper.helper.deleteData(
                                    id: "${controller.historyList[index].id}");
                                controller.getData();
                                Get.back();
                              },
                              child: const Text("Delete")),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Close")),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)),
                  child: Text(
                    "${controller.historyList[index].answer}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 15,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
