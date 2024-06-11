import 'package:cuci_mobil/model/model_user.dart';
import 'package:cuci_mobil/screen/menu/booking_tempat.dart';
import 'package:cuci_mobil/screen/menu/review_tampat.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Konten extends StatefulWidget {
  final String ownerName;
  final String ownerNumber;
  final String about;
  final String placeAddress;
  final String placeName;
  final String placeRating;
  final String placeReview;
  final String carWashImageUrl;

  Konten(
      {required this.ownerName,
      required this.ownerNumber,
      required this.about,
      required this.placeAddress,
      required this.placeName,
      required this.placeRating,
      required this.placeReview,
      required this.carWashImageUrl});

  @override
  _KontenState createState() => _KontenState();
}

class _KontenState extends State<Konten> {
  bool isFavorited = false;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          toolbarHeight: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(context),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isiKonten(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: tombolBooking(context),
    );
  }

  Widget _header(
    BuildContext context,
  ) {
    return SizedBox(
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            image: NetworkImage(widget.carWashImageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorited =
                              !isFavorited; // Toggle the favorite state
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: isFavorited
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    key: ValueKey('red'),
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    size: 20,
                                    color: Colors.white,
                                    key: ValueKey('white'),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        // Add share functionality here
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoKontak(
    BuildContext context,
  ) {
    return Container(
      height: 90,
      width: 450,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 2))
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(widget.carWashImageUrl),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.ownerName,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.ownerNumber,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _isiKonten(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 40,
                width: 120,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    "Car Washing",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 40,
                width: 170,
                child: Container(
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          widget.placeRating.toString() +
                              " " +
                              widget.placeReview +
                              " Ulasan",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.placeName,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.placeAddress,
                style: TextStyle(fontSize: 14.0),
              )
            ],
          ),
        ),
        Divider(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Deskripsi",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              ExpandableText(
                widget.about,
                expandText: 'Selengkapnya',
                collapseText: 'Sembunyikan',
                maxLines: 5,
                linkColor: Colors.green,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Kontak",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        _infoKontak(context),
        SizedBox(
          height: 20,
        ),
        _review(context)
      ],
    );
  }

  Widget _review(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Penilian Tempat",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                    _nilaiReview(context)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewTempatFull(),
                        ));
                  });
                },
                child: Container(
                  height: 25,
                  child: Center(
                    child: Text(
                      "Lihat Semua >",
                      style: TextStyle(color: Colors.green, fontSize: 14.0),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            height: 20,
          ),
          _komenUser(context)
        ],
      ),
    );
  }

  Widget _komenUser(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: UserModel_List.map((userModel) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 2),
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 3,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userModel.imgProfile),
                    radius: 25,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.namaUser,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: userModel.ratingUser,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 18,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              userModel.ratingUser = rating;
                            });
                          },
                        ),
                        SizedBox(height: 5),
                        Text(
                          userModel.komenUser,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _nilaiReview(BuildContext context) {
    double _rating = double.parse(widget.placeRating);
    return Row(
      children: [
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemSize: 15,
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
        SizedBox(
          width: 5,
        ),
        Text(widget.placeRating.toString() + "/5 " + widget.placeReview)
      ],
    );
  }

  Widget tombolBooking(BuildContext context) {
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
              MaterialPageRoute(
                  builder: (context) => Booking_tempat(
                      namaTempat: widget.placeName,
                      alamatTempat: widget.placeAddress)),
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
}
