import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/firebase/authHandler.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/buyers/buyerHomepage.dart';
import 'package:kickflip/screens/sellers/sellerHomepage.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key, required this.user});
  final user;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthService().getUserDetails(widget.user.user!.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: AlertDialog(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 100, horizontal: 121),
                content: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2,
                ),
              ),
            );
          } else {
            if (snapshot.hasData) {
              KFUser myUser = snapshot.data!;
              if (myUser.type == 'seller') {
                return SellerHomepage(user: myUser);
              } else {
                return BuyerHomepage(user: myUser);
              }
            } else {
              return Center(
                child: MyText('--> ${snapshot.error}'),
              );
            }
          }
        },
      ),
    );
  }
}
