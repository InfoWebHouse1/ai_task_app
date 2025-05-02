import 'package:flutter/material.dart';
import 'package:task_app_ai/contants/size_utils.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onSubmitField,
  });

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onSubmitField;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: Container(
            width: width ?? double.maxFinite,
            margin: margin,
            child: TextFormField(
              controller: controller,
              focusNode: focusNode ?? FocusNode(),
              autofocus: autofocus!,
              style:
                  textStyle ??
                  Theme.of(context).textTheme.titleSmall!.copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.surface,
                  ),
              cursorColor: Theme.of(context).colorScheme.surface,
              obscureText: obscureText!,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              maxLines: maxLines ?? 1,
              decoration: InputDecoration(
                hintText: hintText ?? "",
                hintStyle: hintStyle ?? Theme.of(context).textTheme.titleSmall,
                errorStyle: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.red),
                prefixIcon: prefix,
                prefixIconConstraints: prefixConstraints,
                suffixIcon: suffix,
                suffixIconConstraints: suffixConstraints,
                isDense: true,
                contentPadding: contentPadding ?? getPadding(all: 12),
                fillColor: fillColor ?? Colors.white,
                filled: filled,
                border:
                    borderDecoration ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(10.00),
                      ),
                      borderSide: BorderSide.none,
                    ),
                enabledBorder:
                    borderDecoration ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(10.00),
                      ),
                      borderSide: BorderSide.none,
                    ),
                focusedBorder:
                    borderDecoration ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(10.00),
                      ),
                      borderSide: BorderSide.none,
                    ),
              ),
              validator: validator,
              onFieldSubmitted: onSubmitField,
            ),
          ),
        )
        : Container(
          width: width ?? double.maxFinite,
          margin: margin,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode ?? FocusNode(),
            autofocus: autofocus!,
            style:
                textStyle ??
                Theme.of(context).textTheme.titleSmall!.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.surface,
                ),
            cursorColor: Theme.of(context).colorScheme.surface,
            obscureText: obscureText!,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              hintText: hintText ?? "",
              hintStyle: hintStyle ?? Theme.of(context).textTheme.titleSmall,
              errorStyle: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: Colors.red),
              prefixIcon: prefix,
              prefixIconConstraints: prefixConstraints,
              suffixIcon: suffix,
              suffixIconConstraints: suffixConstraints,
              isDense: true,
              contentPadding: contentPadding ?? getPadding(all: 12),
              fillColor: fillColor ?? Colors.white,
              filled: filled,
              border:
                  borderDecoration ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(10.00),
                    ),
                    borderSide: BorderSide.none,
                  ),
              enabledBorder:
                  borderDecoration ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(10.00),
                    ),
                    borderSide: BorderSide.none,
                  ),
              focusedBorder:
                  borderDecoration ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(10.00),
                    ),
                    borderSide: BorderSide.none,
                  ),
            ),
            validator: validator,
            onFieldSubmitted: onSubmitField,
          ),
        );
  }
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillWhiteA => OutlineInputBorder(
    borderRadius: BorderRadius.circular(getHorizontalSize(3.00)),
    borderSide: BorderSide.none,
  );

  static OutlineInputBorder get fillGray => OutlineInputBorder(
    borderRadius: BorderRadius.circular(getHorizontalSize(2.00)),
    borderSide: BorderSide.none,
  );

  static OutlineInputBorder get outlineBlackTL7 => OutlineInputBorder(
    borderRadius: BorderRadius.circular(getHorizontalSize(7.00)),
    borderSide: BorderSide.none,
  );
}
