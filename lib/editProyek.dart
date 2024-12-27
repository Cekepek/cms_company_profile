import 'dart:convert';
import 'dart:io';

import 'package:cms_company_profile/class/gambar.dart';
import 'package:cms_company_profile/class/project.dart';
import 'package:cms_company_profile/helper.dart';
import 'package:cms_company_profile/hoverableImage.dart';
import 'package:cms_company_profile/sidebar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'package:cms_company_profile/model/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:typed_data';

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
  var kategoriController = TextEditingController();
  final List<String> _dropdownItems = ['Interior', 'Architecture'];
  String kategoriPilihan = "Interior";

  Future<void> uploadImage(Uint8List imageFile, String filename) async {
    try {
      String url = "https://biiio-studio.com:5868/portfolio";
      // Membuat request multipart
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Tambahkan file ke dalam request
      var image = await http.MultipartFile.fromBytes(
        'photo', // Nama field di API
        imageFile,
        filename: filename, // Nama file
      );

      request.files.add(image);

      // request.fields.addAll(jsonEncode(
      // {"id": 0, "id_proyek": global.proyekTerpilih.id, "path": filename}));

      // request.fields['id'] = "0";
      request.fields['id_proyek'] = global.proyekTerpilih.id.toString();
      // request.fields['path'] = filename;

      // Kirim request
      var response = await request.send();

      if (response.statusCode == 200) {
        var body = await http.Response.fromStream(response);
        String stringBody = body.body;
        // Map json = jsonDecode(body);
        print(stringBody);
        print('Upload berhasil');
        getData();
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
    global.listGambar = [];
    getData();
    nameController.text = global.proyekTerpilih.namaProject;
    lokasiController.text = global.proyekTerpilih.lokasi;
    kategoriController.text = global.proyekTerpilih.kategori;
    global.proyekTerpilih.kategori == ""
        ? kategoriPilihan = 'Interior'
        : kategoriPilihan = global.proyekTerpilih.kategori;
  }

  void getData() async {
    String idProyek = global.proyekTerpilih.id.toString();
    final response = await api.connectApi("/sinkronasi/$idProyek", "get", null);
    if (response.status == 200) {
      if (response.message == 'berhasil') {
        setState(() {
          print(response.data);
          final List<Gambar> gambarList =
              Gambar.decode(jsonEncode(response.data));
          global.listGambar = gambarList;
        });
      } else {}
    } else {
      throw Exception('Failed to read API');
    }
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

  void refreshGrid() {
    getData();
  }

  void simpanEdit() async {
    final body = jsonEncode({
      "id": global.proyekTerpilih.id,
      "nama": nameController.text,
      "lokasi": lokasiController.text,
      "kategori": kategoriPilihan,
    });
    print(body);
    final response = await api.connectApi("/proyek", "put", body);
    if (response.status == 200) {
      print("KEUPLOAD ");

      print(response.data['id']);
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
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          for (var file in result.files) {
            Uint8List fileBytes = file.bytes!;
            uploadImage(fileBytes, file.name);
            print("File disimpan: ${file.name}");
          }
          // Uint8List fileBytes = result.files.single.bytes!;
          // uploadImage(fileBytes, result.files.single.name);
          // //  _imageBytes = result.files.first.bytes;
          // print("KE SAVE " + result.files.first.name);
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
                          SizedBox(
                            height: 16,
                          ),
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
                                print(kategoriPilihan);
                              });
                            },
                            items: _dropdownItems.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                            mainAxisSpacing: 10,
                          ),
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index) {
                            if (index < global.listGambar.length) {
                              return HoverableImage(
                                imageUrl:
                                    "https://biiio-studio.com:5868/getPhoto?path=" +
                                        global.listGambar[index].path,
                                idGambar: global.listGambar[index].id,
                                onImageDeleted: refreshGrid,
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
