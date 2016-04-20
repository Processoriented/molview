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

/// TODO: Find a way to make the popup scrollable on small heights.
/// TODO: Implement using IronResizableBehavior?
@PolymerRegister('molview-search-input')
class MolViewSearchInput extends PolymerElement {
  /// Store if the input is focussed.
  bool isFocussed = false;

  MolViewSearchInput.created() : super.created() {
    // Resize the popup.
    window.addEventListener('resize', (_) {
      $['popup-wrapper'].style.width = '${$['bar'].clientWidth}px';

      // Only resize popup height if the popup is visible.
      if (isFocussed) {
        $['popup'].style.height = '${$['popup-list'].clientHeight}px';
      }
    });
  }

  @Listen('input.focus')
  void onInputFocus(Event event, Map detail) {
    isFocussed = true;

    // Set styles.
    $['ripple'].classes.add('down');
    $['bar'].classes.add('focussed');
    $['left-button'].classes.add('visible');
    $['popup-wrapper'].classes.add('visible');

    // Resize popup.
    $['popup-wrapper'].style.width = '${$['bar'].clientWidth}px';
    $['popup'].style.height = '${$['popup-list'].clientHeight}px';
  }

  @Listen('input.blur')
  void onInputBlur(Event event, Map detail) {
    isFocussed = false;

    // Set styles.
    $['ripple'].classes.remove('down');
    $['bar'].classes.remove('focussed');
    $['left-button'].classes.remove('visible');
    $['popup-wrapper'].classes.remove('visible');

    // Set popup height back to 0.
    $['popup'].style.height = '0px';
  }

  @Listen('drawer-toggle.tap')
  void onDrawerToggleTap(Event event, Map detail) {
    fire('drawer-toggle');
  }
}
