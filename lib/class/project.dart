import 'dart:convert';

class Project {
  int id;
  String namaProject;
  String lokasi;
  String kategori;
  Project({
    required this.id,
    required this.namaProject,
    required this.lokasi,
    required this.kategori,
  });

  factory Project.fromJson(Map<String, dynamic> jsonData) {
    return Project(
        id: jsonData['id_proyek'],
        namaProject: jsonData['nama'],
        lokasi: jsonData['lokasi'],
        kategori: jsonData['kategori']);
  }

  static Map<String, dynamic> toMap(Project c) => {
        'id_proyek': c.id,
        'nama': c.namaProject,
        'lokasi': c.lokasi,
        'kategori': c.kategori,
      };

  static String encode(List<Project> c) => json.encode(
        c.map<Map<String, dynamic>>((proyek) => Project.toMap(proyek)).toList(),
      );

  static List<Project> decode(String proyek) =>
      (json.decode(proyek) as List<dynamic>)
          .map<Project>((item) => Project.fromJson(item))
          .toList();
}
