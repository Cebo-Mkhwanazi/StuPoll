import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../widgets/pickers/user_image.dart';
import '../start.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  final nameCon = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    nameCon.dispose();
    super.dispose();
  }

  final partyName = TextEditingController();
  final chairCon = TextEditingController();
  final finCon = TextEditingController();
  final raoCon = TextEditingController();
  final secCon = TextEditingController();
  final supCon = TextEditingController();
  bool isPressed = false;
  File? pImageFile;
  File? cImageFile;
  File? fImageFile;
  File? rImageFile;
  File? secImageFile;
  File? supImageFile;
  String col = 'green';
  void _pickedImage(File image) {
    pImageFile = image;
  }
  void _pickedImage2(File image) {
    cImageFile = image;
  }
  void _pickedImageF(File image) {
    fImageFile = image;
  }
  void _pickedImageR(File image) {
    rImageFile = image;
  }
  void _pickedImageSec(File image) {
    secImageFile = image;
  }
  void _pickedImageSup(File image) {
    supImageFile = image;
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String getRandomString2(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Create Profile",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 40,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext) => StartPage()));
                  },
                ),
                Text(
                  "Secure",
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Party Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserImage(_pickedImage),
                SizedBox(
                  width: 10,
                ),
                inputText('party_name', 'Name of party', partyName.text, 150,
                    partyName),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'ChairPerson',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    UserImage(_pickedImage2),
                    SizedBox(
                      width: 10,
                    ),
                    inputText('chair', 'Name of candidate', chairCon.text, 150,
                        chairCon),
                  ],
                ),
              ],
            ),
            //Start***********************
            SizedBox(
              height: 20,
            ),
            Text(
              'Finance Officer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    UserImage(_pickedImageF),
                    SizedBox(
                      width: 10,
                    ),
                    inputText('fin', 'Name of candidate', finCon.text, 150,
                        finCon),
                  ],
                ),
              ],
            ),//End ////////////////////////////////////////////////////////////////////////
            SizedBox(
              height: 20,
            ),
            Text(
              'RAO',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    UserImage(_pickedImageR),
                    SizedBox(
                      width: 10,
                    ),
                    inputText('rao', 'Name of candidate', raoCon.text, 150,
                        raoCon),
                  ],
                ),
              ],
            ),
            //Start***********************
            SizedBox(
              height: 20,
            ),
            Text(
              'Secretary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    UserImage(_pickedImageSec),
                    SizedBox(
                      width: 10,
                    ),
                    inputText('sec', 'Name of candidate', secCon.text, 150,
                        secCon),
                  ],
                ),
              ],
            ),//
            //End*******************
            //Start***********************
            SizedBox(
              height: 20,
            ),
            Text(
              'Support',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    UserImage(_pickedImageSup),
                    SizedBox(
                      width: 10,
                    ),
                    inputText('sup', 'Name of candidate', supCon.text, 150,
                        supCon),
                  ],
                ),
              ],
            ),//
            //End*******************
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
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
                width: 150,
                height: 60,
                child: Center(
                    child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                )),
              ),
              onTap: () async {
                //Start*********************
                final ref = FirebaseStorage.instance
                    .ref()
                    .child('images')
                    .child(partyName.text + getRandomString(5) + '.jpg');
                await ref
                    .putFile(pImageFile!)
                    .whenComplete(() => print('Uploading party Image Done'));
                final url1 = await ref.getDownloadURL();
                //End************************

                //Start*********************
                final ref2 = FirebaseStorage.instance
                    .ref()
                    .child('images')
                    .child(partyName.text + getRandomString2(5) + '.jpg');
                await ref2
                    .putFile(cImageFile!)
                    .whenComplete(() => print('Uploading chairperson Image Done'));
                final url2 = await ref2.getDownloadURL();
                //End*********************
                FirebaseFirestore.instance
                    .collection('chairperson')
                    .doc('${partyName.text}')
                    .set({
                  //'color': col,
                  'image_url1': url1,
                  'image_url2': url2,
                  'name': chairCon.text,
                  'pname': partyName.text.toUpperCase(),
                });

                //Start*********************
                final refF = FirebaseStorage.instance
                    .ref()
                    .child('images')
                    .child(partyName.text + getRandomString2(5) + '.jpg');
                await refF
                    .putFile(fImageFile!)
                    .whenComplete(() => print('Uploading Finance Officer Image Done'));
                final urlF = await refF.getDownloadURL();
                FirebaseFirestore.instance
                    .collection('finance_officer')
                    .doc('${partyName.text}')
                    .set({
                  //'color': col,
                  'image_url1': url1,
                  'image_url2': urlF,
                  'name': finCon.text,
                  'pname': partyName.text.toUpperCase(),
                });
                //end****************************
                //Start*********************
                final refR = FirebaseStorage.instance
                    .ref()
                    .child('images')
                    .child(partyName.text + getRandomString2(5) + '.jpg');
                await refR
                    .putFile(rImageFile!)
                    .whenComplete(() => print('Uploading RAO Image Done'));
                final urlR = await refR.getDownloadURL();
                FirebaseFirestore.instance
                    .collection('rao')
                    .doc('${partyName.text}')
                    .set({
                  //'color': col,
                  'image_url1': url1,
                  'image_url2': urlR,
                  'name': raoCon.text,
                  'pname': partyName.text.toUpperCase(),
                });
                //end****************************
                //Start*********************
                final refSec = FirebaseStorage.instance
                    .ref()
                    .child('images')
                    .child(partyName.text + getRandomString2(5) + '.jpg');
                await refSec
                    .putFile(secImageFile!)
                    .whenComplete(() => print('Uploading Secretary Image Done'));
                final urlSec = await refSec.getDownloadURL();
                FirebaseFirestore.instance
                    .collection('secretary')
                    .doc('${partyName.text}')
                    .set({
                  //'color': col,
                  'image_url1': url1,
                  'image_url2': urlSec,
                  'name': secCon.text,
                  'pname': partyName.text.toUpperCase(),
                });
                //end****************************
                //Start*********************
                final refSup = FirebaseStorage.instance
                    .ref()
                    .child('images')
                    .child(partyName.text + getRandomString2(5) + '.jpg');
                await refSup
                    .putFile(supImageFile!)
                    .whenComplete(() => print('Uploading Support Image Done'));
                final urlSup = await refSup.getDownloadURL();
                FirebaseFirestore.instance
                    .collection('support')
                    .doc('${partyName.text}')
                    .set({
                  //'color': col,
                  'image_url1': url1,
                  'image_url2': urlSup,
                  'name': supCon.text,
                  'pname': partyName.text.toUpperCase(),
                });
                //end****************************
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Text('Party Added Succesfully',style: TextStyle(color: Colors.indigo),),
                        actions: [
                          //_pickImage();
                          MaterialButton(
                            child: Text('Ok'),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>StartPage()));
                            },
                          ),
                        ],
                      );
                    }
                );

              },
            ),
          ],
        ),
      ),
    );
  }

  Widget inputText(String myKey, String Name, String myController,
      double myWidth, TextEditingController myCon) {
    return Container(
      width: myWidth,
      child: TextFormField(
        controller: myCon,
        key: ValueKey(myKey),
        validator: (value) {
          if (value!.isEmpty) {
            return 'please enter $Name';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            // fillColor: Colors.tealAccent,
            //   filled: false,
            focusColor: Colors.teal,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            isDense: true,
            labelText: '$Name',
            hintText: '',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelStyle: const TextStyle(fontSize: 16),
            labelStyle: const TextStyle(fontSize: 13, color: Colors.teal)),
        onSaved: (value) {
          myController = value!;
        },
      ),
    );
  }
}
