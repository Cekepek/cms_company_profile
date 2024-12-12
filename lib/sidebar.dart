import 'package:cms_company_profile/helper.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Helper().primaryColor,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(10))),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        Image(
          image: AssetImage("assets/images/logo.png"),
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            elevation: 1,
            color: global.selectedPage == "portfolio"
                ? Helper().colorPrimaryGelapSelected
                : Helper().colorPrimaryGelap,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.5),
              highlightColor: Helper().colorPrimaryGelap.withOpacity(0.3),
              onTap: () {
                setState(() {
                  global.selectedPage = "portfolio";
                  Navigator.pushNamed(context, "/portfolio");
                });
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Portfolio",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            elevation: 1,
            color: global.selectedPage == "contact"
                ? Helper().colorPrimaryGelapSelected
                : Helper().colorPrimaryGelap,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.5),
              highlightColor: Helper().colorPrimaryGelap.withOpacity(0.3),
              onTap: () {
                setState(() {
                  global.selectedPage = "contact";
                  Navigator.pushNamed(context, "/contact");
                });
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Contact",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
