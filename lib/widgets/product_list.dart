import 'package:flutter/material.dart';
import 'package:shoe_shop/global_var.dart';
import 'package:shoe_shop/widgets/product_card.dart';
import 'package:shoe_shop/pages/product_desc.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Puma'];
  late String selectedFilter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(40),
      ),
    );
    return SafeArea(
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Rugged",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Colors.grey
                          : Color.fromARGB(255, 230, 236, 239),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                      label: Text(
                        filter,
                        style: TextStyle(
                          fontWeight: selectedFilter == filter
                              ? FontWeight.w900
                              : FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDesc(product: product);
                        },
                      ),
                    );
                  },
                  child: ProductCard(
                    title: product['title'] as String,
                    price: product['price'] as double,
                    image: product['image'] as String,
                  ),
                );
              }),
        )
      ]),
    );
  }
}
