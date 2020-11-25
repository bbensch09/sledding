/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var e,t,n,r=tinymce.util.Tools.resolve("tinymce.PluginManager"),a=function(){},o=function(e){return function(){return e}},c=o(!1),u=o(!0),i=tinymce.util.Tools.resolve("tinymce.util.Tools"),l=tinymce.util.Tools.resolve("tinymce.util.XHR"),s=function(e){return e.getParam("template_mdate_classes","mdate")},f=function(e){return e.getParam("template_replace_values")},m=function(e){return e.getParam("template_mdate_format",e.translate("%Y-%m-%d"))},p=function(e,t){if((e=""+e).length<t)for(var n=0;n<t-e.length;n++)e="0"+e;return e},d=function(e,t,n){var r="Sun Mon Tue Wed Thu Fri Sat Sun".split(" "),a="Sunday Monday Tuesday Wednesday Thursday Friday Saturday Sunday".split(" "),o="Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec".split(" "),c="January February March April May June July August September October November December".split(" ");return n=n||new Date,(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=t.replace("%D","%m/%d/%Y")).replace("%r","%I:%M:%S %p")).replace("%Y",""+n.getFullYear())).replace("%y",""+n.getYear())).replace("%m",p(n.getMonth()+1,2))).replace("%d",p(n.getDate(),2))).replace("%H",""+p(n.getHours(),2))).replace("%M",""+p(n.getMinutes(),2))).replace("%S",""+p(n.getSeconds(),2))).replace("%I",""+((n.getHours()+11)%12+1))).replace("%p",n.getHours()<12?"AM":"PM")).replace("%B",""+e.translate(c[n.getMonth()]))).replace("%b",""+e.translate(o[n.getMonth()]))).replace("%A",""+e.translate(a[n.getDay()]))).replace("%a",""+e.translate(r[n.getDay()]))).replace("%%","%")},g=function(e,t){return function(){var n=e.getParam("templates");"function"!=typeof n?"string"==typeof n?l.send({url:n,success:function(e){t(JSON.parse(e))}}):t(n):n(t)}},y=function(e,t){return i.each(t,function(t,n){"function"==typeof t&&(t=t(n)),e=e.replace(new RegExp("\\{\\$"+n+"\\}","g"),t)}),e},v=function(e,t){var n=e.dom,r=f(e);i.each(n.select("*",t),function(e){i.each(r,function(t,a){n.hasClass(e,a)&&"function"==typeof r[a]&&r[a](e)})})},h=function(e,t){return new RegExp("\\b"+t+"\\b","g").test(e.className)},b=function(e,t,n){var r,a=e.dom,o=e.selection.getContent();n=y(n,f(e)),r=a.create("div",null,n);var c=a.select(".mceTmpl",r);c&&0<c.length&&(r=a.create("div",null)).appendChild(c[0].cloneNode(!0)),i.each(a.select("*",r),function(t){var n;h(t,e.getParam("template_cdate_classes","cdate").replace(/\s+/g,"|"))&&(t.innerHTML=d(e,(n=e).getParam("template_cdate_format",n.translate("%Y-%m-%d")))),h(t,s(e).replace(/\s+/g,"|"))&&(t.innerHTML=d(e,m(e))),h(t,e.getParam("template_selected_content_classes","selcontent").replace(/\s+/g,"|"))&&(t.innerHTML=o)}),v(e,r),e.execCommand("mceInsertContent",!1,r.innerHTML),e.addVisual()},T=function(e){e.addCommand("mceInsertTemplate",function(e){for(var t=[],n=1;n<arguments.length;n++)t[n-1]=arguments[n];return function(){for(var n=[],r=0;r<arguments.length;r++)n[r]=arguments[r];var a=t.concat(n);return e.apply(null,a)}}(b,e))},M=function(){return _},_=(e=function(e){return e.isNone()},{fold:function(e){return e()},is:c,isSome:c,isNone:u,getOr:n=function(e){return e},getOrThunk:t=function(e){return e()},getOrDie:function(e){throw new Error(e||"error: getOrDie called on none.")},getOrNull:o(null),getOrUndefined:o(undefined),or:n,orThunk:t,map:M,each:a,bind:M,exists:c,forall:u,filter:M,equals:e,equals_:e,toArray:function(){return[]},toString:o("none()")}),x=function(e){var t=o(e),n=function(){return a},r=function(t){return t(e)},a={fold:function(t,n){return n(e)},is:function(t){return e===t},isSome:u,isNone:c,getOr:t,getOrThunk:t,getOrDie:t,getOrNull:t,getOrUndefined:t,or:n,orThunk:n,map:function(t){return x(t(e))},each:function(t){t(e)},bind:r,exists:r,forall:r,filter:function(t){return t(e)?a:_},toArray:function(){return[e]},toString:function(){return"some("+e+")"},equals:function(t){return t.is(e)},equals_:function(t,n){return t.fold(c,function(t){return n(e,t)})}};return a},O={some:x,none:M,from:function(e){return null===e||e===undefined?_:x(e)}},P=function(e,t){return function(e,t,n){for(var r=0,a=e.length;r<a;r++){var o=e[r];if(t(o,r))return O.some(o);if(n(o,r))break}return O.none()}(e,t,c)},S=tinymce.util.Tools.resolve("tinymce.Env"),w=tinymce.util.Tools.resolve("tinymce.util.Promise"),D=Object.hasOwnProperty,A=function(e,t){return D.call(e,t)},C={'"':"&quot;","<":"&lt;",">":"&gt;","&":"&amp;","'":"&#039;"},N=function(e){return e.replace(/["'<>&]/g,function(e){return(A(t=C,n=e)?O.from(t[n]):O.none()).getOr(e);var t,n})},I=function(e,t){var n=function(e){return function(e,t){for(var n=e.length,r=new Array(n),a=0;a<n;a++){var o=e[a];r[a]=t(o,a)}return r}(e,function(e){return{text:e.text,value:e.text}})},r=function(e,t){return P(e,function(e){return e.text===t})},a=function(t){e.windowManager.alert("Could not load the specified template.",function(){return t.focus("template")})},o=function(e){return new w(function(t,n){e.value.url.fold(function(){return t(e.value.content.getOr(""))},function(e){return l.send({url:e,success:function(e){t(e)},error:function(e){n(e)}})})})};(function(){if(t&&0!==t.length)return O.from(i.map(t,function(e,t){var n=function(e){return e.url!==undefined};return{selected:0===t,text:e.title,value:{url:n(e)?O.from(e.url):O.none(),content:n(e)?O.none():O.from(e.content),description:e.description}}}));var n=e.translate("No templates defined.");return e.notificationManager.open({text:n,type:"info"}),O.none()})().each(function(t){var c=n(t),u=function(n,c){return{title:"Insert Template",size:"large",body:{type:"panel",items:n},initialData:c,buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],onSubmit:function(t){var n=t.getData();r(s,n.template).each(function(n){o(n).then(function(n){b(e,0,n),t.close()})["catch"](function(){t.disable("save"),a(t)})})},onChange:(u=s=t,i=l,function(e,t){var n;"template"===t.name&&(n=e.getData().template,r(u,n).each(function(t){e.block("Loading..."),o(t).then(function(n){i(e,t,n)})["catch"](function(){i(e,t,""),e.disable("save"),a(e)})}))})};var u,i,s},l=function(t,n,r){var a,o,l,s,f,m,p,d,g,v,h,b,T,M=(a=e,-1===(o=r).indexOf("<html>")&&(l="",(s=a.getParam("content_style","","string"))&&(l+='<style type="text/css">'+s+"</style>"),f=a.getParam("content_css_cors",!1,"boolean")?' crossorigin="anonymous"':"",i.each(a.contentCSS,function(e){l+='<link type="text/css" rel="stylesheet" href="'+a.documentBaseURI.toAbsolute(e)+'"'+f+">"}),m=-1===(T=(h=a).getParam("body_class","","string")).indexOf("=")?T:(b=h).getParam("body_class","","hash")[b.id]||"",p=a.dom.encode,d='<script>document.addEventListener && document.addEventListener("click", function(e) {for (var elm = e.target; elm; elm = elm.parentNode) {if (elm.nodeName === "A" && !('+(S.mac?"e.metaKey":"e.ctrlKey && !e.altKey")+")) {e.preventDefault();}}}, false);</script> ",v=(g=a.getBody().dir)?' dir="'+p(g)+'"':"",o='<!DOCTYPE html><html><head><base href="'+p(a.documentBaseURI.getURI())+'">'+l+d+'</head><body class="'+p(m)+'"'+v+">"+o+"</body></html>"),y(o,a.getParam("template_preview_replace_values"))),_=[{type:"selectbox",name:"template",label:"Templates",items:c},{type:"htmlpanel",html:'<p aria-live="polite">'+N(n.value.description)+"</p>"},{label:"Preview",type:"iframe",name:"preview",sandboxed:!1}],x={template:n.text,preview:M};t.unblock(),t.redial(u(_,x)),t.focus("template")},s=e.windowManager.open(u([],{template:"",preview:""}));s.block("Loading..."),o(t[0]).then(function(e){l(s,t[0],e)})["catch"](function(){l(s,t[0],""),s.disable("save"),a(s)})})},k=function(e){return function(t){I(e,t)}};r.add("template",function(e){var t,n;(t=e).ui.registry.addButton("template",{icon:"template",tooltip:"Insert template",onAction:g(t,k(t))}),t.ui.registry.addMenuItem("template",{icon:"template",text:"Insert template...",onAction:g(t,k(t))}),T(e),(n=e).on("PreProcess",function(e){var t=n.dom,r=m(n);i.each(t.select("div",e.node),function(e){t.hasClass(e,"mceTmpl")&&(i.each(t.select("*",e),function(e){t.hasClass(e,s(n).replace(/\s+/g,"|"))&&(e.innerHTML=d(n,r))}),v(n,e))})})})}();