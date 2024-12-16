import 'dart:convert';
import 'dart:io';

import 'package:cms_company_profile/helper.dart';
import 'package:cms_company_profile/sidebar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'package:cms_company_profile/model/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class EditProyek extends StatefulWidget {
  const EditProyek({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditProyekState();
  }
}

class _EditProyekState extends State<EditProyek> {
  var nameController = TextEditingController();
  var lokasiController = TextEditingController();

  Future<void> uploadImage(File imageFile, String url) async {
    try {
      // Membuat request multipart
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Tambahkan file ke dalam request
      var image = await http.MultipartFile.fromPath(
        'file', // Nama field di API
        imageFile.path,
        filename: path.basename(imageFile.path), // Nama file
      );

      request.files.add(image);

      // Tambahkan parameter lain jika diperlukan
      request.fields['key'] = 'value'; // Tambahan parameter, jika ada

      // Kirim request
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Upload berhasil');
      } else {
        print('Upload gagal: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = global.proyekTerpilih.namaProject;
    lokasiController.text = global.proyekTerpilih.lokasi;
  }

  Future<void> showAlert() async {
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
                            "Edit Proyek",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Data berhasil di Edit !",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              height: 47,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Helper().primaryColor),
                              child: const Center(
                                child: Text(
                                  "OK",
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

  void simpanEdit() async {
    final body = jsonEncode({
      "id_proyek": global.proyekTerpilih.id,
      "nama": nameController.text,
      "lokasi": lokasiController.text
    });
    print(body);
    final response = await api.connectApi("/proyek", "put", body);
    if (response.status == 200) {
      print("KEUPLOAD ");

      print(response.data['id_proyek']);
      showAlert();
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Only allow image files
        withData: true, // Get the file's byte data
      );

      if (result != null) {
        setState(() {
          File file = File(result.files.single.path!);
          uploadImage(file, "http://biiio-studio.com:5868");
          //  _imageBytes = result.files.first.bytes;
          print("KE SAVE " + result.files.first.name);
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print("ERROR PICKING FILE : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
              )),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Helper().primaryColor, width: 1),
                    ),
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
                          SizedBox(
                            height: 16,
                          ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    simpanEdit();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Helper().primaryColor),
                                    child: const Center(
                                      child: Text(
                                        "SIMPAN",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Helper().primaryColor, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gambar Portfolio",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        GridView.builder(
                          itemCount: global.listGambar.length + 1,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.5,
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                          ),
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index) {
                            if (index < global.listGambar.length) {
                              return SizedBox(
                                width: double.infinity / 4,
                                height: MediaQuery.of(context).size.height / 6,
                                child:
                                    Image.asset(global.listGambar[index].path),
                              );
                            } else {
                              return Material(
                                elevation: 4.0, // Optional shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Optional rounded corners
                                  side: BorderSide(
                                    color:
                                        Helper().primaryColor, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: SizedBox(
                                    width: double.infinity / 4,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.upload),
                                        Text("Upload Gambar")
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
