import 'package:cuci_mobil/menu/booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        child: AppBar(toolbarHeight: 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 290,
              color: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(Icons.arrow_back_sharp, () {
                    Navigator.pop(context);
                  }),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildIconButton(Icons.favorite, () {
                          // Do something when favorite icon is tapped
                        }),
                        SizedBox(
                          width: 20,
                        ),
                        _buildIconButton(Icons.share, () {
                          // Do something when share icon is tapped
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(139, 219, 154, 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Car Washing",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          "4.5 (500 Reviewer)",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama tempat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Alamat lengkap",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  441, // Adjust the height according to your needs
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _buttonBooking(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(icon),
      ),
    );
  }

  Widget _buttonBooking(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Booking(),
              ));
        });
      },
      child: Center(
        child: SizedBox(
          height: 60,
          width: 350,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "BOOKING NOW",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
