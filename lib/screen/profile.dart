import 'package:cuci_mobil/model/model_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            toolbarHeight: 0,
          ),
        ),
        body: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter, child: _gambarProfile(context))
          ],
        ));
  }

  Widget _gambarProfile(BuildContext context) {
    UserModel userModel = UserModel_List[1];
    return ClipRRect(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(userModel.imgProfile),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  border: Border.all(
                      color: Colors.greenAccent,
                      width: 3,
                      style: BorderStyle.solid)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              userModel.namaUser,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,),
            ),
          ],
        ),
      ),
    );
  }
}
