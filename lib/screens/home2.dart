import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stupoll/screens/positions/chairperson.dart';
import 'package:stupoll/screens/positions/finance_officer.dart';
import 'package:stupoll/screens/positions/rao.dart';
import 'package:stupoll/screens/positions/secretary.dart';
import 'package:stupoll/screens/positions/support.dart';
import 'package:stupoll/screens/start.dart';
import 'package:stupoll/widgets/gradient_appbar.dart';

import '../widgets/gradient_appbar_home.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  bool isIt = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 10;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(0.0,50.0),
        child: GradientAppBarHome('StuPoll'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
             GestureDetector(
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://arua.org.za/wp-content/uploads/UKZN-Logo-Colour.png",
                ), //Change here***********************//
                radius:40,
              ),
               onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>StartPage()));
               },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "2022/23 SRC Elections",
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            //Container(width: 60,child: Divider(color:Colors.grey,)),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: 60,
                child: Divider(
                  color: Colors.green,
                )),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(child: positions("https://image.shutterstock.com/image-vector/chair-icon-vector-260nw-645397549.jpg",Colors.indigo, "Campus Chair Person ", screenWidth,'Chair','chairBool'),
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ChairPerson(profImage: "https://image.shutterstock.com/image-vector/chair-icon-vector-260nw-645397549.jpg",position:  "Campus Chair Person ",)));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(child: positions("https://cdn5.vectorstock.com/i/1000x1000/06/89/finance-logo-business-and-accounting-logo-design-vector-35020689.jpg",Colors.indigo, "Campus Finance Officer", screenWidth,'Fin','finBool'),
                onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>FinanceOfficer(profImage: "https://cdn5.vectorstock.com/i/1000x1000/06/89/finance-logo-business-and-accounting-logo-design-vector-35020689.jpg",position:  "Campus Finance Officer ",)));
      },
      ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(child: positions("https://img.freepik.com/premium-vector/home-icon-house-symbol-simple-vector-design-logo_231786-5048.jpg?w=2000",Colors.indigo, "Campus Residence Affairs Officer", screenWidth,'Rao','raoBool'),
                onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>RAO(profImage: "https://img.freepik.com/premium-vector/home-icon-house-symbol-simple-vector-design-logo_231786-5048.jpg?w=2000",position:  "RAO ",)));
      },
      ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(child: positions("https://cdn4.vectorstock.com/i/1000x1000/91/63/secretary-symbol-icon-black-sign-vector-35209163.jpg",Colors.indigo, "Campus Secretary", screenWidth,'Sec','secBool')
                ,onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>Secretary(profImage: "https://cdn4.vectorstock.com/i/1000x1000/91/63/secretary-symbol-icon-black-sign-vector-35209163.jpg",position:  "Secretary ",)));
      },
      ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(child: positions("https://thumbs.dreamstime.com/z/support-group-four-people-concept-financial-business-association-customer-service-54643182.jpg",Colors.indigo, "Campus Student Support Service Officer", screenWidth,'Sup','supBool')
              ,onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Support(profImage: "https://thumbs.dreamstime.com/z/support-group-four-people-concept-financial-business-association-customer-service-54643182.jpg",position:  "Support ",)));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget positions(String profImage,Color? myCol, String position, double screenWidth,String doc,String typeBool) {
    var userId = FirebaseAuth.instance.currentUser!.uid!;
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
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
              Radius.circular(10),
            ),
            //color: myCol, //Change here***********************//
          ),
          padding: const EdgeInsets.all(8),
          width: screenWidth,
          //height: 140,
          child: Row(
            children: [
              const SizedBox(
                width: 3,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  profImage,
                ), //Change here***********************//
                radius: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              //Spacer(),
              Container(
                width: screenWidth - 160,
                //color: Colors.red,
                child: Text(
                  "$position",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
               FutureBuilder(
    future: FirebaseFirestore.instance.collection('myVotes').doc('$doc-$userId').get(),
    builder: (context, snapshot){
      if(snapshot.connectionState!= ConnectionState.done){
        return Text('!',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
      }else if(snapshot.hasError){
        return Text('?',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
      }else if(snapshot.data![typeBool]==null){
        return Text('?',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),);
      }
      return snapshot.data![typeBool] ?
      Container(
        // width: 27,
        // height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue),
            borderRadius: BorderRadius.all(
              Radius.circular(60),
            ),
            color: Colors.green,
          ),
          padding: EdgeInsets.all(5),
          child: const Icon(Icons.check_circle,color: Colors.white,)
      )
      : Container(
        // width: 27,
        // height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue),
            borderRadius: BorderRadius.all(
              Radius.circular(60),
            ),
            color: Colors.black,
          ),
          padding: EdgeInsets.all(5),
          child: const Icon(Icons.navigate_next_sharp,color: Colors.white,)
      );
    }
              ),
            ],
          ),
        ),
      ],
    ); //End**********************
  }
}
