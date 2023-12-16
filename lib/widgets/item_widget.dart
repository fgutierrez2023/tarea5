import 'package:tarea5/db/db_admin.dart';
import 'package:tarea5/models/bill_model.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  BillModel billProduct;
  final Function updateData;
  final Function mostrarModal;
  ItemWidget({
    required this.billProduct,
    required this.updateData,
    required this.mostrarModal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.shopping_cart,
          color: Colors.blue,
          size: 30,
        ),
        title: Text(
          billProduct.product,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        subtitle: Row(
          children: [
            Text(
              billProduct.type,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: 15,
            ),

            Text(
              billProduct.price.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                mostrarModal(billProduct.id, billProduct.product,
                    billProduct.price, billProduct.type);
              },
              child: Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                DBAdmin().delBill(billProduct.id!).then((value) {
                  updateData();
                });
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
