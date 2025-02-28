import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../drug_models/drug_model.dart';
import '../../db_service/bd_service.dart';
import 'brand_screen.dart';
import 'dosage_screen.dart';
import 'utils/card_widget.dart';

class DrugInfoScreen extends StatefulWidget {
  final String drugName;
  final String typeName;
  final String? drugId;

  const DrugInfoScreen(
      {Key? key, required this.drugName, required this.typeName, this.drugId})
      : super(key: key);

  @override
  State<DrugInfoScreen> createState() => _DrugInfoScreenState();
}

class _DrugInfoScreenState extends State<DrugInfoScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DrugInfoService _drugInfoService = DrugInfoService();

  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  // Check if the drug is marked as a favorite
  void _checkIfFavorite() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null || widget.drugId == null) return;

    final docId = '${userId}_${widget.drugId}';
    final favoriteDoc =
        await _firestore.collection('favorites').doc(docId).get();

    setState(() {
      _isFavorite = favoriteDoc.exists;
    });
  }

  // Toggle the favorite status of the drug
  Future<void> _toggleFavorite() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null || widget.drugId == null) return;

    final docId = '${userId}_${widget.drugId}';

    try {
      final favoriteDoc =
          await _firestore.collection('favorites').doc(docId).get();

      if (favoriteDoc.exists) {
        // Remove from favorites
        await _firestore.collection('favorites').doc(docId).delete();
        setState(() => _isFavorite = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.drugName} removed from favorites')),
        );
      } else {
        // Add to favorites
        await _firestore.collection('favorites').doc(docId).set({
          'userId': userId,
          'drugId': widget.drugId,
          'drugName': widget.drugName,
          'typeName': widget.typeName,
        });
        setState(() => _isFavorite = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.drugName} added to favorites')),
        );
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating favorites')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildDrugInfoStream(),
    );
  }

  // Build the AppBar with a favorite icon
  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: Text(
        widget.drugName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      backgroundColor: Colors.deepPurple[900],
      elevation: 3.8,
      actions: [
        IconButton(
          icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
          color: _isFavorite ? Colors.red : Colors.white,
          onPressed: () => _toggleFavorite(),
        ),
      ],
    );
  }

  // StreamBuilder to fetch drug information based on the drug name and type
  Widget _buildDrugInfoStream() {
    return StreamBuilder<List<DrugInfo>>(
      stream: _drugInfoService.getDrugInfo(widget.drugName, widget.typeName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snapshot.hasError) {
          return _buildErrorWidget();
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return _buildDrugInfoList(snapshot.data!);
        }
        return _buildNoDataWidget();
      },
    );
  }

  // Display loading animation while waiting for the data
  Widget _buildLoadingIndicator() {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        size: 50,
        color: Colors.deepPurple,
      ),
    );
  }

  // Show error widget if there's an issue fetching data
  Widget _buildErrorWidget() {
    return const Center(
      child: Text('Something went wrong!'),
    );
  }

  // Show no data available message
  Widget _buildNoDataWidget() {
    return const Center(
      child: Text('No data available yet'),
    );
  }

  // Build the list of drug information once data is fetched
  Widget _buildDrugInfoList(List<DrugInfo> drugList) {
    return ListView.builder(
      itemCount: drugList.length,
      itemBuilder: (context, index) {
        final drug = drugList[index];
        return Column(
          children: [
            _buildDosageAndBrandButtons(drug.drugId),
            Card_Widget(title: 'Overview', content: drug.overview),
            Card_Widget(title: 'Indication', content: drug.indication),
            Card_Widget(
                title: 'Contraindication', content: drug.contraindication),
            Card_Widget(title: 'Side Effects', content: drug.sideEffects),
            Card_Widget(title: 'Warnings', content: drug.warnings),
            Card_Widget(
                title: 'High Risk Groups', content: drug.highRiskGroups),
          ],
        );
      },
    );
  }

  // Build the Dosage and Brand buttons
  Widget _buildDosageAndBrandButtons(String drugId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(
            title: 'DOSAGES',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DosageScreen(drugId: drugId)),
            ),
          ),
          const SizedBox(width: 6),
          _buildButton(
            title: 'BRANDS',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AvailableBrandsScreen()

                  // BrandScreen(drugId: drugId, brand: 'brand'),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // Build a custom button for navigation
  Widget _buildButton({required String title, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.deepPurple,
              width: 1.6,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
