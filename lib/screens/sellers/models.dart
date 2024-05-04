class SellerData {
  SellerData({required this.sID, required this.name, required this.email});
  int sID;
  String name, email;
}

class SellerProductListItem {
  SellerProductListItem({
    required this.pID,
    required this.sID,
    required this.name,
    required this.desc,
    required this.status,
    this.bidders,
    this.date,
    this.price,
    this.listedDate,
    this.bID,
    this.buyerName,
  });

  bool? inTransit;
  int pID, sID;
  String name, desc, status;
  int? bID, price;
  String? date, listedDate, buyerName;
  List<int>? bidders; // List of buyers (bIDs) who have bid on the product
}

class BidItem {
  BidItem({
    required this.pID,
    required this.bidPrice,
    required this.bID,
    required this.bName,
  });
  int bidPrice, pID, bID;
  String bName;
}
