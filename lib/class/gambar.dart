import 'dart:convert';

class Gambar {
  int id;
  String path;
  int id_proyek;
  Gambar({
    required this.id,
    required this.path,
    required this.id_proyek,
  });

  factory Gambar.fromJson(Map<String, dynamic> jsonData) {
    return Gambar(
      id: jsonData['id'],
      id_proyek: jsonData['id_proyek'],
      path: jsonData['path'],
    );
  }

  static Map<String, dynamic> toMap(Gambar c) => {
        'id': c.id,
        'id_proyek': c.id_proyek,
        'path': c.path,
      };

  static String encode(List<Gambar> c) => json.encode(
        c.map<Map<String, dynamic>>((gambar) => Gambar.toMap(gambar)).toList(),
      );

  static List<Gambar> decode(String gambar) =>
      (json.decode(gambar) as List<dynamic>)
          .map<Gambar>((item) => Gambar.fromJson(item))
          .toList();
}
