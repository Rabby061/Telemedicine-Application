
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/consts/consts.dart';

class FirestoreServices {
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }

  static getDoctor({category}){
    if(category!="")
    {
     return FirebaseFirestore.instance
    .collection(doctorsCollection)
    .where('speciality', isGreaterThanOrEqualTo: category)
    .where('speciality', isLessThan: category + 'z')
    .orderBy('speciality',descending: true)
    .where('approved',isEqualTo: "true")
    .orderBy('total-call', descending: true)
    .snapshots();
    }
    else{
      return firestore.collection(doctorsCollection).where('approved',isEqualTo: "true").orderBy('total-call',descending: true).snapshots();
    }
    
  }

  static getDoctor2({id}){
    return firestore.collection(doctorsCollection).where('id',isEqualTo: id)
      .snapshots();
  }

  static getCall(uid){
    return firestore.collection("calls").where('user-id',isEqualTo: uid).orderBy('time',descending: true).snapshots();
  }
  static getFile({uid,doctorID}){
    return firestore.collection("files").where('user-id',isEqualTo: uid).where('doctor-id',isEqualTo: doctorID).snapshots();
  }
}