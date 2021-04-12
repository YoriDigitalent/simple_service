import 'dart:convert';

class Bio {
  int id;
  String nama;
  String email;
  String tempatLahir;
  String tanggalLahir;
  String alamat;
  String noHP;

  Bio(
      {this.id = 0,
      required this.nama,
      required this.email,
      required this.tempatLahir,
      required this.tanggalLahir,
      required this.alamat,
      required this.noHP});

  factory Bio.fromJson(Map<String, dynamic> map) {
    return Bio(
        id: map["id"],
        nama: map["nama"],
        email: map["email"],
        tempatLahir: map["tempatLahir"],
        tanggalLahir: map["tanggalLahir"],
        alamat: map["alamat"],
        noHP: map["noHP"]);
  } //constructor

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "email": email,
      "tempatLahir": tempatLahir,
      "tanggalLahir": tanggalLahir,
      "alamat": alamat,
      "noHP": noHP
    };
  } // konversi dari class model ke map

  @override
  String toString() {
    return 'Bio{id: $id, nama: $nama, email: $email, tempatLahir: $tempatLahir, tanggalLahir: $tanggalLahir, alamat: $alamat, noHP: $noHP}';
  }
}

List<Bio> bioFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Bio>.from(data.map((item) => Bio.fromJson((item))));
} // konversi respon dari API ke model

String bioToJson(Bio data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
} // konversi dari class model ke json format
