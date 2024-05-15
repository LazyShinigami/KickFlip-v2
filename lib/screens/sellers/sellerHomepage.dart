import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/firebase/firestoreHandler.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';
import 'package:kickflip/screens/sellers/addListingPage.dart';
import 'package:kickflip/screens/sellers/allListingsPage.dart';
import 'package:kickflip/screens/sellers/listingWidget.dart';

class SellerHomepage extends StatefulWidget {
  SellerHomepage({super.key, required this.user});
  final KFUser user;

  @override
  State<SellerHomepage> createState() => _SellerHomepageState();
}

class _SellerHomepageState extends State<SellerHomepage> {
  final int _currentIndex = 0;

  // late List<KFProduct> allItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // allItems = FirestoreService().getAllProductsByThisSeller(widget.user.uID);
    // allItems = FirestoreService().getAllProductsByThisSeller(widget.user.uID);
  }
  // @override
  // void initState() {
  //   super.initState();
  //   allItems = FirestoreService().getAllProductsByThisSeller(widget.user.uID);
  // }

  // Get results on monthly basis
  // List<KFProduct> productsList = // dummy data
  //     [
  //   KFProduct(
  //     pID: 32423324,
  //     sID: 1234,
  //     price: 4000,
  //     status: 'sold',
  //     bidders: [1000, 2000, 5000, 3400, 2500],
  //     name: 'Jordans Belfsdlvnsdjlnsdnvsdnvlsdnvast',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 43364634,
  //     sID: 1234,
  //     status: 'listed',
  //     bidders: [],
  //     name: 'Jordans Belfast',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 95659843,
  //     sID: 1234,
  //     status: 'to-be-verified',
  //     bidders: [],
  //     name: 'Jordans Belfast - to-be-verified',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 32525249,
  //     sID: 1234,
  //     price: 10000,
  //     status: 'sold',
  //     bidders: [1000, 2000, 5000, 3400, 2500],
  //     name: 'Jordans Belfast - Another',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 35362554,
  //     sID: 1234,
  //     price: 2500,
  //     status: 'sold',
  //     bidders: [32000, 12000, 5000, 3400, 2500],
  //     name: 'Jordans Belfast Yet Another',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 35226262,
  //     sID: 1234,
  //     status: 'listed',
  //     bidders: [],
  //     name: 'No bids testing item',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 79398533,
  //     sID: 1234,
  //     status: 'to-be-verified',
  //     bidders: [1000, 3000, 2500],
  //     name: 'Jordans Belfast',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 35252522,
  //     sID: 1234,
  //     price: 6000,
  //     status: 'sold',
  //     bidders: [1000, 1000, 1000, 1000, 1000],
  //     name: 'Jordans Belfast - Dummy for straight line',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 45645664,
  //     sID: 1234,
  //     status: 'listed',
  //     bidders: [2000, 2000, 5000, 5000, 2000],
  //     name: 'Jordans Belfast Hello',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 32423444,
  //     sID: 1234,
  //     status: 'listed',
  //     bidders: [1000, 1200, 5000, 3400, 2300, 5300, 6000, 7000],
  //     name: 'Jordans Belfast ehhhhh',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  //   KFProduct(
  //     pID: 23432432,
  //     sID: 1234,
  //     price: 2000,
  //     status: 'sold',
  //     bidders: [30000, 30300, 1500, 5000, 3000, 500],
  //     name: 'Jordans Belfast Newwwwww Version',
  //     desc:
  //         'some weird long ass description talking about the shoe maybe? Maybe it\'s materials and such are included in this.',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Dashboard
              FutureBuilder(
                future: FirestoreService()
                    .getAllProductsByThisSeller(widget.user.uID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the data is loading, you can show a loading indicator
                    return const CircularProgressIndicator(color: Colors.black);
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null) {
                      print('Snapshot has some data: ${snapshot.data}');
                      return Dashboard(productsList: snapshot.data!);
                    } else {
                      return Container(
                        height: 150,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.5, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // Dashboard title
                            Center(
                              child: MyText(
                                'Dashboard',
                                weight: FontWeight.bold,
                                size: 18,
                                spacing: 2,
                              ),
                            ),
                            const Divider(
                                height: 20, endIndent: 20, indent: 20),

                            // Nothing to see here yet message
                            Expanded(
                              child: Container(
                                child: Center(
                                  child: MyText('${snapshot.error}'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: MyText('outer else called'),
                    );
                  }
                },
              ),

              // Add a product section
              const SizedBox(height: 35),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: ThemeColors().light,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    MyText(
                      'Got some kicks you wanna sell?',
                      weight: FontWeight.bold,
                      spacing: 1,
                    ),
                    MyText('We got you covered!', size: 14, spacing: 1),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AddListingPage(user: widget.user);
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage('assets/graphics/op-02.jpeg'),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: MyText('Add a Product',
                              color: Colors.white, size: 15, spacing: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Manage Listings Widget
              FutureBuilder(
                future: FirestoreService()
                    .getAllProductsByThisSeller(widget.user.uID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the data is loading, you can show a loading indicator
                    return const CircularProgressIndicator(color: Colors.black);
                  } else if (snapshot.hasError) {
                    // If there's an error, you can handle it here
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ManageListingsWidget(
                        user: widget.user, productsList: snapshot.data!);
                    // return Center(
                    //   child: MyText('${snapshot.data}'),
                    // );
                  }
                },
              ),

              // ManageListingsWidget(productsList: allItems, user: widget.user),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _currentIndex,
          accountType: 'seller',
          user: widget.user),
    );
  }
}

class ManageListingsWidget extends StatelessWidget {
  const ManageListingsWidget(
      {super.key, required this.productsList, required this.user});
  final KFUser user;
  final List<KFProduct> productsList;

  @override
  Widget build(BuildContext context) {
    // print('-PRODUCT LIST- $productsList');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: ThemeColors().light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            'Manage Listings',
            weight: FontWeight.bold,
            spacing: 2,
          ),
          const SizedBox(height: 10),
          if (productsList.isEmpty)
            Center(
              child: MyText(
                'No items listed yet',
                color: Colors.grey,
                size: 13,
                spacing: 1,
              ),
            )
          else
            for (int i = 0; i < productsList.length; i++)
              if (productsList[i].status == 'listed')
                ListingWidget(
                  product: productsList[i],
                  user: user,
                ),
          const Divider(height: 30),
          if (productsList.isNotEmpty)
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return SellerAllListingsPage(user: user);
                }), (route) => false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Center(
                        child: MyText(
                          'See all listings  →',
                          color: const Color(0xFF5E5E5E),
                          size: 12,
                          spacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.productsList});
  final List<KFProduct> productsList;

  List<int> countLST(List<KFProduct> productsList) {
    int L = 0, S = 0, T = 0;
    int total = productsList.length;
    for (var product in productsList) {
      if (product.status == 'listed') {
        L++;
      } else if (product.status == 'sold') {
        S++;
      } else if (product.status == 'to-be-verified') {
        T++;
      }
    }

    List<int> countsLST = [L, S, T, total];

    return countsLST;
  }

  List<double> countPercentagesLST(List<KFProduct> productsList) {
    int total = productsList.length;
    double L = double.parse('${countLST(productsList)[0]}'),
        S = double.parse('${countLST(productsList)[1]}'),
        T = double.parse('${countLST(productsList)[2]}');
    double LP = L / total * 100, SP = S / total * 100, TP = T / total * 100;
    LP = double.parse(LP.toStringAsFixed(2));
    SP = double.parse(SP.toStringAsFixed(2));
    TP = double.parse(TP.toStringAsFixed(2));

    List<double> percentageShoe = [LP, SP, TP];

    return percentageShoe;
  }

  int calcSale(List<KFProduct> productsList) {
    int totalSaleAmount = 0;
    for (var product in productsList) {
      if (product.salePrice != null) {
        totalSaleAmount += product.salePrice!;
      }
    }
    return totalSaleAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Dashboard title
          Center(
            child: MyText(
              'Dashboard',
              weight: FontWeight.bold,
              size: 18,
              spacing: 2,
            ),
          ),
          const Divider(height: 20, endIndent: 20, indent: 20),
          const SizedBox(height: 10),

          //
          Row(
            children: [
              _buildPieChart(MediaQuery.of(context).size.width),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPieChartDetails(),
                    const SizedBox(height: 50),
                    _buildSalesSummary(),
                  ],
                ),
              ),
            ],
          ),

          // spacing
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Stack _buildPieChart(double w) {
    return Stack(
      children: [
        Container(
          height: 175,
          width: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                'Total Sales',
                size: w * 0.02,
                color: const Color(0xFF505050),
              ),
              MyText(
                '${countPercentagesLST(productsList)[1]}%',
                size: w * 0.03,
                weight: FontWeight.bold,
                spacing: 2,
                color: const Color(0xFF6F6F6F),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 175,
          width: 175,
          child: PieChart(
            PieChartData(
              sections: [
                // Product Count - Listed
                PieChartSectionData(
                  value: double.parse('${countLST(productsList)[0]}'),
                  color: Colors.blue,
                  titleStyle: const TextStyle(color: Colors.transparent),
                ),

                // Product Count - Sold
                PieChartSectionData(
                  value: double.parse('${countLST(productsList)[1]}'),
                  color: Colors.black,
                  titleStyle: const TextStyle(color: Colors.transparent),
                ),

                // Product Count - To be verified
                PieChartSectionData(
                  value: double.parse('${countLST(productsList)[2]}'),
                  color: Color.fromARGB(164, 251, 255, 148),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  titleStyle: const TextStyle(color: Colors.transparent),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPieChartDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sold

        Row(
          children: [
            const Icon(Icons.square_rounded, size: 10),
            MyText(
              ' ${countLST(productsList)[1]} products sold',
              size: 12,
              spacing: 1,
            ),
          ],
        ),

        // Listed
        Row(
          children: [
            const Icon(
              Icons.square_rounded,
              size: 10,
              color: Colors.blue,
            ),
            MyText(
              ' ${countLST(productsList)[0]} products listed',
              size: 12,
              spacing: 1,
            ),
          ],
        ),

        // To-be Verified
        Row(
          children: [
            const Icon(
              Icons.square_rounded,
              size: 10,
              color: Color(0xFFFBFF94),
            ),
            MyText(
              ' ${countLST(productsList)[2]} products to be verified',
              size: 12,
              spacing: 1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSalesSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Net Sales
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText('Net Sales', size: 14, weight: FontWeight.bold, spacing: 1),
            MyText(
              double.parse('${calcSale(productsList)}').toStringAsFixed(2),
              size: 14,
              weight: FontWeight.bold,
              spacing: 0.5,
            ),
          ],
        ),

        // Platform Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText('Platform Fee', size: 13),
            MyText(
              double.parse('${calcSale(productsList) * 0.2}')
                  .toStringAsFixed(2),
              size: 13,
              spacing: 1.15,
            ),
          ],
        ),
      ],
    );
  }
}
