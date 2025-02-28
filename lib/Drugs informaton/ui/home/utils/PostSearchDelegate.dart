import 'package:drug_app/Drugs%20informaton/ui/home/brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../db_service/bd_service.dart';
import '../../../drug_models/drug_model.dart';
import '../dosage_screen.dart';
import 'card_widget.dart';

class PostSearchDelegate extends SearchDelegate<List<DrugInfo>> {
  final DrugInfoService drugInfoService = DrugInfoService();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<DrugInfo>>(
      stream: drugInfoService.getDrugInfo(query, 'generic'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              size: 50,
              color: Colors.deepPurple,
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text('Something went wrong');
        } else if (snapshot.hasData) {
          List<DrugInfo> drugList = snapshot.data!;
          if (drugList.isEmpty) {
            return Center(
              child: Text('No data available yet'),
            );
          }
          return ListView.builder(
            itemCount: drugList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Container for "DOSAGES"
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DosageScreen(
                                            drugId: drugList[index].drugId,
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  bottomLeft: Radius.circular(12.0),
                                ),
                                border: Border.all(
                                  color:
                                      Colors.deepPurple, // Color of the border
                                  width: 1.6, // Width of the border line
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'DOSAGES',
                                  style: TextStyle(
                                    color: Colors.deepPurple[
                                        900], // Text color same as border color
                                    fontSize: 18.0,
                                    fontWeight:
                                        FontWeight.bold, // Make text bold
                                    letterSpacing:
                                        1.2, // Add spacing between letters
                                    shadows: [
                                      Shadow(
                                        color: Colors.black
                                            .withOpacity(0.3), // Shadow color
                                        offset: Offset(1, 0), // Shadow offset
                                        blurRadius: 1, // Shadow blur radius
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        // Container for "BRANDS"
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AvailableBrandsScreen()
                                      // BrandScreen(
                                      //       brand: 'brand',
                                      //       drugId: '',
                                      //     )
                                      ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0),
                                ),
                                border: Border.all(
                                  color:
                                      Colors.deepPurple, // Color of the border
                                  width: 2.6, // Width of the border line
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'BRANDS',
                                  style: TextStyle(
                                    color: Colors.deepPurple[
                                        900], // Text color same as border color
                                    fontSize: 18.0,
                                    fontWeight:
                                        FontWeight.bold, // Make text bold
                                    letterSpacing:
                                        1.2, // Add spacing between letters
                                    shadows: [
                                      Shadow(
                                        color: Colors.black
                                            .withOpacity(0.3), // Shadow color
                                        offset: Offset(1, 0), // Shadow offset
                                        blurRadius: 1, // Shadow blur radius
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(drugList[index].drugName),
                  Card_Widget(
                    title: 'Overview',
                    content: drugList[index].overview,
                  ),
                  Card_Widget(
                      title: 'Indication', content: drugList[index].indication),
                  Card_Widget(
                      title: 'Contraindication',
                      content: drugList[index].contraindication),
                  Card_Widget(
                      title: 'Side Effects',
                      content: drugList[index].sideEffects),
                  Card_Widget(
                      title: 'Warnings', content: drugList[index].warnings),
                  Card_Widget(
                      title: 'High Risk Groups',
                      content: drugList[index].highRiskGroups),
                ],
              );
            },
          );
        }
        return Text('No data available yet');
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}
