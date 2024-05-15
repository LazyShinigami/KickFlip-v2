import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/firebase/firestoreHandler.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/buyers/buyerHomepage.dart';
import 'package:kickflip/screens/buyers/productDetailPage.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';
import 'package:kickflip/screens/sellers/models.dart';

class BidsScreen extends StatelessWidget {
  BidsScreen({super.key, required this.user});
  final int _selectedIndex = 2;
  final KFUser user;

  // int bID, pID, bidValue;
  // String title, sellerName, imgURL;

  // Dummy data
  List<BuyerBids> buyerBids = [
    BuyerBids(
        bID: 1234,
        pID: 32523,
        bidValue: 5000,
        title: 'Jordans High Top Retro 1',
        sellerName: 'Seller 1',
        imgURL: 'a.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 52542,
        bidValue: 10000,
        title: 'Jordans High Top Retro 2',
        sellerName: 'Seller 2',
        imgURL: 'b.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 54321,
        bidValue: 90000,
        title: 'Jordans High Top Retro 3',
        sellerName: 'Seller 3',
        imgURL: 'c.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 63663,
        bidValue: 100000,
        title: 'Jordans High Top Retro 4',
        sellerName: 'Seller 4',
        imgURL: 'd.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 96568,
        bidValue: 2000,
        title: 'Jordans High Top Retro 5',
        sellerName: 'Seller 5',
        imgURL: 'e.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 45346,
        bidValue: 5000,
        title: 'Jordans High Top Retro 6',
        sellerName: 'Seller 6',
        imgURL: 'f.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 54321,
        bidValue: 90000,
        title: 'Jordans High Top Retro 3',
        sellerName: 'Seller 3',
        imgURL: 'c.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 63663,
        bidValue: 100000,
        title: 'Jordans High Top Retro 4',
        sellerName: 'Seller 4',
        imgURL: 'd.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 96568,
        bidValue: 2000,
        title: 'Jordans High Top Retro 5',
        sellerName: 'Seller 5',
        imgURL: 'e.jpg'),
    BuyerBids(
        bID: 1234,
        pID: 45346,
        bidValue: 5000,
        title: 'Jordans High Top Retro 6',
        sellerName: 'Seller 6',
        imgURL: 'f.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(),
      body: FutureBuilder(
        future: FirestoreService().getAllBidsByThisBuyer(bID: user.uID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  color: Colors.black, strokeWidth: 2),
            );
          } else {
            if (snapshot.data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        'You have not bid on anything yet',
                        color: Colors.grey,
                        weight: FontWeight.bold,
                        spacing: 2,
                        size: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyerHomepage(user: user)),
                          (route) => false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/graphics/op-01.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: MyText(
                          'Shop for amazing kicks now!',
                          color: Colors.white,
                          weight: FontWeight.bold,
                          spacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      MyText(
                        'View all your bids here...',
                        weight: FontWeight.bold,
                        spacing: 2,
                      ),
                      for (int i = 0; i < snapshot.data!.length; i++)
                        FutureBuilder(
                          future: FirestoreService()
                              .getBiddedProducts('${snapshot.data![i].pID}'),
                          builder: (context, childSnapshot) {
                            BidItem bidData = snapshot.data![i];
                            if (childSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              );
                            } else {
                              if (childSnapshot.hasData) {
                                if (childSnapshot.data!.isNotEmpty) {
                                  var product = childSnapshot.data!;
                                  // print(product);

                                  // return MyText('${product[0].name}');
                                  return BuyerBidTile(
                                    product: product[0],
                                    bidData: bidData,
                                    user: user,
                                  );
                                } else {
                                  return Center(
                                    child: MyText('Nothing Found'),
                                  );
                                }
                              } else {
                                return Center(
                                  child:
                                      MyText('Got an error: ${snapshot.error}'),
                                );
                              }
                            }
                          },
                        ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: MyText('-----------> ${snapshot.data}'),
              );
            }
          }
        },
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedIndex: _selectedIndex, user: user),
    );
  }
}

class BuyerBidTile extends StatelessWidget {
  const BuyerBidTile(
      {super.key,
      required this.product,
      required this.bidData,
      required this.user});
  final KFProduct product;
  final BidItem bidData;
  final KFUser user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tapped Bid Item: ${product.pID}  -----  ${product.name}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              sneaker: product,
              user: user,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // product image, title and seller
            Row(
              children: [
                //product image
                Container(
                  height: 50,
                  width: 50,
                  child:
                      Image.network(product.thumbnailImage, fit: BoxFit.cover),
                ),

                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    MyText(product.name,
                        size: 13,
                        weight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                    //seller
                    MyText(product.sellerName,
                        size: 11, spacing: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ],
            ),

            // bid price
            MyText(
              '₹ ${bidData.bidAmount}',
              size: 16,
              weight: FontWeight.bold,
              color: Colors.green,
              spacing: 2,
            )
          ],
        ),
      ),
    );
  }
}





















// Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: (buyerBids.isEmpty)
//             ? Center(
//                 child: MyText(
//                   'You have not bid on any products yet.',
//                   size: 12,
//                   spacing: 1,
//                 ),
//               )
//             : SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     MyText('View your bids here...',
//                         weight: FontWeight.bold, size: 16, spacing: 2),
//                     const SizedBox(height: 20),
//                     for (int i = 0; i < buyerBids.length; i++)
//                       BuyerBidTile(
//                         buyerBidItem: buyerBids[i],
//                       ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         MyText(
//                           '--  End of section  --',
//                           color: Colors.grey,
//                           size: 12,
//                           spacing: 2.5,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//       ),
      