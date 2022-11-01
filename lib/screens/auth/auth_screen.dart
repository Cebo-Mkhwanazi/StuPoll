//import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/auth/auth_form.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String password, String username,bool isLogin,BuildContext ctx) async {
    UserCredential authResult;
    try{
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        String? userId = authResult.user?.uid;
        //Create Users collection
        await FirebaseFirestore.instance.collection('users').doc(authResult.user?.uid).set({
          'username': username,
          'email': email,
          'userId': authResult.user?.uid,
        });//End
        //Create Chair Document etc...
        await FirebaseFirestore.instance.collection('myVotes').doc('Votes-$userId').set({
          'voteCount': 6,
        });
        await FirebaseFirestore.instance.collection('myVotes').doc('Chair-$userId').set({
          'chairBool': false,
         // 'voteCount': 5,
        });
        await FirebaseFirestore.instance.collection('myVotes').doc('Fin-$userId').set({
          'finBool': false,
          //'voteCount': 5,
        });
        await FirebaseFirestore.instance.collection('myVotes').doc('Rao-$userId').set({
          'raoBool': false,
          //'voteCount': 5,
        });
        await FirebaseFirestore.instance.collection('myVotes').doc('Sec-$userId').set({
          'secBool': false,
          //'voteCount': 5,
        });
        await FirebaseFirestore.instance.collection('myVotes').doc('Sup-$userId').set({
          'supBool': false,
          //'voteCount': 5,
        });
      }
    } on PlatformException catch(e){
      String? message = 'an error occured, please check your credentials bro...';
      if(e.message != null){
        message = e.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message!),backgroundColor: Theme.of(context).errorColor,));
      setState(() {
        _isLoading = false;
      });
    } catch (e){
      print(e);
      _isLoading = false;
      String err = e.toString();
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(err),backgroundColor: Theme.of(context).errorColor,));
    }
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.centerRight,
      //         colors: [Colors.orange,Colors.red, Colors.green,])),
      //color: Colors.white,
      child: Scaffold(
        //backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        body: AuthForm(_submitAuthForm,_isLoading),
      ),
    );
  }
}
