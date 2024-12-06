import 'package:cms_company_profile/helper.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
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
                            child: Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: Colors.white,
                                    onSaved: (email) {},
                                    decoration: const InputDecoration(
                                      hintText: "Your email",
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
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                        hintText: "Your password",
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.lock),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Hero(
                                    tag: "login_btn",
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/portfolio');
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
