/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var t=tinymce.util.Tools.resolve("tinymce.PluginManager"),o=function(t,o,e){var n,i;t.dom.toggleClass(t.getBody(),"mce-visualblocks"),e.set(!e.get()),n=t,i=e.get(),n.fire("VisualBlocks",{state:i})},e=function(t,o){return function(e){e.setActive(o.get());var n=function(t){return e.setActive(t.state)};return t.on("VisualBlocks",n),function(){return t.off("VisualBlocks",n)}}};t.add("visualblocks",function(t){var n,i,s,c,u,l,a,r=(n=!1,{get:function(){return n},set:function(t){n=t}});s=r,(i=t).addCommand("mceVisualBlocks",function(){o(i,0,s)}),u=r,(c=t).ui.registry.addToggleButton("visualblocks",{icon:"visualblocks",tooltip:"Show blocks",onAction:function(){return c.execCommand("mceVisualBlocks")},onSetup:e(c,u)}),c.ui.registry.addToggleMenuItem("visualblocks",{text:"Show blocks",icon:"visualblocks",onAction:function(){return c.execCommand("mceVisualBlocks")},onSetup:e(c,u)}),a=r,(l=t).on("PreviewFormats AfterPreviewFormats",function(t){a.get()&&l.dom.toggleClass(l.getBody(),"mce-visualblocks","afterpreviewformats"===t.type)}),l.on("init",function(){l.getParam("visualblocks_default_state",!1,"boolean")&&o(l,0,a)})})}();