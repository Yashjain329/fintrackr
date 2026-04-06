import 'package:flutter/material.dart';
import '../transactions/transaction_list_screen.dart';
import '../goals/goal_screen.dart';
import '../insights/insights_screen.dart';
import 'widgets/balance_card.dart';
import 'widgets/expense_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _index = 0;

  final _screens = [
    const DashboardHome(),
    const TransactionListScreen(),
    const GoalScreen(),
    const InsightsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.list), label: "Transactions"),
          NavigationDestination(icon: Icon(Icons.flag), label: "Goals"),
          NavigationDestination(icon: Icon(Icons.insights), label: "Insights"),
        ],
      ),
    );
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            BalanceCard(),
            SizedBox(height: 20),
            ExpenseChart(),
          ],
        ),
      ),
    );
  }
}