import 'package:beauty_store/widgets/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool disabled;
  final bool loading;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final bool mini;

  const PrimaryButton({
    Key? key,
    required this.title,
    this.onTap,
    this.mini = false,
    this.buttonStyle,
    this.textStyle,
    this.disabled = false,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mini ? null : double.infinity,
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        onPressed: disabled
            ? null
            : () {
                FocusScope.of(context).unfocus();
                onTap!();
              },
        style: buttonStyle ??
            ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0))),
              elevation: MaterialStateProperty.all(10),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xfffff8f8)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 45, vertical: 12)),
            ),
        child: (loading)
            ? SizedBox(
                height: 18.h,
                width: 18.h,
                child: const AppCircularProgressIndicator(),
              )
            : Text(
                title,
                style: textStyle ??
                    const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
              ),
      ),
    );
  }
}
