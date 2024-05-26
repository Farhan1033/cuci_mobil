import 'package:cuci_mobil/login%20dan%20register/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void resetPassword(String email) async {
    if (email != "") {
      try {
        await _auth.sendPasswordResetEmail(email: email);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Reset Password Sudah Dikirim Ke Email Anda"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      });
                    },
                    child: Text("Oke, Saya Mengerti"))
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Email yang Anda Masukkan Tidak Valid"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Coba Lagi!"))
                ],
              );
            });
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Harap Masukkan Email Anda"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Oke, Saya Mengerti"))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            toolbarHeight: 0,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
          child: Column(
            children: [
              _header(context),
              SizedBox(
                height: 16.0,
              ),
              _buildTextField(context),
              SizedBox(
                height: 16.0,
              ),
              _buttonReset(context),
              SizedBox(
                height: 10.0,
              ),
              _buildBack(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 193,
            width: 349,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/lupaPass.png"),
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Masukkan Email untuk Reset Password',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Ciee Yang Lupa sama Passwordnya sendiri",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          setState(() {
            Navigator.pop(context);
          });
        },
        child: Text(
          "Back To Login",
          style: TextStyle(color: Colors.green, fontSize: 14.0),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.email),
          prefixIconColor: Colors.green,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buttonReset(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 180,
        height: 46,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green),
          ),
          onPressed: () async {
            resetPassword(_emailController.text);
          },
          child: Text(
            'Reset Password',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
