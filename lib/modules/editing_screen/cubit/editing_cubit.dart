import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'editing_state.dart';

class EditingCubit extends Cubit<EditingState> {
  EditingCubit() : super(EditingInitial());

  static EditingCubit get(context) => BlocProvider.of(context);

  // bool downloading = false;
  // var progress = "";
  // var path = "No Data";
  // var platformVersion = "Unknown";
  // Permission permission1 = Permission.WriteExternalStorage;
  // var _onPressed;
  // static final Random random = Random();

  // Future<void> downloadImage(imgUrl1) async {
  //   Dio dio = Dio();
  //   String dirloc = "";

  //   bool checkPermission1 =
  //       await SimplePermissions.checkPermission(permission1);
  //   // print(checkPermission1);
  //   if (checkPermission1 == false) {
  //     await SimplePermissions.requestPermission(permission1);
  //     checkPermission1 = await SimplePermissions.checkPermission(permission1);
  //   }
  //   if (checkPermission1 == true) {
  //     String dirloc = "";
  //     if (Platform.isAndroid) {
  //       dirloc = "/sdcard/download/";
  //     } else {
  //       dirloc = (await getApplicationDocumentsDirectory()).path;
  //     }

  //     var randid = random.nextInt(10000);

  //     try {
  //       FileUtils.mkdir([dirloc]);
  //       await dio.download(imgUrl1, dirloc + randid.toString() + ".jpg",
  //           onReceiveProgress: (receivedBytes, totalBytes) {
  //         downloading = true;
  //         progress =
  //             ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
  //         emit(EditingLoadState());
  //       });
  //     } catch (e) {
  //       print(e);
  //       emit(EditingErrorState());
  //     }

  //     downloading = false;
  //     progress = "Download Completed.";
  //     path = dirloc + randid.toString() + ".jpg";
  //     emit(EditingSuccessState());
  //   } else {
  //     progress = "Permission Denied!";
  //     _onPressed = () {
  //       downloadImage(imgUrl1);
  //     };
  //     emit(EditingSuccessState());
  //   }
  // }
}
