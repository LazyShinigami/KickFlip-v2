import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';

class KickFlipAppBar extends StatelessWidget implements PreferredSizeWidget {
  KickFlipAppBar({Key? key, this.showLeading}) : super(key: key) {
    showLeading ??= false;
  }
  bool? showLeading;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      leading: (showLeading!)
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            )
          : null,
      title: MyText(
        'KickFlip',
        color: Colors.white,
        weight: FontWeight.bold,
        spacing: 13,
        size: 25,
        shadowList: const [
          Shadow(
            color: Color.fromARGB(113, 255, 255, 255),
            offset: Offset(2, 1),
            blurRadius: 7.5,
          ),
        ],
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/graphics/op-01.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
