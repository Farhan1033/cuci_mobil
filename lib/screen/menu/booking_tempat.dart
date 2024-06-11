import 'package:cuci_mobil/controller/auth_services.dart';
import 'package:cuci_mobil/model/list_cucimobil.dart';
import 'package:cuci_mobil/screen/menu/struk_booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Booking_tempat extends StatefulWidget {
  final String namaTempat;
  final String alamatTempat;

  Booking_tempat({required this.namaTempat, required this.alamatTempat});

  @override
  State<Booking_tempat> createState() => _Booking_tempatState();
}

class _Booking_tempatState extends State<Booking_tempat> {
  var _idPilihan = 0;
  String _jeniscuci = "";
  var _harga = 0;
  var _counter = 0;
  FocusNode _focusNode = FocusNode();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _numberFocusNode = FocusNode();
  final _dateController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  void dispose() {
    _dateController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

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
            _showAlertPilihan(context);
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

  Widget _alertPilihan(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
          Text('Konfirmasi Pendaftaran'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Aksi jika setuju
            Navigator.of(context).pop(true);
          },
          child: Text('Setuju'),
        ),
        TextButton(
          onPressed: () {
            // Aksi jika tidak setuju
            Navigator.of(context).pop(false);
          },
          child: Text('Tidak Setuju'),
        ),
      ],
    );
  }

  void _showAlertPilihan(BuildContext context) async {
  final String placeName = widget.namaTempat;
  final String placeAddress = widget.alamatTempat;

  if (_nameController.text.isEmpty ||
      _numberController.text.isEmpty ||
      _dateController.text.isEmpty ||
      _idPilihan == 0) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Peringatan'),
          content: Text('Harap isi semua field terlebih dahulu.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertPilihan(context);
      },
    );

    if (result == true) {
      try {
        // Debugging: Print values to console
        print('Name: ${_nameController.text}');
        print('Number: ${_numberController.text}');
        print('Date: ${_dateController.text}');
        print('Place Name: $placeName');
        print('Place Address: $placeAddress');

        // Ensure setState doesn't block async call
        setState(() {
          _counter++;
        });

        await AuthService.saveBookingToFirebase(
          _nameController.text,
          _numberController.text,
          _dateController.text,
          _jeniscuci,
          _harga.toDouble(),
          _counter,
          placeName,
          placeAddress,
        );

        // Navigation after saving data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StruckBooking(
              namaTempat: placeName,
              alamatTempat: placeAddress,
              tanggalBooking: _dateController.text,
              namaUser: _nameController.text,
              nomorUser: _numberController.text,
              jenisCuci: _jeniscuci,
              hargaCuci: _harga.toString(),
            ),
          ),
        );

      } catch (e) {
        print('Error saving booking: ${e.toString()}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to save booking: ${e.toString()}'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
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
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  decoration: InputDecoration(
                    hintText: "Masukkan Nama Anda",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _nameFocusNode.hasFocus
                            ? Colors.green
                            : Colors.green,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
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
                  controller: _numberController,
                  focusNode: _numberFocusNode,
                  decoration: InputDecoration(
                    hintText: "Masukkan No. Telepon",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _numberFocusNode.hasFocus
                            ? Colors.green
                            : Colors.green,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _pilihTanggal(context),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _pilihTanggal(BuildContext context) {
    return Container(
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
            width: 180,
            child: TextField(
              controller: _dateController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                prefixIconColor: Colors.green,
                hintText: "Pilih Tanggal",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              readOnly: true,
              onTap: () async {
                await _selectDate(context);
                _focusNode.unfocus();
              },
            ),
          ),
        ],
      ),
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
                  _jeniscuci = selected ? a.label : "";
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
