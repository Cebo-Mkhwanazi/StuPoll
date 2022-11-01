import 'package:flutter/material.dart';
import 'package:stupoll/screens/results/results_page.dart';

import 'add_party/edit_party.dart';
import 'home2.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    Radius.circular(10),
                  ),
                  //color: myCol, //Change here***********************//
                ),
                padding: const EdgeInsets.all(8),
                width: 300,
                height: 60,
                child: Center(child: Text('Add Party',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>EditProfile()));
              },
            ),
            SizedBox(height: 40,),
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
                    Radius.circular(10),
                  ),
                  //color: myCol, //Change here***********************//
                ),
                padding: const EdgeInsets.all(8),
                width: 300,
                height: 60,
                child: Center(child: Text('Vote',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>HomeScreen2()));
              },
            ),
            SizedBox(height: 40,),
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
                    Radius.circular(10),
                  ),
                  //color: myCol, //Change here***********************//
                ),
                padding: const EdgeInsets.all(8),
                width: 300,
                height: 60,
                child: Center(child: Text('View Results',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>ResultsPage()));
              },
            ),

          ],
        ),
      ),
    );
  }
}
