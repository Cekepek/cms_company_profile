import 'dart:convert';

import 'package:cms_company_profile/class/contact.dart';
import 'package:cms_company_profile/class/project.dart';
import 'package:cms_company_profile/helper.dart';
import 'package:cms_company_profile/sidebar.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'package:cms_company_profile/model/api.dart' as api;

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PortfolioState();
  }
}

class _PortfolioState extends State<Portfolio> {
  final List<String> _dropdownItems = ['Interior', 'Architecture'];
  String kategoriPilihan = 'Interior';
  void getData() async {
    final response = await api.connectApi("/proyek", "get", null);
    if (response.status == 200) {
      if (response.message == 'berhasil') {
        print(response.data);
        setState(() {
          final List<Project> projectList =
              Project.decode(jsonEncode(response.data));
          global.listProject = projectList;
          print("Get Data : " + global.listProject[0].id.toString());
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

  void tambahProyek(String namaProyek, String lokasi) async {
    final body = jsonEncode({
      "id_proyek": 0,
      "nama": namaProyek,
      "lokasi": lokasi,
      "kategori": kategoriPilihan
    });
    final response = await api.connectApi("/proyek", "post", body);
    if (response.status == 200) {
      print("KEUPLOAD ");

      print(response.data['id_proyek']);
    } else {
      throw Exception('Failed to read API');
    }
  }

  void deleteProyek() async {
    int id_proyek = global.proyekTerpilih.id;
    final response =
        await api.connectApi("/delete_proyek/$id_proyek", "delete", null);
    print(response.status);
    if (response.status == 200) {
      print(response.data);
      getData();
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<void> showTambahProject() async {
    var nameController = TextEditingController();
    var lokasiController = TextEditingController();
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
                            "Tambah Proyek Baru",
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nama Proyek",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 8)),
                          TextField(
                            controller: nameController,
                            readOnly: false,
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
                            "Lokasi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 8)),
                          TextField(
                            controller: lokasiController,
                            readOnly: false,
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
                            "Kategori",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 8)),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFFD9D9D9)),
                            )),
                            isExpanded: true,
                            value:
                                kategoriPilihan, // Nilai yang dipilih saat ini
                            hint: Text(
                                'Pilih Opsi'), // Placeholder jika belum ada yang dipilih
                            onChanged: (newValue) {
                              setState(() {
                                kategoriPilihan = newValue!;
                              });
                            },
                            items: _dropdownItems.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                tambahProyek(
                                    nameController.text, lokasiController.text);
                                global.listProject.add(Project(
                                    id: global.listProject.length + 1,
                                    namaProject: nameController.text,
                                    lokasi: lokasiController.text,
                                    kategori: kategoriPilihan));

                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              height: 47,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Helper().primaryColor),
                              child: const Center(
                                child: Text(
                                  "CREATE",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                          "Project",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 24),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, bottom: 20),
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            elevation: 1,
                            color: Helper().primaryColor,
                            child: InkWell(
                              splashColor: Colors.white.withOpacity(0.5),
                              highlightColor: Helper().colorPrimaryGelap,
                              onTap: () {
                                showTambahProject();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Tambah Proyek",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                          border: Border.all(
                              width: 1, color: Helper().primaryColor),
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
                            DataColumn(label: Text("Nama Project")),
                            DataColumn(label: Text("Lokasi")),
                            DataColumn(label: Text("Kategori")),
                            DataColumn(label: Text("Aksi"))
                          ],
                          rows: List.generate(
                            global.listProject.length,
                            (index) => DataRow(cells: <DataCell>[
                              DataCell(Text(
                                  global.listProject[index].id.toString())),
                              DataCell(Text(global
                                  .listProject[index].namaProject
                                  .toString())),
                              DataCell(Text(
                                  global.listProject[index].lokasi.toString())),
                              DataCell(Text(global.listProject[index].kategori
                                  .toString())),
                              DataCell(Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      global.proyekTerpilih =
                                          global.listProject[index];
                                      Navigator.pushNamed(
                                          context, "/edit_proyek");
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Color(0xFF0B4D70),
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 8)),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        global.proyekTerpilih =
                                            global.listProject[index];
                                        print("PROYEK : " +
                                            global.proyekTerpilih.id
                                                .toString());

                                        print("NAMA PROYEK : " +
                                            global.proyekTerpilih.namaProject
                                                .toString());
                                        deleteProyek();
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
                ))
          ],
        ),
      ),
    );
  }
}
