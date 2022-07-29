import 'package:one/model/bill/bill_model.dart';

abstract class BillService {
  Future<void> insertbill(BillModel obj);
  Future<void> deleteBill(String billID);
  Future<List<BillModel>> getBills();
  Future<void> refreshBillUI();
}