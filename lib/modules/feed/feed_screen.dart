import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../gallery.dart';

class FeedScreen extends StatelessWidget {
  List<String> images = [
    "https://i0.wp.com/sreditingzone.com/wp-content/uploads/2018/04/pexels-markus-spiske-1957693-scaled.jpg?resize=708%2C1062&ssl=1",
    "https://i.pinimg.com/originals/47/ef/ce/47efcef91b7049332fb562f4be4a5014.jpg",
    "https://images.unsplash.com/photo-1583464699579-68be6a447de1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZWRpdGluZyUyMGJhY2tncm91bmRzfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "https://backgroundeditz.com/files/preview/800x980/116398851579jk0lc3epwtjt2tqaibugzaue4mh18ahirysvum0xxugxqf1hnansxlg3ofjrzmvtif2kxkh6dtcn3pzcxq8ru55frgoouznz1ar.jpg",
    "https://file.oyephoto.com/uploads/preview/broken-heart-picsart-edit-background-11618881147xrrodhvxxw.jpg",
    "https://images.unsplash.com/photo-1630259986871-eb113ee68f61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE1fHx8ZW58MHx8fHw%3D&w=1000&q=80",
    "https://image.winudf.com/v2/image/Y29tLm1rMjBvbmUuQ2Jwbmdfc2NyZWVuXzJfMTUzNzczNzk1MF8wNjM/screen-2.jpg?fakeurl=1&type=.webp",
    "https://images.unsplash.com/photo-1615380817813-5c1e337fcba8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZWRpdGluZyUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80",
    "https://images.unsplash.com/photo-1606498236504-030a628c0047?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZWRpdHxlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://images.unsplash.com/photo-1527883089043-4f72242487b7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZWRpdHxlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://i0.wp.com/sreditingzone.com/wp-content/uploads/2018/04/pexels-markus-spiske-1957693-scaled.jpg?resize=708%2C1062&ssl=1",
    "https://i.pinimg.com/originals/47/ef/ce/47efcef91b7049332fb562f4be4a5014.jpg",
    "https://images.unsplash.com/photo-1583464699579-68be6a447de1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZWRpdGluZyUyMGJhY2tncm91bmRzfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "https://backgroundeditz.com/files/preview/800x980/116398851579jk0lc3epwtjt2tqaibugzaue4mh18ahirysvum0xxugxqf1hnansxlg3ofjrzmvtif2kxkh6dtcn3pzcxq8ru55frgoouznz1ar.jpg",
    "https://file.oyephoto.com/uploads/preview/broken-heart-picsart-edit-background-11618881147xrrodhvxxw.jpg",
    "https://images.unsplash.com/photo-1630259986871-eb113ee68f61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE1fHx8ZW58MHx8fHw%3D&w=1000&q=80",
    "https://image.winudf.com/v2/image/Y29tLm1rMjBvbmUuQ2Jwbmdfc2NyZWVuXzJfMTUzNzczNzk1MF8wNjM/screen-2.jpg?fakeurl=1&type=.webp",
    "https://images.unsplash.com/photo-1615380817813-5c1e337fcba8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZWRpdGluZyUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80",
    "https://images.unsplash.com/photo-1606498236504-030a628c0047?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZWRpdHxlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://images.unsplash.com/photo-1553649084-3e42773ff0e3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80",
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            childAspectRatio: 2 / 4,
            mainAxisSpacing: 4),
            itemCount: images
            .length,
        itemBuilder: (c, index) {
          return InkWell(
            onTap: () {
              APIEDITNUMBER = index + 1;
              NavigateTo(context, GalleryScreen(images[index]));
            },
            child: CachedNetworkImage(
              imageUrl: images[index],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                     ),
                ),
              ),
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            //child: Image.network(images[index],fit: BoxFit.fill,)
          );
        });
  } // cutBro94251.png
}
