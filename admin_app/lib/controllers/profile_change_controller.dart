


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';


import 'package:get/get.dart';

import 'package:admin_app/consts/consts.dart';


class ProfileController extends GetxController{
  var profileImgPath = ''.obs;
  var profileImgLink = '';
  var certificateImgPath = ''.obs;
  var certificateImgLink = '';
  

  updateInfo2({id,remail}) async {
    var store = firestore.collection("doctors").doc(id);
    await store.set({
      'approved':"true",
    },SetOptions(merge: true));
    final Email email = Email(
      body:"Your account of online doctor have been approved",
      subject: "Online Doctor Confirmation Email",
      recipients: [remail],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  deleteInfo2({id,remail}) async {
    var store = firestore.collection("doctors").doc(id);
    await store.set({
      'approved':"declined",
    },SetOptions(merge: true));
    final Email email = Email(
      body:"Your account of online doctor have been declined. Please signup again with proper information.",
      subject: "Online Doctor Confirmation Email",
      recipients: [remail],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  
  

}