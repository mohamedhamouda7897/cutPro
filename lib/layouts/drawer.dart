import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFf7f2ec),
        width: MediaQuery.of(context).size.width * .70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                  bottom: MediaQuery.of(context).size.height * .05),
              width: MediaQuery.of(context).size.width * .25,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(12)),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, elevation: 0.0),
                  onPressed: () {},
                  child: const Text('Login')),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  bottom: MediaQuery.of(context).size.width * .05),
              child: Row(
                children: const [
                  Icon(
                    Icons.home,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Home'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  bottom: MediaQuery.of(context).size.width * .05),
              child: Row(
                children: const [
                  Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Favorite'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  bottom: MediaQuery.of(context).size.width * .05),
              child: Row(
                children: const [
                  Icon(
                    Icons.co_present_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Ai Looks'),
                ],
              ),
            ),
            Container(
              color: OnprimaryColor,
              height: 2,
              width: MediaQuery.of(context).size.width * 0.50,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .05),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  bottom: MediaQuery.of(context).size.width * .05),
              child: Row(
                children: const [
                  Icon(
                    Icons.report_gmailerrorred,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('About'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  bottom: MediaQuery.of(context).size.width * .05),
              child: Row(
                children: const [
                  Icon(
                    Icons.share,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Tell Others'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  bottom: MediaQuery.of(context).size.width * .05),
              child: Row(
                children: const [
                  Icon(
                    Icons.star_border,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Rate us'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  bottom: MediaQuery.of(context).size.width * .05),
              child: Row(
                children: const [
                  Icon(
                    Icons.share,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Go Pro'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  bottom: MediaQuery.of(context).size.width * .05),
              child: Row(
                children: const [
                  Icon(
                    Icons.replay_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Restore in-app purchases'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
