import 'package:flutter/material.dart';
import 'package:innoscripta_home_challenge/core/configs/app/multiprovider_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences localStorage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localStorage = await SharedPreferences.getInstance();
  runApp(blocApplication);
}
