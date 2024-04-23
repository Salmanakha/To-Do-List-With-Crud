import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_crud/pages/employee.dart';
import 'package:new_crud/services/database.dart';

class Home extends StatefulWidget {
  const Home ({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  Stream? EmployeeStream;

  getontheload() async{
    EmployeeStream = await DatabaseMethods().getEmpoyeeDetails();
    setState(() {

    });
  }
@override
  void initState() {
   getontheload();
    super.initState();
  }



  Widget allEmployeeDetails(){
  return StreamBuilder(
      stream: EmployeeStream,
      builder: (context, AsyncSnapshot snapshot){
  return snapshot.hasData?
      ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, Index){
          DocumentSnapshot ds=snapshot.data.docs[Index];
              return  Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(

                          children: [
                            Text("Date: "+ds["Date"],
                              style: TextStyle(color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: (){
                                  nameController.text=ds["Date"];
                                  ageController.text=ds["Time"];
                                  locationController.text=ds["Work"];
                                  EditEmployeeDetail(ds["Id"]);
                                },
                                child: Icon(Icons.edit, color: Colors.orange,)),
                                Icon(Icons.delete, color: Colors.lightBlue,),
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: () async {
                                  await DatabaseMethods().deleteEmployeeDetail(ds["Id"]);
                                  },
                                    child: Icon(Icons.delete, color: Colors.orange,)
                                )
                          ],
                        ),

                        Text("Time: "+ds["Time"],
                          style: TextStyle(color: Colors.orange,
                              fontSize: 20.0,fontWeight:
                              FontWeight.bold),
                        ),

                        Text("Work: "+ds["Work"],
                          style: TextStyle(color: Colors.orange,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  ),
                ),
              );
          }): Container();
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed:() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Employee())
        );
      },
      child: Icon(Icons.add),),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(color: Colors.blue,fontSize: 24.1,fontWeight: FontWeight.bold),
            ),
            Text(
              "Firebase",
              style: TextStyle(color: Colors.orange,fontSize: 24.1,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.1, right: 20, top: 20),
        child: Column(
          children: [
          Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }
  
  Future EditEmployeeDetail(String id)=> showDialog(context: context, builder: (context)=> AlertDialog(
    content: Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.cancel)
            ),

        SizedBox(width: 50,),
        Text(
          "Edit",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 24.1,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Details",
          style: TextStyle(
              color: Colors.orange,
              fontSize: 24.1,
              fontWeight: FontWeight.bold
          ),
        ),
      ],),
      SizedBox(height: 20,),
        Text(
          "Date",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.1,
            fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.1),
        Container(
          padding: EdgeInsets.only(left: 10.1),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
                border: InputBorder.none),
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "Time",style: TextStyle(
            color: Colors.black,
            fontSize: 24.1,
            fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.1),
        Container(
          padding: EdgeInsets.only(left: 10.1),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            controller: ageController,
            decoration: InputDecoration(
                border: InputBorder.none),
          ),
        ),
        SizedBox(height: 10.1),
        Text(
          "Work",style: TextStyle(
            color: Colors.black,
            fontSize: 24.1,
            fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.1),
        Container(
          padding: EdgeInsets.only(left: 10.1),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            controller: locationController,
            decoration: InputDecoration(
                border: InputBorder.none),
          ),
        ),
        SizedBox(height: 30,),
        Center(
          child: ElevatedButton(onPressed: () async {
          Map<String, dynamic>updateInfo={
            "Date": nameController.text,
            "Time":  ageController.text,
            "Id": id,
            "Work": locationController.text,
          };
          await DatabaseMethods().updateEmployeeDetail(id, updateInfo).then((value) {
            Navigator.pop(context);
          });
          },
              child: Text("Update")),
        )
  ], ),
  ),
  ));

}
