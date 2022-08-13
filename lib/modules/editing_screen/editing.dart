import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditingScreen extends StatelessWidget {
  String image;

  EditingScreen(this.image);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  /// Download
                },
                icon: Icon(Icons.download))
          ],
        ),
        body: Image.network(
          image,
          fit: BoxFit.fill,
        ));
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (con) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10),
                Text('Loading...'),
              ],
            ),
          );
        });
  }
}
