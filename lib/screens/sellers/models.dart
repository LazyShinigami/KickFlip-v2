class SellerData {
  SellerData({required this.sID, required this.name, required this.email});
  int sID;
  String name, email;
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
