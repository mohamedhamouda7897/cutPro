import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_scroll_animation/easy_scroll_animation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import '../shared/components/components.dart';
import 'editing_screen/editing.dart';



class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<Album>? _albums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return  _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : EasyAnimatedScroll(
             topCurve: Curves.ease,
             bottomCurve: Curves.bounceOut,
             bottomAnimationDuration: const Duration(seconds: 1),
             topAnimationDuration: const Duration(seconds: 1),
             animationTopType: AnimationType.size,
             animateBottomWidget: true,
             topWidget: SizedBox(
              height: 250,
               child: Row(
                 children: [
            Expanded(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',fit: BoxFit.fitHeight,),
                ),
            ),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Image.network('https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q='),
                 ),
               ),
                 ],
               ),
             ),
             child: LayoutBuilder(
               builder: (context, constraints) {
                 double gridWidth = (constraints.maxWidth - 20) / 3;
                 double gridHeight = gridWidth + 33;
                 double ratio = gridWidth / gridHeight;
                 return AlbumPage(_albums![0]);
               },
             ),
            );
  }
}

class AlbumPage extends StatefulWidget {
  final Album album;

  const AlbumPage(Album album) : album = album;

  @override
  State<StatefulWidget> createState() => AlbumPageState();
}

class AlbumPageState extends State<AlbumPage> {
  List<Medium>? _media;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: <Widget>[
            ...?_media?.map(
              (medium) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewerPage(medium))),
                child: Container(
                  color: Colors.grey[300],
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: ThumbnailProvider(
                      mediumId: medium.id,
                      mediumType: medium.mediumType,
                      highQuality: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}

class ViewerPage extends StatelessWidget  {
  final Medium medium;
 
    ViewerPage(Medium medium) : medium = medium;
 String? name; 
  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;
   
  
    medium.getFile().then((value) {
      name=value.path;
    },);

    return  Stack(
      alignment: Alignment.bottomRight,
      children: [
         Container(
          alignment: Alignment.center,
          child: medium.mediumType == MediumType.image
              ? FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: PhotoProvider(mediumId: medium.id),
                )
              : Container()
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 50.0,right: 22.0),
          child: FloatingActionButton(onPressed: ()async{
              FormData data = FormData.fromMap({
                    "file": await MultipartFile.fromFile(
                      name!,
                      filename: medium.filename,
                    ),
                    "edit_number": 2
                  });

                  Dio dio = Dio();
                  await dio
                      .post('https://pythonleader.com/analyze', data: data)
                      .then((value) {
                    print('done y hamouda success');
                    var x = value.data[0];
                    print(x.toString());
                    NavigateAndFinish(context, EditingScreen(x));
                  }).catchError((onError) {
                    print(onError);
                    print('done y hamouda  error');
                  });
          },child: const Icon(Icons.navigate_next_outlined),))
      ],
    );
   
  }
}
