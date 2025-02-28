import 'package:cloud_firestore/cloud_firestore.dart';

import '../drug_models/drug_model.dart';

class DrugInfoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DrugInfo>> getDrugInfo(String query, String type_name) async* {
    final lowerQuery = query.toLowerCase();

    // Query for exact matches
    final exactMatchesStream = FirebaseFirestore.instance
        .collection('drugs')
        .where('drug_name', isEqualTo: query)
        .where('name_type', isEqualTo: type_name)
        .snapshots();

    await for (final snapshots in exactMatchesStream) {
      if (snapshots.docs.isNotEmpty) {
        yield mapSnapshotsToDrugInfo(snapshots.docs);
      } else {
        // If no exact matches found, search partial matches
        yield* searchPartialMatches(lowerQuery);
      }
    }
  }

  Stream<List<DrugInfo>> searchPartialMatches(String query) async* {
    final upperQuery = query.toUpperCase();

    final partialMatchesStream = FirebaseFirestore.instance
        .collection('drugs')
        .where('drug_name', isGreaterThanOrEqualTo: query)
        .where('drug_name',
            isLessThan: query.substring(0, query.length - 1) +
                String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .snapshots();

    await for (final partialSnapshots in partialMatchesStream) {
      final allSnapshots = partialSnapshots.docs
          .where((doc) =>
              doc['drug_name'].toString().toLowerCase().contains(query) ||
              doc['drug_name'].toString().toUpperCase().contains(upperQuery))
          .toList();
      if (allSnapshots.isNotEmpty) {
        yield mapSnapshotsToDrugInfo(allSnapshots);
      } else {
        print('No partial matches found.');
        yield [];
      }
    }
  }

  List<DrugInfo> mapSnapshotsToDrugInfo(List<DocumentSnapshot> snapshots) {
    return snapshots.map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      final drugName = data['drug_name'] ?? '';
      final nameType = data['name_type'] ?? '';

      // Map dosage list
      List<Dosage> dosageList = [];
      if (data['dosage'] != null) {
        if (data['dosage'] is List<dynamic>) {
          dosageList =
              List<Dosage>.from(data['dosage'].map((d) => Dosage.fromMap(d)));
        } else {
          // Handle if 'dosage' is not a List
        }
      }

      return DrugInfo(
        drugId: snapshot.id, // Use document ID as drugId
        drugName: drugName,
        dosage: dosageList,
        nameType: nameType,
        overview: data['drugPointsdetail']['overview'] ?? '',
        indication: data['drugPointsdetail']['indication'] ?? '',
        contraindication: data['drugPointsdetail']['contraindication'] ?? '',
        sideEffects: data['drugPointsdetail']['sideEffects'] ?? '',
        warnings: data['drugPointsdetail']['warnings'] ?? '',
        highRiskGroups: data['drugPointsdetail']['highRiskGroups'] ?? '',
      );
    }).toList();
  }

  Future<List<Dosage>> getDosageByDrugId(String drugId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('dosages')
          .where('drug_id', isEqualTo: drugId)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Dosage(
          drug_id: data['drug_id'] ?? '',
          dose: data['dose'] ?? '',
          singleDose: data['single_dose'] ?? '',
          frequency: data['frequency'] ?? '',
          route: data['route'] ?? '',
          instruction: data['instruction'] ?? '',
          neonatal: data['neonatal'] ?? '',
          paediatric: data['paediatric'] ?? '',
        );
      }).toList();
    } catch (error) {
      print('Failed to retrieve dosage: $error');
      return []; // Return an empty list in case of failure
    }
  }

  Future<List<DrugInfo>> getBrandDrugs(String brand) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('drugs')
          .where('name_type', isEqualTo: brand)
          .get();

      List<DrugInfo> brandDrugs = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final drugId = data['drug_id'] ?? '';
        final drugName = data['drug_name'] ?? '';
        final nameType = data['name_type'] ?? '';
        final overview = data['overview'] ?? '';
        final indication = data['indication'] ?? '';
        final contraindication = data['contraindication'] ?? '';
        final sideEffects = data['sideEffects'] ?? '';
        final warnings = data['warnings'] ?? '';
        final highRiskGroups = data['highRiskGroups'] ?? '';
        final dosageDataList = data['dosage'] ?? [];

        // Map dosage data to Dosage objects
        List<Dosage> dosageList = [];
        if (dosageDataList is List<dynamic>) {
          dosageList = dosageDataList
              .map<Dosage>((dosageData) => Dosage.fromMap(dosageData))
              .toList();
        }

        // Create a DrugInfo object and add it to the list
        brandDrugs.add(DrugInfo(
          drugId: drugId,
          drugName: drugName,
          nameType: nameType,
          overview: overview,
          indication: indication,
          contraindication: contraindication,
          sideEffects: sideEffects,
          warnings: warnings,
          highRiskGroups: highRiskGroups,
          dosage: dosageList,
        ));
      }

      return brandDrugs;
    } catch (error) {
      print('Failed to retrieve brand drugs: $error');
      return []; // Return an empty list in case of failure
    }
  }

  Future<List<DrugInfo>> getfavourits(String drugId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('drugId', isEqualTo: drugId)
          .get();

      List<DrugInfo> brandDrugs = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final drugId = data['drug_id'] ?? '';
        final drugName = data['drug_name'] ?? '';
        final nameType = data['name_type'] ?? '';
        final overview = data['overview'] ?? '';
        final indication = data['indication'] ?? '';
        final contraindication = data['contraindication'] ?? '';
        final sideEffects = data['sideEffects'] ?? '';
        final warnings = data['warnings'] ?? '';
        final highRiskGroups = data['highRiskGroups'] ?? '';
        final dosageDataList = data['dosage'] ?? [];

        // Map dosage data to Dosage objects
        List<Dosage> dosageList = [];
        if (dosageDataList is List<dynamic>) {
          dosageList = dosageDataList
              .map<Dosage>((dosageData) => Dosage.fromMap(dosageData))
              .toList();
        }

        // Create a DrugInfo object and add it to the list
        brandDrugs.add(DrugInfo(
          drugId: drugId,
          drugName: drugName,
          nameType: nameType,
          overview: overview,
          indication: indication,
          contraindication: contraindication,
          sideEffects: sideEffects,
          warnings: warnings,
          highRiskGroups: highRiskGroups,
          dosage: dosageList,
        ));
      }

      return brandDrugs;
    } catch (error) {
      print('Failed to retrieve brand drugs: $error');
      return []; // Return an empty list in case of failure
    }
  }
}
