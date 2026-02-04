// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';

class FirebaseWorkflowNotifier extends StreamNotifier<List<Workflow>> {
  final workflowCollection = FirebaseFirestore.instance.collection(
    "workflows",
  );

  Future<DocumentReference<Map<String, dynamic>>?> _findWorkflowDocRef(
    String displayName,
  ) async {
    final primary =
        await workflow_collection
            .where("displayName", isEqualTo: displayName)
            .limit(1)
            .get();

    if (primary.docs.isNotEmpty) {
      return primary.docs.first.reference;
    }

    final legacy =
        await workflow_collection
            .where("DisplayName", isEqualTo: displayName)
            .limit(1)
            .get();

    if (legacy.docs.isNotEmpty) {
      return legacy.docs.first.reference;
    }

    return null;
  }

  @override
  Stream<List<Workflow>> build() {
    return workflow_collection.snapshots().map((event) {
      return event.docs.map((e) => Workflow.fromJson(e.data())).toList();
    });
  }

  Future<void> updateWorkflow(Workflow workflow) async {
    final docRef = await _findWorkflowDocRef(workflow.displayName);
    if (docRef == null) {
      return;
    }

    await docRef.update(workflow.toJson());
  }

  Future<void> deleteWorkflow(Workflow workflow) async {
    final docRef = await _findWorkflowDocRef(workflow.displayName);
    if (docRef == null) {
      return;
    }

    await docRef.delete();
  }

  Future<void> setWorkflow(Workflow workflow) async {
    await workflow_collection.add(workflow.toJson());
  }
}

final firebaseWorkflowProvider =
    StreamNotifierProvider<FirebaseWorkflowNotifier, List<Workflow>>(
      FirebaseWorkflowNotifier.new,
    );
