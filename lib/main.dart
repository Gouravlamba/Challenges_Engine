import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/challenge_repository.dart';
import 'state_management/providers/challenge_provider.dart';
import 'presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = ChallengeRepository();
  await repo.loadMockData();
  runApp(MyApp(repository: repo));
}

class MyApp extends StatelessWidget {
  final ChallengeRepository repository;
  const MyApp({required this.repository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChallengeProvider(repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Challenge Engine',
        theme: AppTheme.lightTheme,
        home: HomeScreen(),
      ),
    );
  }
}
