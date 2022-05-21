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
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: customText(txt: 'Report', fsize: 20.0),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, ind) {
          return ExpansionTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            title: customText(txt: 'Operating Systems'),
            // childrenPadding: EdgeInsets.all(10.0),

            children: [
              Table(
                defaultColumnWidth: const FlexColumnWidth(4.0),
                columnWidths: const {
                  0: FlexColumnWidth(7.0),
                  1: FlexColumnWidth(8.0),
                  2: FlexColumnWidth(6.0),
                },
                children: [
                  TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                      ),
                      children: [
                        customText(
                            txt: 'Roll No', clr: Colors.white, padding: 10.0),
                        customText(
                            txt: 'Name', clr: Colors.white, padding: 10.0),
                        customText(
                            txt: 'Percentage',
                            clr: Colors.white,
                            padding: 10.0),
                      ]),
                  TableRow(children: [
                    customText(txt: 'BCSF18BM001', padding: 10.0),
                    customText(txt: 'Rustam Shakeel', padding: 10.0),
                    customText(
                        txt: '96%', padding: 10.0, txtalign: TextAlign.center),
                  ]),
                  TableRow(children: [
                    customText(txt: 'BCSF18BM002', padding: 10.0),
                    customText(txt: 'Amna Malik', padding: 10.0),
                    customText(
                        txt: '80%', padding: 10.0, txtalign: TextAlign.center),
                  ]),
                  TableRow(children: [
                    customText(txt: 'BCSF18BM003', padding: 10.0),
                    customText(txt: 'Sami Ullah', padding: 10.0),
                    customText(
                        txt: '99%', padding: 10.0, txtalign: TextAlign.center),
                  ]),
                  TableRow(children: [
                    customText(txt: 'BCSF18BM004', padding: 10.0),
                    customText(txt: 'Usman Fayaz', padding: 10.0),
                    customText(
                        txt: '60%', padding: 10.0, txtalign: TextAlign.center),
                  ]),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
