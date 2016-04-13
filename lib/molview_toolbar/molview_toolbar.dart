// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

@HtmlImport('molview_toolbar.html')
library molview_web.molview_toolbar;

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
import 'package:molview_web/molview_search_input/molview_search_input.dart';

@PolymerRegister('molview-toolbar')
class MolViewToolbar extends PolymerElement {
  MolViewToolbar.created() : super.created();
}
