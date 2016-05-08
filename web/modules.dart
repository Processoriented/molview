// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by an AGPL-3.0-style license
// that can be found in the LICENSE file.

import 'package:omnibus/omnibus.dart';
import 'package:http/browser_client.dart' as http;
import 'package:molview_pubchem/module.dart' as module_pubchem;

void loadModules(Omnibus bus) {
  var httpClient = new http.BrowserClient();
  module_pubchem.main(bus, httpClient);
}
