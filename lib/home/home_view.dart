import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

import '../main.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packetbase = ref.watch(supabaseProvider);
    return Scaffold(
      body: Center(
        child: Text((packetbase.authStore.model as RecordModel)
            .data
            .entries
            .map((e) => "${e.key}: ${e.value}")
            .join("\n")),
      ),
    );
  }
}
