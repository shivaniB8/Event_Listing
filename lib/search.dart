import 'dart:async';

import 'package:all_events_task/common/colors.dart';
import 'package:all_events_task/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../generated/l10n.dart';

class SearchProjectField extends StatelessWidget {
  final List<String> list;
  final Function(String)? onProjectSelected;
  final Function()? onSelectionCleared;
  final bool isEnabled;
  final bool showBorder;
  final String? label;
  final String? hintText;

  const SearchProjectField({
    Key? key,
    this.onProjectSelected,
    this.onSelectionCleared,
    this.isEnabled = true,
    this.showBorder = false,
    this.label,
    this.hintText, required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blueAccent),
      ),
      child: FormBuilderField<String>(
        name: 'search_project',
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
            errorText: S.of(context).formField_error_isEmpty('Project'),
          ),
        ]),
        builder: (FormFieldState fieldState) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15,right: 10),
            child: Lookup<String>(
              showBorder: showBorder,
              isEnabled: isEnabled,
              hintText: hintText ?? 'Search...',
              label: label ?? 'Event *',

              suggestionText: (selectedValue) {
                return selectedValue;
              },

              suggestionsCallback: (String pattern) {
                RegExp regExp = RegExp(pattern, caseSensitive: false);
                return list.where((item) => regExp.hasMatch(item)).toList();
              },

              onSuggestionSelected: (selectedSuggestion) {
                onProjectSelected?.call(selectedSuggestion);
                fieldState.didChange(selectedSuggestion);
              },

              //drop down item builder
              itemBuilder: (_, value) {
                return _DropDownMenuItem(
                  option: value,
                );
              },

              onSelectionCleared: () {
                onSelectionCleared?.call();
                fieldState.didChange(null);
              },
            ),
          );
        },
      ),
    );
  }
}

class _DropDownMenuItem extends StatelessWidget {
  final String? option;

  const _DropDownMenuItem({
    Key? key,
    this.option,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Text(
        option ?? '',
        style: text_style_title14.copyWith(
          fontWeight: FontWeight.normal,
          color: primary_color,
        ),
      ),
    );
  }
}









class Lookup<T> extends StatefulWidget {
  final String? label;
  final T? initialSuggestion;
  final Function(T selectedSuggestion) onSuggestionSelected;
  final Function()? onSelectionCleared;
  final String Function(T selectedSuggestion) suggestionText;
  final FutureOr<Iterable<T>> Function(String) suggestionsCallback;
  final bool isFormSaved;
  final bool isImportantOrRequired;
  final bool? isValidationAllowed;
  final bool isEnabled;
  final Widget Function(BuildContext context, T suggestions)? itemBuilder;
  final Function? onNoSuggestion;
  final bool showAddEntitySuggestion;
  final bool showUserSelection;
  final Function(BuildContext context)? noItemsBuilder;
  final bool hideSuggestionsOnKeyboardHide;
  final SuggestionsBoxController? suggestionsBoxController;
  final bool initialFocus;
  final String? hintText;
  final bool showBorder;
  final TextStyle? selectedSuggestionTextStyle;

  const Lookup({
    Key? key,
    required this.onSuggestionSelected,
    required this.suggestionText,
    required this.suggestionsCallback,
    this.onSelectionCleared,
    this.label,
    this.initialSuggestion,
    this.isFormSaved = false,
    this.isImportantOrRequired = false,
    this.isValidationAllowed,
    this.isEnabled = true,
    this.itemBuilder,
    this.onNoSuggestion,
    this.showAddEntitySuggestion = false,
    this.showUserSelection = true,
    this.noItemsBuilder,
    this.hideSuggestionsOnKeyboardHide = true,
    this.suggestionsBoxController,
    this.initialFocus = false,
    this.hintText,
    this.showBorder = true,
    this.selectedSuggestionTextStyle,
  }) : super(key: key);

  @override
  _LookupState<T> createState() => _LookupState<T>();
}

class _LookupState<T> extends State<Lookup<T>> {
  T? _selectedSuggestion;
  TextEditingController? _textController;
  String? _selectedSuggestionText;
  List<T>? _emptyFieldSuggestions;

  ///sets text for any initially selected suggestion
  void _setSelection(T? suggestion) {
    setState(() {
      if (suggestion != null && widget.showUserSelection) {
        _selectedSuggestionText = widget.suggestionText.call(suggestion);
      } else {
        _selectedSuggestionText = null;
      }
      _selectedSuggestion = suggestion;
      _textController?.text = '';
    });
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _setSelection(widget.initialSuggestion);
  }

  @override
  void dispose() {
    _textController?.dispose();
    super.dispose();
  }

  String _getHintText(BuildContext context) =>
      _selectedSuggestionText ??
          widget.hintText ??
          'Search Hint';

  TextStyle _getHintTextStyle() => _selectedSuggestionText != null
      ? (widget.selectedSuggestionTextStyle ?? text_style_title8)
      : text_style_title4;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          _setSelection(_selectedSuggestion);
        }
      },
      child: TypeAheadField<T>(
        getImmediateSuggestions: true,
        suggestionsBoxController: widget.suggestionsBoxController,
        hideSuggestionsOnKeyboardHide: widget.hideSuggestionsOnKeyboardHide,
        //input field
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: widget.initialFocus,
          enabled: widget.isEnabled,
          controller: _textController,
          style: text_style_title8,
          decoration: form_field_input_decoration.copyWith(
            border: widget.showBorder
                ? const UnderlineInputBorder()
                : InputBorder.none,
            labelText: widget.label,
            hintText:
            widget.isEnabled || !(_selectedSuggestionText?.isEmpty??false)
                ? _getHintText(context)
                : '-',
            hintStyle: _getHintTextStyle(),
            labelStyle: text_style_title11,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.only(bottom: 8),
            suffixIconConstraints:
            widget.isEnabled ? const BoxConstraints(maxHeight: 16) : null,
            suffixIcon: (_selectedSuggestion != null &&
                widget.isEnabled &&
                widget.showUserSelection)
                ? _ClearSelection(
              onClear: () {
                _setSelection(null);
                widget.onSelectionCleared?.call();
              },
            )
                : null,
          ),
        ),

        suggestionsBoxDecoration: lookup_suggestion_box_decoration,

        //get suggestions
        suggestionsCallback: (String pattern) async {
          if (pattern.isNotEmpty && pattern.length < 3) {
            return Future.error('At least 3 characters required');
          }
          if (pattern.isNotEmpty) {
            return _emptyFieldSuggestions ??=
                (await widget.suggestionsCallback(pattern)).toList();
          }
          return await widget.suggestionsCallback(pattern);
        },

        //suggestion items
        itemBuilder: widget.itemBuilder ??
                (BuildContext context, lookupContent) {
              return Suggestion(
                text: widget.suggestionText.call(lookupContent),
              );
            },

        //suggestion selected
        onSuggestionSelected: (T suggestion) {
          _setSelection(suggestion);

          widget.onSuggestionSelected.call(suggestion);
        },

        //loader
        hideOnLoading: true,
        loadingBuilder: (context) => const NoSuggestions(
          message: 'Loading',
        ),

        //no items
        noItemsFoundBuilder: (context) {
          widget.onNoSuggestion?.call();
          return widget.noItemsBuilder?.call(context) ?? const NoSuggestions();
        },

        //error
        errorBuilder: (context, error) {
          return const NoSuggestions(
            message:  'Need at least 3 characters'

          );
        },
      ),
    );
  }
}

///clear lookup
class _ClearSelection extends StatelessWidget {
  final Function()? onClear;

  const _ClearSelection({
    Key? key,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.close),
      onPressed: onClear,
    );
  }
}




///show when there are no suggestions
class NoSuggestions extends StatelessWidget {
  final String message;

  const NoSuggestions({
    Key? key,
    this.message = '',
  }) : super(key: key);

  String _getMessage(BuildContext context) {
    return message.isNotEmpty
        ? message
        : 'No Match Found';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        _getMessage(context),
        textAlign: TextAlign.center,
        style: text_style_para1.copyWith(
          color: gray_color,
        ),
      ),
    );
  }
}


class Suggestion extends StatelessWidget {
  final String text;

  const Suggestion({
    Key? key,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Text(text),
    );
  }
}
