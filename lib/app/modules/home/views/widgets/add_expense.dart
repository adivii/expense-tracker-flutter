import 'package:expense_tracker/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpense extends StatelessWidget {
  const AddExpense({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          TextField(
            onChanged: (value) {
              controller.amount.value = int.parse(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                labelText: 'Expense',
                prefixIcon: const Icon(Icons.account_balance_wallet_outlined)),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              controller.description.value = value;
            },
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                labelText: 'Notes',
                prefixIcon: const Icon(Icons.event_note_outlined)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_upward_rounded,
                      size: 18,
                    ),
                    const Icon(
                      Icons.arrow_downward_rounded,
                      size: 18,
                    ),
                    const Text('Expanse Category: '),
                    Obx(() => SizedBox(
                          child: DropdownButton<String>(
                            hint: const Text('Category'),
                            value: controller.category.value,
                            items: <String>['Income', 'Outcome']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.category.value = value!;
                            },
                          ),
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                  Obx(
                    () => Ink(
                      decoration: ShapeDecoration(
                        color: controller.category.value == 'Income'
                            ? Colors.green
                            : Colors.red,
                        shape: const CircleBorder(),
                      ),
                      child: IconButton(
                          onPressed: () {
                            controller.saveData();
                          },
                          icon: Icon(controller.category.value == 'Income'
                              ? Icons.add
                              : Icons.remove)),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
