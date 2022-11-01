import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stupoll/screens/home2.dart';
import 'package:firebase_auth/firebase_auth.dart';
class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 50.0;
  String? userId = FirebaseAuth.instance.currentUser!.uid!;
  bool isIt = false;
  GradientAppBar(this.title);
  //Read votes from database****************************
  Widget textB(){
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('myVotes').doc('Votes-$userId').get(),
      builder: (context, snapshot){
        if(snapshot.connectionState!= ConnectionState.done){
          return Text('!',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
        }
        int iVal = snapshot.data!['voteCount']-1;
        return Text("${iVal}",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
      },
    );
  }
  //End
  @override
  Widget build(BuildContext context) {

    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>HomeScreen2()));
              //Navigator.pop(context); //Bullshit this one
            },
          ),
          Spacer(),
          Text(
            '$title',
            style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Container(
            width: 29,
            height: 29,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(40),),
              color:Colors.red,
            ),
            child: Center(child: textB()),
          ),
          const SizedBox(width: 10,),
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