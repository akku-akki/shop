import 'package:rxdart/rxdart.dart';
import 'package:shop/firebaseRepo/homeRepo.dart';
import 'package:shop/model/homeProducts.dart';
import 'package:shop/model/products.dart';
import '../model/faliure.dart';
class HomeBloc {
  HomeRepo homeRepo = HomeRepo();
  final _productItemsLoading = BehaviorSubject<bool>.seeded(false);
  final _loading = BehaviorSubject<bool>.seeded(false);
  final _itemList = BehaviorSubject<DisplayList>();
  final _faliure = PublishSubject<Faliure>();
  final _productListItems = BehaviorSubject<ProductListItems>();

  Stream<bool> get getLoading => _loading.stream;
  Function get setLoading => _loading.sink.add;
  Stream<DisplayList> get getitemList => _itemList.stream;
  Stream<Faliure> get faliure => _faliure.stream;
  Function get setFaliure => _faliure.sink.add;
  Stream<ProductListItems> get getProductList => _productListItems.stream;
  Stream<bool> get productLoading => _productItemsLoading.stream;

  Future<void> getSingularProductList(String value)async{
    print("Started");
   _productItemsLoading.sink.add(true);
   try{
    ProductListItems productItems = await homeRepo.getSingularProducts(value);

    _productListItems.sink.add(productItems);

   } on Faliure catch(f){
     setFaliure(f);
         _productItemsLoading.sink.add(false);
   }
    _productItemsLoading.sink.add(false);
        print("Started");

  }

  Future<void> loadHomeItems() async {
    setLoading(true);
    try {
      DisplayList itemList = await homeRepo.getHomeDisplayProducts();
      _itemList.sink.add(itemList);
    } on Faliure catch (f) {
      _faliure.sink.add(f);
    }
    setLoading(false);
  }

  void dispose() {
    _loading.close();
    _itemList.close();
    _faliure.close();
    _productListItems.close();
    _productItemsLoading.close();
  }
}
