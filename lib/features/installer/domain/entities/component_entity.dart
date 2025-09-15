enum ComponentStatus { notInstalled, downloading, installed, error }

class DownloadableComponent {
  final String title;
  final String description;
  final String size;
  ComponentStatus status;
  double downloadProgress;

  DownloadableComponent({
    required this.title,
    required this.description,
    required this.size,
    this.status = ComponentStatus.notInstalled,
    this.downloadProgress = 0.0,
  });

  DownloadableComponent copyWith({
    ComponentStatus? status,
    double? downloadProgress,
  }) {
    return DownloadableComponent(
      title: title,
      description: description,
      size: size,
      status: status ?? this.status,
      downloadProgress: downloadProgress ?? this.downloadProgress,
    );
  }
}

