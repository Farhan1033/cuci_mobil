import 'package:cuci_mobil/model/list_cucimobil.dart';
import 'package:cuci_mobil/model/list_mobil.dart';
import 'package:flutter/material.dart';

class Booking_tempat extends StatefulWidget {
  const Booking_tempat({super.key});

  @override
  State<Booking_tempat> createState() => _Booking_tempatState();
}

class _Booking_tempatState extends State<Booking_tempat> {
  var _idSelected = 0;
  var _idPilihan = 0;
  var _harga = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("Booking"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textfieldBooking(context),
              Text(
                "Pilih Type Kendaraan",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              _pilihanTypeKendaraan(context),
              SizedBox(
                height: 10,
              ),
              Text(
                "Pilih Jenis Cuci",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              _jenisCuciMobil(context)
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonBooking(context),
    );
  }

  Widget _buttonBooking(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Booking_tempat()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
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

  Widget _textfieldBooking(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "Nama Lengkap",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 55.0,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Masukkan Nama Anda",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "No. Telepon",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 55.0,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Masukkan No. Telepon",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "Tanggal Booking",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 55.0,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Masukkan Tanggal Booking",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _pilihanTypeKendaraan(BuildContext context) {
    var listChoice = ListItem.listChoice;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          children: listChoice
              .map((e) => ChoiceChip(
                    label: Text(e.label),
                    selected: _idSelected == e.id,
                    selectedColor: Colors.green,
                    side: BorderSide(color: Colors.green, width: 1.5),
                    onSelected: (bool selected) => setState(() {
                      _idSelected = selected ? e.id : 0;
                    }),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _jenisCuciMobil(BuildContext context) {
    var _listPilihan = ListItemCuci.listPilihan;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          children: _listPilihan.map((a) {
            return ChoiceChip(
              label: Text(a.label),
              selected: _idPilihan == a.id,
              selectedColor: Colors.green,
              side: BorderSide(
                color: Colors.green,
                width: 1.5,
              ),
              onSelected: (bool selected) {
                setState(() {
                  _idPilihan = selected ? a.id : 0;
                  _harga = selected ? a.harga : 0;
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 16.0),
        Text(
          _harga > 0 ? 'Harga: $_harga' : 'Silakan pilih jenis cuci',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
