import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuci_mobil/login%20dan%20register/lupa_password.dart';
import 'package:cuci_mobil/screen/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:cuci_mobil/controller/auth_services.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obsecureText = true;
  String error = '';
  final _formkey1 = GlobalKey<FormState>();

  bool _isValidEmail(String value) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
    );
    return emailRegex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          toolbarHeight: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
          child: Column(
            children: [
              _header(context),
              SizedBox(height: 20),
              _formEmaildanPassword(context),
              SizedBox(height: 16),
              _buttonLupaPassword(context),
              SizedBox(height: 16),
              _buttonLogin(context),
              SizedBox(height: 16),
              _buttonRegister(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Column(
        children: [
          Container(
            height: 193,
            width: 349,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/wepik-duotone-modern-car-wash-company-logo-20231219095102CRXZ 1.png"),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Login ke Akun Anda",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            "Halo, Selamat datang kembali Kami harap anda selalu baik baik saja",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _formEmaildanPassword(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: TextFormField(
            controller: emailController,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email anda kosong";
              } else if (!_isValidEmail(value)) {
                return "Email tidak valid";
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 55,
          child: TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black),
              suffixIcon: IconButton(
                icon: Icon(
                  _obsecureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obsecureText = !_obsecureText;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green, width: 1.5),
              ),
            ),
            obscureText: _obsecureText,
            onChanged: (val) {
              setState(() {
                passwordController.text = val;
              });
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Jangan kosongi Password anda';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buttonLupaPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPasswordPage(),
                ));
          });
        },
        child: Text(
          'Lupa Password?',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return SizedBox(
      width: 232,
      height: 46,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.green),
        ),
        onPressed: () async {
          try {
            var user = await AuthService.signIn(
                emailController.text, passwordController.text);

            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(user),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Email atau kata sandi salah.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Terjadi kesalahan. Silakan coba lagi.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Text(
          'MASUK',
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Belum punya akun?',
          style: TextStyle(fontSize: 14.0),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          },
          child: Text(
            'Register',
            style: TextStyle(fontSize: 14.0, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
