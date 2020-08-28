import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  Function setImageFile;

  UserImagePicker(this.setImageFile);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _imageFile;
  final _picker = ImagePicker();

  Future<void> _getimage() async{

    PickedFile _img = await _picker.getImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 140);
    if(_img == null)
      return;
    setState(() {
      _imageFile = File(_img.path);
    });
    widget.setImageFile(_imageFile);

//    print(_imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            backgroundImage: _imageFile !=null? FileImage(_imageFile) : null,
            radius: 35,
        ),
        OutlineButton.icon(
            onPressed: () {
              // picked image from camera
              _getimage();
            },
            icon: Icon(Icons.camera),
            label:Text("Pick image"))

      ],
    );
  }
}

