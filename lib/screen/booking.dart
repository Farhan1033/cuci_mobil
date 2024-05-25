import "package:flutter/material.dart";

class Booking extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String bookingDate;
  final int jenisCuciId;
  final int harga;

  Booking({required this.name, required this.phoneNumber, required this.bookingDate, required this.jenisCuciId, required this.harga});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          toolbarHeight: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('No. Telepon: $phoneNumber', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Tanggal Booking: $bookingDate', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Jenis Cuci: $jenisCuciId', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Harga: $harga', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
