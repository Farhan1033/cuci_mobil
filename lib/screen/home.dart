import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuci_mobil/controller/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cuci_mobil/screen/konten/konten_home.dart';
import 'package:cuci_mobil/model/carwash.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double currentPageValue = 0;
  PageController controller = PageController(initialPage: 0);
  TextEditingController cariController = TextEditingController();
  Timer? _timer;
  bool _isFading = false;
  List<CarWash> list = [];
  List<CarWash> originalList = [];
  bool search = false;
  Widget? searchNamaTempat = Text("Tempat Cuci Mobil");
  double selectedRating = 0.0;

  Stream<QuerySnapshot>? categoryStream;

  @override
  void initState() {
    super.initState();
    getData();
    getontheload();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  getontheload() async {
    categoryStream = await AuthService().getProduct();
    setState(() {});
  }

  void _startAutoScroll() {
    if (list.length < 2) {
      print("Not enough items in the list to start auto-scrolling.");
      return;
    }

    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      final topThreeImages = list.sublist(
          0, 2); // This will now always succeed due to the check above

      if (controller.page!.round() == topThreeImages.length - 1) {
        setState(() {
          _isFading = true;
        });
        await Future.delayed(Duration(milliseconds: 500));
        controller.jumpToPage(0);
        setState(() {
          _isFading = false;
        });
      } else {
        controller.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  late String userId;
  bool loading = true;

  void getData() async {
    loading = true;
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userId = currentUser.uid;
    }
    loading = false;
  }

  @override
  void dispose() {
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(toolbarHeight: 0),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          ListTile(
            title: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Text(" ");
                }
                return Text(
                  "Halo, ${snapshot.data!['nama_user']}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
              },
            ),
            subtitle: Text(
              "Ayo Bersihkan Mobilmu hari ini!",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          _gambarBergerak(context),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      onTap: () {
                        setState(() {
                          cariController.clear();
                          _resetList();
                        });
                      },
                      onChanged: (name) {
                        _searchName(name);
                      },
                      controller: cariController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Cari Cuci Mobil",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(139, 219, 154, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.tune, color: Colors.white),
                    onPressed: _showFilterDialog,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          allProduct()
        ],
      ),
    );
  }

  Widget _gambarBergerak(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isFading ? 0.0 : 1.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        height: 225,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          controller: controller,
          itemCount: list.length,
          itemBuilder: (context, index) {
            double different = index - currentPageValue;
            if (different < 0) {
              different *= 1;
            }
            different = min(1, different);
            final carWash = list[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Konten(
                          ownerName: carWash.ownerName,
                          ownerNumber: carWash.ownerNumber,
                          about: carWash.about,
                          placeAddress: carWash.placeAddress,
                          placeName: carWash.placeName,
                          placeRating: carWash.placeRating.toString(),
                          placeReview: carWash.placeReview.toString(),
                          carWashImageUrl: carWash.carWashImageUrl),
                    ),
                  );
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(carWash.carWashImageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          carWash.placeName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          carWash.placeAddress,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            wordSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget allProduct() {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text("Data tidak ditemukan"));
        } else {
          originalList = snapshot.data!.docs.map((doc) {
            return CarWash(
              ownerName: doc['owner_name'],
              ownerNumber: doc['owner_number'],
              about: doc['about'],
              placeAddress: doc['place_address'],
              placeName: doc['place_name'],
              placeRating: double.tryParse(doc['place_rating'].toString()),
              placeReview: doc['place_review'].toString(),
              carWashImageUrl: doc['gambar_cuci_mobil'],
            );
          }).toList();

          if (list.isEmpty || !search) {
            list = List.from(originalList);
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final carWash = list[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Konten(
                        ownerName: carWash.ownerName,
                        ownerNumber: carWash.ownerNumber,
                        about: carWash.about,
                        placeAddress: carWash.placeAddress,
                        placeName: carWash.placeName,
                        placeRating: carWash.placeRating.toString(),
                        placeReview: carWash.placeReview.toString(),
                        carWashImageUrl: carWash.carWashImageUrl,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(carWash.carWashImageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            carWash.placeName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            carWash.placeAddress,
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Text(
                                  "${carWash.placeRating!.toStringAsFixed(2)} (${carWash.placeReview} ulasan)"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Filter Berdasarkan Rating"),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pilih rating:"),
                  StatefulBuilder(
                    builder: (context, StateSetter setState) {
                      return Slider(
                        value: selectedRating,
                        min: 0.0,
                        max: 5.0,
                        divisions: 50,
                        label: selectedRating.toStringAsFixed(1),
                        onChanged: (double value) {
                          setState(() {
                            selectedRating = value;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _filterByRating();
                  },
                  child: Text("Terapkan"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetList();
                  },
                  child: Text("Tampilkan Semuanya"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _filterByRating() {
    setState(() {
      search = true;
      list = originalList.where((item) {
        final rating = item.placeRating;
        return rating == selectedRating;
      }).toList();
    });
  }

  void _searchName(String name) {
    setState(() {
      search = true;
      if (name.isEmpty) {
        _resetList();
      } else {
        list = originalList.where((item) {
          return item.placeName.toLowerCase().contains(name.toLowerCase());
        }).toList();
      }
      searchNamaTempat =
          name.isEmpty ? Text("Tempat Cuci Mobil") : Text("Hasil Pencarian");
    });
  }

  void _resetList() {
    setState(() {
      search = false;
      list = List.from(originalList);
      cariController.clear();
      searchNamaTempat = Text("Tempat Cuci Mobil");
    });
  }
}
