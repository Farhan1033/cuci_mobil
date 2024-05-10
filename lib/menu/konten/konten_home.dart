import 'package:flutter/material.dart';

class Konten extends StatefulWidget {
  const Konten({super.key});

  @override
  State<Konten> createState() => _KontenState();
}

class _KontenState extends State<Konten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListTile(
          leading: SizedBox(
            height: 100,
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://img.freepik.com/free-photo/beautiful-car-washing-service_23-2149212221.jpg?t=st=1715257802~exp=1715261402~hmac=8b9cb8fa19b62d42397c834277357c1f047029870044bbf7ae150377b8b3e330&w=740"),
                      fit: BoxFit.cover)),
            ),
          ),
          title: Text("Berkah Wash Car"),
          subtitle: Row(
            children: [Icon(Icons.star, color: Colors.yellow), Text("4.5")],
          ),
        );
      },
    ));
  }
}
