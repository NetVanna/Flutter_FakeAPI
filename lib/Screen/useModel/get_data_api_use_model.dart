import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fake_api/models/product_res_model.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';

class GetData extends StatelessWidget {
  const GetData({super.key});

  Future<List<ProductResModel>> getProduct() async {
    final response = await http.get(Uri.parse(kProductUrl));
    final data = jsonDecode(response.body);
    return data.map<ProductResModel>((e)=>ProductResModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        body: FutureBuilder<List<ProductResModel>>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data?[index];
                return SingleChildScrollView(
                  child: Card(
                    child: Container(
                      color: Colors.white60,
                      width: double.infinity / 2,
                      height: 200,
                      child: Column(
                        children: [
                          Image.network(
                            product!.image.toString(),
                            height: 80,
                            width: 800,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Flexible(
                            child: SizedBox(
                              child: Text("${product.title}"),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$${product.price}"),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_border),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,

              ),
            );
          },
          future: getProduct(),
        ));
  }
}
