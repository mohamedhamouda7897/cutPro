// ignore_for_file: non_constant_identifier_names, avoid_print

// void SignOut(context) {
//   CacheHelper.RemoveData(key: 'token').then((value) {
//     if (value) {
//       NavigateAndFinish(context, LoginScreen());
//     }
//   });
// }

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}


int APIEDITNUMBER=2;