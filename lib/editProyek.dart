import 'package:cms_company_profile/helper.dart';
import 'package:cms_company_profile/sidebar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = global.listProject[global.proyekTerpilih].namaProject;
    lokasiController.text = global.listProject[global.proyekTerpilih].lokasi;
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Only allow image files
        withData: true, // Get the file's byte data
      );

      if (result != null) {
        setState(() {
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
