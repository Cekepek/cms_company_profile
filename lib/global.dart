library my_prj.globals;

import 'package:cms_company_profile/class/gambar.dart';
import 'package:cms_company_profile/class/project.dart';

String selectedPage = "portfolio";
int proyekTerpilih = 0;

List<Project> listProject = [
  Project(id: 1, namaProject: "Test 1", lokasi: "Test 1 Lokasi"),
  Project(id: 2, namaProject: "Test 2", lokasi: "Test 2 Lokasi")
];

List<Gambar> listGambar = [
  Gambar(id: 1, path: "images/1.jpg", id_proyek: 1),
  Gambar(id: 2, path: "images/2.jpg", id_proyek: 1),
  Gambar(id: 3, path: "images/COVER.jpg", id_proyek: 1)
];
