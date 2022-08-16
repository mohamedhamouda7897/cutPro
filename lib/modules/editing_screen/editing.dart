
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
                  /// //click floating action button 
                  /// 2- select image 
                  /// open image automatic
                  /// click floation action button to send to api 
                  /// display image 
                  /// 
                },
                icon: const Icon(Icons.download)),
                IconButton(
                onPressed: () async {
                  //share button
                },
                icon: const Icon(Icons.share)),
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
