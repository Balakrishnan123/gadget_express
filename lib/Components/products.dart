import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Pages/product_details.dart';
import 'package:gadget_express/components/cart_provider.dart';


class Products extends StatefulWidget {
  final CartManager? cartManager;
   const Products({super.key, required this.cartManager});


  @override
  State<Products> createState() => _ProductsState();
}


class _ProductsState extends State<Products> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator
        }

        final products = snapshot.data!.docs;

        return GridView.builder(
          itemCount: products.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            final productData = products[index].data() as Map<String, dynamic>;

            return Single_Prod(
              cartManager: widget.cartManager,
              prod_name: productData['name'],
              prod_pictures: productData['picture'],
              prod_old_price: productData['old_price'],
              prod_price: productData['price'],
              prod_cat: productData['category'],
              addToCart: (product) {
                widget.cartManager?.addToCart(product);
              },
              index: index,
            );
          },
        );
      },
    );
}
}

class Single_Prod extends StatelessWidget {
  const Single_Prod(
      {super.key,
        required this.addToCart,
        required this.cartManager,
        required this.index,
      this.prod_name,
      this.prod_pictures,
      this.prod_old_price,
      this.prod_price,
        this.prod_cat});

  final prod_name;
  final prod_pictures;
  final prod_old_price;
  final prod_price;
  final prod_cat;
  final int index;
  final CartManager? cartManager;
  final Function(Map<String, dynamic>) addToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: '${prod_name}_$index',
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Consumer<CartManager>(
                    builder: (context, cartManager, child) {
                      return ProductDetails(
                        prod_detail_name: prod_name,
                        prod_detail_picture: prod_pictures,
                        prod_detail_old_price: prod_old_price,
                        prod_detail_price: prod_price,
                        cartManager: cartManager,
                      );
                    },
                  );
                }),
                  ),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "\₹$prod_price",
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "\₹$prod_old_price",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.lineThrough),
                      ),
                   /*  trailing: IconButton(
                       onPressed: () {
                         Map<String, dynamic> product = {
                           "name": prod_name,
                           "picture": prod_pictures,
                           "price": prod_price,
                           // Add other product details as needed
                         };
                         // Call the addToCart function
                         addToCart(product);
                       }, icon: const Icon(Icons.add_shopping_cart),
                     ),*/
                    ),
                  ),
                  child: Image.asset(
                    prod_pictures,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
