import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class About_konten extends StatefulWidget {
  const About_konten({Key? key}) : super(key: key);

  @override
  State<About_konten> createState() => _AboutState();
}

class _AboutState extends State<About_konten> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption =
                            'About'; // Memperbarui pilihan yang dipilih
                      });
                    },
                    child: SizedBox(
                      height: 50,
                      width: 80,
                      child: Container(
                        color: selectedOption == 'About'
                            ? Colors.green
                            : Colors.white.withOpacity(0),
                        child: Center(child: Text('About')),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption =
                            'Review'; // Memperbarui pilihan yang dipilih
                      });
                    },
                    child: SizedBox(
                      height: 50,
                      width: 80,
                      child: Container(
                        color: selectedOption == 'Review'
                            ? Colors.green
                            : Colors.white.withOpacity(0),
                        child: Center(child: Text('Review')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Menampilkan data berdasarkan pilihan yang dipilih
          selectedOption.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Selected Option: $selectedOption'),
                )
              : Container(),
        ],
      ),
    );
  }
}
