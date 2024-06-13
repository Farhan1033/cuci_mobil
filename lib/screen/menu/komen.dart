import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuci_mobil/controller/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Komen extends StatefulWidget {
  final String placeName;

  Komen({required this.placeName});

  @override
  State<Komen> createState() => _KomenState();
}

class _KomenState extends State<Komen> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  int _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Komen"),
          leading: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
            child: _formRating(context),
          ),
        ));
  }

  Widget _buildRatingStar(int index) {
    return IconButton(
        iconSize: 40.0,
        icon: Icon(
          index < _rating ? Icons.star : Icons.star_border,
        ),
        color: Colors.amber,
        onPressed: () {
          setState(
            () {
              _rating = index + 1;
            },
          );
        });
  }

  Widget _formRating(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Beri Rating:',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildRatingStar(index)),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: _commentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Tulis komentar Anda',
                    hintText: 'Masukkan komentar di sini',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Komentar tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      if (_rating == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Rating tidak boleh kosong')),
                        );
                      } else {
                        // Anda bisa menambahkan logika pengiriman komentar dan rating di sini
                        User? currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser != null) {
                          try {
                            await FirebaseFirestore.instance
                                .collection('komen_user')
                                .add({
                              'userId': currentUser.uid,
                              'rating': _rating,
                              'komen': _commentController.text,
                              'timestamp': FieldValue.serverTimestamp(),
                              'namaTempat': widget.placeName
                            });
                            await AuthService.updateAverageRating(
                                widget.placeName);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Komentar dan rating terkirim')),
                            );
                          } catch (e) {
                            print(e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Gagal mengirim komentar: ${e.toString()}')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Pengguna tidak terautentikasi')),
                          );
                        }
                      }
                    }
                  },
                  child: Text(
                    'Kirim',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
