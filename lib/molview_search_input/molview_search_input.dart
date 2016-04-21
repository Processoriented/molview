// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

@HtmlImport('molview_search_input.html')
library molview_web.molview_search_input;

import 'dart:html';
import 'dart:math';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

// ignore: UNUSED_IMPORT
import 'package:polymer_elements/color.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_flex_layout.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_icon.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_icons.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_material.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_icon_button.dart';
// ignore: UNUSED_IMPORT
import 'package:molview_web/molview_search_input/search_popup_item.dart';

/// TODO: Arrow keys to navigate through popup list items.
@PolymerRegister('molview-search-input')
class MolViewSearchInput extends PolymerElement {
  /// Store if the input is focussed.
  bool _isFocussed = false;

  /// Constructor
  MolViewSearchInput.created() : super.created() {
    // Resize the popup.
    window.addEventListener('resize', (_) {
      _updatePopupDimensions();
    });
  }

  /// Getter for the input value
  String get value => $['input'].value;

  /// Update popup with new suggestions.
  void setSuggestions(List<String> suggestions) {
    DivElement list = $['popup-list'];
    list.children.clear();
    suggestions.forEach((String suggestion) {
      list.append(new SearchPopupItem(suggestion));
    });

    _updatePopupDimensions();
  }

  /// Dynamically update the popup items left padding.
  void _updatePopupItemsPadding() {
    bool mini = attributes.containsKey('mini-toolbar');
    DivElement list = $['popup-list'];
    list.childNodes.forEach((Node node) {
      var elm = node as Element;
      elm.style.paddingLeft = mini ? '50px' : '60px';
    });
  }

  /// Update the popup dimensions
  void _updatePopupDimensions() {
    $['popup'].style.width = '${$['bar'].clientWidth}px';

    if (_isFocussed) {
      var maxHeight = document.body.clientHeight - $['popup'].documentOffset.y;
      var popupHeight = min($['popup-list'].clientHeight, maxHeight);

      $['popup'].style.height = '${popupHeight}px';
      $['popup-scroll'].style.height = '${popupHeight}px';
    }

    _updatePopupItemsPadding();
  }

  /// Add event listener to the input change event.
  void onValueChange(EventListener listener) {
    $['input'].onInput.listen(listener);
  }

  /// Set input and popup syles when the text input is focussed.
  @Listen('input.focus')
  void onInputFocus(Event event, Map detail) {
    _isFocussed = true;

    // Set styles.
    $['ripple'].classes.add('down');
    $['bar'].classes.add('focussed');
    $['left-button'].classes.add('visible');

    _updatePopupDimensions();
  }

  /// Reset input and popup syles when the text input is blurred.
  @Listen('input.blur')
  void onInputBlur(Event event, Map detail) {
    _isFocussed = false;

    // Set styles.
    $['ripple'].classes.remove('down');
    $['bar'].classes.remove('focussed');
    $['left-button'].classes.remove('visible');

    // Set popup height back to 0 (collapse transition).
    $['popup'].style.height = '0px';
  }

  /// Fire custom 'drawer-toggle' event when the drawer-toggle is tapped.
  @Listen('drawer-toggle.tap')
  void onDrawerToggleTap(Event event, Map detail) {
    fire('drawer-toggle');
  }
}
