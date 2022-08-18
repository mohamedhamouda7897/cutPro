import 'dart:io';

import 'package:cutpro/modules/editing_screen/cubit/editing_cubit.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class EditingScreen extends StatefulWidget {
  String image;

  EditingScreen(this.image);

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditingCubit(),
      child: BlocConsumer<EditingCubit, EditingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () async {
                        Map<Permission, PermissionStatus> statuses = await [
                          Permission.storage,
                          //add more permission to request here.
                        ].request();

                        if (statuses[Permission.storage]!.isGranted) {
                          var dir =
                              await DownloadsPathProvider.downloadsDirectory;
                          if (dir != null) {
                            String savename = "banner.png";
                            String savePath = dir.path + "/$savename";
                            print(savePath);
                            //output:  /storage/emulated/0/Download/banner.png

                            try {
                              await Dio().download(widget.image, savePath,
                                  onReceiveProgress: (received, total) {
                                if (total != -1) {
                                  print((received / total * 100)
                                          .toStringAsFixed(0) +
                                      "%");
                                  //you can build progressbar feature too
                                }
                              });
                              print("Image is saved to download folder.");
                            } on DioError catch (e) {
                              print(e.message);
                            }
                          }
                        } else {
                          print("No permission to read and write.");
                        }
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
                  widget.image,
                  fit: BoxFit.contain,
                ),
              ));
        },
      ),
    );
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
