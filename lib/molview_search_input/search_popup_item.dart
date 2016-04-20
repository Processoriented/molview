// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

@HtmlImport('search_popup_item.html')
library molview_web.search_popup_item;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('search-popup-item')
class SearchPopupItem extends PolymerElement {
  /// Constructor
  factory SearchPopupItem(String text) =>
      new Element.tag('search-popup-item')..innerHtml = text;

  /// Polymer constructor
  SearchPopupItem.created() : super.created();
}
