import 'package:tarea5/db/db_admin.dart';
import 'package:tarea5/models/bill_model.dart';
import 'package:tarea5/widgets/textfield_normal_widget.dart';
import 'package:flutter/material.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({super.key});

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  TextEditingController _productController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34.0),
          topRight: Radius.circular(34.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Registra el gasto"),
          SizedBox(
            height: 16,
          ),
          TextFieldNormalWidget(
              hintText: "Ingresa el título", controller: _productController),
          SizedBox(
            height: 16,
          ),
          TextFieldNormalWidget(
            hintText: "Ingresa el monto",
            controller: _priceController,
            isNumber: true,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.19),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Seleccione el tipo",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                DropdownButton(
                  // isExpanded: true,
                  // menuMaxHeight: 300,

                  hint: Text("Seleccione"),
                  items: [
                    DropdownMenuItem(
                      value: "kg",
                      child: Text("Kg."),
                    ),
                    DropdownMenuItem(
                      value: "lt",
                      child: Text("Lt."),
                    ),
                    DropdownMenuItem(
                      value: "lata",
                      child: Text("Lata"),
                    ),
                  ],
                  onChanged: (seleccionActual) {
                    _typeController.text = seleccionActual!;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                //SIN PATRÓN SINGLETON CADA QUE SE PRESIONA EL BOTÓN SE CREA UNA INSTANCIA DE DBadmin
                // DBAdmin dbAdmin = DBAdmin();
                // dbAdmin.checkDataBase();
                // dbAdmin.insertarGasto();

                //CON PATRÓN SINGLETON, SOLO EXISTE UNA SOLA INSTANCIA DE DBADMIN Y ES GLOBAL
                // DBAdmin().obtenerGastos();
                // DBAdmin().insertarGasto("Arrzon", 2.5, "Kg.");
                Map<String, dynamic> value = {
                  "product": _productController.text,
                  "price": double.parse(_priceController.text),
                  "type": _typeController.text,
                };

                BillModel model = BillModel(
                  product: _productController.text,
                  price: double.parse(_priceController.text),
                  type: _typeController.text,
                );

                DBAdmin().insertarGasto(model).then((value) {
                  if (value > 0) {
                    //se ha insertado correctamente
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        content: Text("Se realizo el registro correctamente"),
                      ),
                    );
                    Navigator.pop(context);
                  } else {}
                }).catchError((error) {
                  print(error);
                });

                // DBAdmin().obtenerGastos();
              },
              child: const Text(
                "Agregar",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff101321),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}