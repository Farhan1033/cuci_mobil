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
            margin: EdgeInsets.symmetric(vertical: 7),
            height: 130,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 2.0,
                      color: Colors.grey,
                      spreadRadius: 2.0)
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
