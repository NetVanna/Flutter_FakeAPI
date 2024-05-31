import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ProductDetails extends StatelessWidget {
  const ProductDetails(
      {super.key,
      required this.products,
      required this.title,
      required this.subtitle,
      required this.category});

  final dynamic products;
  final String title;
  final String subtitle;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
              ],
            ),
            Expanded(
              child: CachedNetworkImage(
                imageUrl: "$products",
                progressIndicatorBuilder: (context, url,
                    downloadProgress) =>
                    CircularProgressIndicator(
                        value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 30.0,
                          // Set the width of the circle
                          height: 30.0,
                          // Set the height of the circle (same as width)
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle, // Make the container a circle
                            color: Colors
                                .blue, // Set the background color of the circle (optional)
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50.0,
                          // Set the width of the circle
                          height: 50.0,
                          // Set the height of the circle (same as width)
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle, // Make the container a circle
                            color: Colors
                                .blue, // Set the background color of the circle (optional)
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.shopping_bag_outlined),
                              SizedBox(width: 5,),
                              Text("Add to Card"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
