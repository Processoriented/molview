// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

@HtmlImport('molview_web.html')
library molview_web.molview_web;

import 'dart:html';
import 'dart:async';

// ignore: UNUSED_IMPORT
import 'package:web_components/web_components.dart' show HtmlImport;
// ignore: UNUSED_IMPORT
import 'package:polymer/polymer.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_icon.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/iron_icons.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_menu.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_toolbar.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_icon_item.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_drawer_panel.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/paper_header_panel.dart';
// ignore: UNUSED_IMPORT
import 'package:molview_web/molview_toolbar/molview_toolbar.dart';
// ignore: UNUSED_IMPORT
import 'package:molview_web/molview_search_input/molview_search_input.dart';

/// TODO: isolate GUI management and actual event handling.
@PolymerRegister('molview-web')
class MolViewWeb extends PolymerElement {
  /// Inner search input
  MolViewSearchInput _input;

  /// Threshold number of characters for autocomplete.
  int autocompleteThreshold = 2;

  /// Default autocomplete suggestions.
  List<String> defaultSuggestions = [
    'PubChem',
    'ChemSpider',
    'ChEMBL',
    'PDB',
    'COD'
  ];

  /// Constructor
  MolViewWeb.created() : super.created() {
    // Delay because running this code right away causes the drawer to open and
    // close in Firefox (yeah, really weird).
    new Future(() {
      _input = $['toolbar'].getSearchInput();

      // Set popup contents to default suggestions by default.
      _input.setSuggestions(defaultSuggestions);

      // Add callback for search input change.
      _input.onValueChange((Event event) async {
        // Only proceed if the value is longer than the threshold number.
          var value = _input.value;
          if (value.length > autocompleteThreshold) {
            // Get suggestions.
            // TODO: reimplement Wikidata lookup in data library.
            //final suggestions = wikidata.loadSuggestions('en', 5);
            final suggestions = ['No results'];

            // Load new suggestions into input popup.
            // Check if the value has changed since.
            if (value == _input.value) {
              _input.setSuggestions(suggestions);
            }
          } else {
            // Set the autocomplete popup to the default content.
            _input.setSuggestions(defaultSuggestions);
          }
      });
    });
  }

  /// Toggle drawer when the custom 'drawer-toggle' event is triggered.
  @Listen('toolbar.drawer-toggle')
  void onDrawerToggleTap(Event event, Map detail) {
    $['drawer-panel'].togglePanel();
    $['drawer-menu'].selected = -1;
  }

  /// An item in the drawer menu is selected.
  @Listen('drawer-menu.iron-select')
  void onDrawerSelect(Event event, Map detail) {
    $['drawer-panel'].closeDrawer();
  }
}
