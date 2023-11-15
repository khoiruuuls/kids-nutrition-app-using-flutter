// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/main.dart';
import 'package:kids_nutrition_app/pages/details/kid_page.dart';
import 'package:kids_nutrition_app/recipe/model/model.dart';
import 'package:kids_nutrition_app/services/firestore.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  final String kidDocId;

  RecipeDetailPage({
    required this.kidDocId,
    required this.recipe,
  });
  double itemHeight = 40.0;
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.label),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final DocumentReference nutritionReference =
              await firestoreService.addNutrition(
            recipe.label,
            recipe.calories,
            recipe.carbs,
            recipe.fat,
            recipe.protein,
          );
          String nutritionId = nutritionReference.id;
          await firestoreService.addKidNutritionRelation(kidDocId, nutritionId);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KidPage(docId: kidDocId),
            ),
          );
        },
        label: Text("Tambahkan"),
        icon: Icon(Icons.add),
      ),
      body: ListView(
        padding: EdgeInsets.all(paddingMin),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(
                paddingMin), // Adjust the border radius as needed
            child: Image.network(
              recipe.image,
              width: double.infinity, // Use the full width
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: paddingMin),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kalori: ${recipe.calories.toStringAsFixed(2)} kcal',
                    style: TextStyle(fontSize: paddingMin),
                  ),
                  Text(
                    'Protein: ${recipe.protein.toStringAsFixed(2)} g',
                    style: TextStyle(fontSize: paddingMin),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Karbohidrat: ${recipe.carbs.toStringAsFixed(2)} g',
                    style: TextStyle(fontSize: paddingMin),
                  ),
                  Text(
                    'Lemak: ${recipe.fat.toStringAsFixed(2)} g',
                    style: TextStyle(fontSize: paddingMin),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: paddingMin),
          Text(
            'Ingredients:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Create a ListView or Column to list the ingredients
          SizedBox(height: 10), // Add some spacing if needed
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(paddingMin),
            ),
            height: 780,
            child: ListView.builder(
              itemCount: recipe.ingredientLines.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: paddingMin,
                        right: paddingMin,
                        top: paddingMin / 2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: TextStyle(fontSize: paddingMin),
                          ),
                          Expanded(
                            child: Text(
                              '${recipe.ingredientLines[index]}',
                              style: TextStyle(fontSize: paddingMin),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
