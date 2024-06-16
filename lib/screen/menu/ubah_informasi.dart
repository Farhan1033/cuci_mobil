import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuci_mobil/controller/auth_services.dart';
import 'package:cuci_mobil/model/model_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UbahInfo extends StatefulWidget {
  @override
  State<UbahInfo> createState() => _UbahInfoState();
}

class _UbahInfoState extends State<UbahInfo> {
  final namaController = TextEditingController();
  final numberController = TextEditingController();
  final alamatController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  late String userId;
  String? gambarPATH1;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel_List[1];
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Informasi"),
        leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Column(
            children: [
              _gambarProfile(userModel),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                    elevation: MaterialStatePropertyAll(5)),
                onPressed: () async {
                  try {
                    File selectedFile = await getImage();
                    String uploadedPath =
                        await AuthService.uploadGambar(selectedFile);
                    setState(() {
                      gambarPATH1 = uploadedPath;
                    });
                    _updateDataGambar(gambarPATH1!);
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to upload image: $e')));
                  }
                },
                child: Text(
                  'Ganti Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _formUbah(
                  labelText: "Masukkan Nama Anda", controller: namaController),
              SizedBox(
                height: 15,
              ),
              _formUbah(
                  labelText: "Masukkan Nomor Anda",
                  nomor: TextInputType.number,
                  controller: numberController),
              SizedBox(
                height: 15,
              ),
              _formUbah(
                  labelText: "Masukkan Alamat Anda",
                  controller: alamatController),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      elevation: MaterialStatePropertyAll(5)),
                  onPressed: () async {
                    try {
                      _updateData(namaController.text, numberController.text,
                          alamatController.text);
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update data: $e')));
                    }
                  },
                  child: Text(
                    "Simpan Data",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _formUbah(
      {required String labelText,
      required TextEditingController controller,
      TextInputType? nomor}) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        keyboardType: nomor,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Widget _gambarProfile(UserModel userModel) {
    return Column(children: [
      StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('No profile data found');
            }
            var data = snapshot.data!.data() as Map<String, dynamic>;
            var profileImage = data['gambarProfile'] != null &&
                    (data['gambarProfile'] as List).isNotEmpty
                ? (data['gambarProfile'] as List).last
                : null;

            return profileImage != null
                ? Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(profileImage),
                            fit: BoxFit.cover),
                        border: Border.all(
                            color: Colors.green,
                            width: 1.5,
                            style: BorderStyle.solid)),
                  )
                : Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                            style: BorderStyle.solid)),
                    child: Icon(
                      Icons.person,
                      size: 125,
                      color: Colors.white,
                    ),
                  );
          }),
    ]);
  }

  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception('No image selected');
    }
  }

  void getData() async {
    loading = true;
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userId = currentUser.uid;
    }
    loading = false;
  }

  void _updateDataGambar(String newData) async {
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'gambarProfile': FieldValue.arrayUnion([newData]),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image data updated successfully')),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update image data: $e')),
        );
      }
    }
  }

  void _updateData(String nama, String nomor, String alamat) async {
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser!.uid).update(
            {'nama_user': nama, 'nomor_telfon': nomor, 'alamat_user': alamat});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data updated successfully')),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update image data: $e')),
        );
      }
    }
  }
}
