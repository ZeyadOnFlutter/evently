import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/view/home/home_screen.dart';
import 'package:evently/widgets/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance.collection('events').withConverter(
          fromFirestore: (snapshot, options) => Event.fromJson(
            snapshot.data()!,
          ),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> addEventToFireStore(Event event) async {
    CollectionReference<Event> collectionReference = getEventsCollection();
    DocumentReference<Event> docRef = collectionReference.doc();
    event.id = docRef.id;
    await docRef.set(event);
  }

  static Future<List<Event>> getEventsFromFireStore(
      /*String categoryId*/) async {
    CollectionReference<Event> collectionReference = getEventsCollection();
    collectionReference.snapshots();
    QuerySnapshot<Event> querySnapshot =
        await collectionReference.orderBy('dateTime').get();

    return querySnapshot.docs.map(
      (snapshot) {
        return snapshot.data();
      },
    ).toList();
  }

  static Future<void> deleteEventFromFireStore(Event event) async {
    CollectionReference<Event> collectionReference = getEventsCollection();
    await collectionReference.doc(event.id).delete();
  }

  static Future<void> updateEventFromFireStore(Event event) async {
    CollectionReference<Event> collectionReference = getEventsCollection();
    await collectionReference.doc(event.id).update(event.toJson());
  }

  static Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!.sendEmailVerification();
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        favouriteIds: [],
      );
      CollectionReference<UserModel> userCollection = getUserCollection();
      userCollection.doc(user.id).set(user);

      onSuccess();
      return user;
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
      print('Error');
    }
  }

  static Future<UserModel?> login({
    required String email,
    required String password,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      CollectionReference<UserModel> userCollection = getUserCollection();
      DocumentSnapshot<UserModel> docSnapshot =
          await userCollection.doc(userCredential.user!.uid).get();
      if (userCredential.user!.emailVerified) {
        onSuccess(
          docSnapshot.data()!,
        );
      } else {
        onError('Email Must Be Verified');
      }

      return docSnapshot.data()!;
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> addUserToFireStore(UserModel user) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    userCollection.doc(user.id).set(user);
  }

  static Future<UserModel> getUserFromFiresStore(UserModel user) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentSnapshot<UserModel> documentSnapshot =
        await userCollection.doc(user.id).get();
    return documentSnapshot.data()!;
  }

  static Future<UserModel?> loginWithGoogle(
      BuildContext context, Function onError, Function onSuccess) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        onError(
          'User Is Not Signed In',
        );
        return null;
      }
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      CollectionReference<UserModel> collectionReference = getUserCollection();
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? '',
        email: userCredential.user!.email ?? '',
        favouriteIds: [],
      );

      if (userCredential.additionalUserInfo!.isNewUser) {
        addUserToFireStore(user);
      }
      UserModel userModel = await getUserFromFiresStore(user);
      onSuccess('User Signed In SuccesFully', userModel);

      return userModel;
    } on FirebaseAuthException catch (error) {
      onError(error.message);
      print('Error ${error.message}');
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> addEventToFavourite(String eventId) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'favouriteIds': FieldValue.arrayUnion([eventId])
    });
  }

  static Future<void> deleteEventFromFavourite(String eventId) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'favouriteIds': FieldValue.arrayRemove([eventId])
    });
  }
}
