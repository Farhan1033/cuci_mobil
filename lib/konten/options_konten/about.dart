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
                  """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ornare nunc at elementum varius.
                  Suspendisse magna erat, rhoncus at convallis ut, aliquet non tellus. Pellentesque porta, erat et ornare cursus, erat tellus iaculis velit, et tincidunt tortor leo et quam. Phasellus feugiat rhoncus eros eu egestas. Pellentesque sollicitudin, ex id fringilla ornare, nulla lorem ornare lacus, sed ultricies ante erat in tellus. Nullam laoreet massa vel augue malesuada posuere. Cras id nisi feugiat, pulvinar est in, tincidunt justo. Phasellus iaculis vel neque eget porta.""",
                  textAlign: TextAlign.justify)
            ],
          ),
        ),
      ),
    );
  }
}
