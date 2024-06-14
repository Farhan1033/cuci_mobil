import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuci_mobil/model/userkomen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewTempatFull extends StatefulWidget {
  final String namaTempat;

  ReviewTempatFull({required this.namaTempat});

  @override
  State<ReviewTempatFull> createState() => _ReviewTempatFullState();
}

class _ReviewTempatFullState extends State<ReviewTempatFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Penilaian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('komen_user')
              .where('namaTempat', isEqualTo: widget.namaTempat)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("Belum ada penilaian"));
            } else {
              var originalList = snapshot.data!.docs.map((doc) {
                return userKomen(
                    komenUser: doc['komen'],
                    namaTempat: doc['namaTempat'],
                    ratingUser: doc['rating'],
                    userID: doc['userId'],
                    userEmail: doc['userEmail'],
                    userName: doc['userName']);
              }).toList();
        
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: originalList.length,
                itemBuilder: (context, index) {
                  var userModel = originalList[index];
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
                              radius: 25,
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              child: Icon(Icons.person),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userModel.userName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating:
                                        userModel.ratingUser.toDouble(),
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
                                        userModel.ratingUser == rating;
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
                },
              );
            }
          },
        ),
      ),
    );
  }
}
