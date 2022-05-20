import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';

class AttendanceData extends StatefulWidget {
  const AttendanceData({Key? key}) : super(key: key);

  @override
  State<AttendanceData> createState() => _AttendanceDataState();
}

class _AttendanceDataState extends State<AttendanceData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(txt: 'Report'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: customText(
                    txt: 'BSCS-R-2018-2022',
                    fsize: 20.0,
                    fweight: FontWeight.w500)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Center(
              child: DataTable(
                columnSpacing: 20.0,
                showBottomBorder: true,
                columns: [
                  DataColumn(
                      label: customText(
                          txt: 'RollNo',
                          fsize: 19.0,
                          fweight: FontWeight.w400)),
                  DataColumn(
                      label: customText(
                          txt: 'Name', fsize: 19.0, fweight: FontWeight.w400)),
                  DataColumn(
                      label: customText(
                          txt: 'subject',
                          fsize: 19.0,
                          fweight: FontWeight.w400)),
                  DataColumn(
                      label: customText(
                          txt: 'percentage',
                          fsize: 19.0,
                          fweight: FontWeight.w400)),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(SizedBox(
                      child: customText(
                          fsize: 17.0,
                          fweight: FontWeight.w400,
                          txt: 'BCSF18BM001'),
                    )),
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'Rustam Shakeel')),
                    // DataCell(Text('2018-2022')),
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'Operating System')),
                    DataCell(customText(
                        fsize: 17.0, fweight: FontWeight.w400, txt: '85%')),
                  ]),
                  DataRow(cells: [
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'BCSF18BM002')),
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'Amna Malik')),
                    // DataCell(Text('2018-2022')),
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'Operating System')),
                    DataCell(customText(
                        fsize: 17.0, fweight: FontWeight.w400, txt: '95%')),
                  ]),
                  DataRow(cells: [
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'BCSF18BM003')),
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'Sami Ullah')),
                    // DataCell(Text('2018-2022')),
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'Operating System')),
                    DataCell(customText(
                        fsize: 17.0, fweight: FontWeight.w400, txt: '99%')),
                  ]),
                  DataRow(cells: [
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'BCSF18BM004')),
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'Usman Fayaz')),
                    // DataCell(Text('2018-2022')),
                    DataCell(customText(
                        fsize: 17.0,
                        fweight: FontWeight.w400,
                        txt: 'Operating System')),
                    DataCell(customText(
                        fsize: 17.0, fweight: FontWeight.w400, txt: '65%')),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
