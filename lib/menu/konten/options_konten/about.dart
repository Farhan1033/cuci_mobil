import 'package:flutter/material.dart';

class About_konten extends StatelessWidget {
  const About_konten({super.key});

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
                  """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget nunc interdum, luctus purus at, mollis tellus. Sed laoreet lobortis lectus, non dictum purus facilisis in. Nunc interdum consequat pellentesque. 
                  Integer vulputate felis et egestas congue. Integer euismod vestibulum est id finibus. 
                  Praesent sit amet lobortis magna. Duis pharetra cursus magna, ac accumsan massa facilisis eget. Duis et blandit mi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam vulputate ipsum ac aliquam sagittis. 
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
