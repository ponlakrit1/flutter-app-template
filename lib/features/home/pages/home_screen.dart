import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/home/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Id: ${provider.profile?.id}'),
                  const SizedBox(height: 8),
                  Text('Name: ${provider.profile?.name}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => provider.getProfile(),
                    child: Text('Get profile'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
