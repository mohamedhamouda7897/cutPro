
import 'package:flutter/material.dart';

class EditingScreen extends StatelessWidget {
  String image;

  EditingScreen(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  /// Download
                },
                icon: const Icon(Icons.download))
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Image.network(
            image,
            fit: BoxFit.contain,
          ),
        ));
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (con) {
          return AlertDialog(
            content: Row(
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 10),
                Text('Loading...'),
              ],
            ),
          );
        });
  }
}
