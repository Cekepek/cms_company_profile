library my_prj.globals;

import 'package:cms_company_profile/class/gambar.dart';
import 'package:cms_company_profile/class/project.dart';
import 'package:cms_company_profile/class/contact.dart';

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

List<Contact> listContact = [
  Contact(
      id: 1, fullname: "sutoyo", email: "sutoyo@gmail.com", message: "Halo"),
  Contact(
      id: 2,
      fullname: "udin",
      email: "udin@gmail.com",
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pellentesque lorem eu blandit aliquam. Morbi faucibus commodo sapien, id feugiat nisl consectetur quis. Cras tincidunt vel sapien ac congue. Morbi velit ipsum, maximus id tristique at, dictum quis tellus. Aenean non erat sed magna laoreet lacinia eget id odio. Morbi molestie erat varius tortor volutpat tempor. Morbi tempor, quam at rhoncus accumsan, nulla justo tempor diam, sit amet volutpat turpis tellus ut felis. Aliquam pulvinar tincidunt mauris. Pellentesque eget semper quam, vel semper nibh. Maecenas ut ex ut felis gravida blandit.")
];
