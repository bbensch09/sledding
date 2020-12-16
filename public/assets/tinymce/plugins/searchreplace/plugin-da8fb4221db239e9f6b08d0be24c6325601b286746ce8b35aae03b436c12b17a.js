/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var e,t,n,r,o,i,a,u=function(e){var t=e;return{get:function(){return t},set:function(e){t=e}}},c=tinymce.util.Tools.resolve("tinymce.PluginManager"),l=function(){return(l=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e}).apply(this,arguments)},s=function(e){return function(){return e}},f=s(!1),d=s(!0),m=s("[!-#%-*,-\\/:;?@\\[-\\]_{}\xa1\xab\xb7\xbb\xbf;\xb7\u055a-\u055f\u0589\u058a\u05be\u05c0\u05c3\u05c6\u05f3\u05f4\u0609\u060a\u060c\u060d\u061b\u061e\u061f\u066a-\u066d\u06d4\u0700-\u070d\u07f7-\u07f9\u0830-\u083e\u085e\u0964\u0965\u0970\u0df4\u0e4f\u0e5a\u0e5b\u0f04-\u0f12\u0f3a-\u0f3d\u0f85\u0fd0-\u0fd4\u0fd9\u0fda\u104a-\u104f\u10fb\u1361-\u1368\u1400\u166d\u166e\u169b\u169c\u16eb-\u16ed\u1735\u1736\u17d4-\u17d6\u17d8-\u17da\u1800-\u180a\u1944\u1945\u1a1e\u1a1f\u1aa0-\u1aa6\u1aa8-\u1aad\u1b5a-\u1b60\u1bfc-\u1bff\u1c3b-\u1c3f\u1c7e\u1c7f\u1cd3\u2010-\u2027\u2030-\u2043\u2045-\u2051\u2053-\u205e\u207d\u207e\u208d\u208e\u3008\u3009\u2768-\u2775\u27c5\u27c6\u27e6-\u27ef\u2983-\u2998\u29d8-\u29db\u29fc\u29fd\u2cf9-\u2cfc\u2cfe\u2cff\u2d70\u2e00-\u2e2e\u2e30\u2e31\u3001-\u3003\u3008-\u3011\u3014-\u301f\u3030\u303d\u30a0\u30fb\ua4fe\ua4ff\ua60d-\ua60f\ua673\ua67e\ua6f2-\ua6f7\ua874-\ua877\ua8ce\ua8cf\ua8f8-\ua8fa\ua92e\ua92f\ua95f\ua9c1-\ua9cd\ua9de\ua9df\uaa5c-\uaa5f\uaade\uaadf\uabeb\ufd3e\ufd3f\ufe10-\ufe19\ufe30-\ufe52\ufe54-\ufe61\ufe63\ufe68\ufe6a\ufe6b\uff01-\uff03\uff05-\uff0a\uff0c-\uff0f\uff1a\uff1b\uff1f\uff20\uff3b-\uff3d\uff3f\uff5b\uff5d\uff5f-\uff65]"),h=function(){return g},g=(e=function(e){return e.isNone()},{fold:function(e){return e()},is:f,isSome:f,isNone:d,getOr:n=function(e){return e},getOrThunk:t=function(e){return e()},getOrDie:function(e){throw new Error(e||"error: getOrDie called on none.")},getOrNull:s(null),getOrUndefined:s(undefined),or:n,orThunk:t,map:h,each:function(){},bind:h,exists:f,forall:d,filter:h,equals:e,equals_:e,toArray:function(){return[]},toString:s("none()")}),p=function(e){var t=s(e),n=function(){return o},r=function(t){return t(e)},o={fold:function(t,n){return n(e)},is:function(t){return e===t},isSome:d,isNone:f,getOr:t,getOrThunk:t,getOrDie:t,getOrNull:t,getOrUndefined:t,or:n,orThunk:n,map:function(t){return p(t(e))},each:function(t){t(e)},bind:r,exists:r,forall:r,filter:function(t){return t(e)?o:g},toArray:function(){return[e]},toString:function(){return"some("+e+")"},equals:function(t){return t.is(e)},equals_:function(t,n){return t.fold(f,function(t){return n(e,t)})}};return o},v={some:p,none:h,from:function(e){return null===e||e===undefined?g:p(e)}},y=m,x=tinymce.util.Tools.resolve("tinymce.util.Tools"),b=function(e){return function(t){return r=typeof(n=t),(null===n?"null":"object"==r&&(Array.prototype.isPrototypeOf(n)||n.constructor&&"Array"===n.constructor.name)?"array":"object"==r&&(String.prototype.isPrototypeOf(n)||n.constructor&&"String"===n.constructor.name)?"string":r)===e;var n,r}},w=function(e){return function(t){return typeof t===e}},O=b("string"),C=b("array"),T=w("boolean"),N=w("number"),E=Array.prototype.slice,k=Array.prototype.push,S=function(e,t){for(var n=e.length,r=new Array(n),o=0;o<n;o++){var i=e[o];r[o]=t(i,o)}return r},A=function(e,t){for(var n=0,r=e.length;n<r;n++)t(e[n],n)},D=function(e,t){for(var n=e.length-1;0<=n;n--)t(e[n],n)},M=function(e,t){return function(e){for(var t=[],n=0,r=e.length;n<r;++n){if(!C(e[n]))throw new Error("Arr.flatten item "+n+" was not an array, input: "+e);k.apply(t,e[n])}return t}(S(e,t))},B=Object.hasOwnProperty,F=function(e,t){return B.call(e,t)},I=("undefined"!=typeof window||Function("return this;")(),r=3,function(e){return e.dom.nodeType===r}),P=function(e,t,n){!function(e,t,n){if(!(O(n)||T(n)||N(n)))throw console.error("Invalid call to Attribute.set. Key ",t,":: Value ",n,":: Element ",e),new Error("Attribute value was not simple");e.setAttribute(t,n+"")}(e.dom,t,n)},R=function(e){if(null===e||e===undefined)throw new Error("Node cannot be null or undefined");return{dom:e}},W={fromHtml:function(e,t){var n=(t||document).createElement("div");if(n.innerHTML=e,!n.hasChildNodes()||1<n.childNodes.length)throw console.error("HTML does not have a single root node",e),new Error("HTML must have a single root node");return R(n.childNodes[0])},fromTag:function(e,t){var n=(t||document).createElement(e);return R(n)},fromText:function(e,t){var n=(t||document).createTextNode(e);return R(n)},fromDom:R,fromPoint:function(e,t,n){return v.from(e.dom.elementFromPoint(t,n)).map(R)}},j=function(e,t){return{element:e,offset:t}},q=function(e,t){var n=S(e.dom.childNodes,W.fromDom);return 0<n.length&&t<n.length?j(n[t],0):j(e,t)},V=function(e,t){var n;(n=e,v.from(n.dom.parentNode).map(W.fromDom)).each(function(n){n.dom.insertBefore(t.dom,e.dom)})},_=function(e,t){var n;V(e,t),n=e,t.dom.appendChild(n.dom)},H=(o=I,i="text",{get:function(e){if(!o(e))throw new Error("Can only get "+i+" value of a "+i+" node");return a(e).getOr("")},getOption:a=function(e){return o(e)?v.from(e.dom.nodeValue):v.none()},set:function(e,t){if(!o(e))throw new Error("Can only set raw "+i+" value of a "+i+" node");e.dom.nodeValue=t}}),L=function(e){return H.get(e)},U=function(e,t){return n=t,1!==(o=i=(r=e)===undefined?document:r.dom).nodeType&&9!==o.nodeType&&11!==o.nodeType||0===o.childElementCount?[]:S(i.querySelectorAll(n),W.fromDom);var n,r,o,i},$=tinymce.util.Tools.resolve("tinymce.dom.TreeWalker"),z=function(e,t){return e.isBlock(t)||F(e.schema.getShortEndedElements(),t.nodeName)},G=function(e,t){return"false"===e.getContentEditable(t)},K=function(e,t){return!e.isBlock(t)&&F(e.schema.getWhiteSpaceElements(),t.nodeName)},J=function(){return{sOffset:0,fOffset:0,elements:[]}},Q=function(e,t){return q(W.fromDom(e),t)},X=function(e,t,n,r,o,i){void 0===i&&(i=!0);for(var a=i?t(!1):n;a;){var u=G(e,a);if(u||K(e,a)){if(u?r.cef(a):r.boundary(a))break;a=t(!0)}else{if(z(e,a)){if(r.boundary(a))break}else 3===a.nodeType&&r.text(a);if(a===o)break;a=t(!1)}}},Y=function(e,t,n,r,o){var i,a,u,c,l,s,f;z(i=e,a=n)||G(i,a)||K(i,a)||(c=a,"true"===(u=i).getContentEditable(c)&&"false"===u.getContentEditableParent(c.parentNode))||(l=e.getParent(r,e.isBlock),s=new $(n,l),f=o?s.next:s.prev,X(e,f,n,{boundary:d,cef:d,text:function(e){o?t.fOffset+=e.length:t.sOffset+=e.length,t.elements.push(W.fromDom(e))}}))},Z=function(e,t,n,r,o,i){void 0===i&&(i=!0);var a=new $(n,t),u=[],c=J();Y(e,c,n,t,!1);var l=function(){return 0<c.elements.length&&(u.push(c),c=J()),!1};return X(e,a.next,n,{boundary:l,cef:function(e){return l(),o&&u.push.apply(u,o.cef(e)),!1},text:function(e){c.elements.push(W.fromDom(e)),o&&o.text(e,c)}},r,i),r&&Y(e,c,r,t,!0),l(),u},ee=function(e,t){var n=Q(t.startContainer,t.startOffset),r=n.element.dom,o=Q(t.endContainer,t.endOffset),i=o.element.dom;return Z(e,t.commonAncestorContainer,r,i,{text:function(e,t){e===i?t.fOffset+=e.length-o.offset:e===r&&(t.sOffset+=n.offset)},cef:function(t){var n,r,o;return n=M(U(W.fromDom(t),"*[contenteditable=true]"),function(t){var n=t.dom;return Z(e,n,n)}),r=function(e,t){return n=e.elements[0].dom,r=t.elements[0].dom,o=Node.DOCUMENT_POSITION_PRECEDING,0!=(n.compareDocumentPosition(r)&o)?1:-1;var n,r,o},(o=E.call(n,0)).sort(r),o}},!1)},te=function(e,t){return t.collapsed?[]:ee(e,t)},ne=function(e,t){var n=e.createRng();return n.selectNode(t),te(e,n)},re=function(e,t){var n,r;return function(e,t){if(0===e.length)return[];for(var n=t(e[0]),r=[],o=[],i=0,a=e.length;i<a;i++){var u=e[i],c=t(u);c!==n&&(r.push(o),o=[]),n=c,o.push(u)}return 0!==o.length&&r.push(o),r}((n=function(e,n){var r=L(n),o=e.last,i=o+r.length,a=M(t,function(e,t){return e.start<i&&e.finish>o?[{element:n,start:Math.max(o,e.start)-o,finish:Math.min(i,e.finish)-o,matchId:t}]:[]});return{results:e.results.concat(a),last:i}},r={results:[],last:0},A(e,function(e){r=n(r,e)}),r.results),function(e){return e.matchId})},oe=function(e,t){return M(t,function(t){var n=t.elements,r=S(n,L).join(""),o=function(e,t,n,r){void 0===n&&(n=0),void 0===r&&(r=e.length);var o=t.regex;o.lastIndex=n;for(var i,a=[];i=o.exec(e);){var u=i[t.matchIndex],c=i.index+i[0].indexOf(u),l=c+u.length;if(r<l)break;a.push({start:c,finish:l}),o.lastIndex=l}return a}(r,e,t.sOffset,r.length-t.fOffset);return re(n,o)})},ie=function(e,t){D(e,function(e,n){D(e,function(e){var r=W.fromDom(t.cloneNode(!1));P(r,"data-mce-index",n);var o,i=e.element.dom;i.length===e.finish&&0===e.start?_(e.element,r):(i.length!==e.finish&&i.splitText(e.finish),o=i.splitText(e.start),_(W.fromDom(o),r))})})},ae=function(e,t,n,r){var o,i=n.getBookmark(),a=e.select("td[data-mce-selected],th[data-mce-selected]"),u=0<a.length?(o=e,M(a,function(e){return ne(o,e)})):te(e,n.getRng()),c=oe(t,u);return ie(c,r),n.moveToBookmark(i),c.length},ue=function(e){var t=e.getAttribute("data-mce-index");return"number"==typeof t?""+t:t},ce=function(e,t,n,r){var o=e.dom.create("span",{"data-mce-bogus":1});o.className="mce-match-marker";var i,a,u,c,l,s=e.getBody();return ye(e,t,!1),r?ae(e.dom,n,e.selection,o):(i=e.dom,a=n,u=o,c=ne(i,s),l=oe(a,c),ie(l,u),l.length)},le=function(e){var t=e.parentNode;e.firstChild&&t.insertBefore(e.firstChild,e),e.parentNode.removeChild(e)},se=function(e,t){var n=[],r=x.toArray(e.getBody().getElementsByTagName("span"));if(r.length)for(var o=0;o<r.length;o++){var i=ue(r[o]);null!==i&&i.length&&i===t.toString()&&n.push(r[o])}return n},fe=function(e,t,n){var r=t.get(),o=r.index,i=e.dom;(n=!1!==n)?o+1===r.count?o=0:o++:o-1==-1?o=r.count-1:o--,i.removeClass(se(e,r.index),"mce-match-marker-selected");var a=se(e,o);return a.length?(i.addClass(se(e,o),"mce-match-marker-selected"),e.selection.scrollIntoView(a[0]),o):-1},de=function(e,t){var n=t.parentNode;e.remove(t),e.isEmpty(n)&&e.remove(n)},me=function(e,t,n,r,o,i){var a,u,c,l=(a=o,u="("+n.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g,"\\$&").replace(/\s/g,"[^\\S\\r\\n\\uFEFF]")+")",a?"(?:^|\\s|"+y()+")"+u+"(?=$|\\s|"+y()+")":u),s={regex:new RegExp(l,r?"g":"gi"),matchIndex:1},f=ce(e,t,s,i);return f&&(c=fe(e,t,!0),t.set({index:c,count:f,text:n,matchCase:r,wholeWord:o,inSelection:i})),f},he=function(e,t){var n=fe(e,t,!0);t.set(l(l({},t.get()),{index:n}))},ge=function(e,t){var n=fe(e,t,!1);t.set(l(l({},t.get()),{index:n}))},pe=function(e){var t=ue(e);return null!==t&&0<t.length},ve=function(e,t,n,r,o){var i,a=t.get(),u=a.index,c=u;r=!1!==r;for(var s=e.getBody(),f=x.grep(x.toArray(s.getElementsByTagName("span")),pe),d=0;d<f.length;d++){var m=ue(f[d]),h=i=parseInt(m,10);if(o||h===a.index){for(n.length?(f[d].firstChild.nodeValue=n,le(f[d])):de(e.dom,f[d]);f[++d];){if((h=parseInt(ue(f[d]),10))!==i){d--;break}de(e.dom,f[d])}r&&c--}else u<i&&f[d].setAttribute("data-mce-index",String(i-1))}return t.set(l(l({},a),{count:o?0:a.count-1,index:c})),(r?he:ge)(e,t),!o&&0<t.get().count},ye=function(e,t,n){for(var r,o,i=t.get(),a=x.toArray(e.getBody().getElementsByTagName("span")),u=0;u<a.length;u++){var c=ue(a[u]);null!==c&&c.length&&(c===i.index.toString()&&(r=r||a[u].firstChild,o=a[u].firstChild),le(a[u]))}if(t.set(l(l({},i),{index:-1,count:0,text:""})),r&&o){var s=e.dom.createRng();return s.setStart(r,0),s.setEnd(o,o.data.length),!1!==n&&e.selection.setRng(s),s}},xe=tinymce.util.Tools.resolve("tinymce.Env"),be=function(e,t){function n(e){(1<t.get().count?e.enable:e.disable)("next"),(1<t.get().count?e.enable:e.disable)("prev")}var r,o=(r=u(v.none()),{clear:function(){return r.set(v.none())},set:function(e){return r.set(v.some(e))},isSet:function(){return r.get().isSome()},on:function(e){return r.get().each(e)}});e.undoManager.add();var i=x.trim(e.selection.getContent({format:"text"})),a=function(e,t){var n=t?e.disable:e.enable;A(["replace","replaceall","prev","next"],n)},c=function(e,t){xe.browser.isSafari()&&xe.deviceType.isTouch()&&("find"===t||"replace"===t||"replaceall"===t)&&e.focus(t)},s=function(r){ye(e,t,!1),a(r,!0),n(r)},f=function(r){var o,i,u=r.getData(),c=t.get();u.findtext.length?(c.text===u.findtext&&c.matchCase===u.matchcase&&c.wholeWord===u.wholewords?he(e,t):((o=me(e,t,u.findtext,u.matchcase,u.wholewords,u.inselection))<=0&&(i=r,e.windowManager.alert("Could not find the specified string.",function(){i.focus("findtext")})),a(r,0===o)),n(r)):s(r)},d=t.get(),m={title:"Find and Replace",size:"normal",body:{type:"panel",items:[{type:"bar",items:[{type:"input",name:"findtext",placeholder:"Find",maximized:!0,inputMode:"search"},{type:"button",name:"prev",text:"Previous",icon:"action-prev",disabled:!0,borderless:!0},{type:"button",name:"next",text:"Next",icon:"action-next",disabled:!0,borderless:!0}]},{type:"input",name:"replacetext",placeholder:"Replace with",inputMode:"search"}]},buttons:[{type:"menu",name:"options",icon:"preferences",tooltip:"Preferences",align:"start",items:[{type:"togglemenuitem",name:"matchcase",text:"Match case"},{type:"togglemenuitem",name:"wholewords",text:"Find whole words only"},{type:"togglemenuitem",name:"inselection",text:"Find in selection"}]},{type:"custom",name:"find",text:"Find",primary:!0},{type:"custom",name:"replace",text:"Replace",disabled:!0},{type:"custom",name:"replaceall",text:"Replace All",disabled:!0}],initialData:{findtext:i,replacetext:"",wholewords:d.wholeWord,matchcase:d.matchCase,inselection:d.inSelection},onChange:function(e,n){"findtext"===n.name&&0<t.get().count&&s(e)},onAction:function(r,o){var i,a,u=r.getData();switch(o.name){case"find":f(r);break;case"replace":(ve(e,t,u.replacetext)?n:s)(r);break;case"replaceall":ve(e,t,u.replacetext,!0,!0),s(r);break;case"prev":ge(e,t),n(r);break;case"next":he(e,t),n(r);break;case"matchcase":case"wholewords":case"inselection":i=r.getData(),a=t.get(),t.set(l(l({},a),{matchCase:i.matchcase,wholeWord:i.wholewords,inSelection:i.inselection})),s(r)}c(r,o.name)},onSubmit:function(e){f(e),c(e,"find")},onClose:function(){e.focus(),ye(e,t),e.undoManager.add()}};o.set(e.windowManager.open(m,{inline:"toolbar"}))},we=function(e,t){return function(){be(e,t)}};c.add("searchreplace",function(e){var t,n,r,o,i,a,c=u({index:-1,count:0,text:"",matchCase:!1,wholeWord:!1,inSelection:!1});return n=c,(t=e).addCommand("SearchReplace",function(){be(t,n)}),o=c,(r=e).ui.registry.addMenuItem("searchreplace",{text:"Find and replace...",shortcut:"Meta+F",onAction:we(r,o),icon:"search"}),r.ui.registry.addButton("searchreplace",{tooltip:"Find and replace",onAction:we(r,o),icon:"search"}),r.shortcuts.add("Meta+F","",we(r,o)),i=e,a=c,{done:function(e){return ye(i,a,e)},find:function(e,t,n,r){return void 0===r&&(r=!1),me(i,a,e,t,n,r)},next:function(){return he(i,a)},prev:function(){return ge(i,a)},replace:function(e,t,n){return ve(i,a,e,t,n)}}})}();