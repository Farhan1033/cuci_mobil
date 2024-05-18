import 'package:cuci_mobil/model/model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Konten extends StatefulWidget {
  final CarWash carWash;

  Konten(this.carWash);

  @override
  _KontenState createState() => _KontenState();
}

class _KontenState extends State<Konten> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context, widget.carWash),
          _isiKonten(context, widget.carWash)
        ],
      ),
    ));
  }

  Widget _header(BuildContext context, CarWash carWash) {
    return SizedBox(
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                image: NetworkImage(carWash.imgUrl), fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.only(top: 28.0, left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(25)),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(25)),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(25)),
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _isiKonten(BuildContext context, CarWash carWash) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: 120,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    "Car Washing",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  )),
                ),
              ),
              SizedBox(
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
                          carWash.ratingTempat,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
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
                  carWash.namaTempat,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  carWash.alamatTempat,
                  style: TextStyle(fontSize: 16.0),
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
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpandableText(
                  carWash.about,
                  expandText: 'Selengkapnya',
                  collapseText: 'Sembunyikan',
                  maxLines: 5,
                  linkColor: Colors.green,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
