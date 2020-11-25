/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var e=tinymce.util.Tools.resolve("tinymce.PluginManager"),a=tinymce.util.Tools.resolve("tinymce.Env"),n=function(e){return e.getParam("pagebreak_split_block",!1)},t=function(){return"mce-pagebreak"},r=function(){return'<img src="'+a.transparentSrc+'" class="'+t()+'" data-mce-resize="false" data-mce-placeholder />'};e.add("pagebreak",function(e){var a,o,c,i,g,m;(a=e).addCommand("mcePageBreak",function(){n(a)?a.insertContent("<p>"+r()+"</p>"):a.insertContent(r())}),(o=e).ui.registry.addButton("pagebreak",{icon:"page-break",tooltip:"Page break",onAction:function(){return o.execCommand("mcePageBreak")}}),o.ui.registry.addMenuItem("pagebreak",{text:"Page break",icon:"page-break",onAction:function(){return o.execCommand("mcePageBreak")}}),i=(c=e).getParam("pagebreak_separator","<!-- pagebreak -->"),g=new RegExp(i.replace(/[\?\.\*\[\]\(\)\{\}\+\^\$\:]/g,function(e){return"\\"+e}),"gi"),c.on("BeforeSetContent",function(e){e.content=e.content.replace(g,r())}),c.on("PreInit",function(){c.serializer.addNodeFilter("img",function(e){for(var a,t,r=e.length;r--;)if((t=(a=e[r]).attr("class"))&&-1!==t.indexOf("mce-pagebreak")){var o=a.parent;if(c.schema.getBlockElements()[o.name]&&n(c)){o.type=3,o.value=i,o.raw=!0,a.remove();continue}a.type=3,a.value=i,a.raw=!0}})}),(m=e).on("ResolveName",function(e){"IMG"===e.target.nodeName&&m.dom.hasClass(e.target,t())&&(e.name="pagebreak")})})}();