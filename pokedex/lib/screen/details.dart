import 'package:flutter/material.dart';

import '../widget/detail_back_button.dart';
import '../widget/detail_data.dart';
import '../widget/detail_image.dart';
import '../widget/detail_title.dart';

class Details extends StatelessWidget {
  final int? id;
  final String? name;
  final String? image;
  const Details({Key? key, this.id, this.name, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final arguments =
    //     ModalRoute.of(context)!.settings.arguments as PokemonScreenData;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          DetailImage(id: id!, image: image!),
          DetailTitle(id: id!, name: name!),
          DetailData(id: id!),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const DetailBackButton(),
    );
  }
}
