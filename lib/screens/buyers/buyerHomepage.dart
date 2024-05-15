// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/firebase/firestoreHandler.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';

class BuyerHomepage extends StatefulWidget {
  const BuyerHomepage({super.key, required this.user});
  final KFUser user;
  @override
  State<BuyerHomepage> createState() => _BuyerHomepageState(user);
}

class _BuyerHomepageState extends State<BuyerHomepage> {
  _BuyerHomepageState(this.user);
  final KFUser user;
  final _searchController = TextEditingController();
  // late Future<List<KFProduct>> sneakers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sneakers = FirestoreService().getAllProducts();
  }

  // bottom nav bar settings
  final int _selectedIndex = 0;
  String gender = 'Unisex';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(),

      //
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Fresh Arrivals Product Row
              const SizedBox(height: 30),
              Container(
                // height: 350,
                decoration: BoxDecoration(
                  color: ThemeColors().light,
                  // border: Border.all(width: 1, color: Colors.pink),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Box Title
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        MyText(
                          "Fresh Arrivals",
                          weight: FontWeight.bold,
                          color: const Color(0xEE181818),
                          spacing: 1,
                          wordSpacing: 5,
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Fresh Arrivals Product Row
                    FutureBuilder(
                      future: FirestoreService().getAllProducts(user),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print('waiting');
                          return const CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return MyText('Error: ${snapshot.error}');
                          } else {
                            print('->> ${snapshot.data}');
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  if (snapshot.data != null)
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++)
                                      SneakerTile(
                                        sneaker: snapshot.data![i],
                                        user: user,
                                      )
                                ],
                              ),
                            );
                          }
                        }
                      },
                    ),
                    // Shop by Gender Product Row

                    // Shop by Category Product Row
                  ],
                ),
              ),

              // Shop by gender product row
              const SizedBox(height: 20),
              Container(
                // height: 350,
                decoration: BoxDecoration(
                  color: ThemeColors().light,
                  // border: Border.all(width: 1, color: Colors.pink),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Box Title
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        MyText(
                          "Shop by Gender",
                          weight: FontWeight.bold,
                          color: const Color(0xEE181818),
                          spacing: 1,
                          wordSpacing: 5,
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Fresh Arrivals Product Row
                    FutureBuilder(
                      future: FirestoreService()
                          .getAllProductsByGender(gender, user),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print('waiting');
                          return const CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return MyText('Error: ${snapshot.error}');
                          } else {
                            print('->> ${snapshot.data}');
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  InkWell(
                                    onTap: () {
                                      if (gender == 'Men') {
                                        gender = 'Women';
                                      } else if (gender == 'Women') {
                                        gender = 'Unisex';
                                      } else if (gender == 'Unisex') {
                                        gender = 'Men';
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(600),
                                        border: Border.all(
                                            width: 4, color: Colors.black),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MyText(
                                            (gender == 'Men')
                                                ? '♂'
                                                : (gender == 'Women')
                                                    ? '♀'
                                                    : '⚧',
                                            size: 22,
                                            color: Colors.black,
                                          ),
                                          Icon(Icons.arrow_right_rounded),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  if (snapshot.data != null)
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++)
                                      SneakerTile(
                                        sneaker: snapshot.data![i],
                                        user: user,
                                      )
                                ],
                              ),
                            );
                          }
                        }
                      },
                    ),
                    // Shop by Gender Product Row

                    // Shop by Category Product Row
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      //
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedIndex: _selectedIndex, user: user),
    );
  }
}
