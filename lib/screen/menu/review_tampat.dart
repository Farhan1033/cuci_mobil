import 'package:cuci_mobil/model/model_user.dart';
import 'package:flutter/material.dart';

class ReviewTempatFull extends StatelessWidget {
  const ReviewTempatFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Penilaian'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: UserModel_List.length,
        itemBuilder: (context, index) {
          UserModel user = UserModel_List[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user.imgProfile),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.namaUser,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < user.ratingUser
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    user.komenUser,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
