import 'package:flutter/material.dart';

class FavoritesTabBarWidget extends StatelessWidget implements PreferredSize {
  const FavoritesTabBarWidget({
    required this.tabController,
    super.key,
  });
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      iconTheme: Theme.of(context).iconTheme,
      bottom: TabBar(
        labelColor: Theme.of(context).primaryColorDark,
        controller: tabController,
        indicator: _Decoration(context),
        //indicator: BoxDecoration(
        //  color: Theme.of(context).dialogBackgroundColor,
        //  borderRadius: BorderRadius.circular(30.0),
        //),
        tabs: const <Widget>[
          Tab(icon: Icon(Icons.movie), text: 'movies,'),
          Tab(
            icon: Icon(Icons.tv),
            text: 'Series',
          ),
        ],
      ),
    );
  }

  @override
  Widget get child => const SizedBox.shrink();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _Decoration extends Decoration {
  const _Decoration(
    this.context,
  );

  final BuildContext context;
  @override
  BoxPainter createBoxPainter([
    VoidCallback? onChanged,
  ]) {
    return _Painter(context);
  }
}

class _Painter extends BoxPainter {
  _Painter(this.context);

  final BuildContext context;

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final Paint paint = Paint()..color = Theme.of(context).primaryColorDark;
    final Size size = configuration.size ?? Size.zero;

    canvas.drawCircle(
      Offset(
        size.width * 0.5 + offset.dx,
        size.height * 0.9,
      ),
      4,
      paint,
    );
  }
}
