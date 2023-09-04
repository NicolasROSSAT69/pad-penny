import 'package:flutter/material.dart';
import 'package:global_bottom_navigation_bar/widgets/bottom_navigation_item.dart';
import 'package:global_bottom_navigation_bar/widgets/scaffold_bottom_navigation.dart';
import 'package:pad_penny/features/home_page.dart';

import '../logic/ui/common_expenses.dart';
import '../logic/ui/my_spend.dart';
import '../logic/ui/totals.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(
      listOfChild: const [
        MySpend(),
        CommonExpenses(),
        Totals(),
      ],
      listOfBottomNavigationItem: buildBottomNavigationItemList(),
    );
  }

  List<BottomNavigationItem> buildBottomNavigationItemList() => [
    BottomNavigationItem(
      activeIcon: const Icon(
        Icons.person,
        color: Colors.amber,
        size: 18,
      ),
      inActiveIcon: const Icon(
        Icons.person_2_outlined,
        color: Colors.grey,
        size: 21,
      ),
      title: 'Mes dépenses',
      color: Colors.white,
      vSync: this,
    ),
    BottomNavigationItem(
      activeIcon: const Icon(
        Icons.group,
        color: Colors.amber,
        size: 18,
      ),
      inActiveIcon: const Icon(
        Icons.group_outlined,
        color: Colors.grey,
        size: 21,
      ),
      title: 'Dépenses communes',
      color: Colors.white,
      vSync: this,
    ),
    BottomNavigationItem(
      activeIcon: const Icon(
        Icons.calculate,
        color: Colors.amber,
        size: 18,
      ),
      inActiveIcon: const Icon(
        Icons.calculate_outlined,
        color: Colors.grey,
        size: 21,
      ),
      title: 'Totals',
      color: Colors.white,
      vSync: this,
    ),
  ];
}
