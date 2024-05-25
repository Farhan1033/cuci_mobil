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
          padding:
              const EdgeInsets.symmetric(vertical: 100.0, horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                width: 230,
                child: Column(
                  children: [
                    Container(
                      height: 193,
                      width: 349,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/wepik-duotone-modern-car-wash-company-logo-20231219095102CRXZ 1.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Login ke Akun Anda",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Halo, Selamat datang kembali Kami harap anda selalu baik baik saja",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 55,
                child: TextField(
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
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 55,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obsecureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
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
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implementasi lupa password
                  },
                  child: Text(
                    'Lupa Password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 232,
                height: 46,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  onPressed: () async {
                    try {
                     User? user = await AuthService.signIn(
                          emailController.text, passwordController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(user),
                          ));
                    } catch (e) {
                      print(e.toString());
                      return null;
                    }
                  },
                  child: Text(
                    'MASUK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
