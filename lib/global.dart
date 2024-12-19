library my_prj.globals;

import 'package:cms_company_profile/class/gambar.dart';
import 'package:cms_company_profile/class/project.dart';
import 'package:cms_company_profile/class/contact.dart';

String selectedPage = "portfolio";
Project proyekTerpilih =
    Project(id: 0, namaProject: "", lokasi: "", kategori: "");
bool loggedIn = false;

List<Project> listProject = [];

List<Gambar> listGambar = [];

List<Contact> listContact = [
  // Contact(
  //     id: 1, fullname: "sutoyo", email: "sutoyo@gmail.com", message: "Halo"),
  // Contact(
  //     id: 2,
  //     fullname: "udin",
  //     email: "udin@gmail.com",
  //     message:
  //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pellentesque lorem eu blandit aliquam. Morbi faucibus commodo sapien, id feugiat nisl consectetur quis. Cras tincidunt vel sapien ac congue. Morbi velit ipsum, maximus id tristique at, dictum quis tellus. Aenean non erat sed magna laoreet lacinia eget id odio. Morbi molestie erat varius tortor volutpat tempor. Morbi tempor, quam at rhoncus accumsan, nulla justo tempor diam, sit amet volutpat turpis tellus ut felis. Aliquam pulvinar tincidunt mauris. Pellentesque eget semper quam, vel semper nibh. Maecenas ut ex ut felis gravida blandit.")
];
