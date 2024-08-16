import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/resources/app_pallete.dart';
import 'package:todoapp/view/login_screen.dart';
import 'package:todoapp/view/taskScreen/add_new_task.dart';
import 'package:todoapp/view/taskScreen/all_task.dart';
import 'package:todoapp/view/taskScreen/completed_task.dart';
import 'package:todoapp/view/taskScreen/priority_task.dart';
import 'package:todoapp/view/widgets/alert_box.dart';
import 'package:todoapp/view_model.dart/auth_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppPallete.gradient1, AppPallete.gradient2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/todo.png',
                color: AppPallete.whiteColor,
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertBox(
                      title: 'Logout',
                      onYesPressed: () {
                        _logout();
                      },
                      subTitle: 'Are you sure you want to logout?',
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.logout,
                color: AppPallete.whiteColor,
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: AppPallete.whiteColor,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "All Task"),
              Tab(text: "Priority Level"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: AllTaskScreen()),
            Center(child: PriorityTask()),
            Center(child: CompletedTask()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppPallete.gradient1,
            child: const Icon(
              Icons.add,
              color: AppPallete.whiteColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AddNewTask();
                },
              );
            }),
      ),
    );
  }
}
