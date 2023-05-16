import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';

import '../../core/tools/session.dart';

class GetNotificationsUseCase<T> extends BaseUseCase<T?> {
  GetNotificationsUseCase<T> params(
      {required String code, required String token}) {
    return this;
  }

  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(Session.instance.getUser()?.id)
        .collection("inbox")
        .orderBy('date', descending: true)
        .snapshots()
        .forEach((element) {
      List<QueryDocumentSnapshot> snap = [];
      for (var element in element.docs) {
        snap.add(element);
      }
      success(snap as T);
    });
  }
}
