import 'dart:io';

import 'package:cuci_mobil/controller/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class CarWashForm extends StatefulWidget {

  @override
  _CarWashFormState createState() => _CarWashFormState();
}

class _CarWashFormState extends State<CarWashForm> {
  final _formKey = GlobalKey<FormState>();
  final ownerNameController = TextEditingController();
  final ownerNumberController = TextEditingController();
  final placeNameController = TextEditingController();
  final placeAddressController = TextEditingController();
  final placeRatingController = TextEditingController();
  final placeReviewController = TextEditingController();
  final aboutController = TextEditingController();
  String? gambarPATH1;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  Future getDataFromFirestore() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        userId = currentUser.uid;

        DocumentSnapshot documentSnapshot =
            await _firestore.collection('users').doc(userId).get();
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;

        String name = userData['nama_user'];
        String nomor = userData['nomor_telfon'];

        ownerNameController.text = name;
        ownerNumberController.text = nomor;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat mengambil data.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataFromFirestore();
    super.initState();
  }

  Future<void> saveDataToFirestore() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firestore.collection('car_wash_places').add({
          'owner_name': ownerNameController.text,
          'owner_number': ownerNumberController.text,
          'place_name': placeNameController.text,
          'place_address': placeAddressController.text,
          'about': aboutController.text,
          'gambar_cuci_mobil': gambarPATH1,
          'place_rating': '0',
          'place_review': "0",
          'user_id': userId,
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Data berhasil disimpan.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Terjadi kesalahan saat menyimpan data.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Tempat Cuci Mobil')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: ownerNameController,
                decoration: InputDecoration(labelText: 'Nama Pemilik'),
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Pemilik wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ownerNumberController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Nomor Pemilik'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nomor Pemilik wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: placeNameController,
                decoration: InputDecoration(labelText: 'Nama Tempat'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Tempat wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: placeAddressController,
                decoration: InputDecoration(labelText: 'Alamat Tempat'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Alamat Tempat wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: aboutController,
                decoration: InputDecoration(labelText: 'Tentang Tempat'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tentang Tempat wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  gambarPATH1 != null
                      ? Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(gambarPATH1!)),
                          ),
                        )
                      : Container(
                          height: 300,
                          width: 300,
                          child: Center(child: Text('No image selected')),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        File selectedFile = await getImage();
                        String uploadedPath =
                            await AuthService.uploadGambar(selectedFile);
                        setState(() {
                          gambarPATH1 = uploadedPath;
                        });
                      } catch (e) {
                        // Handle the exception, e.g., show an error message
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to upload image: $e')));
                      }
                    },
                    child: Text('Pilih Gambar'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    saveDataToFirestore();

                    Navigator.pop(context);
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
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
}
