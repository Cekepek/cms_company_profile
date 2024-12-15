import 'dart:convert';

class Contact {
  int id;
  String fullname;
  String email;
  String message;
  Contact({
    required this.id,
    required this.fullname,
    required this.email,
    required this.message,
  });

  factory Contact.fromJson(Map<String, dynamic> jsonData) {
    return Contact(
      id: jsonData['id_message'],
      fullname: jsonData['fullname'],
      email: jsonData['email'],
      message: jsonData['message'],
    );
  }

  static Map<String, dynamic> toMap(Contact c) => {
        'id_message': c.id,
        'fullname': c.fullname,
        'email': c.email,
        'message': c.message,
      };

  static String encode(List<Contact> c) => json.encode(
        c
            .map<Map<String, dynamic>>((contact) => Contact.toMap(contact))
            .toList(),
      );

  static List<Contact> decode(String contactUs) =>
      (json.decode(contactUs) as List<dynamic>)
          .map<Contact>((item) => Contact.fromJson(item))
          .toList();
}
