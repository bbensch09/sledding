/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var n=tinymce.util.Tools.resolve("tinymce.PluginManager"),e=function(n,e){for(var a="",o=0;o<e;o++)a+=n;return a},a=function(n,a){var o,i=n.getParam("nonbreaking_wrap",!0,"boolean")||n.plugins.visualchars?'<span class="'+((o=n).plugins.visualchars&&o.plugins.visualchars.isEnabled()?"mce-nbsp-wrap mce-nbsp":"mce-nbsp-wrap")+'" contenteditable="false">'+e("&nbsp;",a)+"</span>":e("&nbsp;",a);n.undoManager.transact(function(){return n.insertContent(i)})},o=tinymce.util.Tools.resolve("tinymce.util.VK");n.add("nonbreaking",function(n){var e,i,t,r,c;(e=n).addCommand("mceNonBreaking",function(){a(e,1)}),(i=n).ui.registry.addButton("nonbreaking",{icon:"non-breaking",tooltip:"Nonbreaking space",onAction:function(){return i.execCommand("mceNonBreaking")}}),i.ui.registry.addMenuItem("nonbreaking",{icon:"non-breaking",text:"Nonbreaking space",onAction:function(){return i.execCommand("mceNonBreaking")}}),0<(c="boolean"==typeof(r=(t=n).getParam("nonbreaking_force_tab",0))?!0===r?3:0:r)&&t.on("keydown",function(n){if(n.keyCode===o.TAB&&!n.isDefaultPrevented()){if(n.shiftKey)return;n.preventDefault(),n.stopImmediatePropagation(),a(t,c)}})})}();