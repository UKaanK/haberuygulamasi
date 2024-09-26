import 'package:flutter/material.dart';
import 'package:haberuygulamasi/views/splashscreen_view.dart';
import 'package:provider/provider.dart';
import 'package:haberuygulamasi/providers/news_provider.dart';
import 'package:haberuygulamasi/views/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haber Uygulaması',
  debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
