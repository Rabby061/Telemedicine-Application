import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:user_app/consts/consts.dart';

class AuthController extends GetxController {

  //textcontroller

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod(context) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      currentUser = auth.currentUser;
      //print(currentUser!.uid);
    } 
    on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod(email,password,context) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      currentUser = auth.currentUser;
      //print(currentUser!.uid);

    } 
    on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method
  storeUserData({name,password,email,phone}) async {
    DocumentReference store = await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name':name,
      'email': email,
      'imageUrl': "",
      'id' : currentUser!.uid,
      'phone':phone,
    });
  }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
      //print(currentUser!.uid);
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}