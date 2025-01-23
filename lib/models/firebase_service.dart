import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';

class FirebaseService {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance.collection('events').withConverter(
          fromFirestore: (snapshot, options) => Event.fromJson(
            snapshot.data()!,
          ),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addEventToFireStore(Event event) async {
    CollectionReference<Event> collectionReference = getEventsCollection();
    DocumentReference<Event> docRef = collectionReference.doc();
    event.id = docRef.id;
    await docRef.set(event);
  }

  static Future<List<Event>> getEventsFromFireStore() async {
    CollectionReference<Event> collectionReference = getEventsCollection();
    QuerySnapshot<Event> querySnapshot = await collectionReference.orderBy('dateTime').get();
    return querySnapshot.docs.map(
      (snapshot) {
        return snapshot.data();
      },
    ).toList();
  }
}
