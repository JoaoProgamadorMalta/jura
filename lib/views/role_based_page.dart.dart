import 'package:flutter/material.dart';
import 'package:jura/controllers/provider/user.provider.dart';
import 'package:jura/views/home_page_admin.dart';
import 'package:jura/views/home_page_competitor.dart';
import 'package:jura/views/home_page_juror.dart';
import 'package:provider/provider.dart';

class RoleBasedPage extends StatelessWidget {
  const RoleBasedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.watch<UserProvider>().role;

    switch (role) {
      case 'admin':
        return const HomePageAdmin();
      case 'juror':
        return const HomePageJuror();
      case 'competitor':
        return const HomePageCompetitor();
      default:
        return Container();
    }
  }
}
