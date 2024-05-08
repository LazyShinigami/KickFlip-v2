import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';
import 'package:kickflip/screens/buyers/productDetailPage.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key, required this.user});
  final KFUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(showLeading: true),
      // body: (orderItems.isEmpty)
      //     ? Center(
      //         child: MyText(
      //           'You have not ordered anything yet.',
      //           size: 12,
      //           spacing: 1,
      //         ),
      //       )
      //     : GridView.count(
      //         padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      //         mainAxisSpacing: 15,
      //         crossAxisSpacing: 25,
      //         crossAxisCount: 2,
      //         // children: [
      //         //   for (int i = 0; i < orderItems.length; i++)
      //         //     OrderPageItem(
      //         //       item: orderItems[i],
      //         //       index: i,
      //         //     ),
      //         // ],
      //       ),

      bottomNavigationBar:
          CustomBottomNavigationBar(selectedIndex: 3, user: user),
    );
  }
}

class OrderPageItem extends StatelessWidget {
  OrderPageItem({super.key, required this.sneaker, required this.index});
  // OrderItem item;
  final KFProduct sneaker;
  int index;

  @override
  Widget build(BuildContext context) {
    // print('Current index -> $index');
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
        // onTap: () {
        //   print(index);
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ProductDetailPage(sneaker: sneaker),
        //     ),
        //   );
        // },
        // child: Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 5),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Placeholder(fallbackHeight: width * 0.30),
        //       const SizedBox(height: 5),
        //       MyText(
        //         item.name,
        //         spacing: 1,
        //         size: 12,
        //         overflow: TextOverflow.ellipsis,
        //         maxLines: 1,
        //       ),
        //       MyText(
        //         item.sellerName,
        //         size: 11,
        //         overflow: TextOverflow.ellipsis,
        //         maxLines: 1,
        //       ),
        //       MyText(
        //         'Bought on: ${item.saleDate}',
        //         size: 10,
        //         overflow: TextOverflow.ellipsis,
        //         maxLines: 1,
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
