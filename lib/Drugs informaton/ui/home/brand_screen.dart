// import 'package:flutter/material.dart';
// import '../../db_service/bd_service.dart';
// import '../../drug_models/drug_model.dart';
// import 'drug_info.dart';

// class BrandScreen extends StatelessWidget {
//   final String brand;

//   BrandScreen({Key? key, required this.brand}) : super(key: key);
//   final DrugInfoService drugInfoService = DrugInfoService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: Colors.deepPurple[900],
//         centerTitle: true,
//         title: Text(
//           'Brands Information',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//           ),
//         ),
//       ),
//       body: Center(
//         child: FutureBuilder<List<DrugInfo>>(
//           future: drugInfoService.getBrandDrugs(brand),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               final brandDrugs = snapshot.data;
//               if (brandDrugs != null && brandDrugs.isNotEmpty) {
//                 return ListView.builder(
//                   itemCount: brandDrugs.length,
//                   itemBuilder: (context, index) {
//                     final drugInfo = brandDrugs[index];
//                     return _buildSocietyCard(drugInfo.drugName, context);
//                   },
//                 );
//               } else {
//                 return Text('No drugs found for the brand $brand');
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildSocietyCard(String name, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: ListTile(
//           contentPadding: EdgeInsets.all(12),
//           title: Text(
//             name,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           subtitle: Text(
//             'Overview',
//             style: TextStyle(fontSize: 14),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//           ),
//           leading: Container(
//             width: 50, // Adjust width as needed
//             height: 50, // Adjust height as needed
//             child: CircleAvatar(
//               backgroundColor: Colors.deepPurple[900],
//               child: Icon(
//                 Icons.medical_services,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.deepPurple[900],
//           ),
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => DrugInfoScreen(
//                           drugName: name.toString(),
//                           typeName: 'brand',
//                         )));
//           },
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../db_service/bd_service.dart';
// import '../../drug_models/drug_model.dart';
// import 'drug_info.dart';

// class BrandScreen extends StatelessWidget {
//   final String brand;
//   final DrugInfoService drugInfoService = DrugInfoService();

//   BrandScreen({Key? key, required this.brand}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: Center(
//         child: FutureBuilder<List<DrugInfo>>(
//           future: drugInfoService.getBrandDrugs(brand),
//           builder: (context, snapshot) => _buildContent(snapshot),
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       iconTheme: const IconThemeData(color: Colors.white),
//       backgroundColor: Colors.deepPurple[900],
//       centerTitle: true,
//       title: const Text(
//         'Brands Information',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }

//   Widget _buildContent(AsyncSnapshot<List<DrugInfo>> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const CircularProgressIndicator();
//     } else if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//       return _buildBrandList(snapshot.data!);
//     } else {
//       return Text('No drugs found for the brand $brand');
//     }
//   }

//   Widget _buildBrandList(List<DrugInfo> brandDrugs) {
//     return ListView.builder(
//       itemCount: brandDrugs.length,
//       itemBuilder: (context, index) {
//         final drugInfo = brandDrugs[index];
//         return _buildBrandCard(drugInfo.drugName, context);
//       },
//     );
//   }

//   Widget _buildBrandCard(String name, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: ListTile(
//           contentPadding: const EdgeInsets.all(12),
//           title: Text(
//             name,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           subtitle: const Text(
//             'Overview',
//             style: TextStyle(fontSize: 14),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//           ),
//           leading: CircleAvatar(
//             backgroundColor: Colors.deepPurple[900],
//             child: const Icon(
//               Icons.medical_services,
//               color: Colors.white,
//             ),
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.deepPurple[900],
//           ),
//           onTap: () => _navigateToDrugInfo(context, name),
//         ),
//       ),
//     );
//   }

//   void _navigateToDrugInfo(BuildContext context, String drugName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DrugInfoScreen(
//           drugName: drugName,
//           typeName: 'brand',
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../../db_service/bd_service.dart';
// import '../../drug_models/drug_model.dart';
// import 'drug_info.dart';

// class BrandScreen extends StatelessWidget {
//   final String brand;
//   final DrugInfoService drugInfoService = DrugInfoService();

//   BrandScreen({Key? key, required this.brand, required String drugId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: Center(
//         child: FutureBuilder<List<DrugInfo>>(
//           future: drugInfoService.getBrandDrugs(brand),
//           builder: (context, snapshot) => _buildContent(snapshot),
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       iconTheme: const IconThemeData(color: Colors.white),
//       backgroundColor: Colors.deepPurple[900],
//       centerTitle: true,
//       title: const Text(
//         'Brands Information',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }

//   Widget _buildContent(AsyncSnapshot<List<DrugInfo>> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const CircularProgressIndicator();
//     } else if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//       return _buildBrandList(snapshot.data!);
//     } else {
//       return Text('No drugs found for the brand $brand');
//     }
//   }

//   Widget _buildBrandList(List<DrugInfo> brandDrugs) {
//     return ListView.builder(
//       itemCount: brandDrugs.length,
//       itemBuilder: (context, index) {
//         final drugInfo = brandDrugs[index];
//         return _buildBrandCard(drugInfo, context);
//       },
//     );
//   }

//   Widget _buildBrandCard(DrugInfo drugInfo, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: ListTile(
//           contentPadding: const EdgeInsets.all(12),
//           title: Text(
//             drugInfo.drugName,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           subtitle: const Text(
//             'Overview',
//             style: TextStyle(fontSize: 14),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//           ),
//           leading: CircleAvatar(
//             backgroundColor: Colors.deepPurple[900],
//             child: const Icon(
//               Icons.medical_services,
//               color: Colors.white,
//             ),
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.deepPurple[900],
//           ),
//           onTap: () => _navigateToDrugInfo(context, drugInfo),
//         ),
//       ),
//     );
//   }

//   void _navigateToDrugInfo(BuildContext context, DrugInfo drugInfo) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DrugInfoScreen(
//           drugName: drugInfo.drugName,
//           typeName: 'brand',
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AvailableBrandsScreen extends StatelessWidget {
  final List<Map<String, String>> brands = [
    {"name": "ANZATAX", "manufacturer": "ATCO LABORATORIES LIMITED"},
    {"name": "EBETAXEL", "manufacturer": "BIO PHARMA"},
    {"name": "INTAXEL", "manufacturer": "ATCO LABORATORIES LIMITED"},
    {"name": "METAPLAXEL", "manufacturer": "CONSOLIDATED CHEMICAL"},
    {"name": "ONCOTAXEL", "manufacturer": "PHARMEVO (PVT) LTD."},
    {"name": "PACLIKEBIR", "manufacturer": "ONCOGENE PHARMACEUTICALS"},
    {"name": "PACLITAX", "manufacturer": "PHARMEDIC (PVT) LTD."},
    {"name": "PACLITAXEL", "manufacturer": "INNO PHARM"},
    {"name": "PACLITAXEL AHP", "manufacturer": "A. J. MIRZA PHARMA (PVT) LTD"},
    {"name": "PACLITAXEL EBEWE", "manufacturer": "NOVARTIS PHARMA (PAK) LTD"},
    {"name": "PACLITAXEL VARIFARMA", "manufacturer": "MEDINET PHARMACEUTICALS"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple[900],
        elevation: 1,
        title: Row(
          children: [
            Icon(
              Icons.local_pharmacy,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Available Brands",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     color: Colors.grey,
        //     onPressed: () {
        //       // Add search functionality here
        //     },
        //   ),
        // ],
      ),
      body: ListView.builder(
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return _buildBrandCard(brand['name']!, brand['manufacturer']!);
        },
      ),
    );
  }

  Widget _buildBrandCard(String brandName, String manufacturer) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(Icons.play_arrow, color: Colors.blue),
        title: Text(
          brandName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          manufacturer,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.medical_services_outlined,
          color: Colors.blue,
        ),
        onTap: () {
          // Handle navigation to brand details here
        },
      ),
    );
  }
}
