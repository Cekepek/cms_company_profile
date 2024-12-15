import 'dart:convert';

import 'package:cms_company_profile/class/contact.dart';
import 'package:cms_company_profile/class/project.dart';
import 'package:cms_company_profile/helper.dart';
import 'package:cms_company_profile/main.dart';
import 'package:flutter/material.dart';
import 'package:cms_company_profile/model/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as global;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  TextEditingController _user_id = TextEditingController();
  TextEditingController _user_password = TextEditingController();
  String error_login = "";
  void getData() async {
    final response = await api.connectApi("/proyek", "get", null);
    if (response.status == 200) {
      if (response.message == 'berhasil') {
        setState(() {
          final List<Project> projectList =
              Project.decode(jsonEncode(response.data));
          global.listProject = projectList;
        });
      } else {}
    } else {
      throw Exception('Failed to read API');
    }
    final response2 = await api.connectApi("/contactUs", "get", null);
    if (response2.status == 200) {
      if (response2.message == 'berhasil') {
        setState(() {
          final List<Contact> contactList =
              Contact.decode(jsonEncode(response2.data));
          global.listContact = contactList;
        });
      } else {}
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  void login() async {
    try {
      setState(() {
        error_login = "";
      });
      if (_user_id.text.isEmpty || _user_password.text.isEmpty) {
        setState(() {
          error_login = "Username/Password tidak boleh kosong";
        });
      } else {
        String username = _user_id.text;
        String password = _user_password.text;
        final response = await api.connectApi(
            "/login?username=$username&password=$password", "post", null);
        if (response.status == 200) {
          if (response.message == 'berhasil') {
            setState(() {
              Navigator.pushNamed(context, "/portfolio");
            });
          } else {
            setState(() {
              error_login = "Username atau password salah";
            });
          }
        } else {
          throw Exception('Failed to read API');
        }
      }
    } catch (e, stackTrace) {
      print("Error: $e");
      print("Stack Trace: $stackTrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Helper().primaryColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Helper().primaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Helper().colorInput,
          iconColor: Colors.black,
          prefixIconColor: Colors.black,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          // const SizedBox(height: 16.0 * 2),
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child: Image(
                                  image: AssetImage("assets/images/logo.png"),
                                  width: 600,
                                  height: 300,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          // const SizedBox(height: 16.0 * 2),
                        ],
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _user_id,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Colors.white,
                                  decoration: const InputDecoration(
                                    hintText: "Your username",
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: TextFormField(
                                    controller: _user_password,
                                    textInputAction: TextInputAction.done,
                                    obscureText: true,
                                    cursorColor: Colors.white,
                                    decoration: const InputDecoration(
                                      hintText: "Your password",
                                      hintStyle: TextStyle(color: Colors.black),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.lock),
                                      ),
                                    ),
                                  ),
                                ),
                                if (error_login != "")
                                  Text(
                                    error_login,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                const SizedBox(height: 16.0),
                                Hero(
                                  tag: "login_btn",
                                  child: ElevatedButton(
                                    onPressed: () {
                                      login();
                                    },
                                    child: Text(
                                      "Login".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
