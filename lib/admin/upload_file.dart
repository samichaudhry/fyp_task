import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_task/custom%20widgets/custom_widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:path/path.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({ Key? key }) : super(key: key);

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {

 bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "obs"){
        visibilityObs = visibility;
      }
    });
  }


  Widget custombutton(title,icon,onclick){
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal:20 ,vertical: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape:StadiumBorder() ,
                  primary: Colors.teal,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                   Icon(icon, size: 28),
                    const SizedBox(width: 16),
                   customText(txt: title,fsize: 22.0)
                  ],
                ),
                onPressed: onclick
              ),
            );
  }
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: customText(txt: 'Upload File', fsize: 20.0),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
           custombutton('Download Templete', Icons.cloud_upload_outlined,  (){}),
        
         SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
         custombutton('Select File', Icons.attach_file,  selectFile),
        
          customText(txt: fileName,fsize: 16.0,fweight: FontWeight.w500),
          SizedBox(height:MediaQuery.of(context).size.height * 0.03,),
         visibilityObs? Column(
           children: [
             custombutton('Upload File',Icons.cloud_upload_outlined, (){}),
              SizedBox(height:MediaQuery.of(context).size.height * 0.05,),
           CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 7.0,
                      percent: 0.70,
                      center: const Text("70%"),
                      progressColor: Colors.teal,
                    ), 
           ],
         ):SizedBox()
        ]
      ),
    );
  }

  Future<void> selectFile() async {
    
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
     visibilityObs ? null : _changed(true, "obs");
  }
}
