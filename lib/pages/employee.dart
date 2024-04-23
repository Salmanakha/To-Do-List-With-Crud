import 'package:new_crud/services/database.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';



class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "To Do",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24.1,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Form",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24.1,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 20.1, top: 30.1,right: 20.1),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date",style: TextStyle(
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
                SizedBox(height: 10,),
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
                SizedBox(
                    height: 10.1
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                      String Id= randomAlphaNumeric(10);
                      Map<String, dynamic> employeeInfoMap={
                        "Date": nameController.text,
                        "Time": ageController.text,
                        "Id": Id,
                        "Work":locationController.text
                      };
                      await DatabaseMethods().addEmployeeDetails(employeeInfoMap, Id).then((value) {
                      Fluttertoast.showToast(
                          msg: "To Do Details Has Been Uploaded Succesfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      } );
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 20.1,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                )

              ]
          )

      ),
    );

  }
}