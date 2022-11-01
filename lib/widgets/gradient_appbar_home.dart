import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stupoll/main.dart';

import '../screens/auth/auth_screen.dart';
class GradientAppBarHome extends StatefulWidget {
  final String title;
  final double barHeight = 50.0;
  String? userId = FirebaseAuth.instance.currentUser!.uid!;
  GradientAppBarHome(this.title);

  @override
  State<GradientAppBarHome> createState() => _GradientAppBarHomeState(title);
}

class _GradientAppBarHomeState extends State<GradientAppBarHome> {
  @override
  final String title;
  final double barHeight = 50.0;
  String? userId = FirebaseAuth.instance.currentUser!.uid!;
  _GradientAppBarHomeState(this.title);
  //Read votes from database****************************
  /*Widget textB(){
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('myVotes').doc('$userId-Votes').get(),
      builder: (context, snapshot){
        if(snapshot.connectionState!= ConnectionState.done){
          return Text('!',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
        }
        return Text("${snapshot.data!['voteCount']}",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
      },
    );
  }*/
  //End
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        children: [
          SizedBox(width: 20,),
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.arrow_left,color: Colors.red,),
                Text(
                  'Exit',
                  style: TextStyle(fontSize: 22.0, color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: (){
              FirebaseAuth.instance.signOut();
              print('Jeeeeez calm down I have been clicked ok ?*****************');
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>MyApp()));
            },
          ),
          Spacer(),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('users').doc('$userId').get(),
            builder: (context, snapshot){
              if(snapshot.connectionState!= ConnectionState.done){
                return Text('!',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
              }
              return Text("${snapshot.data!['username']}",style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),);
            },
          ),
          Spacer(),
          Text(
            'Votes',
            style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10,),
          Container(
            width: 29,
            height: 29,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(40),),
              color: Colors.red,
            ),
            child: Center(child:
            FutureBuilder(
              future: FirebaseFirestore.instance.collection('myVotes').doc('Votes-$userId').get(),
              builder: (context, snapshot){
                if(snapshot.connectionState!= ConnectionState.done){
                  return Text('!',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
                }else if(snapshot.hasError){
                  return Text('?',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
                }else if(snapshot.data!['voteCount']==null){
                  return Text('?',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
                }
                int iVal = snapshot.data!['voteCount'] - 1;
                return Text("${iVal}",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
              },
            )
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.black, Colors.indigo],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
    );
  }
}
