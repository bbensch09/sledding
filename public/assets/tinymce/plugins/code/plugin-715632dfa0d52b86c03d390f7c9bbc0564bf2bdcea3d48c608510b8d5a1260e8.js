/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var e=tinymce.util.Tools.resolve("tinymce.PluginManager"),t=function(e){var t=e.getContent({source_view:!0});e.windowManager.open({title:"Source Code",size:"large",body:{type:"panel",items:[{type:"textarea",name:"code"}]},buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],initialData:{code:t},onSubmit:function(t){var n,o;n=e,o=t.getData().code,n.focus(),n.undoManager.transact(function(){n.setContent(o)}),n.selection.setCursorLocation(),n.nodeChanged(),t.close()}})};e.add("code",function(e){var n,o;return(n=e).addCommand("mceCodeEditor",function(){t(n)}),(o=e).ui.registry.addButton("code",{icon:"sourcecode",tooltip:"Source code",onAction:function(){return t(o)}}),o.ui.registry.addMenuItem("code",{icon:"sourcecode",text:"Source code",onAction:function(){return t(o)}}),{}})}();