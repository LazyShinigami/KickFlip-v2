import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/firebase/firestoreHandler.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/buyers/bidsScreen.dart';
import 'package:kickflip/screens/sellers/models.dart';
import 'package:pay/pay.dart';

class MyPaymentsOptionPage extends StatelessWidget {
  const MyPaymentsOptionPage(
      {super.key,
      required this.amount,
      required this.user,
      this.item,
      required this.product});
  final KFUser user;
  final int amount;
  final BidItem? item;
  final KFProduct product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText('20% of your bid amount'),
            MyText(
              '₹ ${double.parse('$amount')}',
              color: Colors.black,
              weight: FontWeight.bold,
              size: 30,
            ),
            const SizedBox(height: 40),
            MyText('To Pay:'),
            MyText(
              '₹ ${double.parse('${amount * 0.2}')}',
              color: Colors.green,
              weight: FontWeight.bold,
              size: 75,
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    String? confirmation = await FirestoreService()
                        .makeBid(user: user, product: product, amount: amount);
                    if (confirmation != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BidsScreen(user: user)),
                          (route) => false);
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/all_icons/googlepay.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    String? confirmation = await FirestoreService()
                        .makeBid(user: user, product: product, amount: amount);
                    if (confirmation != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BidsScreen(user: user)),
                          (route) => false);
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/all_icons/applepay.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
