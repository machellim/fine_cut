import 'package:fine_cut/widgets/app_top_banner.dart';

class BannerState {
  final bool show;
  final String message;
  final AppBannerType type;

  const BannerState({
    required this.show,
    required this.message,
    this.type = AppBannerType.success,
  });

  factory BannerState.initial() {
    return const BannerState(show: false, message: '');
  }

  BannerState copyWith({bool? show, String? message, AppBannerType? type}) {
    return BannerState(
      show: show ?? this.show,
      message: message ?? this.message,
      type: type ?? this.type,
    );
  }
}
