import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Annotation extends Comparable<Annotation> {
  Annotation({required this.range, this.style});
  final TextRange range;
  final TextStyle? style;

  @override
  int compareTo(Annotation other) {
    return range.start.compareTo(other.range.start);
  }

  @override
  String toString() {
    return 'Annotation(range:$range, style:$style)';
  }
}

class AnnotatedEditableText extends EditableText {
  AnnotatedEditableText({
    Key? key,
    required FocusNode focusNode,
    required TextEditingController controller,
    required TextStyle style,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    required Color cursorColor,
    Color? selectionColor,
    TextSelectionControls? selectionControls,
    this.annotations,
  }) : super(
          backgroundCursorColor: Colors.blue,
          key: key,
          focusNode: focusNode,
          controller: controller,
          cursorColor: cursorColor,
          style: style,
          keyboardType: TextInputType.text,
          autocorrect: true,
          autofocus: true,
          selectionColor: selectionColor,
          selectionControls: selectionControls,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        );

  final List<Annotation>? annotations;

  @override
  AnnotatedEditableTextState createState() => AnnotatedEditableTextState();
}

class AnnotatedEditableTextState extends EditableTextState {
  @override
  AnnotatedEditableText get widget => super.widget as AnnotatedEditableText;
  // EditableText get widget => super.widget;

  List<Annotation> getRanges() {
    final List<Annotation> source = widget.annotations!;
    source.sort();
    final List<Annotation> result = <Annotation>[];
    Annotation? prev;
    for (final Annotation item in source) {
      if (prev == null) {
        // First item, check if we need one before it.
        if (item.range.start > 0) {
          result.add(Annotation(
            range: TextRange(start: 0, end: item.range.start),
          ));
        }
        result.add(item);
        prev = item;
        continue;
      } else {
        // Consequent item, check if there is a gap between.
        if (prev.range.end > item.range.start) {
          // Invalid ranges
          throw StateError('Invalid (intersecting) ranges for annotated field');
        } else if (prev.range.end < item.range.start) {
          result.add(Annotation(
            range: TextRange(start: prev.range.end, end: item.range.start),
          ));
        }
        // Also add current annotation
        result.add(item);
        prev = item;
      }
    }
    // Also check for trailing range
    final String text = textEditingValue.text;
    if (result.last.range.end < text.length) {
      result.add(Annotation(
        range: TextRange(start: result.last.range.end, end: text.length),
      ));
    }
    return result;
  }

  @override
  TextSpan buildTextSpan() {
    final String text = textEditingValue.text;

    if (widget.annotations != null) {
      final List<Annotation> items = getRanges();
      final List<TextSpan> children = <TextSpan>[];
      for (final Annotation item in items) {
        children.add(
          TextSpan(style: item.style, text: item.range.textInside(text)),
        );
      }
      return TextSpan(style: widget.style, children: children);
    }

    return TextSpan(style: widget.style, text: text);
  }
}
