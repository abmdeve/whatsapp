import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp/features/user/data/data_source/remote/user_remote_data_source.dart';

import '../../../../app/const/app_const.dart';
import '../../../../app/const/firebase_collection_const.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../models/user_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  String _verificationId = "";

  @override
  Future<void> createUser(UserEntity user) async {
    // TODO: implement createUser
    final userCollection = firestore.collection(FirebaseCollectionConst.users);

    final uid = await getCurrentUID();

    final newUser = UserModel(
      email: user.email,
      uid: user.uid,
      isOnline: user.isOnline,
      phoneNumber: user.phoneNumber,
      username: user.username,
      profileUrl: user.profileUrl,
      status: user.status,
    ).toDocument();

    try {
      userCollection.doc(uid).get().then((userDoc) {
        if (!userDoc.exists) {
          userCollection.doc(uid).set(newUser);
        } else {
          userCollection.doc(uid).update(newUser);
        }
      });
    } catch (e) {
      throw Exception("ERROR OCCUR WHILE CREATING USER");
    }
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    // TODO: implement getAllUsers
    final userCollection = firestore.collection(FirebaseCollectionConst.users);

    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<List<ContactEntity>> getDeviceNumber() async {
    // TODO: implement getDeviceNumber
    List<ContactEntity> contacts = [];

    final getContactsData = await ContactsService.getContacts();
    getContactsData.forEach((myContact) {
      myContact.phones!.forEach((phoneData) {
        contacts.add(ContactEntity(
          phoneNumber: phoneData.value,
          label: myContact.displayName,
          userProfile: myContact.avatar as String,
        ));
      });
    });

    return contacts;
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    // TODO: implement getSingleUser
    final userCollection = firestore
        .collection(FirebaseCollectionConst.users)
        .where("uid", isEqualTo: uid);

    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    // TODO: implement signInWithPhoneNumber
    try{
      final AuthCredential credential = PhoneAuthProvider
          .credential(
        verificationId: smsPinCode,
        smsCode: _verificationId,
      );

      await auth.signInWithCredential(credential);

    }on FirebaseAuthException catch(e) {
      if(e.code == 'invalid-verification-code'){
        toast("SMS VERIFICATION CODE");
      }else if(e.code == "quota-exceeded"){
        toast("SMS QUOTA-EXCEEDED");
      }
    }catch (e) {
      toast("UNKNOWN EXCEPTION PLEASE TRY AGAIN");
    }
  }

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> updateUser(UserEntity user) async {
    // TODO: implement updateUser
    final userCollection = firestore.collection(FirebaseCollectionConst.users);

    Map<String, dynamic> userInfo = {};

    if (user.username != "" && user.username != null)
      userInfo['username'] = user.username;

    if (user.profileUrl != "" && user.profileUrl != null)
      userInfo['profileUrl'] = user.profileUrl;

    if (user.isOnline != null) userInfo['isOnline'] = user.isOnline;

    userCollection.doc(user.uid).update(userInfo);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    // TODO: implement verifyPhoneNumber
    phoneVerificationCompleted(AuthCredential authCredential) {
      debugPrint(
          "PHONE VERIFIED: TOKEN ${authCredential.token} ${authCredential.signInMethod}");
    }

    phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
      debugPrint(
          "PHONE FAILED: ${firebaseAuthException.message} ${firebaseAuthException.code}");
    }

    phoneCodeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      debugPrint("TIME OUT: $verificationId");
    }

    phoneCodeSend(String verificationId, int? forceResendToken) {
      _verificationId = verificationId;

      debugPrint("PHONE FAILED");
    }

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 60),
      codeSent: phoneCodeSend,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }
}
