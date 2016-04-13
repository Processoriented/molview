// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

@HtmlImport('molview_search_input.html')
library molview_web.molview_search_input;

import 'dart:html';

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

@PolymerRegister('molview-search-input')
class MolViewSearchInput extends PolymerElement {
  MolViewSearchInput.created() : super.created();

  /// Store if the search bar is focussed.
  bool _searchFocus = false;

  @Listen('bar.tap')
  void onBarTap(Event event, Map detail) {
    if (!_searchFocus) {
      $$("#input").focus();
      _searchFocus = true;
    }
  }

  @Listen('bar.down')
  void onBarPointerDown(Event event, Map detail) {
    // Prevent any blurring if the user clicks outside the input inside the bar.
    //
    // Note: also prevents focussing by clicking the input, but that is ok since
    // tap wil handle this already.
    event.preventDefault();
  }

  @Listen('input.focus')
  void onInputFocus(Event event, Map detail) {
    $$("#bar").classes.add('focussed');
    $$("#ripple").classes.add('down');
    _searchFocus = true;
  }

  @Listen('input.blur')
  void onInputBlur(Event event, Map detail) {
    $$("#bar").classes.remove('focussed');
    $$("#ripple").classes.remove('down');
    _searchFocus = false;
  }
}
