import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  UserImage(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;
  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  var myPic = ImageSource.camera;
  var pickedPic;
  void _pickImage(ImageSource myPic) async {
    //ImagePicker.pickImage(source: ImageSource.gallery);
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source:myPic,imageQuality: 50,maxWidth: 150);//getImage(...);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      pickedPic = pickedImageFile;
    });
    widget.imagePickFn(pickedPic);
  }


  /*Future pickImage()async{
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    /*setState(() {
      pickedPic = pickedImageFile as File;
    });*/
    return pickedImageFile;
  }*/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*CircleAvatar(
            radius: 50,
            backgroundImage: pickedPic != null ? FileImage(pickedPic) : null,
          backgroundColor: Colors.grey,
        ),*/
        pickedPic != null ? GestureDetector(
          child: CircleAvatar(
            radius: 34,
            backgroundImage: pickedPic != null ? FileImage(pickedPic) : null,
            backgroundColor: Colors.grey,
          ),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: Text('choose pic from',style: TextStyle(color: Colors.indigo),),
                    actions: [
                      //_pickImage();
                      MaterialButton(
                        child: Text('gallery'),
                        onPressed: (){
                          setState(() {
                            myPic = ImageSource.gallery;
                          });
                          _pickImage(myPic);
                          Navigator.pop(context);
                        },
                      ),
                      MaterialButton(
                        child: Text('camera'),
                        onPressed: (){
                          setState(() {
                            myPic = ImageSource.camera;
                          });
                          _pickImage(myPic);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          },
        ):
        GestureDetector(child:
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigo,
                  Colors.black,
                ],
              ),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              //color: myCol, //Change here***********************//
            ),
            padding: const EdgeInsets.all(8),
            width: 62,
            height: 62,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image,color: Colors.white),
                Text('add pic',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: Text('choose pic from',style: TextStyle(color: Colors.indigo),),
                    actions: [
                      //_pickImage();
                      MaterialButton(
                        child: Text('gallery'),
                        onPressed: (){
                          setState(() {
                            myPic = ImageSource.gallery;
                          });
                          _pickImage(myPic);
                          Navigator.pop(context);
                        },
                      ),
                      MaterialButton(
                        child: Text('camera'),
                        onPressed: (){
                          setState(() {
                            myPic = ImageSource.camera;
                          });
                          _pickImage(myPic);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          },
        ),
        //FlatButton.icon(onPressed: (){_pickImage();}, icon: Icon(Icons.image), label:Text('add pic'),textColor: Theme.of(context).primaryColor,),
        /*Container(
          width: 110,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey, // background
              onPrimary: Colors.white, // foreground
            ),
            child: Row(
              children: [
                Icon(Icons.image,/*color: Colors.teal*/),
                Text('add pic',/*style: TextStyle(color: Colors.teal),*/),
              ],
            ),
            onPressed: (){_pickImage();},
          ),
        )*/
      ],
    );
  }
}
