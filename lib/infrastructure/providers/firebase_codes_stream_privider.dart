// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/infrared_code.dart';

class FirebaseCodesStreamNotifier extends StreamNotifier<List<InfraredCode>> {
  final code_collection = FirebaseFirestore.instance.collection("codes");

  @override
  Stream<List<InfraredCode>> build() {
    return code_collection.snapshots().map((e) {
      return e.docs.map((e) => InfraredCode.fromJson(e.data())).toList();
    });
  }

  void updateCodes(InfraredCode code) async {
    final querySnapshot =
        await code_collection.where("name", isEqualTo: code.name).get();

    await querySnapshot.docs.first.reference.update(code.toJson());
  }

  Future<InfraredCode> getCode(String docId) async {
    final docSnapshot = await code_collection.doc(docId).get();
    final code = InfraredCode.fromJson(docSnapshot.data()!);
    return code;
  }

  deleteCode(InfraredCode code) async {
    final querySnapshot =
        await code_collection.where("name", isEqualTo: code.name).get();

    await querySnapshot.docs.first.reference.delete();
  }

  Future<String?> getDocIdByName(String name) async {
    final querySnapshot =
        await code_collection.where("name", isEqualTo: name).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      return docId;
    }
    return null;
  }
}

final firebaseCodesStreamProvider = StreamNotifierProvider.autoDispose<
  FirebaseCodesStreamNotifier,
  List<InfraredCode>
>(FirebaseCodesStreamNotifier.new);
