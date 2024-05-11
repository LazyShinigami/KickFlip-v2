import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/firebase/authHandler.dart';
import 'package:kickflip/firebase/firestoreHandler.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/buyers/buyerHomepage.dart';
import 'package:kickflip/screens/commonElements/authPageController.dart';
import 'package:kickflip/screens/commonElements/loadingScreen.dart';
import 'package:kickflip/screens/sellers/sellerHomepage.dart';

class Root extends StatelessWidget {
  Root({super.key});
  final auth = AuthService();
  // KFUser demoUser = KFUser(
  //     uID: 1234, name: 'demoUser', email: 'hello@world.com', type: 'seller');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.userStream,
      builder: (context, snapshot) {
        print("----> ${snapshot.data.runtimeType}");
        if (snapshot.data != null) {
          var user = snapshot.data!;
          print('USER DATA: $user');

          // Make the following line conditional - depending on user.type from our KFUser class object
          return FutureBuilder(
              future: AuthService().getUserDetails(snapshot.data!.email!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.type == 'buyer') {
                      return BuyerHomepage(user: snapshot.data!);
                    } else {
                      return SellerHomepage(user: snapshot.data!);
                    }
                  } else {
                    return Center(
                      child: MyText('No account found', color: Colors.white),
                    );
                  }
                }
              });
        } else {
          return const AuthPageHandler();
        }
      },
    );
  }
}
