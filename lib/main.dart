// import 'package:fetch_client/fetch_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import 'config/app_config.dart';
import 'routes/app_router.dart';

final pbProvider = Provider<PocketBase>((ref) {
  return PocketBase("http://10.0.2.2:8090");
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [
        pbProvider.overrideWithValue(
          PocketBase(
            "http://10.0.2.2:8090",
            // httpClientFactory:
            //     kIsWeb ? () => FetchClient(mode: RequestMode.cors) : null,
          ),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final route = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: route,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
