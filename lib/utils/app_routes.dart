import 'package:flutter/material.dart';
import 'package:gemini/screen/history/view/history_screen.dart';
import 'package:gemini/screen/home/view/home_screen.dart';
import 'package:gemini/screen/splash/view/splash_screen.dart';

Map<String,WidgetBuilder> screen_routes = {

  "/":(context) => const SplashScreen(),
  "home":(context) => const HomeScreen(),
  "history":(context) => const HistoryScreen(),
};