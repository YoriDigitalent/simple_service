import 'package:flutter/material.dart';
import 'package:simple_service/src/api/api.dart';
import 'package:simple_service/src/model/model.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  Api _apiService = Api();
  late bool _isFieldNamaValid;
  late bool _isFieldEmailValid;
  late bool _isFieldTempatLahirValid;
  late bool _isFieldTanggalLahirValid;
  late bool _isFieldAlamatValid;
  late bool _isFieldNoHPValid;
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerTempatLahir = TextEditingController();
  TextEditingController _controllerTanggalLahir = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();
  TextEditingController _controllerNoHP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Form Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldNama(),
                _buildTextFieldEmail(),
                _buildTextFieldTempatLahir(),
                _buildTextFieldTanggalLahir(),
                _buildTextFieldAlamat(),
                _buildTextFieldNoHP(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (!_isFieldNamaValid ||
                          !_isFieldEmailValid ||
                          !_isFieldTempatLahirValid ||
                          !_isFieldTanggalLahirValid ||
                          !_isFieldAlamatValid ||
                          !_isFieldNoHPValid) {
                        var snackBar = SnackBar(
                          content: Text("Wajib Diisi"),
                        );
                        _scaffoldState.currentState!.showSnackBar(
                          snackBar,
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String nama = _controllerNama.text.toString();
                      String email = _controllerEmail.text.toString();
                      String tempatLahir =
                          _controllerTempatLahir.text.toString();
                      String tanggalLahir =
                          _controllerTanggalLahir.text.toString();
                      String alamat = _controllerAlamat.text.toString();
                      String noHP = _controllerNoHP.text.toString();
                      Bio profile = Bio(
                          nama: nama,
                          email: email,
                          tempatLahir: tempatLahir,
                          tanggalLahir: tanggalLahir,
                          alamat: alamat,
                          noHP: noHP);
                      _apiService.createBio(profile).then((isSuccess) {
                        setState(() => _isLoading = false);
                        if (isSuccess) {
                          Navigator.pop(_scaffoldState.currentState!.context);
                        } else {
                          _scaffoldState.currentState!.showSnackBar(SnackBar(
                            content: Text("Submit data failed"),
                          ));
                        }
                      });
                    },
                    child: Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldNama() {
    return TextField(
      controller: _controllerNama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Lengkap",
        errorText: _isFieldNamaValid == null || _isFieldNamaValid
            ? null
            : "Nama Lengkap wajib diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaValid) {
          setState(() => _isFieldNamaValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Alamat Email wajib diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldTempatLahir() {
    return TextField(
      controller: _controllerTempatLahir,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Tempat Lahir",
        errorText: _isFieldTempatLahirValid == null || _isFieldTempatLahirValid
            ? null
            : "Tempat Lahir wajib diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTempatLahirValid) {
          setState(() => _isFieldTempatLahirValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldTanggalLahir() {
    return TextField(
      controller: _controllerTanggalLahir,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: "Tanggal Lahir",
        errorText: _isFieldTanggalLahirValid == null || _isFieldTempatLahirValid
            ? null
            : "Tanggal Lahir wajib diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTanggalLahirValid) {
          setState(() => _isFieldTanggalLahirValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAlamat() {
    return TextField(
      controller: _controllerAlamat,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Alamat Rumah",
        errorText: _isFieldAlamatValid == null || _isFieldAlamatValid
            ? null
            : "Alamat Rumah wajib diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAlamatValid) {
          setState(() => _isFieldAlamatValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNoHP() {
    return TextField(
      controller: _controllerNoHP,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Nomor HP",
        errorText: _isFieldNoHPValid == null || _isFieldNoHPValid
            ? null
            : "Nomor Handphone wajib diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNoHPValid) {
          setState(() => _isFieldNoHPValid = isFieldValid);
        }
      },
    );
  }
}
