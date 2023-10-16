import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/media/media_model.dart';
import '../../../../global/utils/get_umage_url.dart';

class FavoritesListWidget extends StatelessWidget {
  const FavoritesListWidget({
    required this.items,
    super.key,
  });

  final List<MediaModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, int index) {
        final MediaModel item = items[index];
        return ListTile(
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
}
