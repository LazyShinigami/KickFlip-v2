class SellerData {
  SellerData({required this.sID, required this.name, required this.email});
  int sID;
  String name, email;
}

class BidItem {
  BidItem({
    required this.pID,
    required this.bidAmount,
    required this.bID,
    required this.bName,
    required this.bidderUID,
    required this.sID,
    required this.status,
  });
  int bidAmount, pID, bID, bidderUID, sID;
  String bName, status;
}
