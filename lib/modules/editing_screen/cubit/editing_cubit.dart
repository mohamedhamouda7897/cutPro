import 'dart:math';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'editing_state.dart';

class EditingCubit extends Cubit<EditingState> {
  EditingCubit() : super(EditingInitial());

  static EditingCubit get(context) => BlocProvider.of(context);
  String? load = '';
  Future<void> downloadImage(imgUrl1) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.storage]!.isGranted) {
      var dir = await DownloadsPathProvider.downloadsDirectory;
      if (dir != null) {
        Random r = Random();
        int ra = r.nextInt(506999);
        String savename = "cutBro$ra.png";
        String savePath = dir.path + "/$savename";
        print(savePath);

        try {
          await Dio().download(imgUrl1, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              print((received / total * 100).toStringAsFixed(0) + "%");
              //you can build progressbar feature too
              emit(EditingSuccessState());
              load = (received / total * 100).toStringAsFixed(0) + "%";
            }
          });
          print("Image is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
          emit(EditingErrorState());
        }
      }
    } else {
      print("No permission to read and write.");
      emit(EditingErrorState());
    }
  }
}
