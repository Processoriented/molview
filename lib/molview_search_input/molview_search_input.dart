// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

@HtmlImport('molview_search_input.html')
library molview_web.molview_search_input;

import 'dart:html';
import 'dart:math';
import 'dart:async';

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
import 'package:polymer_elements/paper_ripple.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_material.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_icon_button.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_icon_item.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_menu.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_menu_button.dart';
// ignore: UNUSED_IMPORT
import 'package:molview_web/molview_search_input/search_popup_item.dart';

@PolymerRegister('molview-search-input')
class MolViewSearchInput extends PolymerElement {
  /// Store if the input is focussed.
  bool _isFocussed = false;

  /// Selected popup item, -1 if none is selected.
  int _selectedItem = -1;

  /// Constructor
  MolViewSearchInput.created() : super.created() {
    // Resize the popup onresize.
    window.addEventListener('resize', (_) {
      // Always update width because the popup can still be visible when it is
      // unfocussed due to the transition.
      _updatePopupDimensions(true, _isFocussed, true);
    });

    // Popup arrow navigation
    $['input'].onKeyDown.listen((KeyboardEvent e) {
      switch (e.keyCode) {
        case KeyCode.UP:
          e.preventDefault(); // Prevent input navigation
          setSelectedItem(_selectedItem == 0
              ? $['popup-list'].childNodes.length - 1
              : _selectedItem - 1);
          break;
        case KeyCode.DOWN:
          e.preventDefault(); // Prevent input navigation
          setSelectedItem(_selectedItem + 1 == $['popup-list'].childNodes.length
              ? 0
              : _selectedItem + 1);
          break;
      }
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

    _updatePopupItemsPadding();

    // Delay so the UI can update the height of the list.
    if (_isFocussed) {
      new Future(() {
        _updatePopupDimensions(false, true, false);
      });
    }

    // Clear selection.
    _selectedItem = -1;
  }

  /// Change popup selected item index.
  void setSelectedItem(int idx) {
    // Unselect currently selected item.
    if (_selectedItem != -1) {
      $['popup-list'].childNodes[_selectedItem].attributes.remove('selected');
    }

    // Select new item.
    if (idx != -1) {
      _selectedItem = idx;
      $['popup-list'].childNodes[_selectedItem].attributes['selected'] = '';
    }
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
  void _updatePopupDimensions(bool width, bool height, bool padding) {
    if (width) {
      $['popup'].style.width = '${$['bar'].clientWidth}px';
    }

    if (height) {
      var maxHeight = document.body.clientHeight - $['popup'].documentOffset.y;
      var popupHeight = min($['popup-list'].clientHeight, maxHeight);

      $['popup'].style.height = '${popupHeight}px';
      $['popup-scroll'].style.height = '${popupHeight}px';
    }

    if (padding) {
      _updatePopupItemsPadding();
    }
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

    // Note that the width actually only has to be updated once at te beginning
    // when no width is set yet.
    _updatePopupDimensions(true, true, false);
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

  /// Reset menu selected status after the menu closes
  @Listen('menu.paper-dropdown-open')
  void onMenuClose(Event event, Map details) {
    $['menu-items'].selected = -1;
  }
}
