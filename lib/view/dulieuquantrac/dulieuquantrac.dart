import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/duLieuQuanTrac_model.dart';
import '../../services/server_service.dart';
import '../../services/homepage_service.dart';

class DuLieuQuanTrac extends StatefulWidget {
  const DuLieuQuanTrac({super.key});

  @override
  State<DuLieuQuanTrac> createState() => _DuLieuQuanTracState();
}

class _DuLieuQuanTracState extends State<DuLieuQuanTrac> {
  HomePageService homePageService = Get.put(HomePageService());
  late DuLieuQuanTracModel duLieuQuanTracModel;
  ServerService serverService = ServerService();

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(30 / sizeDevice, 0, 35 / sizeDevice, 0),
          height: 670 / sizeDevice,
          width: 1365 / sizeDevice,
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FractionColumnWidth(0.37),
                1: FractionColumnWidth(0.1),
                2: FractionColumnWidth(0.1),
                3: FractionColumnWidth(0.1),
                4: FractionColumnWidth(0.1),
                5: FractionColumnWidth(0.1),
                6: FractionColumnWidth(0.13),
              },
              children: [
                buildRow(
                    ['Thời gian', 'pH', 'COD', 'BOD', 'TSS', 'NH4', 'Nhiệt độ'],
                    isHeader: true),
                for (int i = 0; i < homePageService.listData.length; i++)
                  buildRow(homePageService.listData[i].toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow buildRow(List<dynamic> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((cell) {
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: isHeader ? 26 : 22);
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
              child: Text(
            cell.toString(),
            style: style,
          )),
        );
      }).toList());
}
