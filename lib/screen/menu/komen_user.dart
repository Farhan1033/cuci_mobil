import 'package:cuci_mobil/main.dart';
import 'package:cuci_mobil/screen/menu/komen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class KomenUser extends StatefulWidget {
  final String namaTempat;
  final String alamatTempat;
  final String tanggalBooking;
  final String namaUser;
  final String nomorUser;
  final String jenisCuci;
  final String hargaCuci;

  KomenUser(
      {required this.namaTempat,
      required this.alamatTempat,
      required this.tanggalBooking,
      required this.namaUser,
      required this.nomorUser,
      required this.jenisCuci,
      required this.hargaCuci});

  @override
  State<KomenUser> createState() => _KomenUserState();
}

class _KomenUserState extends State<KomenUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/wepik-duotone-modern-car-wash-company-logo-20231219095102CRXZ 1.png"))),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 2.0,
                        color: Colors.green,
                        style: BorderStyle.solid)),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _text(
                              isiText: "Data Booking Antrian",
                              ukuranFont: 20.0,
                              boldFont: FontWeight.bold),
                          _text(
                            isiText: "Silahkan Memeriksa Di bawah Ini",
                            ukuranFont: 12.0,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _textContainer(
                        isiText: "Tempat Booking",
                        ukuranFont: 12.0,
                        boldFont: FontWeight.bold,
                        isiText2: widget.namaTempat,
                        ukuranFont2: 12.0),
                    _textContainer(
                        isiText: "Lokasi Alamat",
                        ukuranFont: 12.0,
                        boldFont: FontWeight.bold,
                        isiText2: widget.alamatTempat,
                        ukuranFont2: 12.0),
                    _textContainer(
                        isiText: "Tanggal Booking",
                        ukuranFont: 12.0,
                        boldFont: FontWeight.bold,
                        isiText2: widget.tanggalBooking,
                        ukuranFont2: 12.0),
                    _textContainer(
                        isiText: "Nama Pengguna",
                        ukuranFont: 12.0,
                        boldFont: FontWeight.bold,
                        isiText2: widget.namaUser,
                        ukuranFont2: 12.0),
                    _textContainer(
                        isiText: "No.Telepon",
                        ukuranFont: 12.0,
                        boldFont: FontWeight.bold,
                        isiText2: widget.nomorUser,
                        ukuranFont2: 12.0),
                    _textContainer(
                        isiText: "Jenis Cuci Mobil",
                        ukuranFont: 12.0,
                        boldFont: FontWeight.bold,
                        isiText2: widget.jenisCuci,
                        ukuranFont2: 12.0),
                    _textContainer(
                        isiText: "Harga",
                        ukuranFont: 12.0,
                        boldFont: FontWeight.bold,
                        isiText2: widget.hargaCuci,
                        ukuranFont2: 12.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonHome(context),
    );
  }

  Widget _buttonHome(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 60,
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Back",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Komen(placeName: widget.namaTempat),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Nilai Tempat Cuci",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _text(
      {required String isiText,
      required double ukuranFont,
      FontWeight? boldFont}) {
    return Text(
      isiText,
      style: TextStyle(fontSize: ukuranFont, fontWeight: boldFont),
    );
  }

  Widget _textContainer(
      {required String isiText,
      required String isiText2,
      required double ukuranFont,
      required double ukuranFont2,
      FontWeight? boldFont,
      FontWeight? boldFont2}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isiText,
            style: TextStyle(fontSize: ukuranFont, fontWeight: boldFont),
          ),
          Text(
            isiText2,
            style: TextStyle(fontSize: ukuranFont2, fontWeight: boldFont2),
          ),
        ],
      ),
    );
  }
}
