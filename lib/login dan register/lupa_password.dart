import 'package:cuci_mobil/login%20dan%20register/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your email to receive password reset instructions',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 55,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 1.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            _buttonReset(context)
          ],
        ),
      ),
    );
  }

  Widget _buttonReset(BuildContext context) {
    return SizedBox(
      width: 232,
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
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
