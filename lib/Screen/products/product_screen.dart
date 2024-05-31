import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../product_detail/product_detail.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  Future<List<dynamic>> getProduct() async {
    var url = Uri.parse(kProductUrl);
    final response = await http.get(url);
    final data =
        jsonDecode(response.body); // convert json string that allow dart know
    return data;
  }

  Future<List<dynamic>> getProductCategory() async {
    var url = Uri.parse(kProductCategoryUrl);
    final response = await http.get(url);
    final data =
        jsonDecode(response.body); // convert json string that allow dart know
    return data;
  }

  void buildButtonSheet(BuildContext context, List<dynamic> listCategories) {
    showModalBottomSheet(
      elevation: 10,
      context: context,
      builder: (context) => Container(
        color: Colors.white54,
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: listCategories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listCategories[index]),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.location_on_sharp)),
            )
          ],
          title: const Text(
            "Flutter Api Fake Store",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.refresh),
        ),
        body: FutureBuilder<List>(
          future: Future.wait([
            getProduct(), // Your first future function
            getProductCategory() // Your second future function
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search anything....",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () =>
                            buildButtonSheet(context, snapshot.data![1]),
                        child: Container(
                          width: 50,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: snapshot.data![0].length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![0][index];
                      return SingleChildScrollView(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  products: product['image'],
                                  title: product['title'],
                                  subtitle: product['description'],
                                  category: product['category'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Container(
                              color: Colors.white60,
                              width: double.infinity / 2,
                              height: 200,
                              child: Expanded(
                                child: Column(
                                  children: [
                                    // Image.network(
                                    //   product['image'],
                                    //   height: 80,
                                    //   width: 800,
                                    // ),
                                    CachedNetworkImage(
                                      height: 80,
                                      width: 800,
                                      imageUrl: "${product['image']}",
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        child: Text("${product['title']}"),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("\$${product['price']}"),
                                        IconButton(
                                          onPressed: () {},
                                          icon:
                                              const Icon(Icons.favorite_border),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 10,
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
