/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var n,e,t,r=function(n){var e=n;return{get:function(){return e},set:function(n){e=n}}},o=tinymce.util.Tools.resolve("tinymce.PluginManager"),u=function(n){return{isFullscreen:function(){return null!==n.get()}}},i=function(){},l=function(n){return function(){return n}},c=l(!1),f=l(!0),a=function(){return d},d=(n=function(n){return n.isNone()},{fold:function(n){return n()},is:c,isSome:c,isNone:f,getOr:t=function(n){return n},getOrThunk:e=function(n){return n()},getOrDie:function(n){throw new Error(n||"error: getOrDie called on none.")},getOrNull:l(null),getOrUndefined:l(undefined),or:t,orThunk:e,map:a,each:i,bind:a,exists:c,forall:f,filter:a,equals:n,equals_:n,toArray:function(){return[]},toString:l("none()")}),s=function(n){var e=l(n),t=function(){return o},r=function(e){return e(n)},o={fold:function(e,t){return t(n)},is:function(e){return n===e},isSome:f,isNone:c,getOr:e,getOrThunk:e,getOrDie:e,getOrNull:e,getOrUndefined:e,or:t,orThunk:t,map:function(e){return s(e(n))},each:function(e){e(n)},bind:r,exists:r,forall:r,filter:function(e){return e(n)?o:d},toArray:function(){return[n]},toString:function(){return"some("+n+")"},equals:function(e){return e.is(n)},equals_:function(e,t){return e.fold(c,function(e){return t(n,e)})}};return o},m={some:s,none:a,from:function(n){return null===n||n===undefined?d:s(n)}},h=function(){return n=function(n){return n.unbind()},e=r(m.none()),t=function(){return e.get().each(n)},{clear:function(){t(),e.set(m.none())},isSet:function(){return e.get().isSome()},set:function(n){t(),e.set(m.some(n))}};var n,e,t},g=function(n){return function(e){return r=typeof(t=e),(null===t?"null":"object"==r&&(Array.prototype.isPrototypeOf(t)||t.constructor&&"Array"===t.constructor.name)?"array":"object"==r&&(String.prototype.isPrototypeOf(t)||t.constructor&&"String"===t.constructor.name)?"string":r)===n;var t,r}},p=function(n){return function(e){return typeof e===n}},v=g("string"),y=g("array"),w=p("boolean"),b=function(n){return!(null===(e=n)||e===undefined);var e},S=p("function"),E=p("number"),F=Array.prototype.push,T=function(n,e){for(var t=n.length,r=new Array(t),o=0;o<t;o++){var u=n[o];r[o]=e(u,o)}return r},x=function(n,e){for(var t=0,r=n.length;t<r;t++)e(n[t],t)},D=function(n,e){for(var t=[],r=0,o=n.length;r<o;r++){var u=n[r];e(u,r)&&t.push(u)}return t},k=function(n,e){return function(n){for(var e=[],t=0,r=n.length;t<r;++t){if(!y(n[t]))throw new Error("Arr.flatten item "+t+" was not an array, input: "+n);F.apply(e,n[t])}return e}(T(n,e))},C=Object.keys,O=function(n){return n.style!==undefined&&S(n.style.getPropertyValue)},A=function(n){if(null===n||n===undefined)throw new Error("Node cannot be null or undefined");return{dom:n}},N={fromHtml:function(n,e){var t=(e||document).createElement("div");if(t.innerHTML=n,!t.hasChildNodes()||1<t.childNodes.length)throw console.error("HTML does not have a single root node",n),new Error("HTML must have a single root node");return A(t.childNodes[0])},fromTag:function(n,e){var t=(e||document).createElement(n);return A(t)},fromText:function(n,e){var t=(e||document).createTextNode(n);return A(t)},fromDom:A,fromPoint:function(n,e,t){return m.from(n.dom.elementFromPoint(e,t)).map(A)}},M=("undefined"!=typeof window||Function("return this;")(),function(n){return function(e){return e.dom.nodeType===n}}),P=M(1),L=M(3),q=M(9),H=M(11),R=function(n,e){var t=n.dom;if(1!==t.nodeType)return!1;var r=t;if(r.matches!==undefined)return r.matches(e);if(r.msMatchesSelector!==undefined)return r.msMatchesSelector(e);if(r.webkitMatchesSelector!==undefined)return r.webkitMatchesSelector(e);if(r.mozMatchesSelector!==undefined)return r.mozMatchesSelector(e);throw new Error("Browser lacks native selectors")},V=function(n){return N.fromDom(n.dom.ownerDocument)},W=function(n){var e;return e=n,m.from(e.dom.parentNode).map(N.fromDom).map(B).map(function(e){return D(e,function(e){return t=e,n.dom!==t.dom;var t})}).getOr([])},B=function(n){return T(n.dom.childNodes,N.fromDom)},j=S(Element.prototype.attachShadow)&&S(Node.prototype.getRootNode),z=l(j),I=j?function(n){return N.fromDom(n.dom.getRootNode())}:function(n){return q(n)?n:V(n)},U=function(n){var e=I(n);return H(e)?m.some(e):m.none()},_=function(n){return N.fromDom(n.dom.host)},K=function(n){if(z()&&b(n.target)){var e=N.fromDom(n.target);if(P(e)&&X(e)&&n.composed&&n.composedPath){var t=n.composedPath();if(t)return 0===(r=t).length?m.none():m.some(r[0])}}var r;return m.from(n.target)},X=function(n){return b(n.dom.shadowRoot)},Y=function(n){var e=L(n)?n.dom.parentNode:n.dom;if(e===undefined||null===e||null===e.ownerDocument)return!1;var t,r,o=e.ownerDocument;return U(N.fromDom(e)).fold(function(){return o.body.contains(e)},(t=Y,r=_,function(n){return t(r(n))}))},G=function(n,e,t){!function(n,e,t){if(!(v(t)||w(t)||E(t)))throw console.error("Invalid call to Attribute.set. Key ",e,":: Value ",t,":: Element ",n),new Error("Attribute value was not simple");n.setAttribute(e,t+"")}(n.dom,e,t)},J=function(n,e){var t=n.dom.getAttribute(e);return null===t?undefined:t},Q=function(n,e){n.dom.removeAttribute(e)},Z=function(n,e){var t=n.dom;!function(n,e){for(var t=C(n),r=0,o=t.length;r<o;r++){var u=t[r];e(n[u],u)}}(e,function(n,e){!function(n,e,t){if(!v(t))throw console.error("Invalid call to CSS.set. Property ",e,":: Value ",t,":: Element ",n),new Error("CSS value must be a string: "+t);O(n)&&n.style.setProperty(e,t)}(t,e,n)})},$=function(n,e){return O(n)?n.style.getPropertyValue(e):""},nn=function(n){var e,t,r=N.fromDom(K(n).getOr(n.target)),o=function(){return n.stopPropagation()},u=function(){return n.preventDefault()},i=(e=u,t=o,function(){for(var n=[],r=0;r<arguments.length;r++)n[r]=arguments[r];return e(t.apply(null,n))});return{target:r,x:n.clientX,y:n.clientY,stop:o,prevent:u,kill:i,raw:n}},en=function(n,e,t,r,o){var u,i,l=(u=t,i=r,function(n){u(n)&&i(nn(n))});return n.dom.addEventListener(e,l,o),{unbind:function(n){for(var e=[],t=1;t<arguments.length;t++)e[t-1]=arguments[t];return function(){for(var t=[],r=0;r<arguments.length;r++)t[r]=arguments[r];var o=e.concat(t);return n.apply(null,o)}}(tn,n,e,l,o)}},tn=function(n,e,t,r){n.dom.removeEventListener(e,t,r)},rn=f,on=function(n,e,t){return en(n,e,rn,t,!1)},un=function(n,e){return{left:n,top:e,translate:function(t,r){return un(n+t,e+r)}}},ln=un,cn=function(n){var e=n===undefined?window:n;return m.from(e.visualViewport)},fn=function(n,e,t,r){return{x:n,y:e,width:t,height:r,right:n+t,bottom:e+r}},an=function(n){var e,t,r,o,u=n===undefined?window:n,i=u.document,l=(r=(t=(e=N.fromDom(i))!==undefined?e.dom:document).body.scrollLeft||t.documentElement.scrollLeft,o=t.body.scrollTop||t.documentElement.scrollTop,ln(r,o));return cn(u).fold(function(){var n=u.document.documentElement,e=n.clientWidth,t=n.clientHeight;return fn(l.left,l.top,e,t)},function(n){return fn(Math.max(n.pageLeft,l.left),Math.max(n.pageTop,l.top),n.width,n.height)})},dn=function(n,e,t){return cn(t).map(function(t){var r=function(n){return e(nn(n))};return t.addEventListener(n,r),{unbind:function(){return t.removeEventListener(n,r)}}}).getOrThunk(function(){return{unbind:i}})},sn=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),mn=tinymce.util.Tools.resolve("tinymce.Env"),hn=tinymce.util.Tools.resolve("tinymce.util.Delay"),gn=function(n,e){n.fire("FullscreenStateChanged",{state:e})},pn=function(n){return n.getParam("fullscreen_native",!1,"boolean")},vn=function(n){var e=N.fromDom(n.getElement());return U(e).map(_).getOrThunk(function(){return function(n){var e=n.dom.body;if(null===e||e===undefined)throw new Error("Body is not available yet");return N.fromDom(e)}(V(e))})},yn=function(n){return n.dom===((e=V(n).dom).fullscreenElement!==undefined?e.fullscreenElement:e.msFullscreenElement!==undefined?e.msFullscreenElement:e.webkitFullscreenElement!==undefined?e.webkitFullscreenElement:null);var e},wn=function(n,e,t){return D(function(n,e){for(var t=S(e)?e:c,r=n.dom,o=[];null!==r.parentNode&&r.parentNode!==undefined;){var u=r.parentNode,i=N.fromDom(u);if(o.push(i),!0===t(i))break;r=u}return o}(n,t),e)},bn=function(n){return e=n,1!==(r=o=t===undefined?document:t.dom).nodeType&&9!==r.nodeType&&11!==r.nodeType||0===r.childElementCount?[]:T(o.querySelectorAll(e),N.fromDom);var e,t,r,o},Sn=function(n,e){return t=function(n){return R(n,e)},D(W(n),t);var t},En="data-ephox-mobile-fullscreen-style",Fn="position:absolute!important;",Tn="top:0!important;left:0!important;margin:0!important;padding:0!important;width:100%!important;height:100%!important;overflow:visible!important;",xn=mn.os.isAndroid(),Dn=function(n){var e,t,r,o,u=(t="background-color",r=(e=n).dom,""!==(o=window.getComputedStyle(r).getPropertyValue(t))||Y(e)?o:$(r,t));return u!==undefined&&""!==u?"background-color:"+u+"!important":"background-color:rgb(255,255,255)!important;"},kn=function(n,e,t){var r,o,u=function(e){return function(t){var r=J(t,"style"),o=r===undefined?"no-styles":r.trim();o!==e&&(G(t,En,o),Z(t,n.parseStyle(e)))}},i=(r="*",wn(e,function(n){return R(n,r)},o)),l=k(i,function(n){return Sn(n,"*:not(.tox-silver-sink)")}),c=Dn(t);x(l,u("display:none!important;")),x(i,u(Fn+Tn+c)),u((!0===xn?"":Fn)+Tn+c)(e)},Cn=sn.DOM,On=cn().fold(function(){return{bind:i,unbind:i}},function(n){var e,t=(e=r(m.none()),{clear:function(){return e.set(m.none())},set:function(n){return e.set(m.some(n))},isSet:function(){return e.get().isSome()},on:function(n){return e.get().each(n)}}),o=h(),u=h(),i=hn.throttle(function(){document.body.scrollTop=0,document.documentElement.scrollTop=0,window.requestAnimationFrame(function(){t.on(function(e){return Z(e,{top:n.offsetTop+"px",left:n.offsetLeft+"px",height:n.height+"px",width:n.width+"px"})})})},50);return{bind:function(n){t.set(n),i(),o.set(dn("resize",i)),u.set(dn("scroll",i))},unbind:function(){t.on(function(){o.clear(),u.clear()}),t.clear()}}}),An=function(n,e){var t,r,o,u,i,l,c=document.body,f=document.documentElement,a=n.getContainer(),d=N.fromDom(a),s=vn(n),h=e.get(),g=N.fromDom(n.getBody()),p=mn.deviceType.isTouch(),v=a.style,y=n.iframeElement.style,w=function(){var t,r;p&&(t=n.dom,r=bn("["+En+"]"),x(r,function(n){var e=J(n,En);"no-styles"!==e?Z(n,t.parseStyle(e)):Q(n,"style"),Q(n,En)})),Cn.removeClass(c,"tox-fullscreen"),Cn.removeClass(f,"tox-fullscreen"),Cn.removeClass(a,"tox-fullscreen"),On.unbind(),m.from(e.get()).each(function(n){return n.fullscreenChangeHandler.unbind()})};h?(h.fullscreenChangeHandler.unbind(),pn(n)&&yn(s)&&((u=V(s).dom).exitFullscreen?u.exitFullscreen():u.msExitFullscreen?u.msExitFullscreen():u.webkitCancelFullScreen&&u.webkitCancelFullScreen()),y.width=h.iframeWidth,y.height=h.iframeHeight,v.width=h.containerWidth,v.height=h.containerHeight,v.top=h.containerTop,v.left=h.containerLeft,o=h.scrollPos,window.scrollTo(o.x,o.y),e.set(null),gn(n,!1),w(),n.off("remove",w)):(t=on(V(s),document.fullscreenElement!==undefined?"fullscreenchange":document.msFullscreenElement!==undefined?"MSFullscreenChange":document.webkitFullscreenElement!==undefined?"webkitfullscreenchange":"fullscreenchange",function(){pn(n)&&(yn(s)||null===e.get()||An(n,e))}),r={scrollPos:{x:(l=an(window)).x,y:l.y},containerWidth:v.width,containerHeight:v.height,containerTop:v.top,containerLeft:v.left,iframeWidth:y.width,iframeHeight:y.height,fullscreenChangeHandler:t},p&&kn(n.dom,d,g),y.width=y.height="100%",v.width=v.height="",Cn.addClass(c,"tox-fullscreen"),Cn.addClass(f,"tox-fullscreen"),Cn.addClass(a,"tox-fullscreen"),On.bind(d),n.on("remove",w),e.set(r),pn(n)&&((i=s.dom).requestFullscreen?i.requestFullscreen():i.msRequestFullscreen?i.msRequestFullscreen():i.webkitRequestFullScreen&&i.webkitRequestFullScreen()),gn(n,!0))},Nn=function(n,e){return function(t){t.setActive(null!==e.get());var r=function(n){return t.setActive(n.state)};return n.on("FullscreenStateChanged",r),function(){return n.off("FullscreenStateChanged",r)}}};o.add("fullscreen",function(n){var e,t,o,i,l=r(null);return n.inline||(t=l,(e=n).addCommand("mceFullScreen",function(){An(e,t)}),i=l,(o=n).ui.registry.addToggleMenuItem("fullscreen",{text:"Fullscreen",icon:"fullscreen",shortcut:"Meta+Shift+F",onAction:function(){return o.execCommand("mceFullScreen")},onSetup:Nn(o,i)}),o.ui.registry.addToggleButton("fullscreen",{tooltip:"Fullscreen",icon:"fullscreen",onAction:function(){return o.execCommand("mceFullScreen")},onSetup:Nn(o,i)}),n.addShortcut("Meta+Shift+F","","mceFullScreen")),u(l)})}();