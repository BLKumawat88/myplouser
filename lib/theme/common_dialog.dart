import 'package:flutter/material.dart';

class CommanDialog {
  static showLoading(context, {String title = 'Loading...'}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator.adaptive(
                backgroundColor: Color(0xFFF903E3),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }

  static hideLoading(context) {
    Navigator.pop(context);
  }

  static showErrorDialog(
    context, {
    String title = "Oops Error",
    String description = "Something went wrong ",
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(description),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
