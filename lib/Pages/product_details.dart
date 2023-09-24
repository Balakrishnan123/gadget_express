import 'package:flutter/material.dart';
import 'package:gadget_express/components/cart_provider.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class ProductDetails extends StatefulWidget {
  final CartManager? cartManager;
  final prod_detail_name;
  final prod_detail_price;
  final prod_detail_old_price;
  final prod_detail_picture;


     const ProductDetails(
      {super.key,
        required this.cartManager,
        this.prod_detail_name,
        this.prod_detail_picture,
        this.prod_detail_old_price,
        this.prod_detail_price,
  //      CartManager? cartManager,
        });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.black26,
        title: const Text("Gadget Express"),
        actions:  <Widget>[
          const IconButton(
              icon: Icon(Icons.search, color: Colors.black), onPressed: null),
          IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(cartManager: widget.cartManager), // Pass the CartManager instance
                  ),
                );
              }),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: GridTile(
              footer: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Text(
                    widget.prod_detail_name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "\₹${widget.prod_detail_old_price}",
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )),
                      Expanded(
                          child: Text(
                        "\₹${widget.prod_detail_price}",
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      )),
                    ],
                  ),
                ),
              ),
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.prod_detail_picture),
              ),
            ),
          ),
          //====Buttons====
          Row(
            children: <Widget>[
              Expanded(
                  child: MaterialButton(
                      onPressed: () {},
                      color: Colors.white,
                      textColor: Colors.grey,
                      elevation: 0.2,
                      child: const Row(
                        children: <Widget>[
                          Expanded(child: Text("Quantity")),
                          Expanded(child: Icon(Icons.arrow_drop_down))
                        ],
                      ))),
              Expanded(
                  child: MaterialButton(
                      onPressed: () {},
                      color: Colors.white,
                      textColor: Colors.grey,
                      elevation: 0.2,
                      child: const Row(
                        children: <Widget>[
                          Expanded(child: Text("Color")),
                          Expanded(child: Icon(Icons.arrow_drop_down))
                        ],
                      ))),
            ],
          ),
          Row(children: <Widget>[
            Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    color: Colors.amber,
                    textColor: Colors.black,
                    elevation: 0.2,
                    child: const Text("Buy Now"))),
            IconButton(
                onPressed: () {
                  final product  = {
                    "name": widget.prod_detail_name,
                    "picture": widget.prod_detail_picture,
                    "price": widget.prod_detail_price,
                    "color": "white",
                    "quantity": 1,
                  };
                  print("Add to Cart Button Pressed: $product");
                  // Add the product to the cart using cartManager
                  widget.cartManager?.addToCart(product);
                  print("Cart Contains: ${widget.cartManager?.cartItems}");
                  // Show a snackbar or provide feedback to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product added to cart'),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                color: Colors.blue),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
                color: Colors.red)
          ]),

          const Divider(),
          const ListTile(
            title: Text("Product Details"),
            subtitle: Text(
                "Specifications are for those who are choosing to purchase a new laptop and need guidance on which specifications to go with. Also please visit our Preferred Vendors list to the left. As a rule of thumb, if you are buying a new laptop, most, if not all, specifications will be fine. However, these guidelines will provide you with a good starting point."),
          ),
          const Divider(),
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(widget.prod_detail_name))
            ],
          ),
          const Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Brand",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0), child: Text("HP"))
            ],
          ),
          const Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "RAM",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0), child: Text("8 GB"))
            ],
          ),
          const Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Storage",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0), child: Text("1 TB"))
            ],
          ),
          const Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Operating System",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0), child: Text("Windows"))
            ],
          ),
          const Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Processor Name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0), child: Text("MediaTek Kompanio 500"))
            ],
          ),

          const Divider(),
          const Padding(padding: EdgeInsets.all(8.0), child: Text("Similiar Products"),),


           SizedBox(
            height: 360.0,
            child: SimilarProducts(cartManager: widget.cartManager,),
          )
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  final CartManager? cartManager;

  const SimilarProducts({super.key, required this.cartManager});

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  var product_list = [

    {
      "name": "HP Chromebook",
      "picture": "Images/devices/l2.jpg",
      "old_price": 830000,
      "price": 670000,
    },
    {
      "name": "Iphone 12",
      "picture": "Images/devices/p1.jpg",
      "old_price": 50000,
      "price": 39999,
    },
    {
      "name": "Samsung Galaxy",
      "picture": "Images/devices/p2.jpg",
      "old_price": 35000,
      "price": 29999,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SimilarProd(
              prod_name: product_list[index]['name'],
              prod_pictures: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
              prod_cat: product_list[index]['category'],
              cartManager: widget.cartManager);
        });
  }
}
class SimilarProd extends StatelessWidget {

  const SimilarProd(
      {super.key,
        this.prod_name,
        this.prod_pictures,
        this.prod_old_price,
        this.prod_price,
        this.prod_cat,
        this.cartManager});

  final prod_name;
  final prod_pictures;
  final prod_old_price;
  final prod_price;
  final prod_cat;
  final CartManager? cartManager;

  @override

  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Consumer<CartManager>(
                    builder: (context, cartManager, child) {
                      return ProductDetails(
                        // Pass the product details and cartManager
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

