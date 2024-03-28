import 'package:admin_app/consts/consts.dart';

class FirestoreServices {
  static getUser(){
    return firestore.collection("users").snapshots();
  }
  static getDoctor(){
    return firestore.collection("doctors").where('approved',isEqualTo: 'true').snapshots();
  }
  static getDoctorRequest(){
    return firestore.collection("doctors").where('approved',isEqualTo: 'false').snapshots();
  }
  static getPatient2({id}){
    return firestore.collection("users").where('id',isEqualTo: id)
      .snapshots();
    
  }

  static getCall(uid){
    return firestore.collection("calls").where('doctor-id',isEqualTo: uid).orderBy('time',descending: true).snapshots();
  }
  static getFile({uid,doctorID}){
    return firestore.collection("files").where('doctor-id',isEqualTo: doctorID).where('user-id',isEqualTo: uid).snapshots();
  }
}