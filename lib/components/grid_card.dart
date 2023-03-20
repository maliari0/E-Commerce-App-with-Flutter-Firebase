import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

import '../utils/custom_theme.dart';

class GridCard extends StatelessWidget {
  final int index;
  final void Function() onPress;

  final Product product;

  const GridCard(
      {Key? key,
      required this.product,
      required this.index,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index % 2 == 0
          ? const EdgeInsets.only(left: 22)
          : const EdgeInsets.only(right: 22),
      decoration: CustomTheme.getCardDecoration(),
      child: GestureDetector(
        onTap: onPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: [
              Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                    ), // CachedNetworkImage
                  )),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ), // Text
                      ),
                      Text(
                        product.price.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ) // Text
                    ]), // Column
                  )) // Center, Expanded
            ],
          ),
        ),
      ),
    );
  }
}
