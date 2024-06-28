import 'package:flutter/material.dart';
import 'package:gemini/screen/history/model/history_model.dart';
import 'package:gemini/screen/home/controller/home_controller.dart';
import 'package:gemini/utils/database/database_helper.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Welcome To Gemini",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed("history");
              },
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  reverse: true,
                  itemCount: controller.dataList.length,
                  itemBuilder: (context, index) {
                    final result = controller.dataList.length - index - 1;

                    return Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(6),
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                HistoryModel historyModel = HistoryModel(
                                  answer: controller.dataList[result],
                                );
                                DbHelper.helper.insertData(historyModel);
                              },
                              icon: const Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            controller.dataList[result],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                controller: txtSearch,
                hintText: "Search Your Questions",
                elevation: const MaterialStatePropertyAll(3),
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                trailing: [
                  IconButton(
                    onPressed: () async {
                      controller.dataList.add(txtSearch.text);
                      HistoryModel model = HistoryModel(answer: txtSearch.text);
                      DbHelper.helper.insertData(model);
                      await controller.getHomeData(txtSearch.text);
                      txtSearch.clear();
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*

*/
