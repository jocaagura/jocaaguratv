import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/media/media_model.dart';
import '../../../../global/utils/get_umage_url.dart';
import '../../../../utils/go_to_media_details.dart';

class FavoritesListWidget extends StatefulWidget {
  const FavoritesListWidget({
    required this.items,
    super.key,
  });

  final List<MediaModel> items;

  @override
  State<FavoritesListWidget> createState() => _FavoritesListWidgetState();
}

class _FavoritesListWidgetState extends State<FavoritesListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (_, int index) {
        final MediaModel item = widget.items[index];
        return ListTile(
          onTap: () {
            goToMediaDetails(
              context,
              item,
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              width: 40.0,
              child: ExtendedImage.network(
                getImageUrl(item.posterPath),
              ),
            ),
          ),
          title: Text(item.originalTitle),
          subtitle: Text(
            item.overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
