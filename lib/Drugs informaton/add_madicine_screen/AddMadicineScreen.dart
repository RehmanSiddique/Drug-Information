import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMedicineScreen extends StatefulWidget {
  final bool isEdit;
  final String? drugId;
  final Map<String, dynamic>? initialData;
  final Map<String, dynamic>? initialDosageData;

  const AddMedicineScreen({
    Key? key,
    this.isEdit = false,
    this.drugId,
    this.initialData,
    this.initialDosageData,
  }) : super(key: key);

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  // Controllers for form fields
  late TextEditingController _drugNameController;
  late TextEditingController _nameTypeController;
  late TextEditingController _doseController;
  late TextEditingController _singleDoseController;
  late TextEditingController _frequencyController;
  late TextEditingController _routeController;
  late TextEditingController _instructionController;
  late TextEditingController _neonatalController;
  late TextEditingController _paediatricController;
  late TextEditingController _overviewController;
  late TextEditingController _indicationController;
  late TextEditingController _contraindicationController;
  late TextEditingController _sideEffectsController;
  late TextEditingController _warningsController;
  late TextEditingController _highRiskGroupsController;

  bool _isUploading = false;

  @override
  void initState() {
    super.initState();

    // Initialize drug detail controllers
    _drugNameController = TextEditingController(
        text: widget.isEdit ? widget.initialData!['drug_name'] : '');
    _nameTypeController = TextEditingController(
        text: widget.isEdit ? widget.initialData!['name_type'] : '');
    _overviewController = TextEditingController(
        text: widget.isEdit
            ? widget.initialData?['drugPointsdetail']?['overview']
            : '');
    _indicationController = TextEditingController(
        text: widget.isEdit
            ? widget.initialData?['drugPointsdetail']?['indication']
            : '');
    _contraindicationController = TextEditingController(
        text: widget.isEdit
            ? widget.initialData?['drugPointsdetail']?['contraindication']
            : '');
    _sideEffectsController = TextEditingController(
        text: widget.isEdit
            ? widget.initialData?['drugPointsdetail']?['sideEffects']
            : '');
    _warningsController = TextEditingController(
        text: widget.isEdit
            ? widget.initialData?['drugPointsdetail']?['warnings']
            : '');
    _highRiskGroupsController = TextEditingController(
        text: widget.isEdit
            ? widget.initialData?['drugPointsdetail']?['highRiskGroups']
            : '');

    // Initialize dosage detail controllers
    _doseController = TextEditingController(
        text: widget.isEdit ? widget.initialDosageData!['dose'] : '');
    _singleDoseController = TextEditingController(
        text: widget.isEdit ? widget.initialDosageData!['single_dose'] : '');
    _frequencyController = TextEditingController(
        text: widget.isEdit ? widget.initialDosageData!['frequency'] : '');
    _routeController = TextEditingController(
        text: widget.isEdit ? widget.initialDosageData!['route'] : '');
    _instructionController = TextEditingController(
        text: widget.isEdit ? widget.initialDosageData!['instruction'] : '');
    _neonatalController = TextEditingController(
        text: widget.isEdit ? widget.initialDosageData!['neonatal'] : '');
    _paediatricController = TextEditingController(
        text: widget.isEdit ? widget.initialDosageData!['paediatric'] : '');
  }

  @override
  void dispose() {
    // Dispose controllers to release memory
    _drugNameController.dispose();
    _nameTypeController.dispose();
    _doseController.dispose();
    _singleDoseController.dispose();
    _frequencyController.dispose();
    _routeController.dispose();
    _instructionController.dispose();
    _neonatalController.dispose();
    _paediatricController.dispose();
    _overviewController.dispose();
    _indicationController.dispose();
    _contraindicationController.dispose();
    _sideEffectsController.dispose();
    _warningsController.dispose();
    _highRiskGroupsController.dispose();
    super.dispose();
  }

  Future<void> _saveDrugInfo() async {
    try {
      // Show progress indicator
      setState(() {
        _isUploading = true;
      });

      final drugData = {
        'drug_name': _drugNameController.text,
        'name_type': _nameTypeController.text,
        'drugPointsdetail': {
          'overview': _overviewController.text,
          'indication': _indicationController.text,
          'contraindication': _contraindicationController.text,
          'sideEffects': _sideEffectsController.text,
          'warnings': _warningsController.text,
          'highRiskGroups': _highRiskGroupsController.text,
        },
      };

      if (widget.isEdit && widget.drugId != null) {
        // Update existing drug
        await FirebaseFirestore.instance
            .collection('drugs')
            .doc(widget.drugId)
            .update(drugData);

        // Update dosage information
        final dosagesSnapshot = await FirebaseFirestore.instance
            .collection('dosages')
            .where('drug_id', isEqualTo: widget.drugId)
            .limit(1)
            .get();

        if (dosagesSnapshot.docs.isNotEmpty) {
          final dosageDocId = dosagesSnapshot.docs.first.id;

          await FirebaseFirestore.instance
              .collection('dosages')
              .doc(dosageDocId)
              .update({
            'dose': _doseController.text,
            'single_dose': _singleDoseController.text,
            'frequency': _frequencyController.text,
            'route': _routeController.text,
            'instruction': _instructionController.text,
            'neonatal': _neonatalController.text,
            'paediatric': _paediatricController.text,
          });
        } else {
          // Handle the case where no dosage document exists
          throw Exception('Dosage document not found for editing.');
        }
      } else {
        // Add new drug
        final drugRef =
            await FirebaseFirestore.instance.collection('drugs').add(drugData);

        // Add dosage information for new drug
        await FirebaseFirestore.instance.collection('dosages').add({
          'drug_id': drugRef.id,
          'dose': _doseController.text,
          'single_dose': _singleDoseController.text,
          'frequency': _frequencyController.text,
          'route': _routeController.text,
          'instruction': _instructionController.text,
          'neonatal': _neonatalController.text,
          'paediatric': _paediatricController.text,
        });
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isEdit
              ? 'Drug information updated successfully'
              : 'Drug information added successfully'),
        ),
      );

      Navigator.pop(context);
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save drug information: $error')),
      );
    } finally {
      // Hide progress indicator
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.isEdit ? 'Edit Drug Info' : 'Add Drug Info'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(_drugNameController, 'Drug Name'),
            _buildTextField(
                _nameTypeController, 'Drug Type (e.g., generic, brand)'),
            const SizedBox(height: 16.0),
            _buildSectionTitle(context, 'Dosage'),
            _buildTextField(_doseController, 'Dose'),
            _buildTextField(_singleDoseController, 'Single Dose'),
            _buildTextField(_frequencyController, 'Frequency'),
            _buildTextField(_routeController, 'Route'),
            _buildTextField(_instructionController, 'Instruction'),
            _buildTextField(_neonatalController, 'Neonatal'),
            _buildTextField(_paediatricController, 'Paediatric'),
            const SizedBox(height: 16.0),
            _buildSectionTitle(context, 'Drug Points Detail'),
            _buildTextField(_overviewController, 'Overview'),
            _buildTextField(_indicationController, 'Indication'),
            _buildTextField(_contraindicationController, 'Contraindication'),
            _buildTextField(_sideEffectsController, 'Side Effects'),
            _buildTextField(_warningsController, 'Warnings'),
            _buildTextField(_highRiskGroupsController, 'High Risk Groups'),
            const SizedBox(height: 16.0),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: _isUploading ? null : _saveDrugInfo,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: _isUploading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text(
                  'Save Drug',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
