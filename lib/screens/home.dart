import 'package:flutter/material.dart';
import 'package:ticaret/screens/product.dart';

import '../components/grid_card.dart';
import '../components/loader.dart';
import '../models/product.dart';
import '../utils/firestore.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final data = ["1", "2"];

  Future<List<Product>>? products;

  @override
  void initState() {
    super.initState();
    products = FirestoreUtil.getProducts([]);
  }

  @override
  Widget build(BuildContext context) {
    onCardPress(Product product) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductScreen(
                    product: product,
                  )));
    }

    return FutureBuilder<List<Product>>(
        future: products,
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return GridView.builder(
                itemCount: snapshot.data?.length,
                padding: const EdgeInsets.symmetric(vertical: 30),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30),
                itemBuilder: (BuildContext context, int index) {
                  return GridCard(
                      //buraya ctrl sol tık yapıp grid_cart.dart a gidiyok
                      product: snapshot.data![index],
                      index: index,
                      onPress: () {
                        onCardPress(snapshot.data![
                            index]); //sıkıntı var geçici deneme yapıldı satır:30
                      });
                });
          } else {
            return const Center(child: Loader());
          }
        });
  }
}
