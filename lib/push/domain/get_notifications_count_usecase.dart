import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';

import '../../core/tools/session.dart';

class GetNotificationsCountUseCase<T> extends BaseUseCase<T?> {
  @override
  Future<void> invoke(
      {required Function(T?) success, required Function failure}) async {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(Session.instance.getUser()?.id)
        .collection("inbox")
        .snapshots()
        .forEach((element) {
      int count = 0;
      for (var element in element.docs) {
        count++;
      }
      success(count.toString() as T);
    });
  }
}
