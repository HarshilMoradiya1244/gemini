import 'package:flutter/material.dart';
import 'package:gemini/utils/app_routes.dart';
import 'package:get/get.dart';

void main(){
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: screen_routes,
        theme: ThemeData.dark(),
      )
  );
}