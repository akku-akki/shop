import 'package:rxdart/rxdart.dart';
import '../model/products.dart';
import '../model/order.dart';
import '../firebaseRepo/orderRepo.dart';
import '../offline/sharedPrefs.dart';
import '../model/faliure.dart';

class OrderBloc {
  OrderRepo orderRepo = OrderRepo();

  final _orderStatus = PublishSubject<bool>();
  final _getProducts = BehaviorSubject<OrderList>.seeded(null);
  Stream<OrderList> get productList => _getProducts.stream;
  Stream<bool> get orderStatus => _orderStatus.stream;

  Future<bool> placeOrder(
      {List<Product> product,
      double totalMrp,
      double discount,
      double priceToBePaid}) async {
    Order order = Order();

    final List<Map<String, dynamic>> orderMap = order.convertToOrder(product);
    print(orderMap);
    String id = await OfflineDetails.getUserId();
    print(id);
    order.delivered = false;
    order.discount = discount;
    order.order = orderMap;
    order.priceToBePaid = priceToBePaid;
    order.totalMrp = totalMrp;
    order.userId = id;
    order.cancel = false;
    order.milliSecondsFromEpoch = DateTime.now().millisecondsSinceEpoch;
    try {
      bool result = await orderRepo.placeOrder(order);
      return result;
    } on Faliure catch (f) {
      print(f.message);

      return false;
    }
  }

  Future<bool> cancelOrder(String docId) async {
    try {
      bool result = await orderRepo.cancelOrder(docId);
      if (result) {
        getMyOrders();
        _orderStatus.add(true);
      } else {
        _orderStatus.add(false);
      }
    } on Faliure catch (f) {
      print(f.message);
    }
  }

  Future<OrderList> getMyOrders() async {
    OrderList orders;
    try {
      orders = await orderRepo.getMyOrders();
      _getProducts.sink.add(orders);
    } on Faliure catch (f) {
      print(f.message);
    }
  }

  closeSubject() {
    _orderStatus.close();
    _getProducts.close();
  }
}
