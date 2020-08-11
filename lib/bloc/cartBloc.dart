import 'package:rxdart/rxdart.dart';
import 'package:shop/model/products.dart';
import './orderBloc.dart';

class CartBloc {
  OrderBloc order;

  final _productList = BehaviorSubject<List<Product>>.seeded([]);
  final _totalOrderPrice = BehaviorSubject<double>.seeded(0.0);
  final _discountPrice = BehaviorSubject<double>.seeded(0.0);
  final _deliveryCost = BehaviorSubject<double>.seeded(0.0);
  final _priceToBePaid = BehaviorSubject<double>.seeded(0.0);
  final _mrp = BehaviorSubject<double>.seeded(0.0);

  void clear() {
    _productList.sink.add([]);
    _totalOrderPrice.sink.add(0.0);
    _discountPrice.sink.add(0.0);
    _deliveryCost.sink.add(0.0);
    _priceToBePaid.sink.add(0.0);
    _mrp.sink.add(0.0);
  }

  Stream<List<Product>> get productList => _productList.stream;
  Stream<double> get totalOrderPrice => _totalOrderPrice.stream;
  Stream<double> get discountPrice => _discountPrice.stream;
  Stream<double> get deliveryCost => _deliveryCost.stream;
  Stream<double> get priceToBePaid => _priceToBePaid.stream;
  Stream<double> get mrp => _mrp.stream;

  Function get productBasket => _productList.sink.add;

  addToBasket(Product p) {
    _productList.value.add(p);
  }

  bool checkProduct(Product product) {
    if ((_productList.value.singleWhere((element) => element.uid == product.uid,
            orElse: () => null)) !=
        null) {
      print("item exist");
      return false;
    } else {
      onProductAdd(product);
      print("Added");
      return true;
    }
  }

  void onProductAdd(Product product) {
    addToBasket(product);
    productBasket(_productList.value);
    double value =
        _totalOrderPrice.value + (product.price * product.quantityOrdered);
    double discount = _discountPrice.value +
        (product.pricediscount * product.quantityOrdered);
    double mrp = _mrp.value + (product.mrp * product.quantityOrdered);
    _mrp.sink.add(mrp);
    _totalOrderPrice.sink.add(value);
    _discountPrice.sink.add(discount);
    _priceToBePaid.sink.add(_totalOrderPrice.value + _deliveryCost.value);
    print(_productList.value.first.name);
  }

  void onProductRemove(Product product) {
    print(product.uid);
    if (_productList.value.contains(product)) {
      _productList.value.remove(product);
      productBasket(_productList.value);
      double value =
          _totalOrderPrice.value - (product.price * product.quantityOrdered);
      double discount = _discountPrice.value -
          (product.pricediscount * product.quantityOrdered);
      double mrp = _mrp.value - (product.mrp * product.quantityOrdered);
      _mrp.sink.add(mrp);
      _totalOrderPrice.sink.add(value);
      _discountPrice.sink.add(discount);
      _priceToBePaid.sink.add(_totalOrderPrice.value + _deliveryCost.value);
    }
  }

  void onProductIncrease(Product product) {
    _productList.value.forEach((element) {
      if (element.uid == product.uid) {
        if (element.quantityOrdered <= element.max - 1) {
          element.quantityOrdered++;
          double value = _totalOrderPrice.value + (product.price);
          double discount = _discountPrice.value + (product.pricediscount);
          double mrp = _mrp.value + (product.mrp);
          _mrp.sink.add(mrp);
          _totalOrderPrice.sink.add(value);
          _discountPrice.sink.add(discount);
          _priceToBePaid.sink.add(_totalOrderPrice.value + _deliveryCost.value);
        } else {}
      }
    });
  }

  void onProductDecrease(Product product) {
    _productList.value.forEach((element) {
      if (element.uid == product.uid) {
        element.quantityOrdered--;
        if (element.quantityOrdered < 1) {
          _productList.value.remove(element);
          productBasket(_productList.value);
        }
        double value = _totalOrderPrice.value - (product.price);
        double discount = _discountPrice.value - (product.pricediscount);
        double mrp = _mrp.value - (product.mrp);
        _mrp.sink.add(mrp);
        _totalOrderPrice.sink.add(value);
        _discountPrice.sink.add(discount);
        _priceToBePaid.sink.add(_totalOrderPrice.value + _deliveryCost.value);
      }
    });
  }

  Future<bool> placeOrder() async {
    return await order.placeOrder(
        discount: _discountPrice.value,
        priceToBePaid: _priceToBePaid.value,
        product: _productList.value,
        totalMrp: _mrp.value);
  }

  void disposeSubjects() {
    _productList.close();
    _totalOrderPrice.close();
    _discountPrice.close();
    _deliveryCost.close();
    _priceToBePaid.close();
    _mrp.close();
  }
}
