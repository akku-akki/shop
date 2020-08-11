import 'package:rxdart/rxdart.dart';
import 'package:shop/bloc/cartBloc.dart';
import 'package:shop/model/products.dart';

class SingleProductBloc {
  CartBloc cartBloc;

  final _message = PublishSubject<bool>();
  final _singleProduct = BehaviorSubject<Product>();
  final _buttonEnabled = BehaviorSubject<bool>.seeded(true);
  final _totalPrice = BehaviorSubject<double>.seeded(0.0);
  final _discount = BehaviorSubject<double>.seeded(0.0);
  final _totalQty = BehaviorSubject<int>.seeded(1);
  final _mrpSingle = BehaviorSubject<double>.seeded(0.0);

  Stream<bool> get enabled => _buttonEnabled.stream;
  Stream<int> get totalOTY => _totalQty.stream;
  Stream<double> get totalPrice => _totalPrice.stream;
  Stream<Product> get singleProduct => _singleProduct.stream;
  Stream<double> get discount => _discount.stream;
  Stream<double> get mrpSingle => _mrpSingle.stream;
  Stream<bool> get meaasga => _message.stream;

  Function get setSingleProduct => _singleProduct.sink.add;
  Function get setTotalQty => _totalQty.sink.add;
  Function get setDiscount => _discount.sink.add;
  Function get setTotalPrice => _totalPrice.sink.add;
  Function get setMrpSingle => _mrpSingle.sink.add;
  Function(bool) get setButtonEnabled => _buttonEnabled.sink.add;
  Function(bool) get setMessage => _buttonEnabled.sink.add; 

  void onSingleProductAdd(Product product) {
    setSingleProduct(product);
    double totalValue =
        _totalPrice.value + (product.price * product.quantityOrdered);
    double discount =
        _discount.value + (product.pricediscount * product.quantityOrdered);
    double mrp = _mrpSingle.value + (product.mrp * product.quantityOrdered);
        _totalQty.sink.add(product.quantityOrdered);
    _mrpSingle.sink.add(mrp);
    _discount.sink.add(discount);
    _totalPrice.sink.add(totalValue);
    setButtonEnabled(true);
  }

  void quantityAdd() {
    if (_singleProduct.value.quantityOrdered <= _singleProduct.value.max - 1) {
      _singleProduct.value.quantityOrdered++;
      double totalValue = _totalPrice.value + (_singleProduct.value.price);
      double discount = _discount.value + (_singleProduct.value.pricediscount);
      double mrp = _mrpSingle.value + (_singleProduct.value.mrp);
      _mrpSingle.sink.add(mrp);
      _totalQty.sink.add(_singleProduct.value.quantityOrdered);
      _totalPrice.sink.add(totalValue);
      _discount.sink.add(discount);
      _buttonEnabled.add(true);
    }
  }

  void quantityRemove() {
    if (_singleProduct.value.quantityOrdered <= 1 ||
        _singleProduct.value.quantityOrdered == 0) {
      if (_singleProduct.value.quantityOrdered > 0) {
        _singleProduct.value.quantityOrdered--;
        _totalQty.sink.add(_singleProduct.value.quantityOrdered);
        double value = _totalPrice.value - (_singleProduct.value.price);
        double discount =
            _discount.value - (_singleProduct.value.pricediscount);
        double mrp = _mrpSingle.value - (_singleProduct.value.mrp);
              _totalQty.sink.add(_singleProduct.value.quantityOrdered);
        _mrpSingle.sink.add(mrp);
        _totalPrice.sink.add(value);
        _discount.sink.add(discount);
      }else{
        _singleProduct.value.quantityOrdered = 0;
        _totalQty.sink.add(0);
        _mrpSingle.sink.add(0.0);
        _discount.sink.add(0.0);
        _totalPrice.sink.add(0.0);
      }
      _buttonEnabled.sink.add(false);
    } else {
      _singleProduct.value.quantityOrdered--;
      double value = _totalPrice.value - (_singleProduct.value.price);
      double discount = _discount.value - (_singleProduct.value.pricediscount);
      double mrp = _mrpSingle.value - (_singleProduct.value.mrp);
      _mrpSingle.sink.add(mrp);
      _totalQty.sink.add(_singleProduct.value.quantityOrdered);
      _totalPrice.sink.add(value);
      _discount.sink.add(discount);
      _buttonEnabled.add(true);
    }
  }

  void addToCart() {
    bool result = cartBloc.checkProduct(_singleProduct.value);
    if (result) {
      _message.add(true);
    } else {
      _message.add(false);
    }
  }

    void clearData () {
    setSingleProduct(null);
    setTotalQty(1);
    setTotalPrice(0.0);
    setDiscount(0.0);
    setMrpSingle(0.0);
  }

  void closeSubject() {
    _singleProduct.close();
    _buttonEnabled.close();
    _totalPrice.close();
    _discount.close();
    _totalQty.close();
    _mrpSingle.close();
    _message.close();
  }
}
