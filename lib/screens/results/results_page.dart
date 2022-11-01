import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Results Page',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                //SizedBox(width: 40,),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.teal,
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
                    width: 420,
                    height: 60,
                    child: Center(child: Text('ChairPerson',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>ResultsPage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
