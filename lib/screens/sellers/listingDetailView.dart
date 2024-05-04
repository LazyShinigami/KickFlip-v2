import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/sellers/models.dart';

class ListingDetailView extends StatefulWidget {
  ListingDetailView({super.key, required this.product, required this.user});
  final SellerProductListItem product;
  final KFUser user;
  @override
  State<ListingDetailView> createState() =>
      _ListingDetailViewState(product, user);
}

class _ListingDetailViewState extends State<ListingDetailView> {
  _ListingDetailViewState(this.product, this.user);
  KFUser user;
  SellerProductListItem product;
  final int _currentIndex = 0;
  late List<BidItem> bids = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // You already have products.bidders value, convert that into BidItem class object, as shown below, in order to use it
    // Actually no this might need more tampering
    bids = [
      BidItem(pID: product.pID, bidPrice: 10000, bID: 1234, bName: 'Buyer 1'),
      BidItem(pID: product.pID, bidPrice: 4000, bID: 2343, bName: 'Buyer 2'),
      BidItem(pID: product.pID, bidPrice: 8000, bID: 5464, bName: 'Buyer 3'),
      BidItem(pID: product.pID, bidPrice: 12500, bID: 3455, bName: 'Buyer 4'),
      BidItem(pID: product.pID, bidPrice: 9500, bID: 9867, bName: 'Buyer 5'),
      BidItem(pID: product.pID, bidPrice: 4750, bID: 7885, bName: 'Buyer 6'),
      BidItem(pID: product.pID, bidPrice: 8000, bID: 5745, bName: 'Buyer 7'),
      BidItem(pID: product.pID, bidPrice: 9000, bID: 3447, bName: 'Buyer 8'),
      BidItem(pID: product.pID, bidPrice: 11500, bID: 8075, bName: 'Buyer 9'),
      BidItem(pID: product.pID, bidPrice: 10000, bID: 2534, bName: 'Buyer 10'),
      BidItem(pID: product.pID, bidPrice: 15000, bID: 2141, bName: 'Buyer 11'),
      BidItem(pID: product.pID, bidPrice: 1000, bID: 5422, bName: 'Buyer 12'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    print(product.pID);
    return Scaffold(
      appBar: KickFlipAppBar(showLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Image
              Container(
                height: 275,
                color: Colors.grey,
              ),

              // Title
              const SizedBox(height: 10),
              MyText(
                widget.product.name,
                size: 18,
                weight: FontWeight.bold,
                spacing: 1.5,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),

              // Desc
              const SizedBox(height: 10),
              MyText('About', weight: FontWeight.bold, spacing: 2),
              MyText(widget.product.desc, size: 15, spacing: 1),

              // Status
              const SizedBox(height: 15),
              Row(
                children: [
                  MyText(
                    'Status: ',
                    size: 14,
                    spacing: 1,
                    weight: FontWeight.bold,
                  ),
                  MyText(
                    '[ ${widget.product.status[0].toUpperCase()}${widget.product.status.substring(1)} ]',
                    size: 14,
                    weight: FontWeight.w500,
                    spacing: 1,
                    color: (widget.product.status == 'listed')
                        ? Colors.green // if listed
                        : (widget.product.status == 'sold')
                            ? Colors.grey // if sold
                            : Colors.yellow[700], // if to be verified
                  ),
                ],
              ),

              // Price - Not sold yet / 12000

              // Line Chart - Top 10 or less Bidders
              const SizedBox(height: 30),
              _buildLineChartSection(),

              // Table of all bids
              const SizedBox(height: 20),
              _buildAllBidsSection(bids),

              // Remove Product Button
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Confirmation Popup
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: SingleChildScrollView(
                          child: AlertDialog(
                            content: MyText(
                                'Are you sure you want to remove this product'),
                            actions: [
                              // Confirm Button
                              GestureDetector(
                                onTap: () {
                                  print(
                                      'Call firebase function that removes the product here');
                                  Navigator.of(context).pop();
                                },
                                child: MyText(
                                  'Confirm',
                                  color: Colors.red,
                                  weight: FontWeight.w600,
                                  spacing: 1,
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Cancel Button
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black,
                                  ),
                                  child: MyText('Cancel',
                                      color: Colors.white, spacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/graphics/op-02.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: MyText(
                      'Remove Product',
                      color: Colors.white,
                      size: 14,
                      weight: FontWeight.w600,
                      spacing: 1.5,
                    ),
                  ),
                ),
              ),

              // spacing
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //     selectedIndex: _currentIndex, accountType: 'seller', uID: uID),
    );
  }

  Container _buildAllBidsSection(List<BidItem> bids) {
    return Container(
      padding: (bids.isNotEmpty)
          ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
          : const EdgeInsets.fromLTRB(15, 5, 15, 30),
      decoration: BoxDecoration(
        color: ThemeColors().light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText('All Your Bids', spacing: 2, weight: FontWeight.bold),
          const SizedBox(height: 20),
          Container(
            child: (bids.isNotEmpty)
                ? BidsTableBuilder(bids: bids)
                : Center(
                    child: MyText('No Bids Yet!', spacing: 2, size: 12),
                  ),
          ),
        ],
      ),
    );
  }

  Container _buildLineChartSection() {
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
            'Here\'s Your Top Bidders',
            weight: FontWeight.bold,
            spacing: 2,
          ),
          const SizedBox(height: 20),
          LineChartBuilder(
            data: bids,
          ),
        ],
      ),
    );
  }
}

class LineChartBuilder extends StatelessWidget {
  const LineChartBuilder({
    super.key,
    required this.data,
  });
  final List<BidItem> data;

  @override
  Widget build(BuildContext context) {
    List<int> prices = [];
    List<int> buyers = [];

    // Extraction
    for (int i = 0; i < data.length; i++) {
      prices.add(data[i].bidPrice);
      buyers.add(data[i].bID);
    }
    double minPrice = 0;
    double maxPrice = 0;

    // todo - adjust this to calculate for a maximum set of 10 bids
    if (prices.isNotEmpty) {
      minPrice = double.parse(
          '${prices.reduce((value, element) => value < element ? value : element)}');
      maxPrice = double.parse(
          '${prices.reduce((value, element) => value > element ? value : element)}');
      print('-- $minPrice ++ $maxPrice --');
    }
    //
    return Center(
      child: Container(
        height: (prices.isNotEmpty) ? 275 : null,
        padding: (prices.isNotEmpty)
            ? const EdgeInsets.fromLTRB(0, 10, 0, 0)
            : const EdgeInsets.fromLTRB(0, 5, 0, 30),
        child: (prices.isNotEmpty)
            ? LineChart(
                LineChartData(
                  borderData: FlBorderData(
                    border:
                        Border.all(color: const Color(0x6A9E9E9E), width: 1),
                  ),
                  gridData: const FlGridData(show: false),
                  minY: 0,
                  maxY: maxPrice,
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      axisNameSize: 10,
                      sideTitles: SideTitles(
                        interval: (maxPrice - minPrice) / 5,
                        showTitles: true,
                        reservedSize: 50,
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (int i = 1; i < 11; i++)
                          FlSpot(
                            i.toDouble(),
                            prices[i].toDouble(),
                          ),
                      ],
                      barWidth: 0.35,
                      isStrokeCapRound: true,
                      color: Colors.black,
                      // dotData: FlDotData(getDotPainter: ),

                      // colors: const Color(0xFF17E124),
                    ),
                  ],
                ),
              )
            : Center(
                child: MyText('No Bids Yet!', spacing: 2, size: 12),
              ),
      ),
    );
  }
}

class BidsTableBuilder extends StatefulWidget {
  BidsTableBuilder({super.key, required this.bids});
  final List<BidItem> bids;

  @override
  State<BidsTableBuilder> createState() => _BidsTableBuilderState();
}

class _BidsTableBuilderState extends State<BidsTableBuilder> {
  String sortFactor = 'descending';

  @override
  Widget build(BuildContext context) {
    (sortFactor == 'descending')
        ? // Sorting the list by bidPrice in ascending order
        widget.bids.sort((a, b) => a.bidPrice.compareTo(b.bidPrice))
        : // Sorting the list by bidPrice in descending order
        widget.bids.sort((a, b) => b.bidPrice.compareTo(a.bidPrice));

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: MyText(
                'Buyer Name',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                size: 13,
                weight: FontWeight.bold,
              ),
            ),
            DataColumn(
              numeric: true,
              label: GestureDetector(
                onTap: () {
                  sortFactor =
                      (sortFactor == 'ascending') ? 'descending' : 'ascending';
                  setState(() {});
                },
                child: Row(
                  children: [
                    MyText(
                      'Price ',
                      size: 13,
                      weight: FontWeight.bold,
                    ),
                    Icon(
                      (sortFactor == 'ascending')
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: 15,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: MyText(
                    'Actions',
                    size: 13,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          rows: [
            for (int i = 0; i < widget.bids.length; i++)
              DataRow(
                cells: [
                  DataCell(
                    MyText(
                      widget.bids[i].bName,
                      size: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataCell(
                    MyText(widget.bids[i].bidPrice.toString(), size: 12),
                  ),
                  DataCell(
                    Row(
                      children: [
                        // accept
                        _acceptOrDenyBidButtonBuilder(
                          task: 'accept',
                          onTap: () {
                            _acceptOrDenyBid_PopUpBuilder(
                                context, 'accept', widget.bids[i]);
                          },
                        ),
                        // Deny
                        _acceptOrDenyBidButtonBuilder(
                          task: 'remove',
                          onTap: () {
                            _acceptOrDenyBid_PopUpBuilder(
                                context, 'remove', widget.bids[i]);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  _acceptOrDenyBid_PopUpBuilder(
      BuildContext context, String action, BidItem bid) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: MyText('Bid Information', size: 20),
              content: Column(
                children: [
                  // Details of the bid
                  Container(
                    child: Column(
                      children: [
                        // Bidder Name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText('Bidder Name', size: 14, spacing: 1),
                            MyText(bid.bName, size: 14)
                          ],
                        ),

                        // Bid Amout
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText('Bid Amount', size: 14, spacing: 1),
                            MyText('${bid.bidPrice.toDouble()}', size: 14)
                          ],
                        ),

                        // Platform Fee
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText('Platform Fee', size: 14, spacing: 1),
                            MyText('- ${bid.bidPrice * 0.2}', size: 14)
                          ],
                        ),

                        // Divider
                        const Divider(thickness: 0.5),

                        // Receivable amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText('Amount Receivable',
                                size: 14,
                                spacing: 1,
                                color: (action == 'accept')
                                    ? Colors.green
                                    : Colors.red),
                            MyText('${bid.bidPrice * 0.8}',
                                size: 14,
                                color: (action == 'accept')
                                    ? Colors.green
                                    : Colors.red)
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Note section
                  if (action == 'accept') const SizedBox(height: 15),
                  if (action == 'accept')
                    MyText(
                      'Note: All other bids will be removed after transaction is completed.',
                      size: 12,
                      spacing: 0.5,
                    ),

                  // Confirmation message
                  const SizedBox(height: 10),
                  MyText('Are you sure you wish to continue?'),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    if (action == 'accept') {
                      print('accept the bid -> ${bid.pID}');
                    } else {
                      print('Remove the bid -> ${bid.pID}');
                    }
                    Navigator.of(context).pop();
                  },
                  child: (action == 'accept')
                      ? MyText(
                          'Accept',
                          color: Colors.green,
                          weight: FontWeight.w600,
                          spacing: 1,
                        )
                      : MyText(
                          'Remove',
                          color: Colors.red,
                          weight: FontWeight.w600,
                          spacing: 1,
                        ),
                ),
                const SizedBox(width: 10),

                // Cancel Button
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: MyText('Cancel', color: Colors.white, spacing: 1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconButton _acceptOrDenyBidButtonBuilder(
      {required String task, required Function onTap}) {
    return IconButton(
      onPressed: () {
        onTap();
      },
      icon: Container(
        height: 25,
        width: 25,
        padding: (task == 'accept') ? null : const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: (task == 'accept') ? Colors.green : Colors.red,
        ),
        child: Center(
          child: (task == 'accept')
              ? const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: Colors.white,
                )
              : SizedBox(
                  child: Image.asset(
                    'assets/all_icons/xIcon.png',
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
