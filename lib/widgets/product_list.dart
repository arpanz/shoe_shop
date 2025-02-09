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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final brandMatch =
          selectedFilter == 'All' || product['company'] == selectedFilter;
      final searchMatch =
          product['title'].toString().toLowerCase().contains(_searchQuery);
      return brandMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(40)),
    );

    return GestureDetector(
      onTap: () {
        _searchFocusNode.unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.opaque,
      child: SafeArea(
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Rugged",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  autofocus: false, // Prevent auto-focus on screen load
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: filters.map((filter) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: selectedFilter == filter,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = selected ? filter : filters[0];
                      });
                      _searchFocusNode.unfocus(); // Remove focus from search
                    },
                    labelStyle: TextStyle(
                      fontWeight: selectedFilter == filter
                          ? FontWeight.w900
                          : FontWeight.w800,
                      fontSize: 17,
                    ),
                    selectedColor: Colors.grey,
                    backgroundColor: const Color.fromARGB(255, 230, 236, 239),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Text(
                      'No products found',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDesc(
                                  product: product as Map<String, Object>),
                            ),
                          );
                          _searchFocusNode.unfocus(); // Remove search focus
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
      ),
    );
  }
}
