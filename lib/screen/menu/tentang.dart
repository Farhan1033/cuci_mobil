import 'package:flutter/material.dart';

class Tentang extends StatelessWidget {
  const Tentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/wepik-duotone-modern-car-wash-company-logo-20231219095102CRXZ 1.png"),
                    opacity: 0.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  """
                Car Wash adalah aplikasi cuci mobil terdepan yang menawarkan kemudahan, kenyamanan, dan kualitas terbaik langsung ke lokasi Anda. Dengan Car Wash, pengguna dapat memesan layanan cuci mobil hanya dengan beberapa ketukan jari, menghemat waktu dan tenaga tanpa harus mengunjungi tempat cuci mobil fisik. Dirancang untuk memenuhi kebutuhan pemilik kendaraan yang sibuk, Car Wash memberikan berbagai pilihan layanan mulai dari cuci dasar hingga detailing premium.""",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Kelompok :",
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '''1. Eka Rahma Agustina (22SA11A069)
2. Anggie Maesyaroh (22SA11A086)
3. Frisda Puspa Salsabilla (22SA11A006)
4. Alfi Permana Putra (22SA11A020)
5. ⁠Mahmudi (22SA11A289)''',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Pembagian Tugas",
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '''
1. Login dan Register : Alfi, Elsa
2. Home page : Eka, Anggie
3. History booking : Elsa, Alfi
4. Profile : Anggie, Mudi
5. Detail booking : Mudi, Eka''',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
