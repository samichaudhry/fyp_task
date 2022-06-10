import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final icon;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(bottom: 0, right: 4, child: buildEditIcon()),
        ],
      ),
    );
  }

  Widget buildImage() {
    var image;
    if(imagePath.contains('https')){
    image = CachedNetworkImageProvider(imagePath);
    }else{
      image = FileImage(File(imagePath));
    }

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child:  CircleAvatar(
                          radius: 50.0,
                          foregroundImage: image,
                          child: const Icon(
                            Icons.person,
                            size: 80.0,
                            color: Colors.white,
                          ),
                        )
        // child: Ink.image(
        //   image: image,
        //   fit: BoxFit.cover,
        //   width: 128,
        //   height: 128,
        // ),
      ),
    );
  }

  Widget buildEditIcon() => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
            color: Colors.teal,
            all: 8,
            child: InkWell(
              onTap: onClicked,
              child: Icon(icon, color: Colors.white, size: 20),
            )),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  void setState(Null Function() param0) {}
}