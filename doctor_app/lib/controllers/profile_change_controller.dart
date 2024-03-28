
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctor_app/consts/consts.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{
  var profileImgPath = ''.obs;
  var profileImgLink = '';
  var certificateImgPath = ''.obs;
  var certificateImgLink = '';
  var addressController = TextEditingController();
  var timeController = TextEditingController();
  var timeController2 = TextEditingController();
  var specialityController = TextEditingController();
  var serviceController = TextEditingController();
  var phoneController = TextEditingController();
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
    var store = firestore.collection(doctorsCollection).doc(currentUser!.uid);
    await store.set({
      'imageUrl': imgUrl,
    },SetOptions(merge: true));
  }

  updatePassword(pass) async {
    var store = firestore.collection(doctorsCollection).doc(currentUser!.uid);
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


  changeCertificate(context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(img == null) return;
      certificateImgPath.value=img.path;
      
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

  }

  uploadCertificateImage() async {
    var filename = basename(profileImgPath.value);
    
    var destination = 'certificate/${currentUser!.uid}/$filename';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    
    await ref.putFile(File(certificateImgPath.value));
    certificateImgLink = await ref.getDownloadURL();
  }

  updateInfo({certificateImg,qualification,address,stime,etime,speciality,services,phone}) async {
    var store = firestore.collection(doctorsCollection).doc(currentUser!.uid);
    await store.set({
      
     
      
      'certificate' : certificateImg,
      'qualification' : qualification,
      'address' : address,
      'start-time' : stime,
      'end-time' : etime,
      'speciality' : speciality,
      'services' : services,
      'phone' : phone,
      
    },SetOptions(merge: true));
  }

  updateInfo2() async {
    var store = firestore.collection(doctorsCollection).doc(currentUser!.uid);
    await store.set({
      'address' : addressController.text,
      'start-time' : timeController.text,
      'end-time' : timeController2.text,
      'speciality' : specialityController.text,
      'services' : serviceController.text,
      'phone' : phoneController.text,
      
    },SetOptions(merge: true));
  }

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  selectFile({userId}) async {
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
      'user-id' : userId,
      'doctor-id': currentUser!.uid,
      'file-name' : pickedFile!.name,
      'url': urlDownload,
    });
  }

}