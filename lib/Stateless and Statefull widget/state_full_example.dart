import 'package:flutter/material.dart';

class StateFullWidgetExample extends StatefulWidget {
  const StateFullWidgetExample({super.key});

  @override
  State<StateFullWidgetExample> createState() => _StateFullWidgetExampleState();
}

class _StateFullWidgetExampleState extends State<StateFullWidgetExample> {
  xyz() {
    print("You are calling me forn anywhere..");
    setState(() {
      yourScore++;
    });

    print(yourScore);
  }

  int yourScore = 60;
  String name = "ABCD";

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
        Text("$yourScore"),
        Text("$name")
      ]),
    );
  }
}
