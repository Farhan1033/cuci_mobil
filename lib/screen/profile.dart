import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuci_mobil/controller/auth_services.dart';
import 'package:cuci_mobil/login%20dan%20register/login_page.dart';
import 'package:cuci_mobil/model/model_user.dart';
import 'package:cuci_mobil/screen/menu/buka_tempat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? gambarPATH1;
  User? currentUser = FirebaseAuth.instance.currentUser;
  late String userId;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          toolbarHeight: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _gambarProfile(userModel),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuOption(
                      icon: Icons.edit,
                      title: "Ubah Informasi",
                      onTap: () {
                        // Implementasi untuk mengubah informasi
                      },
                    ),
                    Divider(),
                    _buildMenuOption(
                      icon: Icons.local_car_wash,
                      title: "Buka Tempat Cuci",
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarWashForm(),
                              ));
                        });
                      },
                    ),
                    Divider(),
                    _buildMenuOption(
                      icon: Icons.favorite,
                      title: "Favorite",
                      onTap: () {
                        // Implementasi untuk melihat tentang aplikasi
                      },
                    ),
                    Divider(),
                    _buildMenuOption(
                      icon: Icons.info,
                      title: "About",
                      onTap: () {
                        // Implementasi untuk melihat tentang aplikasi
                      },
                    ),
                    Divider(),
                    _buildMenuOption(
                      icon: Icons.logout,
                      title: "Logout",
                      onTap: () async {
                        try {
                          await AuthService.signOut();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gambarProfile(UserModel userModel) {
    return Column(
      children: [
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
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(profileImage),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
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
                          shape: BoxShape.circle,
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
        SizedBox(height: 16),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Text(" ");
              }
              return Column(
                children: [
                  Text(
                    snapshot.data?.get("nama_user"),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    snapshot.data?.get("email"),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
            }),
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
              _updateData(gambarPATH1!);
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
      ],
    );
  }

  void getData() async {
    loading = true;
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userId = currentUser.uid;
    }
    loading = false;
  }

  Widget _buildMenuOption(
      {required IconData icon,
      required String title,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      onTap: onTap,
      hoverColor: Colors.grey[100],
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _updateData(String newData) async {
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'gambarProfile': FieldValue.arrayUnion([newData]),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data updated successfully')),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update data: $e')),
        );
      }
    }
  }
}
