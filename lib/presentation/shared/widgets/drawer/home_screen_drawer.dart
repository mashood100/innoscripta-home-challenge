import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innoscripta_home_challenge/presentation/routes/app_routes.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({super.key});

  @override
  Widget build(BuildContext context, ) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Languages'),
            onTap: () {
              context.goNamed(AppRoute.languages.name);
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              context.goNamed(AppRoute.favorites.name);
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              context.pushNamed(AppRoute.taskHistory.name);
              Navigator.pop(context); // Close drawer
            },
          ),
        ],
      ),
    );
  }
}
