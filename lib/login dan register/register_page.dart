import 'package:cuci_mobil/login%20dan%20register/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cuci_mobil/controller/auth_services.dart'; // Import AuthService

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: 230,
                child: Column(
                  children: [
                    Container(
                      height: 96.5,
                      width: 174.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/wepik-duotone-modern-car-wash-company-logo-20231219095102CRXZ 1.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Anda Belum Terdaftar",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Isi informasi dibawah ini",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildTextField(
                  judul: "Nama Lengkap",
                  controller: nameController,
                  iconData: Icon(Icons.person)),
              SizedBox(height: 16),
              _buildTextField(
                  judul: "Nomor Handphone",
                  controller: phoneController,
                  iconData: Icon(Icons.phone)),
              SizedBox(height: 16),
              _buildTextField(
                  judul: "Email",
                  controller: emailController,
                  iconData: Icon(Icons.email)),
              SizedBox(height: 16),
              _buildPassText(label: "Password", controller: passwordController),
              SizedBox(height: 16),
              _buildPassText(
                  label: "Konfirmasi Password",
                  controller: confirmPasswordController),
              SizedBox(height: 16),
              SizedBox(
                width: 232,
                height: 46,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () async {
                    try {
                      await AuthService.signUp(
                          nameController.text,
                          phoneController.text,
                          emailController.text,
                          confirmPasswordController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } catch (e) {
                      print('Error saat mendaftar: $e');
                    }
                  },
                  child: Text(
                    'DAFTAR',
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
                    'Sudah punya akun?',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Masuk',
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

  Widget _buildTextField(
      {required String judul,
      required TextEditingController controller,
      required Icon iconData}) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: judul,
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: iconData,
          prefixIconColor: Colors.green,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green, width: 1.5)),
        ),
      ),
    );
  }

  Widget _buildPassText(
      {required String label, required TextEditingController controller}) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.key),
          prefixIconColor: Colors.green,
          suffixIcon: IconButton(
            icon: Icon(
              _obsecureText ? Icons.remove_red_eye : Icons.visibility_off,
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
              borderSide: BorderSide(color: Colors.green, width: 1.5)),
        ),
        obscureText: _obsecureText,
      ),
    );
  }
}
