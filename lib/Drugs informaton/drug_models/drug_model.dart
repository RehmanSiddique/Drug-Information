
class DrugInfo {
  final String drugName;
  final String drugId;
  final String nameType;
  final String overview;
  final String indication;
  final String contraindication;
  final String sideEffects;
  final String warnings;
  final String highRiskGroups;
  final List<Dosage> dosage;

  DrugInfo({
    required this.drugId,
    required this.overview,
    required this.indication,
    required this.contraindication,
    required this.sideEffects,
    required this.warnings,
    required this.highRiskGroups,
    required this.drugName,
    required this.nameType,
    required this.dosage,
  });

  factory DrugInfo.fromMap(Map<String, dynamic> map) {
    return DrugInfo(
      drugId: map['drug_id'] ?? '',
      drugName: map['drug_name'] ?? '',
      nameType: map['name_type'] ?? '',
      overview: map['overview'] ?? '',
      indication: map['indication'] ?? '',
      contraindication: map['contraindication'] ?? '',
      sideEffects: map['sideEffects'] ?? '',
      warnings: map['warnings'] ?? '',
      highRiskGroups: map['highRiskGroups'] ?? '',
      dosage: (map['dosage'] ?? []).map<Dosage>((dosageData) => Dosage.fromMap(dosageData)).toList(),
    );
  }
}

class Dosage {
  final String dose;
  final String drug_id;
  final String singleDose;
  final String frequency;
  final String route;
  final String instruction;
  final String neonatal;
  final String paediatric;

  Dosage({
    required this.drug_id,
    required this.dose,
    required this.singleDose,
    required this.frequency,
    required this.route,
    required this.instruction,
    required this.neonatal,
    required this.paediatric,
  });

  factory Dosage.fromMap(Map<String, dynamic> map) {
    return Dosage(
      drug_id: map['drug_id'] ?? '',
      dose: map['dose'] ?? '',
      singleDose: map['single_dose'] ?? '',
      frequency: map['frequency'] ?? '',
      route: map['route'] ?? '',
      instruction: map['instruction'] ?? '',
      neonatal: map['neonatal'] ?? '',
      paediatric: map['paediatric'] ?? '',
    );
  }
}

// class DrugPointsdetail {
//   final String overview;
//   final String indication;
//   final String contraindication;
//   final String sideEffects;
//   final String warnings;
//   final String highRiskGroups;
//
//   DrugPointsdetail({
//     required this.overview,
//     required this.indication,
//     required this.contraindication,
//     required this.sideEffects,
//     required this.warnings,
//     required this.highRiskGroups,
//   });
//
//   factory DrugPointsdetail.fromMap(Map<String, dynamic> map) {
//     return DrugPointsdetail(
//       overview: map['overview'] ?? '',
//       indication: map['indication'] ?? '',
//       contraindication: map['contraindication'] ?? '',
//       sideEffects: map['sideEffects'] ?? '',
//       warnings: map['warnings'] ?? '',
//       highRiskGroups: map['highRiskGroups'] ?? '',
//     );
//   }
// }
