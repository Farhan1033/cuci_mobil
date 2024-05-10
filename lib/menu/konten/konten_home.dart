import 'package:flutter/material.dart';

class Konten extends StatefulWidget {
  const Konten({super.key});

  @override
  State<Konten> createState() => _KontenState();
}

class _KontenState extends State<Konten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              toolbarHeight: 0,
            )),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.arrow_back_sharp),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
