import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addEmployeeDetails(
    Map <String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("To Do")
        .doc(id)
        .set(employeeInfoMap);
  }
  Future<Stream<QuerySnapshot>> getEmpoyeeDetails() async {
    return await FirebaseFirestore.instance.collection("To Do").snapshots();
  }

  Future updateEmployeeDetail (String id, Map<String,dynamic> updateInfo) async{
    return await FirebaseFirestore.instance.collection("To Do").doc(id).update(updateInfo);
  }

  Future deleteEmployeeDetail (String id) async{
    return await FirebaseFirestore.instance.collection("To Do").doc(id).delete();
  }

}
