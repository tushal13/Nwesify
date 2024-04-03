import 'package:flutter/material.dart';
import 'package:nwesify/controller/theme_controller.dart';
import 'package:nwesify/utility/theme.dart';
import 'package:nwesify/views/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'controller/news_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NewsController()),
    ChangeNotifierProvider(create: (_) => ThemeController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nwesify',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeController>(context).isDark
          ? Apptheme.DarkTheme
          : Apptheme.lightTheme,
      home: HomePage(),
    );
  }
}
