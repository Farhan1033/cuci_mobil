import 'package:cuci_mobil/controller/auth_services.dart';
import 'package:cuci_mobil/login%20dan%20register/login_page.dart';
import 'package:cuci_mobil/model/model_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _gambarProfile(userModel),
            SizedBox(height: 16),
            Text(
              userModel.namaUser,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32),
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
                    icon: Icons.photo_camera,
                    title: "Ubah Gambar",
                    onTap: () {
                      // Implementasi untuk mengubah gambar
                    },
                  ),
                  Divider(),
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
                      // Implementasi untuk membuka tempat cuci
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
                  Divider(),
                  _buildMenuOption(
                    icon: Icons.info,
                    title: "About",
                    onTap: () {
                      // Implementasi untuk melihat tentang aplikasi
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gambarProfile(UserModel userModel) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(75.0),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(userModel.imgProfile),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
          color: Colors.blue,
          border: Border.all(
            color: Colors.greenAccent,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(
      {required IconData icon,
      required String title,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }
}
