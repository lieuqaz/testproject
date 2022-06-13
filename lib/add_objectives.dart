// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class AddObject {
  CollectionReference ob = FirebaseFirestore.instance.collection('objectives');

  Future<void> addObject(object, uid) async {
    await ob
        .doc(uid)
        .set({'objectname': object})
        .then((value) => print('object'))
        .catchError((error) => print('$error'));
  }

  Future<void> addResult(
      id, result, typekr, criteria, start, target, unit, date) async {
    await ob
        .doc(id)
        .collection('Result')
        .add({
          'result': result,
          'typekr': typekr,
          'criterias': criteria,
          'start': start,
          'target': target,
          'unit': unit,
          'duedate': date
        })
        .then((value) => print('ok'))
        .catchError((error) => print('$error'));
  }
}
