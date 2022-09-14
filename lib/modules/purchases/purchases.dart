import 'package:flutter/material.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                    'https://cdn.pocket-lint.com/r/s/1201x/assets/images/159480-apps-news-best-photo-editing-software-for-windows-10-for-2022-image20-7gsmkrwliv.jpg'),
                InkWell(
                  onTap: () {},
                  child: Container(
                      margin: const EdgeInsets.only(top: 15, left: 15),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 204, 204, 204),
                          borderRadius: BorderRadius.circular(25)),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            const Text('CUT PRO VIP'),
          ],
        ),
      ),
    );
  }
}
