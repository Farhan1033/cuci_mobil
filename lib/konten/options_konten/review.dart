import 'package:flutter/material.dart';

class Review_konten extends StatelessWidget {
  const Review_konten({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  """Duis pharetra cursus magna, ac accumsan massa facilisis eget. Duis et blandit mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam vulputate ipsum ac aliquam sagittis. 
                  Duis pretium orci non tellus gravida mattis. Donec sed blandit justo, congue mollis nibh. Morbi ornare sagittis velit ut iaculis. Cras consequat, mauris laoreet semper feugiat, purus diam malesuada elit, 
                  at rutrum augue ipsum et augue. Ut et risus vehicula felis gravida ornare in eget turpis. Donec non dictum orci, at egestas risus.""",
                  textAlign: TextAlign.justify)
            ],
          ),
        ),
      ),
    );
  }
}