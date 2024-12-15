import 'dart:convert';

import 'package:cms_company_profile/class/project.dart';
import 'package:cms_company_profile/class/contact.dart';
import 'package:cms_company_profile/contact.dart';
import 'package:cms_company_profile/editProyek.dart';
import 'package:cms_company_profile/helper.dart';
import 'package:cms_company_profile/login.dart';
import 'package:cms_company_profile/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:cms_company_profile/model/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as global;

// Future<String> checkUser() async {
//   String userLogin = "";
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     userLogin = prefs.getString("userLogin") ?? "";
//     if (userLogin != "") {
//       global.loggedIn = true;
//     }
//   } catch (e, stackTrace) {
//     print("Error: $e");
//     print("Stack Trace: $stackTrace");
//   }

//   return userLogin;
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   checkUser().then((String result) async {
//     if (result == "") {
//       runApp(const Login());
//     } else {
//       runApp(const MyApp());
//     }
//   });
// }

main() {
  runApp(MyApp());
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
        '/contact': (context) => ContactUs()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Helper().primaryColor),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Welcome"),
    );
  }
}
