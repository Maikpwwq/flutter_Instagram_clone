import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error ocurred";
    try {
      if (email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty||file!=null) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        print(cred.user!.uid);
        //
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        // add user to DataBase
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        // personalized uid to DataBase
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        //   });

        res = "Success";
      }
    // } on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email'){
    //     res = 'El formato de correo no es valido.';
    //   } else if (err.code == 'weak-password'){
    //     res = 'La contraseña debe tener más de seis caracteres.';
    //   }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser ({
    required String email,
    required String password,
  }) async {
    String res = 'Some error ocurred';
    try {
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else {
        res = 'Registre todos los campos';
      }
      // } on FirebaseAuthException catch (err) {
      //   if (err.code == 'user-not-found'){
      //     res = 'El usuario no ha sido registrado.';
      //   } else if (err.code == 'wrong-password'){
      //     res = 'La contraseña es incorrecta.';
      //   }
    } catch (err){
      res = err.toString();
    }
    return res;
  }
}