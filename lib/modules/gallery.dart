import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cutpro/shared/styles/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import 'editing_screen/editing.dart';

class GalleryScreen extends StatefulWidget {
  String FilterImageUrl;
  GalleryScreen(this.FilterImageUrl);
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
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: SecondaryColor,
                  expandedHeight: 300,
                  title: Container(
                    child: Text('Filter Name',
                        style: Theme.of(context).textTheme.headline3),
                  ),
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: widget.FilterImageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      // child: Image.network(
                      //   widget.FilterImageUrl,
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ),
                ),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * .80,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double gridWidth =
                                  (constraints.maxWidth - 20) / 3;
                              double gridHeight = gridWidth + 33;
                              double ratio = gridWidth / gridHeight;
                              return AlbumPage(_albums![0]);
                            },
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                    itemExtent: MediaQuery.of(context).size.height),
              ],
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
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        ...?_media?.map(
          (medium) => GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewerPage(medium))),
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

class ViewerPage extends StatelessWidget {
  final Medium medium;

  ViewerPage(Medium medium) : medium = medium;
  String? name;
  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;

    medium.getFile().then(
      (value) {
        name = value.path;
      },
    );

    return Stack(
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
                : Container()),
        Container(
            margin: const EdgeInsets.only(bottom: 50.0, right: 22.0),
            child: FloatingActionButton(
              onPressed: () async {
                showLoading(context, 'Loading...');
                FormData data = FormData.fromMap({
                  "file": await MultipartFile.fromFile(
                    name!,
                    filename: medium.filename,
                  ),
                  "edit_number": APIEDITNUMBER
                });

                Dio dio = Dio();
                await dio
                    .post('https://pythonleader.com/analyze', data: data)
                    .then((value) {
                  hideLoadingDialog(context);
                  print('done y hamouda success');
                  var x = value.data[0];
                  print(x.toString());
                  NavigateAndFinish(context, EditingScreen(x));
                }).catchError((onError) {
                  print(onError);
                  print('done y hamouda  error');
                });
              },
              child: const Icon(Icons.navigate_next_outlined),
            ))
      ],
    );
  }
}
