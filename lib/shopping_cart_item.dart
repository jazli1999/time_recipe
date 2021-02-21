import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'model/task.dart';
import 'styles.dart';

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    this.index,
    this.task,
    this.quantity,
    this.lastItem,
    this.formatter,
  });

  final Task task;
  final int index;
  final int quantity;
  final bool lastItem;
  final NumberFormat formatter;
  
  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              task.assetName,
              package: task.assetPackage,
              fit: BoxFit.cover,
              width: 76,
              height: 76,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task.name,
                    style: Styles.productRowItemName,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    '\$${task.price}',
                    style: Styles.productRowItemPrice,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '\$${task.price}',
              style: Styles.productRowTotal,
            ),
          )
        ]
      )
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16
          ),
          child: Container(
            height: 1,
            color: Styles.productRowDivider,
          )
        )
      ]
    );
  }
}