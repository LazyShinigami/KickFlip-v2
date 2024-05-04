import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';
import 'package:kickflip/screens/buyers/productDetailPage.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key, required this.user});
  final KFUser user;
  // Dummy Data
  List<OrderItem> orderItems = [
    OrderItem(
        pID: 1234,
        name: 'Jordan Retro Top 85',
        imageURL: 'a.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 123456'),
    OrderItem(
        pID: 2425,
        name: 'Jordan Retro Top 86',
        imageURL: 'b.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 325235'),
    OrderItem(
        pID: 1234,
        name: 'Jordan Retro Top 85',
        imageURL: 'a.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 123456'),
    OrderItem(
        pID: 2425,
        name: 'Jordan Retro Top 86',
        imageURL: 'b.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 325235'),
    OrderItem(
        pID: 1234,
        name: 'Jordan Retro Top 85',
        imageURL: 'a.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 123456'),
    OrderItem(
        pID: 2425,
        name: 'Jordan Retro Top 86',
        imageURL: 'b.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 325235'),
    OrderItem(
        pID: 1234,
        name: 'Jordan Retro Top 85',
        imageURL: 'a.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 123456'),
    OrderItem(
        pID: 2425,
        name: 'Jordan Retro Top 86',
        imageURL: 'b.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 325235'),
    OrderItem(
        pID: 1234,
        name: 'Jordan Retro Top 85',
        imageURL: 'a.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 123456'),
    OrderItem(
        pID: 2425,
        name: 'Jordan Retro Top 86',
        imageURL: 'b.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 325235'),
    OrderItem(
        pID: 3522,
        name: 'Jordan Retro Top 87',
        imageURL: 'c.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 3y35y35y'),
    OrderItem(
        pID: 4534,
        name: 'Jordan Retro Top 88',
        imageURL: 'd.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller 3y5y4j446h4h4'),
    OrderItem(
        pID: 7885,
        name: 'Jordan Retro Top 89',
        imageURL: 'e.jpg',
        saleDate: '09-09-2009',
        sellerName: 'Seller g3gdfg dfgdg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(showLeading: true),
      body: (orderItems.isEmpty)
          ? Center(
              child: MyText(
                'You have not ordered anything yet.',
                size: 12,
                spacing: 1,
              ),
            )
          : GridView.count(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              mainAxisSpacing: 15,
              crossAxisSpacing: 25,
              crossAxisCount: 2,
              children: [
                for (int i = 0; i < orderItems.length; i++)
                  OrderPageItem(
                    item: orderItems[i],
                    index: i,
                  ),
              ],
            ),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedIndex: 3, user: user),
    );
  }
}

class OrderPageItem extends StatelessWidget {
  OrderPageItem({super.key, required this.item, required this.index});
  OrderItem item;
  int index;

  //
  // String title
  // thumbnail
  // seller
  // pid
  //

  @override
  Widget build(BuildContext context) {
    // print('Current index -> $index');
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        print(index);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(pID: item.pID),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Placeholder(fallbackHeight: width * 0.30),
            const SizedBox(height: 5),
            MyText(
              item.name,
              spacing: 1,
              size: 12,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            MyText(
              item.sellerName,
              size: 11,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            MyText(
              'Bought on: ${item.saleDate}',
              size: 10,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
