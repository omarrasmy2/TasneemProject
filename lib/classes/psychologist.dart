import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalgraduationversion/classes/personel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './report.dart';

class Psychologist extends Personel{
Report report=new Report();
  List_current_day_reports()async{
    if(auth()){
      return await report.List_current_day_psychologist_reports();
    }
  }

  Future<bool> Add_psychologist(Map<String,dynamic>data)async{
    if(auth()){
      AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: data['e_mail'], password: data['passward']);
    FirebaseUser user = result.user;
   await Firestore.instance.collection('pychologist_information').document(user.uid).setData(data);
   return true;

    }
    else{
      return false;
    }
  }

  Future<bool> Delete_psychologist(ID)async{
    if(auth()){
      await Firestore.instance.collection('pychologist_information').document(ID).delete();
      await Firestore.instance.collection('floors_tokens').document(ID).delete();
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> Update_psychologist(data,ID)async{
    if(auth()){
      await Firestore.instance.collection('pychologist_information').document(ID).setData(data);
      return true;
    }
    else{
      return false;
    }
    
  }
  List_psychologist(){
    if(auth()){
      return Firestore.instance.collection('pychologist_information').snapshots();
    }
  }
  List_reports()async{
    if(auth()){
    return await report.List_reports_psychologist();
    }
  }
  Get_report(id){
    if(auth()){
      return report.Get_report(id);
    }
  }
}