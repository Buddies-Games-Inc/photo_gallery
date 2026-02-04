part of '../../photo_gallery.dart';

/// A album in the gallery.
@immutable
class Album {
  /// A unique identifier for the album.
  final String id;

  /// The [MediumType] of the album.
  final MediumType? mediumType;

  /// The sort direction is newest or not
  final bool newest;

  /// The name of the album.
  final String? name;

  /// The total number of media in the album.
  final int count;

  /// Indicates whether this album contains all media.
  bool get isAllAlbum => id == "__ALL__";

  /// Creates a album from platform channel protocol.
  Album.fromJson(dynamic json, this.mediumType, this.newest)
      : id = json['id'],
        name = json['name'],
        count = json['count'] ?? 0;

  /// list media in the album.
  ///
  /// Pagination can be controlled out of [skip] (defaults to `0`) and
  /// [take] (defaults to `<total>`).
  /// [includeCloudStatus] when true, checks if assets are stored locally on device
  /// (iOS only - slower as it requires checking each asset). When false or null,
  /// [Medium.isOnDevice] will be null on iOS and true on Android.
  Future<MediaPage> listMedia({
    int? skip,
    int? take,
    bool? lightWeight,
    bool? includeCloudStatus,
  }) {
    return PhotoGallery._listMedia(
      album: this,
      skip: skip,
      take: take,
      lightWeight: lightWeight,
      includeCloudStatus: includeCloudStatus,
    );
  }

  /// Get thumbnail data for this album.
  ///
  /// It will display the lastly taken medium thumbnail.
  Future<List<int>> getThumbnail({
    int? width,
    int? height,
    bool? highQuality = false,
  }) {
    return PhotoGallery.getAlbumThumbnail(
      albumId: id,
      mediumType: mediumType,
      width: width,
      height: height,
      highQuality: highQuality,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Album &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          mediumType == other.mediumType &&
          name == other.name &&
          count == other.count;

  @override
  int get hashCode =>
      id.hashCode ^ mediumType.hashCode ^ name.hashCode ^ count.hashCode;

  @override
  String toString() {
    return 'Album{id: $id, '
        'mediumType: $mediumType, '
        'name: $name, '
        'count: $count}';
  }
}
