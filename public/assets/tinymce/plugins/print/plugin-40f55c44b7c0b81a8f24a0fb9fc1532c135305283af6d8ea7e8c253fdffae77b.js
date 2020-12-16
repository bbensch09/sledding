/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var n=tinymce.util.Tools.resolve("tinymce.PluginManager"),t=tinymce.util.Tools.resolve("tinymce.Env");n.add("print",function(n){var i,e;(i=n).addCommand("mcePrint",function(){t.browser.isIE()?i.getDoc().execCommand("print",!1,null):i.getWin().print()}),(e=n).ui.registry.addButton("print",{icon:"print",tooltip:"Print",onAction:function(){return e.execCommand("mcePrint")}}),e.ui.registry.addMenuItem("print",{text:"Print...",icon:"print",onAction:function(){return e.execCommand("mcePrint")}}),n.addShortcut("Meta+P","","mcePrint")})}();