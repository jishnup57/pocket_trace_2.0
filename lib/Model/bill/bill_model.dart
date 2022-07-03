


import 'package:hive_flutter/hive_flutter.dart';
part 'bill_model.g.dart';
@HiveType(typeId: 4)
class BillModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime date;

  @HiveField(3)
  final String amound;

  @HiveField(4)
  final String id;

  BillModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amound,
  });
}
