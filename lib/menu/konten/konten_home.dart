import 'package:cuci_mobil/menu/booking.dart';
import 'package:flutter/material.dart';

class Konten extends StatefulWidget {
  const Konten({Key? key}) : super(key: key);

  @override
  State<Konten> createState() => _KontenState();
}

class _KontenState extends State<Konten> {
  String _selectedOption = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerSection(),
          _infoSection(),
          _optionsSection(),
          Spacer(),
          _bookingButton(),
        ],
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
          _buildIconButton(Icons.arrow_back_sharp, () => Navigator.pop(context)),
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

  Widget _optionsSection() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          _optionButton("About"),
          _optionButton("Review"),
        ],
      ),
    );
  }

  Widget _optionButton(String option) {
    return GestureDetector(
      onTap: () => setState(() => _selectedOption = option),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 80,
            color: _selectedOption == option ? Colors.green : Colors.transparent,
            child: Center(child: Text(option)),
          ),
          _selectedOption.isNotEmpty
              ? Text(_selectedOption)
              : Container(),
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