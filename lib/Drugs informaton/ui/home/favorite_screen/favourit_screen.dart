import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../drug_info.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference favoritesRef =
        FirebaseFirestore.instance.collection('favorites');

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: favoritesRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorite items yet.'));
          }

          final favoriteItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              final favorite = favoriteItems[index];
              final drugName = favorite['drugName'];
              final typeName = favorite['typeName'];
              final drugId = favorite['drugId'];

              return ListTile(
                title: Text(drugName),
                subtitle: Text(typeName),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to DrugInfoScreen and pass required parameters
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DrugInfoScreen(
                        drugName: drugName,
                        typeName: typeName,
                        drugId: drugId, // Pass the drugId
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
