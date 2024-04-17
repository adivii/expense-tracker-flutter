import 'package:expense_tracker/app/data/expense.dart';
import 'package:expense_tracker/app/services/DbHelper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {

  Expense? expense;
  DbHelper dbHelper = DbHelper();
  final box = GetStorage();

  RxString category = 'Outcome'.obs;
  RxInt amount = 0.obs;
  RxString description = ''.obs;

  saveData() async {
    expense = Expense(
        id: 1,
        amount: amount.value,
        isIncome: category.value == 'Outcome' ? 0 : 1,
        description: description.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    dbHelper.insert(expense!);

    print((await dbHelper.getExpenseList()).last.amount);

    Get.back();
  }

  @override
  void onInit() async {
    // print(await box.read('category'));
    category.value =
        box.read('category') == '' ? 'Outcome' : box.read('category');
    super.onInit();
  }

  @override
  void onClose() {
    box.write('category', category.value);
    super.onClose();
  }

}
