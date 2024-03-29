
import 'package:cutpro/modules/editing_screen/cubit/editing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () async {
                        EditingCubit.get(context).downloadImage(widget.image);
                      },
                      icon: const Icon(Icons.download)),
                  IconButton(
                      onPressed: ()  {
                         EditingCubit.get(context).shareFile();
                      },
                      icon: const Icon(Icons.share)),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(EditingCubit.get(context).load!.toString()),
                    SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
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
