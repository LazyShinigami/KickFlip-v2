import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';

class GuideBook extends StatelessWidget {
  const GuideBook({super.key, required this.user});
  final KFUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(showLeading: true),
      body: Center(child: MyText('GuideBookPage')),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 3,
        accountType: 'seller',
        user: user,
      ),
    );
  }
}
