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
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_icon_button.dart';

@PolymerRegister('molview-search-input')
class MolViewSearchInput extends PolymerElement {
  MolViewSearchInput.created() : super.created();

  @Listen('input.focus')
  void onInputFocus(Event event, Map detail) {
    $['bar'].classes.add('focussed');
    $['ripple'].classes.add('down');
    $['left-button'].classes.add('focussed');
  }

  @Listen('input.blur')
  void onInputBlur(Event event, Map detail) {
    $['bar'].classes.remove('focussed');
    $['ripple'].classes.remove('down');
    $['left-button'].classes.remove('focussed');
  }

  @Listen('drawer-toggle.tap')
  void onDrawerToggleTap(Event event, Map detail) {
    fire('drawer-toggle');
  }
}
