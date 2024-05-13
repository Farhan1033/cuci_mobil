import 'package:cuci_mobil/menu/booking.dart';
import 'package:cuci_mobil/menu/konten/options_konten/about.dart';
import 'package:cuci_mobil/menu/konten/options_konten/review.dart';
import 'package:flutter/material.dart';

class Konten extends StatefulWidget {
  const Konten({Key? key}) : super(key: key);

  @override
  State<Konten> createState() => _KontenState();
}

class _KontenState extends State<Konten> {
  int pilihan = 0;
  List options = [About_konten(), Review_konten()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSection(),
            _infoSection(),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(right: 200.0),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            pilihan = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: pilihan == 0
                                ? Color.fromRGBO(139, 219, 154, 1)
                                : Colors.transparent,
                          ),
                          child: Center(
                              child: Text("About",
                                  style: TextStyle(color: pilihan == 0
                                          ? Colors.white
                                          : Colors.black),
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            pilihan = 1;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            color: pilihan == 1
                                ? Color.fromRGBO(139, 219, 154, 1)
                                : Colors.transparent,
                          ),
                          child: Center(
                              child: Text("Review",
                                  style: TextStyle(
                                      color: pilihan == 1
                                          ? Colors.white
                                          : Colors.black),
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(color: Colors.yellow),
              child: options[pilihan],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: _bookingButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerSection() {
    return Container(
      height: 290,
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(
              Icons.arrow_back_sharp, () => Navigator.pop(context)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildIconButton(Icons.favorite, () {}),
                const SizedBox(width: 20),
                _buildIconButton(Icons.share, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSection() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoCard("Car Washing", Colors.white, FontWeight.bold),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text("4.5 (500 Reviewer)", style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookingButton() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Booking()),
      ),
      child: Center(
        child: Container(
          height: 60,
          width: 350,
          decoration: BoxDecoration(
            color: Color.fromRGBO(139, 219, 154, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "BOOKING NOW",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, Color color, FontWeight fontWeight) {
    return Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
        color: Color.fromRGBO(139, 219, 154, 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: color, fontWeight: fontWeight),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
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
}
