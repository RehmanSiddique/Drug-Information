import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../add_madicine_screen/AddMadicineScreen.dart';
import '../auth/wLogin_screen.dart';
import 'about_screen.dart';
import 'drug_info.dart';
import 'favorite_screen/favourit_screen.dart';

class DrugHomePage extends StatefulWidget {
  @override
  State<DrugHomePage> createState() => _DrugHomePageState();
}

class _DrugHomePageState extends State<DrugHomePage> {
  String? selectedOption;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WLoginPage()));
    } catch (error) {
      rethrow;
    }
  }

  void _deleteDrug(String drugId) async {
    try {
      await FirebaseFirestore.instance.collection('drugs').doc(drugId).delete();
      await FirebaseFirestore.instance
          .collection('dosages')
          .where('drug_id', isEqualTo: drugId)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Drug deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete drug: $e')),
      );
    }
  }

  void _editDrug(String drugId) async {
    try {
      // Fetch drug details
      DocumentSnapshot drugDoc = await FirebaseFirestore.instance
          .collection('drugs')
          .doc(drugId)
          .get();

      // Fetch associated dosage details
      QuerySnapshot dosagesSnapshot = await FirebaseFirestore.instance
          .collection('dosages')
          .where('drug_id', isEqualTo: drugId)
          .limit(1) // Assuming one dosage per drug
          .get();

      Map<String, dynamic>? dosageData;

      if (dosagesSnapshot.docs.isNotEmpty) {
        dosageData = dosagesSnapshot.docs.first.data() as Map<String, dynamic>;
      }

      // Navigate to AddMedicineScreen with the fetched data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMedicineScreen(
            isEdit: true,
            drugId: drugId,
            initialData: drugDoc.data() as Map<String, dynamic>,
            initialDosageData: dosageData,
          ),
        ),
      );
    } catch (e) {
      // Show error message if fetching or navigation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to edit drug: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
        title: const Text(
          'Drug Information App',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3.8,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddMedicineScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: null,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoriteScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About App'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutAppPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: signOut,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (String value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrugInfoScreen(
                              drugName: value.toString(),
                              typeName: selectedOption.toString(),
                            )));
              },
              decoration: InputDecoration(
                hintText: 'Search for drugs...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
          ),

          // Radio Buttons
          ListTile(
            title: const Text('Generic'),
            leading: Radio(
              value: 'Generic',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value as String?;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Brand'),
            leading: Radio(
              value: 'Brand',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value as String?;
                });
              },
            ),
          ),

          // Scrollable List of Drugs
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('drugs').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No drugs found'));
                }

                final drugDocs = snapshot.data!.docs;

                return ListView.separated(
                  itemCount: drugDocs.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final drugData =
                        drugDocs[index].data() as Map<String, dynamic>;

                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DrugInfoScreen(
                                      drugName: drugData['drug_name'] ??
                                          'Unknown Drug',
                                      typeName: drugData['name_type'] ?? 'N/A',
                                      drugId: snapshot.data!.docs[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Drug Name
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Drug Name
                                      Text(
                                        drugData['drug_name'] ?? 'Unknown Drug',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                      // Delete Icon
                                      // Popup Menu
                                      PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            _editDrug(
                                                snapshot.data!.docs[index].id);
                                          } else if (value == 'delete') {
                                            _deleteDrug(
                                                snapshot.data!.docs[index].id);
                                          }
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return [
                                            PopupMenuItem(
                                              value: 'edit',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit,
                                                      color: Colors.blue),
                                                  SizedBox(width: 8),
                                                  Text('Edit'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete,
                                                      color: Colors.red),
                                                  SizedBox(width: 8),
                                                  Text('Delete'),
                                                ],
                                              ),
                                            ),
                                          ];
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Type of Drug
                                  Text(
                                    'Type: ${drugData['name_type'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  // Overview
                                  _buildSectionTitle('Overview'),
                                  Text(
                                    drugData['drugPointsdetail']?['overview'] ??
                                        'N/A',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),

                                  // Indication
                                  _buildSectionTitle('Indication'),
                                  Text(
                                    drugData['drugPointsdetail']
                                            ?['indication'] ??
                                        'N/A',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),

                                  // Contraindication
                                  _buildSectionTitle('Contraindication'),
                                  Text(
                                    drugData['drugPointsdetail']
                                            ?['contraindication'] ??
                                        'N/A',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),

                                  // Warnings
                                  _buildSectionTitle('Warnings'),
                                  Text(
                                    drugData['drugPointsdetail']?['warnings'] ??
                                        'N/A',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),

                                  // Side Effects
                                  _buildSectionTitle('Side Effects'),
                                  Text(
                                    drugData['drugPointsdetail']
                                            ?['sideEffects'] ??
                                        'N/A',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),

                                  // High Risk Groups
                                  _buildSectionTitle('High Risk Groups'),
                                  Text(
                                    drugData['drugPointsdetail']
                                            ?['highRiskGroups'] ??
                                        'N/A',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
