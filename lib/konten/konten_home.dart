import 'package:cuci_mobil/menu/booking.dart';
import 'package:cuci_mobil/konten/options_konten/about.dart';
import 'package:cuci_mobil/konten/options_konten/review.dart';
import 'package:cuci_mobil/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Konten extends StatefulWidget {
  final CarWash carWash;

  Konten(this.carWash);

  @override
  _KontenState createState() => _KontenState();
}

class _KontenState extends State<Konten> {
  int _pilihan = 0;
  List<Widget> _options = [About_konten(), Review_konten()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerSection(context, widget.carWash),
                _infoSection(widget.carWash),
                _buildTabBar(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(color: Colors.yellow),
                  child: _options[_pilihan],
                ),
                SizedBox(height: 10),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildBottomButton(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
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
            _buildTabItem("About", 0),
            _buildTabItem("Review", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _pilihan = index;
          });
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: _pilihan == index
                ? Color.fromRGBO(139, 219, 154, 1)
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: _pilihan == index ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      height: 100,
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
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Booking()),
        ),
        child: Center(
          child: Container(
            height: 100,
            width: double.infinity,
            margin: EdgeInsets.all(16.0),
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
      ),
    );
  }

  Widget _headerSection(BuildContext context, CarWash carWash) {
    return Container(
      height: 290,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(
            Icons.arrow_back_sharp,
            () => Navigator.pop(context),
          ),
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(carWash.imgUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _infoSection(CarWash carWash) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoCard("Car Washing", Colors.white, FontWeight.bold),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text(carWash.ratingTempat, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 60,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carWash.namaTempat,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  carWash.alamatTempat,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
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
