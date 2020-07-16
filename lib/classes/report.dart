import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Report{
  String action;
  String bully_name;
  String victim_name;
  String supervisor_name;
  String supervisor_id;
  String supervision_location;
  Timestamp date_time;
  String event;

  Report(){}
  SetAction(String action){
    this.action=action;
  }
  String GetAction(){
    return this.action;
  }
  SetBullyName(String name){
    this.bully_name=name;
  }
  String GetBullyName(){
    return this.bully_name;
  }
  SetVictimName(String name){
    this.victim_name=name;
  }
  String GetVictimName(){
    return this.victim_name;
  }
  SetEvent(String event){
    this.event=event;
  }
  String GetEvent(){
    return this.event;
  }
  Timestamp GetDateTime(){
    return this.date_time;
  }
  String GetSupervisorName(){
    return this.supervisor_name;
  }
  String GetSupervisionLocation(){
    return this.supervision_location;
  }
  
  

  bool auth() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }
  Future<bool> Create_report(Map<String,dynamic> data)async{
    if (auth()) {
      await Firestore.instance.collection('reports').add(data);
      return true;
    }
    else{
      return false;
    }
  }

  List_reports_supervisor(String user_id)async{
    if(auth()){
      return await Firestore.instance.collection('reports').where('supervisor_id',isEqualTo: user_id).snapshots();
    }
  }

  Future<bool> Update_report(data,ID)async{
    if(auth()){
      await Firestore.instance.collection('reports').document(ID).setData(data);
      return true;
    }
    else{
      return false;
    }
  }
 Future<bool> Delete_report(ID)async{
   if(auth()){
      await Firestore.instance.collection('reports').document(ID).delete();
      return true;
    }
    else{
      return false;
    }
 }

 List_reports_psychologist()async{
   if(auth()){
     return await Firestore.instance.collection('reports').snapshots();
   }
 }
 List_current_day_psychologist_reports()async{
   if(auth()){
     //DateTime pastweek = DateTime.now().subtract(Duration(days: 7));
     DateTime current_day = new DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day, 00, 00, 00, 00, 00);
    Stream<QuerySnapshot> bullying_reports=await Firestore.instance
                .collection('reports')
                .where('date_time', isGreaterThanOrEqualTo: current_day)
                .snapshots();

                return await bullying_reports;
   } }

   Get_report(ID)async{
     if(auth()){
       return await Firestore.instance.collection('reports').document(ID).get();
     }
  }

}