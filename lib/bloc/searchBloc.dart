import 'package:rxdart/rxdart.dart';
import 'package:shop/firebaseRepo/searchRepo.dart';
import 'package:shop/model/products.dart';

class SearchBloc {
  final SearchRepo searchRepo = SearchRepo();
  ProductListItems item;

  final _loading = BehaviorSubject<bool>();
  Stream<bool> get loading => _loading.stream;
  Function get setLoading => _loading.sink.add;

  final _searchTerm = BehaviorSubject<String>();
  Function get searchKeyWord => (String val) async {
        setLoading(true);
        print("loding");
        item = await searchRepo.searchProducts("rice", val);
        if (item != null) {
          _productList.sink.add(item);
        } else {
          _productList.sink.add(null);
        }
        setLoading(false);
        print("loding finish");
      };

  final _productList = BehaviorSubject<ProductListItems>.seeded(null);
  Stream<ProductListItems> get products => _productList.stream;
 
  void dispose() {
    _searchTerm.close();
    _loading.close();
    _productList.close();
  }
}
