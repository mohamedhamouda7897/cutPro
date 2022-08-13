import 'dart:convert';
import 'dart:io';

import 'package:cutpro/shared/components/components.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../editing_screen/editing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final piker = ImagePicker();

  File? image;

  // String? path;
  // File? newfile;
  // String? namefile;

  Future getImage() async {
    final filepiked = await piker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (filepiked != null) {
        image = File(filepiked.path);
      } else {
        print('no select image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: mq.width * 0.99,
              height: mq.height * 0.80,
              child: image == null
                  ? IconButton(
                      onPressed: () {
                        getImage();
                      },
                      icon: const Icon(
                        Icons.image,
                        size: 30.0,
                      ),
                      // icon: Image.asset('assets/images/upimage.png',
                      //     width: 40, fit: BoxFit.cover),
                    )
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          width: 150,
                          height: 250,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Image.file(
                            image!,
                            width: 40,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            getImage();
                          },
                          icon: const Icon(
                            Icons.image,
                            size: 30.0,
                          ),
                          // icon: Image.asset('assets/images/upimage.png',
                          //     width: 40, fit: BoxFit.cover),
                        ),
                      ],
                    ),
            ),
            defaultButton(
                function: () async {
                  FormData data = FormData.fromMap({
                    "file": await MultipartFile.fromFile(
                      image!.path,
                      filename: image!.path,
                    ),
                    "edit_number": 2
                  });
                  // print('data is done ${image!.path}');
                  // String x = '';
                  // print('hello world 1');
                  // var url = Uri.parse('https://pythonleader.com/analyze');
                  // print('hello world 2');
                  // Stream<http.Response> response = http.post(url, body: {
                  //   "file": image!.path,
                  //   "edit_number": "2"
                  // }).asStream();

                  // response.asBroadcastStream().listen((event) {
                  //   print('hello world 3');
                  //   print(event.bodyBytes); // prints the URL
                  //   NavigateAndFinish(context, EditingScreen(event.bodyBytes));
                  // });

                  // final decodedResponse = json.decode(response.body);
                  // response.statusCode == 200
                  //     ? print('hello world')
                  //     : print('hello khara');
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
                },
                text: 'Cut',
                width: 120,
                radius: 12.0)
          ],
        ),
      ),
    );
  }

  // Future<File> saveFilePermanently(PlatformFile file) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final newFile = File('${appStorage.path}/${file.name}');
  //   return File(file.path!).copy(newFile.path);
  // }
}
