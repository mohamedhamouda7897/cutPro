import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
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
            : LayoutBuilder(
                builder: (context, constraints) {
                  double gridWidth = (constraints.maxWidth - 20) / 3;
                  double gridHeight = gridWidth + 33;
                  double ratio = gridWidth / gridHeight;
                  return AlbumPage(_albums![0]);
                },
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

// class VideoProvider extends StatefulWidget {
//   final String mediumId;

//   const VideoProvider({
//     required this.mediumId,
//   });

//   @override
//   _VideoProviderState createState() => _VideoProviderState();
// }

// class _VideoProviderState extends State<VideoProvider> {
//   VideoPlayerController? _controller;
//   File? _file;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       initAsync();
//     });
//     super.initState();
//   }

//   Future<void> initAsync() async {
//     try {
//       _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
//       _controller = VideoPlayerController.file(_file!);
//       _controller?.initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//     } catch (e) {
//       print("Failed : $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _controller == null || !_controller!.value.isInitialized
//         ? Container()
//         : Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               AspectRatio(
//                 aspectRatio: _controller!.value.aspectRatio,
//                 child: VideoPlayer(_controller!),
//               ),
//               FlatButton(
//                 onPressed: () {
//                   setState(() {
//                     _controller!.value.isPlaying
//                         ? _controller!.pause()
//                         : _controller!.play();
//                   });
//                 },
//                 child: Icon(
//                   _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                 ),
//               ),
//             ],
//           );
//   }
// }