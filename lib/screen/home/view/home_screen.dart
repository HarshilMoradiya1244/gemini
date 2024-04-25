import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
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
        body: Stack(
          children: [
            Image.asset(
              "assets/images/home.jpg",
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Welcome To Gemini",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
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
                const Divider(
                  color: Colors.white,
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.dataList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
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
                                        HistoryModel historyModel =
                                            HistoryModel(
                                          answer: controller.dataList[index],
                                        );
                                        DbHelper.helper
                                            .insertData(historyModel);
                                      },
                                      icon: const Icon(
                                        Icons.bookmark_border,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        controller.dataList[index],
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: txtSearch,
                          decoration: const InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          controller.dataList.add(txtSearch.text);
                          await controller.getHomeData(txtSearch.text);
                          txtSearch.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 40,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
