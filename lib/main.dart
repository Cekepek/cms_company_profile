import 'package:cms_company_profile/contact.dart';
import 'package:cms_company_profile/editProyek.dart';
import 'package:cms_company_profile/helper.dart';
import 'package:cms_company_profile/login.dart';
import 'package:cms_company_profile/portfolio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biiio Studio Admin',
      initialRoute: '/',
      routes: {
        '/portfolio': (context) => Portfolio(),
        '/edit_proyek': (context) => EditProyek(),
        '/contact': (context) => Contact()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Helper().primaryColor),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
