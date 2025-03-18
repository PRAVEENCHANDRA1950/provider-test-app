import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/controllers/products_provider.dart';
import 'package:provider_test/models/products_model.dart';
import 'package:provider_test/widgets/filter_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          Selector<ProductsProvider, int>(
            selector: (context, provider) => provider.productCount,
            builder: (context, val, _) => Text("$val"),
          ),
          SizedBox(
            width: 80,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            productsProvider.fetchProducts();
          },
          label: Text("Get Products")),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FilterButtons(
                    icon: Icon(Icons.branding_watermark),
                    filterPressed: () {
                      productsProvider.filterbyBrand(["samsung", "apple"]);
                    },
                    label: "samsung\napple"),
                FilterButtons(
                    icon: Icon(Icons.currency_rupee),
                    filterPressed: () {
                      productsProvider.filterbyPrice(500);
                    },
                    label: "Price"),
                FilterButtons(
                    icon: Icon(Icons.clear_all),
                    color: Colors.red,
                    filterPressed: () {
                      productsProvider.clearFilter();
                    },
                    label: "Clear"),
              ],
            ),
          ),
          Consumer<ProductsProvider>(builder: (context, value, child) {
            if (value.allProducts.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: ListView.builder(
                  itemCount: value.allProducts.length,
                  itemBuilder: (context, i) {
                    Product product = value.allProducts[i];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                          "Brand: ${product.brand}, Price: ₹${product.price}"),
                    );
                  }),
            );
          })
        ],
      ),
    );
  }
}
