import 'package:flutter/material.dart';
import 'package:icddrb/screens/login_page.dart';
void main() => runApp( MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "icddr,b",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: const LoginPage(),
    );
  }
}