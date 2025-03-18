import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider_test/models/products_model.dart';
import 'package:provider_test/jsons/products_json.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  double _filteredPrice = 0.0;
  List<String> _selectedBrands = [];

  List<Product> get allProducts =>
      _filteredProducts.isEmpty ? _products : _filteredProducts;

  int get productCount =>
      _filteredProducts.isEmpty ? _products.length : _filteredProducts.length;

  fetchProducts() async {
    final List data = productsJson;
    _products = data.map((e) => Product.fromJson(e)).toList();

    notifyListeners();
  }

  _applyFilters() {
    _filteredProducts = _products.where((e) {
      final filteredByBrands = _selectedBrands.isEmpty ||
          _selectedBrands.contains(e.brand.toLowerCase());
      final filteredByPrice =
          _filteredPrice == 0.0 || e.price <= _filteredPrice;
      return filteredByBrands && filteredByPrice;
    }).toList();
    log("${_filteredProducts.length}");
    notifyListeners();
  }

  filterbyBrand(List<String> brands) {
    _selectedBrands = brands;
    _applyFilters();
  }

  filterbyPrice(double price) {
    _filteredPrice = price;
    _applyFilters();
  }

  clearFilter() {
    _filteredPrice = 0.00;
    _selectedBrands = [];
    _filteredProducts = [];
    notifyListeners();
  }
}
