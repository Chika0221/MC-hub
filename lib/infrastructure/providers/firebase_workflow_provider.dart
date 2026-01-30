// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';

class FirebaseWorkflowNotifier extends StreamNotifier<List<Workflow>> {
  final workflow_collection = FirebaseFirestore.instance.collection(
    "workflows",
  );

  @override
  Stream<List<Workflow>> build() {
    return workflow_collection.snapshots().map((event) {
      return event.docs.map((e) => Workflow.fromJson(e.data())).toList();
    });
  }

  void updateWorkflow(Workflow workflow) async {
    final querySnapshot =
        await workflow_collection
            .where("DisplayName", isEqualTo: workflow.displayName)
            .get();

    await querySnapshot.docs.first.reference.update(workflow.toJson());
  }

  void deleteWorkflow(Workflow workflow) async {
    final querySnapshot =
        await workflow_collection
            .where("DisplayName", isEqualTo: workflow.displayName)
            .get();

    await querySnapshot.docs.first.reference.delete();
  }

  void setWorkflow(Workflow workflow) async {
    await workflow_collection.doc().set(workflow.toJson());
  }
}

final firebaseWorkflowProvider =
    StreamNotifierProvider<FirebaseWorkflowNotifier, List<Workflow>>(
      FirebaseWorkflowNotifier.new,
    );
