
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/consts/consts.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{
  var profileImgPath = ''.obs;
  var profileImgLink = '';
  var searchController = TextEditingController();
  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(img == null) return;
      profileImgPath.value=img.path;
      
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    
    var destination = 'images/${currentUser!.uid}/$filename';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    
    await ref.putFile(File(profileImgPath.value));
    profileImgLink = await ref.getDownloadURL();
  }

  updateProfile(imgUrl) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'imageUrl': imgUrl,
    },SetOptions(merge: true));
  }

  updatePassword(pass) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'password': pass,
    },SetOptions(merge: true));

  }
  changeAuthPassword(email,password,newpassword) async {
    final cred= EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error){
      print(error.toString());
    });
  }

  storeCallData({doctorId,call}) async {
    String callId=currentUser!.uid+doctorId;
    DocumentReference store = await firestore.collection("calls").doc(callId);
    store.set({
      'user-id' : currentUser!.uid,
      'doctor-id': doctorId,
      'time' : FieldValue.serverTimestamp(),
    });
    var store2 = firestore.collection("doctors").doc(doctorId);
    await store2.set({
      'total-call':call,
    },SetOptions(merge: true));
  }
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  selectFile({doctorId}) async {
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;
    pickedFile = result.files.first;
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    
    final snapshot = await uploadTask!.whenComplete((){});
    final urlDownload = await snapshot.ref.getDownloadURL();
    DocumentReference store = await firestore.collection("files").doc();
    store.set({
      'user-id' : currentUser!.uid,
      'doctor-id': doctorId,
      'file-name' : pickedFile!.name,
      'url': urlDownload,
    });
  }

  

}