import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes/routes.dart';
import '../controller/home_controller.dart';
import '../controller/state/home_state.dart';
import 'widgets/trending_list_widget.dart';
import 'widgets/trending_performers_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) {
        return HomeController(
          HomeState(),
          trendingRepository: context.read(),
        )..init();
      },
      child: SafeArea(
        child: LayoutBuilder(
          builder: (_, BoxConstraints constraints) {
            return RefreshIndicator(
              onRefresh: () async {},
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  elevation: 1,
                  actions: <IconButton>[
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.favorites,
                        );
                      },
                      icon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: const Column(
                      children: <Widget>[
                        _SeparatorWidget(),
                        TrendingListWidget(),
                        _SeparatorWidget(),
                        Expanded(child: TrendingPerformersWidget()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SeparatorWidget extends StatelessWidget {
  const _SeparatorWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10.0,
    );
  }
}
