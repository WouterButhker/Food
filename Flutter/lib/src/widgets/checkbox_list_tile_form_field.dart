import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckboxListTileFormField extends FormField<bool> {
  CheckboxListTileFormField(
      {Widget title,
      @required BuildContext context,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autoValidate = false,
      bool dense = false})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autoValidate,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: dense,
              title: title,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Text(
                      state.errorText,
                      style: TextStyle(
                          color: Theme.of(context).errorColor, fontSize: 12),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
