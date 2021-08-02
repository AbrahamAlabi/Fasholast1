class PaymentsModel {
  static const ID = "id";
  static const PAYMENT_ID = "paymentId";
  static const CART = "cart";
  static const SUM = "sum";
  static const RANK = "rank";
  static const MADE_AT = "madeAt";

  String id;
  String paymentId;
  String sum;
  String rank;
  int madeAt;
  List cart;

  PaymentsModel({this.id, this.paymentId, this.sum, this.rank, this.madeAt, this.cart});

  PaymentsModel.fromMap(Map data){
    id = data[ID];
    madeAt = data[MADE_AT];
    paymentId = data[PAYMENT_ID];
    sum = data[SUM];
    rank = data[RANK];
    cart = data[CART];
  }
}