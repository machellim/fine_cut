import 'package:fine_cut/widgets/emoji_popup/app_floating_emoji.dart';
import 'package:flutter/material.dart';

void showFloatingEmoji(BuildContext context, {String emoji = "😌"}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    transitionDuration: Duration.zero,
    pageBuilder: (_, __, ___) => FloatingEmoji(emoji: emoji),
  );
}
