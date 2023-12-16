import 'package:tarea5/db/db_admin.dart';
import 'package:tarea5/models/bill_model.dart';
import 'package:tarea5/pages/modals/register_modal.dart';
import 'package:tarea5/pages/modals/update_modal.dart';
import 'package:tarea5/widgets/item_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> gastosList = [];
  List<BillModel> gastosBill = [];
  

  showRegisterModal() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // height: 200,
          // color: Colors.white,
          child: RegisterModal(),
        );
      },
    ).then((value) {
      getDataGeneralBillModel();
    });
  }


  showUpdateModal(int gasto_id,String gasto_nombre,double gasto_precio,String gasto_tipo) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: UpdateModal(gasto_id,gasto_nombre,gasto_precio,gasto_tipo),
        );
      },
    ).then((value) {
      getDataGeneralBillModel();
    });
  }

  // Future<void> getDataGeneralMap() async {
  //   gastosList = await DBAdmin().obtenerGastos();
  //   print("RECUPERANDO LA BD Y ASIGNANDOLA EN NUESTRA LISTA");
  //   print(gastosList);
  //   setState(() {});
  // }

  Future<void> getDataGeneralBillModel() async {
    gastosBill = await DBAdmin().getBills();
    print("RECUPERANDO LA BD Y ASIGNANDOLA EN NUESTRA LISTA de BILLS MODEL");
    print(gastosBill);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // getDataGeneralMap();
    getDataGeneralBillModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  showRegisterModal();
                  // DBAdmin().obtenerGastos();
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Agregar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(34),
                      bottomRight: Radius.circular(34),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Resumen de gastos",
                            style: TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text("Gestiona tus gastos de la mejor forma"),
                          Divider(
                            height: 24,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: gastosBill.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(

                                  child: ItemWidget(
                                    billProduct: gastosBill[index],
                                    updateData: getDataGeneralBillModel,
                                    mostrarModal: showUpdateModal,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ],
      ),
    );
  }
}
