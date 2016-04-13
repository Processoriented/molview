// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

@HtmlImport('molview_toolbar.html')
library molview_web.molview_toolbar;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

// ignore: UNUSED_IMPORT
import 'package:polymer_elements/color.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_flex_layout.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_image.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_icons.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_icon_button.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_tabs.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_material.dart';

/// TODO: fix #search-input blur when clicking inside the #search div.
@PolymerRegister('molview-toolbar')
class MolViewToolbar extends PolymerElement {
  MolViewToolbar.created() : super.created();

  /// Store if the search bar is focussed.
  bool _searchFocus = false;

  @Listen('search.tap')
  void onSearchTap(Event event, Map detail) {
    if (!_searchFocus) {
      $$("#search-input").focus();
      _searchFocus = true;
    }
  }

  @Listen('search-input.focus')
  void onSearchInputFocus(Event event, Map detail) {
    $$("#search").classes.add('focussed');
    $$("#search-ripple").classes.add('down');
    _searchFocus = true;
  }

  @Listen('search-input.blur')
  void onSearchInputBlur(Event event, Map detail) {
    $$("#search").classes.remove('focussed');
    $$("#search-ripple").classes.remove('down');
    _searchFocus = false;
  }
}
