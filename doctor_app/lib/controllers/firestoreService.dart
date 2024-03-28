import 'package:doctor_app/consts/consts.dart';

class FirestoreServices {
  static getUser(uid){
    return firestore.collection(doctorsCollection).where('id',isEqualTo: uid).snapshots();
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