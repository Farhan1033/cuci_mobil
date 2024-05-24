import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cuci_mobil/konten/konten_home.dart';
import 'package:cuci_mobil/model/model.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
  List<CarWash> listRating = [];
  bool search = false;
  Widget? searchNamaTempat = Text("Tempat Cuci Mobil");
  double selectedRating = 0.0;

  @override
  void initState() {
    super.initState();
    listRating.addAll(CarWash_List);
    list.addAll(CarWash_List);
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      if (controller.page!.round() == CarWash_List.length - 1) {
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
        child: AppBar(
          toolbarHeight: 0,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          ListTile(
            title: Text(
              "Halo, ",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Ayo Bersihkan Mobilmu hari ini!",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          _gambarBergerak(context),
          SizedBox(
            height: 15,
          ),
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
                    onPressed: () {
                      _showFilterDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
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
                      builder: (context) => Konten(carWash),
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
                              image: NetworkImage(
                                carWash.imgUrl,
                              ),
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
                            carWash.namaTempat,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            carWash.alamatTempat,
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Text(carWash.reviewTempat.toString() +
                                  " " +
                                  carWash.ratingTempat),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
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
          itemCount: CarWash_List.length,
          itemBuilder: (context, index) {
            double different = index - currentPageValue;
            if (different < 0) {
              different *= 1;
            }
            different = min(1, different);
            final carWash = CarWash_List[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Konten(carWash),
                      ));
                });
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(carWash.imgUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            carWash.namaTempat,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            carWash.alamatTempat,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                wordSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
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
                  StatefulBuilder(builder: (context, State) {
                    return Slider(
                      value: selectedRating,
                      min: 0.0,
                      max: 5.0,
                      divisions: 50,
                      label: selectedRating.toStringAsFixed(1),
                      onChanged: (double value) {
                        State(() {
                          selectedRating = value;
                        });
                      },
                    );
                  }),
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
      list = CarWash_List.where((item) {
        final rating = item.reviewTempat;
        return rating == selectedRating;
      }).toList();
    });
  }

  void _searchName(String name) {
    setState(() {
      if (name.isEmpty) {
        _resetList();
      } else {
        list = CarWash_List.where((item) =>
                item.namaTempat.toLowerCase().contains(name.toLowerCase()))
            .toList();
      }
    });
    setState(() {
      searchNamaTempat =
          name.isEmpty ? Text("Tempat Cuci Mobil") : Text("Hasil Pencarian");
    });
  }

  void _resetList() {
    setState(() {
      list.clear();
      list.addAll(CarWash_List);
      cariController.clear();
    });
    setState(() {
      searchNamaTempat = Text("Tempat Cuci Mobil");
    });
  }
}
