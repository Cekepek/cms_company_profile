import 'dart:convert';

import 'package:cms_company_profile/class/gambar.dart';
import 'package:flutter/material.dart';
import 'package:cms_company_profile/model/api.dart' as api;
import 'global.dart' as global;

class HoverableImage extends StatefulWidget {
  final String imageUrl;
  final int idGambar;
  final VoidCallback onImageDeleted;
  const HoverableImage({
    Key? key,
    required this.imageUrl,
    required this.idGambar,
    required this.onImageDeleted,
  }) : super(key: key);

  @override
  _HoverableImageState createState() => _HoverableImageState();
}

class _HoverableImageState extends State<HoverableImage> {
  bool _isHovered = false;

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

  void deleteFoto() async {
    int id = widget.idGambar;
    print(id);
    final response =
        await api.connectApi("/delete_portfolio/$id", "delete", null);
    print(response.status);
    if (response.status == 200) {
      print(response.data);
      setState(() {
        widget.onImageDeleted();
      });
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          if (_isHovered)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        widget.imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(height: 16),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Close"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text("Preview"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          deleteFoto();
                        },
                        child: Text(
                          "Hapus",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
