import 'package:hive_flutter/hive_flutter.dart';
import 'package:one/Model/category/category_model.dart';
 part 'transaction_model.g.dart';
@HiveType(typeId: 3)
class TransationModel {
  @HiveField(0)
  final double amound;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final CategoryType type;
  @HiveField(3)
  final CategoryModel category;
  @HiveField(4)
  final String notes;

  @HiveField(5)
  String? id;

  TransationModel({
    required this.amound,
    required this.date,
    required this.type,
    required this.category,
    required this.notes,
    required this.id,
  });
}
