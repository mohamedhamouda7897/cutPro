import 'package:easy_scroll_animation/easy_scroll_animation.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    
       child: EasyAnimatedScroll(
        topCurve: Curves.linear,
        bottomCurve: Curves.bounceOut,
        bottomAnimationDuration: const Duration(seconds: 1),
        topAnimationDuration: const Duration(seconds: 1),
        animationTopType: AnimationType.size,
        animateBottomWidget: false,
        topWidget: Row(
          children: [
            Expanded(
              child: SizedBox
              (
            

                child: Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')),
            ),
             Expanded(
               child: SizedBox(
               
             
                child: Image.network('https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=')),
             ),
          ],
        ),
        child: Column(
          children: [
             
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemBuilder: (_, index) => Text("hi $index"),
                itemCount: 500,
              ),
            ),
          ],
        ),
      ),
    
    
    );
  }
}
