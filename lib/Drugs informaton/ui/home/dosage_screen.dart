import 'package:flutter/material.dart';

import '../../db_service/bd_service.dart';
import '../../drug_models/drug_model.dart';

class DosageScreen extends StatelessWidget {
  final String drugId;
  final DrugInfoService drugInfoService = DrugInfoService();

  DosageScreen({Key? key, required this.drugId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: FutureBuilder<List<Dosage>>(
          future: drugInfoService.getDosageByDrugId(drugId),
          builder: (context, snapshot) => _buildContent(snapshot),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurple[900],
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: const Text(
        'Dosage Information',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot<List<Dosage>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
      return _buildDosageList(snapshot.data!);
    } else {
      return const Text('No dosage information available');
    }
  }

  Widget _buildDosageList(List<Dosage> dosages) {
    return ListView.builder(
      itemCount: dosages.length,
      itemBuilder: (context, index) {
        final dosage = dosages[index];
        return Column(
          children: [
            _buildDosageTile('Adult', dosage),
            _buildDivider(),
            _buildCardWidget('Neonatal', dosage.neonatal),
            _buildDivider(),
            _buildCardWidget('Paediatric', dosage.paediatric),
            _buildDivider(),
          ],
        );
      },
    );
  }

  Widget _buildDosageTile(String title, Dosage dosage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          '$title:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubtitleText('Dose', dosage.dose),
            _buildSubtitleText('Single Dose', dosage.singleDose),
            _buildSubtitleText('Frequency', dosage.frequency),
            _buildSubtitleText('Route', dosage.route),
            _buildSubtitleText('Instruction', dosage.instruction),
          ],
        ),
      ),
    );
  }

  Widget _buildCardWidget(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: ExpansionTile(
        leading: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Colors.deepPurple[900],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.deepPurple[900],
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(1, 0),
                blurRadius: 1,
              ),
            ],
          ),
        ),
        children: [
          ListTile(
            title: Text(
              content,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSubtitleText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple[900],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Divider(
        height: 2,
        color: Colors.deepPurple[900],
      ),
    );
  }
}
