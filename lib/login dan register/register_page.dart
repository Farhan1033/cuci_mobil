import 'package:cuci_mobil/login%20dan%20register/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cuci_mobil/controller/auth_services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;
  String error = '';

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi berhasil!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email tidak valid')),
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _header(context),
                SizedBox(height: 16),
                _buildTextField(
                    judul: "Nama Lengkap",
                    controller: nameController,
                    iconData: Icon(Icons.person),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                _buildTextField(
                    judul: "Nomor Handphone",
                    controller: phoneController,
                    iconData: Icon(Icons.phone),
                    number: 13,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor handphone tidak boleh kosong';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                _buildTextField(
                    judul: "Email",
                    controller: emailController,
                    iconData: Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      } else if (!_isValidEmail(value)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                _buildPassText(
                  label: "Password",
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildPassText(
                  label: "Konfirmasi Password",
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buttonDaftar(context),
                SizedBox(height: 16),
                _footer(context)
              ],
            ),
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
            height: 96.5,
            width: 174.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/wepik-duotone-modern-car-wash-company-logo-20231219095102CRXZ 1.png",
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            "Anda Belum Terdaftar",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            "Isi informasi dibawah ini",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String judul,
      required TextEditingController controller,
      required Icon iconData,
      int? number,
      String? Function(String?)? validator}) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: controller,
        keyboardType:
            number != null ? TextInputType.number : TextInputType.text,
        inputFormatters: number != null
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(number),
              ]
            : [],
        decoration: InputDecoration(
          labelText: judul,
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: iconData,
          prefixIconColor: Colors.green,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green, width: 1.5)),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildPassText(
      {required String label,
      required TextEditingController controller,
      String? Function(String?)? validator}) {
    return SizedBox(
      height: 55,
      child: TextFormField(
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green, width: 1.5)),
        ),
        obscureText: _obsecureText,
        validator: validator,
      ),
    );
  }

  Widget _buttonDaftar(BuildContext context) {
    return SizedBox(
      width: 232,
      height: 46,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green)),
        onPressed: () async {
          try {
            if (_formKey.currentState!.validate()) {
              await AuthService.signUp(
                  nameController.text,
                  phoneController.text,
                  emailController.text,
                  confirmPasswordController.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            } else {
              final snackBar = SnackBar(
                content: Text('Email tidak valid'),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } catch (e) {
            print('Error saat mendaftar: $e');
            final snackBar = SnackBar(
              content: Text("Gagal Mendaftarkan Akun"),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Text(
          'DAFTAR',
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return Row(
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
            style: TextStyle(fontSize: 14.0, color: Colors.green),
          ),
        ),
      ],
    );
  }
}
