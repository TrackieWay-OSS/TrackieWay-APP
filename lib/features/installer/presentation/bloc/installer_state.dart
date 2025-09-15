import 'package:equatable/equatable.dart';
import 'package:trackie_app/features/installer/domain/entities/component_entity.dart';

abstract class InstallerState extends Equatable {
  final List<DownloadableComponent> components;
  final bool isDownloadingAll;
  final double overallProgress;

  const InstallerState({
    required this.components,
    this.isDownloadingAll = false,
    this.overallProgress = 0.0,
  });

  @override
  List<Object> get props => [components, isDownloadingAll, overallProgress];

  InstallerState copyWith({
    List<DownloadableComponent>? components,
    bool? isDownloadingAll,
    double? overallProgress,
  }) {
    return InstallerLoading(
      components: components ?? this.components,
      isDownloadingAll: isDownloadingAll ?? this.isDownloadingAll,
      overallProgress: overallProgress ?? this.overallProgress,
    );
  }
}

class InstallerInitial extends InstallerState {
  const InstallerInitial({required super.components});
}

class InstallerLoading extends InstallerState {
  const InstallerLoading({
    required super.components,
    required super.isDownloadingAll,
    required super.overallProgress,
  });
}

