import 'dart:convert';

import 'package:cms_company_profile/class/contact.dart';
import 'package:cms_company_profile/helper.dart';
import 'package:cms_company_profile/sidebar.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'package:cms_company_profile/model/api.dart' as api;

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContactUsState();
  }
}

class _ContactUsState extends State<ContactUs> {
  void getData() async {
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

  Future<void> bacaPesan(int index) async {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var pesanController = TextEditingController();
    nameController.text = global.listContact[index].fullname;
    emailController.text = global.listContact[index].email;
    pesanController.text = global.listContact[index].message;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateCreate) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: Helper().primaryColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Isi Pesan",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nama",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 8)),
                            TextField(
                              controller: nameController,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                filled: false,
                                fillColor: Color(0xFFD9D9D9),
                                hintText: '',
                                border: InputBorder.none,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 16)),
                            const Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 8)),
                            TextField(
                              controller: emailController,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                filled: false,
                                fillColor: Color(0xFFD9D9D9),
                                hintText: '',
                                border: InputBorder.none,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 16)),
                            const Text(
                              "Pesan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 8)),
                            TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: pesanController,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                ),
                                filled: false,
                                fillColor: Color(0xFFD9D9D9),
                                hintText: '',
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Sidebar(),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Contact",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        border:
                            Border.all(width: 1, color: Helper().primaryColor),
                      ),
                      child: DataTable(
                        headingTextStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        dataTextStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        columns: [
                          DataColumn(label: Text("Nomor")),
                          DataColumn(label: Text("Nama")),
                          DataColumn(label: Text("Email")),
                          DataColumn(label: Text("Pesan")),
                          DataColumn(label: Text("Hapus")),
                        ],
                        rows: List.generate(
                          global.listContact.length,
                          (index) => DataRow(cells: <DataCell>[
                            DataCell(
                                Text(global.listContact[index].id.toString())),
                            DataCell(Text(
                                global.listContact[index].fullname.toString())),
                            DataCell(Text(
                                global.listContact[index].email.toString())),
                            DataCell(Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    bacaPesan(index);
                                  },
                                  child: const Icon(
                                    Icons.read_more,
                                    size: 30,
                                    color: Color(0xFF0B4D70),
                                  ),
                                ),
                              ],
                            )),
                            DataCell(Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      global.listContact.removeAt(index);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
