import "package:cloud_firestore/cloud_firestore.dart";
import "package:cuci_mobil/controller/auth_services.dart";
import "package:cuci_mobil/model/history.dart";
import "package:cuci_mobil/screen/menu/komen_user.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class Booking extends StatefulWidget {
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Stream<QuerySnapshot>? categoryStream;
  List<history> originalList = [];
  List<history> list = [];

  getontheload() async {
    categoryStream = await AuthService().getAntrian();
    setState(() {});
  }

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
            child: Stack(
              children: [_cardBooking()],
            )));
  }

  Widget _cardBooking() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('booking')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No bookings available'));
        }

        final bookings = snapshot.data!.docs;

        return ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = bookings[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KomenUser(
                          namaTempat: ds['namaTempat'],
                          alamatTempat: ds['alamatTempat'],
                          tanggalBooking: ds['bookingDate'],
                          namaUser: ds['name'],
                          nomorUser: ds['phoneNumber'],
                          jenisCuci: ds['jenisCuci'],
                          hargaCuci: ds['harga'].toString()),
                    ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 4.0,
                      color: Colors.grey.shade300,
                      spreadRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ds['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            ds['phoneNumber'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            ds['bookingDate'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            ds['jenisCuci'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Divider(
                            height: 20,
                            color: Colors.black,
                            thickness: 1,
                          ),
                          Text(
                            'Rp ${ds['harga']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
