// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

@HtmlImport('molview_web.html')
library molview_web.molview_web;

import 'dart:html';

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

@PolymerRegister('molview-web')
class MolViewWeb extends PolymerElement {
  MolViewWeb.created() : super.created();

  @Listen('toolbar.drawer-toggle')
  void onDrawerToggleTap(Event event, Map detail) {
    var drawer = $['drawer-menu'] as PaperDrawerPanel;
    drawer.togglePanel();
  }
}
