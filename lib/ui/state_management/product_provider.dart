import 'package:assignment/models/product_model.dart';
import 'package:assignment/services/api_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  bool _hasMore = true;
  final int _limit = 10;
  int _offset = 0;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  final ApiService apiService = ApiService();

  Future<void> fetchProducts() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    notifyListeners();
    
    try {
      List<Product> newProducts =
          await apiService.fetchProducts(_limit, _offset);

      if (newProducts.length < _limit) {
        _hasMore = false;
      }

      _products.addAll(newProducts.where((newProduct) => !_products
          .any((existingProduct) => existingProduct.id == newProduct.id)));
      _offset += newProducts.length;

    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
