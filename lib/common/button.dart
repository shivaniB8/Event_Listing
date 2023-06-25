
import 'package:all_events_task/common/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { solid, stroked }

class Button extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Function()? onPressed;
  final ButtonType? buttonType;
  final Color? textColor;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Color? borderColor;

  /// Spacing between leading icon and text
  final double? leadingIconSpace;

  /// Spacing between trailing icon and text
  final double? trailingIconSpace;
  final bool isRectangularBorder;

  const Button({
    Key? key,
    this.text,
    this.child,
    this.onPressed,
    this.buttonType,
    this.textColor,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.padding,
    this.leadingIconSpace,
    this.trailingIconSpace,
    this.borderColor,
    this.isRectangularBorder = false,
  })  : assert(
  text != null || child != null,
  'text and child both cannot be null',
  ),
        super(key: key);

  Widget _getButtonByType() {
    switch (buttonType) {
      case ButtonType.solid:
        return _getSolidButton();
      case ButtonType.stroked:
        return _getStrokedButton();
      default:
        return _getSolidButton();
    }
  }

  Widget _getStrokedButton() {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: _getButtonBorder(),
        side: BorderSide(
          width: 1,
          color: borderColor ?? gray_color,
        ),
        padding: padding,
      ),
      child: _getChild(),
    );
  }

  Widget _getSolidButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
            if (states.contains(MaterialState.disabled)) {
              return disabled_color;
            }
            return backgroundColor ?? Colors.blue;
          },
        ),
        shape: MaterialStateProperty.all(
          _getButtonBorder(),
        ),
        foregroundColor: MaterialStateProperty.all(_getTextColor()),
        padding: MaterialStateProperty.all(padding),
      ),
      child: _getChild(),
    );
  }

  Widget _getChild() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading ?? const SizedBox.shrink(),
        if (leading != null)
          SizedBox(
            width: leadingIconSpace ?? 8,
          ),
        child ??
            Text(
              text ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
               color: _getTextColor(),
              )

            ),
        if (trailing != null)
          SizedBox(
            width: trailingIconSpace ?? 8,
          ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }

  Color _getTextColor() {
    return textColor ?? _getTextColorByButtonType();
  }

  Color _getTextColorByButtonType() {
    if (buttonType == ButtonType.stroked) {
      return gray_color;
    }
    return Colors.white;
  }

  OutlinedBorder _getButtonBorder() {
    return isRectangularBorder
        ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))
        : const StadiumBorder();
  }

  @override
  Widget build(BuildContext context) {
    return _getButtonByType();
  }
}
