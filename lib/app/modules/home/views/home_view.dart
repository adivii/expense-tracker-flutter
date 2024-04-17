import 'package:expense_tracker/app/modules/home/views/widgets/add_expense.dart';
import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(onPressed: () {}, child: const Text('data')),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.bottomSheet(
            SizedBox(
                width: double.infinity,
                // height: 400,
                // color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AddExpense(controller: controller),
                  ],
                )),
            enableDrag: true,
            isScrollControlled: true,
            backgroundColor: Colors.white);
      }),
    );
  }
}
