import 'package:flutter/material.dart';
import 'package:kickflip/firebase/authHandler.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/buyers/buyerHomepage.dart';
import 'package:kickflip/screens/commonElements/authPageController.dart';
import 'package:kickflip/screens/sellers/sellerHomepage.dart';

class Root extends StatelessWidget {
  Root({super.key});
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<KFUser>(
      stream: auth.userStream,
      builder: (context, snapshot) {
        // print("----> ${snapshot.data}");
        if (snapshot.data != null) {
          KFUser user = snapshot.data!;

          // Make the following line conditional - depending on user.type from our KFUser class object
          if (user.type == 'seller') {
            return SellerHomepage(user: user);
          } else {
            return BuyerHomepage(user: user);
          }
        } else {
          return const AuthPageHandler();
        }
      },
    );
  }
}
