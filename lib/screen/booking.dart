import "package:flutter/material.dart";

class Booking extends StatelessWidget {
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
              children: [_cardBooking(context)],
            )));
  }

  Widget _cardBooking(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            height: 130,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
    );
  }
}
