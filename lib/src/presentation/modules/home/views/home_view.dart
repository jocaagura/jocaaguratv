import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/translations.g.dart';
import '../../../global/widgets/my_scaffold_widget.dart';
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
    Localizations.localeOf(context).languageCode;
    return ChangeNotifierProvider<HomeController>(
      key: Key('home-${LocaleSettings.currentLocale.languageCode}'),
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
              child: MyScaffold(
                appBar: AppBar(
                  actions: <IconButton>[
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.favorites,
                        );
                      },
                      icon: const Icon(
                        Icons.favorite,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.profile,
                        );
                      },
                      icon: const Icon(
                        Icons.person,
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
