import 'package:flutter/material.dart';

class StateLessWidgetExample extends StatelessWidget {
  StateLessWidgetExample({super.key});

  xyz() {
    print("You are calling me forn anywhere..");
    yourScore++;

    print(yourScore);
  }

  int yourScore = 60;

  @override
  Widget build(BuildContext context) {
    print("Calling build");
    return Scaffold(
      appBar: AppBar(
        title: Text('State Less Widget Example'),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: () {
            xyz();
          },
          child: Text("I am a Button"),
        ),
        Text("$yourScore")
      ]),
    );
  }
}
