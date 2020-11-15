/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var t,e=tinymce.util.Tools.resolve("tinymce.PluginManager"),r=(t=undefined,function(e){return t===e}),n=tinymce.util.Tools.resolve("tinymce.util.Delay"),a=tinymce.util.Tools.resolve("tinymce.util.LocalStorage"),o=tinymce.util.Tools.resolve("tinymce.util.Tools"),i=function(t,e){var r=t||e,n=/^(\d+)([ms]?)$/.exec(""+r);return(n[2]?{s:1e3,m:6e4}[n[2]]:1)*parseInt(r,10)},u=function(t){var e=document.location;return t.getParam("autosave_prefix","tinymce-autosave-{path}{query}{hash}-{id}-").replace(/{path}/g,e.pathname).replace(/{query}/g,e.search).replace(/{hash}/g,e.hash).replace(/{id}/g,t.id)},s=function(t,e){if(r(e))return t.dom.isEmpty(t.getBody());var n=o.trim(e);if(""===n)return!0;var a=(new DOMParser).parseFromString(n,"text/html");return t.dom.isEmpty(a)},f=function(t){var e=parseInt(a.getItem(u(t)+"time"),10)||0;return!((new Date).getTime()-e>i(t.getParam("autosave_retention"),"20m")&&(c(t,!1),1))},c=function(t,e){var r=u(t);a.removeItem(r+"draft"),a.removeItem(r+"time"),!1!==e&&t.fire("RemoveDraft")},m=function(t){var e=u(t);!s(t)&&t.isDirty()&&(a.setItem(e+"draft",t.getContent({format:"raw",no_events:!0})),a.setItem(e+"time",(new Date).getTime().toString()),t.fire("StoreDraft"))},l=function(t){var e=u(t);f(t)&&(t.setContent(a.getItem(e+"draft"),{format:"raw"}),t.fire("RestoreDraft"))},v=function(t){var e=i(t.getParam("autosave_interval"),"30s");n.setInterval(function(){t.removed||m(t)},e)},d=function(t){t.undoManager.transact(function(){l(t),c(t)}),t.focus()},g=tinymce.util.Tools.resolve("tinymce.EditorManager"),y=function(t){return function(e){e.setDisabled(!f(t));var r=function(){return e.setDisabled(!f(t))};return t.on("StoreDraft RestoreDraft RemoveDraft",r),function(){return t.off("StoreDraft RestoreDraft RemoveDraft",r)}}};e.add("autosave",function(t){var e,r;return t.editorManager.on("BeforeUnload",function(t){var e;o.each(g.get(),function(t){t.plugins.autosave&&t.plugins.autosave.storeDraft(),!e&&t.isDirty()&&t.getParam("autosave_ask_before_unload",!0)&&(e=t.translate("You have unsaved changes are you sure you want to navigate away?"))}),e&&(t.preventDefault(),t.returnValue=e)}),v(e=t),e.ui.registry.addButton("restoredraft",{tooltip:"Restore last draft",icon:"restore-draft",onAction:function(){d(e)},onSetup:y(e)}),e.ui.registry.addMenuItem("restoredraft",{text:"Restore last draft",icon:"restore-draft",onAction:function(){d(e)},onSetup:y(e)}),t.on("init",function(){t.getParam("autosave_restore_when_empty",!1)&&t.dom.isEmpty(t.getBody())&&l(t)}),r=t,{hasDraft:function(){return f(r)},storeDraft:function(){return m(r)},restoreDraft:function(){return l(r)},removeDraft:function(t){return c(r,t)},isEmpty:function(t){return s(r,t)}}})}();