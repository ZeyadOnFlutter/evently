import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/user.dart';
import 'package:evently/view/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          toFirestore: (value, options) => value.toJson(),
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

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel user = UserModel(
      id: userCredential.user!.uid,
      name: name,
      email: email,
      favouriteIds: [],
    );
    CollectionReference<UserModel> userCollection = getUserCollection();
    userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentSnapshot<UserModel> docSnapshot =
        await userCollection.doc(userCredential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
