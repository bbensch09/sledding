/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var e,t,r,n=tinymce.util.Tools.resolve("tinymce.PluginManager"),i=function(){return(i=Object.assign||function(e){for(var t,r=1,n=arguments.length;r<n;r++)for(var i in t=arguments[r])Object.prototype.hasOwnProperty.call(t,i)&&(e[i]=t[i]);return e}).apply(this,arguments)},a=function(e){return function(){return e}},o=a(!1),c=a(!0),u=function(){return s},s=(e=function(e){return e.isNone()},{fold:function(e){return e()},is:o,isSome:o,isNone:c,getOr:r=function(e){return e},getOrThunk:t=function(e){return e()},getOrDie:function(e){throw new Error(e||"error: getOrDie called on none.")},getOrNull:a(null),getOrUndefined:a(undefined),or:r,orThunk:t,map:u,each:function(){},bind:u,exists:o,forall:c,filter:u,equals:e,equals_:e,toArray:function(){return[]},toString:a("none()")}),l=function(e){var t=a(e),r=function(){return i},n=function(t){return t(e)},i={fold:function(t,r){return r(e)},is:function(t){return e===t},isSome:c,isNone:o,getOr:t,getOrThunk:t,getOrDie:t,getOrNull:t,getOrUndefined:t,or:r,orThunk:r,map:function(t){return l(t(e))},each:function(t){t(e)},bind:n,exists:n,forall:n,filter:function(t){return t(e)?i:s},toArray:function(){return[e]},toString:function(){return"some("+e+")"},equals:function(t){return t.is(e)},equals_:function(t,r){return t.fold(o,function(t){return r(e,t)})}};return i},m={some:l,none:u,from:function(e){return null===e||e===undefined?s:l(e)}},d=function(e){return function(t){return n=typeof(r=t),(null===r?"null":"object"==n&&(Array.prototype.isPrototypeOf(r)||r.constructor&&"Array"===r.constructor.name)?"array":"object"==n&&(String.prototype.isPrototypeOf(r)||r.constructor&&"String"===r.constructor.name)?"string":n)===e;var r,n}},h=d("string"),f=d("object"),p=d("array"),g=Array.prototype.push,v=function(e,t){for(var r=0,n=e.length;r<n;r++)t(e[r],r)},w=function(e){var t=e;return{get:function(){return t},set:function(e){t=e}}},b=Object.keys,y=Object.hasOwnProperty,x=function(e,t){return j(e,t)?m.from(e[t]):m.none()},j=function(e,t){return y.call(e,t)},O=function(e){return e.getParam("media_scripts")},S=tinymce.util.Tools.resolve("tinymce.util.Tools"),_=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),k=tinymce.util.Tools.resolve("tinymce.html.SaxParser"),A=function(e,t){if(e)for(var r=0;r<e.length;r++)if(-1!==t.indexOf(e[r].filter))return e[r]},T=_.DOM,C=function(e){return e.replace(/px$/,"")},P=function(e,t){var r=w(!1),n={};return k({validate:!1,allow_conditional_comments:!0,start:function(t,i){if(!r.get())if(j(i.map,"data-ephox-embed-iri"))r.set(!0),u=(c=(o=i).map.style)?T.parseStyle(c):{},n={type:"ephox-embed-iri",source:o.map["data-ephox-embed-iri"],altsource:"",poster:"",width:x(u,"max-width").map(C).getOr(""),height:x(u,"max-height").map(C).getOr("")};else{if(n.source||"param"!==t||(n.source=i.map.movie),"iframe"!==t&&"object"!==t&&"embed"!==t&&"video"!==t&&"audio"!==t||(n.type||(n.type=t),n=S.extend(i.map,n)),"script"===t){var a=A(e,i.map.src);if(!a)return;n={type:"script",source:i.map.src,width:String(a.width),height:String(a.height)}}"source"===t&&(n.source?n.altsource||(n.altsource=i.map.src):n.source=i.map.src),"img"!==t||n.poster||(n.poster=i.map.src)}var o,c,u}}).parse(t),n.source=n.source||n.src||n.data,n.altsource=n.altsource||"",n.poster=n.poster||"",n},D=function(e){return{mp3:"audio/mpeg",m4a:"audio/x-m4a",wav:"audio/wav",mp4:"video/mp4",webm:"video/webm",ogg:"video/ogg",swf:"application/x-shockwave-flash"}[e.toLowerCase().split(".").pop()]||""},$=tinymce.util.Tools.resolve("tinymce.html.Schema"),F=tinymce.util.Tools.resolve("tinymce.html.Writer"),M=_.DOM,z=function(e){return/^[0-9.]+$/.test(e)?e+"px":e},N=function(e,t){!function(e,t){for(var r=b(e),n=0,i=r.length;n<i;n++){var a=r[n];t(e[a],a)}}(t,function(t,r){var n=""+t;if(e.map[r])for(var i=e.length;i--;){var a=e[i];a.name===r&&(n?(e.map[r]=n,a.value=n):(delete e.map[r],e.splice(i,1)))}else n&&(e.push({name:r,value:n}),e.map[r]=n)})},U=["source","altsource"],E=function(e,t,r){var n,i=F(),a=w(!1),o=0;return k({validate:!1,allow_conditional_comments:!0,comment:function(e){i.comment(e)},cdata:function(e){i.cdata(e)},text:function(e,t){i.text(e,t)},start:function(e,c,u){if(!a.get())if(j(c.map,"data-ephox-embed-iri"))a.set(!0),s=t,(d=(m=(l=c).map.style)?M.parseStyle(m):{})["max-width"]=z(s.width),d["max-height"]=z(s.height),N(l,{style:M.serializeStyle(d)});else{switch(e){case"video":case"object":case"embed":case"img":case"iframe":t.height!==undefined&&t.width!==undefined&&N(c,{width:t.width,height:t.height})}if(r)switch(e){case"video":N(c,{poster:t.poster,src:""}),t.altsource&&N(c,{src:""});break;case"iframe":N(c,{src:t.source});break;case"source":if(o<2&&(N(c,{src:t[U[o]],type:t[U[o]+"mime"]}),!t[U[o]]))return;o++;break;case"img":if(!t.poster)return;n=!0}}var s,l,m,d;i.start(e,c,u)},end:function(e){if(!a.get()){if("video"===e&&r)for(var c,u=0;u<2;u++)t[U[u]]&&((c=[]).map={},o<=u&&(N(c,{src:t[U[u]],type:t[U[u]+"mime"]}),i.start("source",c,!0)));var s;t.poster&&"object"===e&&r&&!n&&((s=[]).map={},N(s,{src:t.poster,width:t.width,height:t.height}),i.start("img",s,!0))}i.end(e)}},$({})).parse(e),i.getContent()},R=[{regex:/youtu\.be\/([\w\-_\?&=.]+)/i,type:"iframe",w:560,h:314,url:"www.youtube.com/embed/$1",allowFullscreen:!0},{regex:/youtube\.com(.+)v=([^&]+)(&([a-z0-9&=\-_]+))?/i,type:"iframe",w:560,h:314,url:"www.youtube.com/embed/$2?$4",allowFullscreen:!0},{regex:/youtube.com\/embed\/([a-z0-9\?&=\-_]+)/i,type:"iframe",w:560,h:314,url:"www.youtube.com/embed/$1",allowFullscreen:!0},{regex:/vimeo\.com\/([0-9]+)/,type:"iframe",w:425,h:350,url:"player.vimeo.com/video/$1?title=0&byline=0&portrait=0&color=8dc7dc",allowFullscreen:!0},{regex:/vimeo\.com\/(.*)\/([0-9]+)/,type:"iframe",w:425,h:350,url:"player.vimeo.com/video/$2?title=0&amp;byline=0",allowFullscreen:!0},{regex:/maps\.google\.([a-z]{2,3})\/maps\/(.+)msid=(.+)/,type:"iframe",w:425,h:350,url:'maps.google.com/maps/ms?msid=$2&output=embed"',allowFullscreen:!1},{regex:/dailymotion\.com\/video\/([^_]+)/,type:"iframe",w:480,h:270,url:"www.dailymotion.com/embed/video/$1",allowFullscreen:!0},{regex:/dai\.ly\/([^_]+)/,type:"iframe",w:480,h:270,url:"www.dailymotion.com/embed/video/$1",allowFullscreen:!0}],L=function(e){var t=R.filter(function(t){return t.regex.test(e)});return 0<t.length?S.extend({},t[0],{url:function(e,t){for(var r,n=(r=t.match(/^(https?:\/\/|www\.)(.+)$/i))&&1<r.length&&"www."!==r[1]?r[1]:"https://",i=e.regex.exec(t),a=n+e.url,o=0;o<i.length;o++)!function(e){a=a.replace("$"+e,function(){return i[e]?i[e]:""})}(o);return a.replace(/\?$/,"")}(t[0],e)}):null},I=function(e,t){var r=S.extend({},t);if(!r.source&&(S.extend(r,P(O(e),r.embed)),!r.source))return"";r.altsource||(r.altsource=""),r.poster||(r.poster=""),r.source=e.convertURL(r.source,"source"),r.altsource=e.convertURL(r.altsource,"source"),r.sourcemime=D(r.source),r.altsourcemime=D(r.altsource),r.poster=e.convertURL(r.poster,"poster");var n=L(r.source);if(n&&(r.source=n.url,r.type=n.type,r.allowFullscreen=n.allowFullscreen,r.width=r.width||String(n.w),r.height=r.height||String(n.h)),r.embed)return E(r.embed,r,!0);var i=A(O(e),r.source);i&&(r.type="script",r.width=String(i.width),r.height=String(i.height));var a,o,c,u,s,l,m,d,h=e.getParam("audio_template_callback"),f=e.getParam("video_template_callback");return r.width=r.width||"300",r.height=r.height||"150",S.each(r,function(t,n){r[n]=e.dom.encode(""+t)}),"iframe"===r.type?(d=(m=r).allowFullscreen?' allowFullscreen="1"':"",'<iframe src="'+m.source+'" width="'+m.width+'" height="'+m.height+'"'+d+"></iframe>"):"application/x-shockwave-flash"===r.sourcemime?(l='<object data="'+(s=r).source+'" width="'+s.width+'" height="'+s.height+'" type="application/x-shockwave-flash">',s.poster&&(l+='<img src="'+s.poster+'" width="'+s.width+'" height="'+s.height+'" />'),l+="</object>"):-1!==r.sourcemime.indexOf("audio")?(c=r,(u=h)?u(c):'<audio controls="controls" src="'+c.source+'">'+(c.altsource?'\n<source src="'+c.altsource+'"'+(c.altsourcemime?' type="'+c.altsourcemime+'"':"")+" />\n":"")+"</audio>"):"script"===r.type?'<script src="'+r.source+'"></script>':(a=r,(o=f)?o(a):'<video width="'+a.width+'" height="'+a.height+'"'+(a.poster?' poster="'+a.poster+'"':"")+' controls="controls">\n<source src="'+a.source+'"'+(a.sourcemime?' type="'+a.sourcemime+'"':"")+" />\n"+(a.altsource?'<source src="'+a.altsource+'"'+(a.altsourcemime?' type="'+a.altsourcemime+'"':"")+" />\n":"")+"</video>")},q=tinymce.util.Tools.resolve("tinymce.util.Promise"),B={},W=function(e){return function(t){return I(e,t)}},G=function(e,t){var r,n,i,a,o,c=e.getParam("media_url_resolver");return c?(i=t,a=W(e),o=c,new q(function(e,t){var r=function(t){return t.html&&(B[i.source]=t),e({url:i.source,html:t.html?t.html:a(i)})};B[i.source]?r(B[i.source]):o({url:i.source},r,t)})):(r=t,n=W(e),new q(function(e){e({html:n(r),url:r.source})}))},H=function(e,t,r){return function(n){var i=function(){return x(e,n)},a=function(){return x(t,n)},o=function(e){return x(e,"value").bind(function(e){return 0<e.length?m.some(e):m.none()})},c={};return c[n]=(n===r?i().bind(function(e){return f(e)?o(e).orThunk(a):a().orThunk(function(){return m.from(e)})}):a().orThunk(function(){return i().bind(function(e){return f(e)?o(e):m.from(e)})})).getOr(""),c}},J=function(e,t){var r,n,a=t?x(e,t).bind(function(e){return x(e,"meta")}).getOr({}):{},o=H(e,a,t);return i(i(i(i(i({},o("source")),o("altsource")),o("poster")),o("embed")),(r=a,n={},x(e,"dimensions").each(function(e){v(["width","height"],function(t){x(r,t).orThunk(function(){return x(e,t)}).each(function(e){return n[t]=e})})}),n))},K=function(e){var t=i(i({},e),{source:{value:x(e,"source").getOr("")},altsource:{value:x(e,"altsource").getOr("")},poster:{value:x(e,"poster").getOr("")}});return v(["width","height"],function(r){x(e,r).each(function(e){var n=t.dimensions||{};n[r]=e,t.dimensions=n})}),t},Q=function(e){return function(t){var r=t&&t.msg?"Media embed handler error: "+t.msg:"Media embed handler threw unknown error.";e.notificationManager.open({type:"error",text:r})}},V=function(e,t){return P(O(e),t)},X=function(e,t){return function(r){var n,a,o;h(r.url)&&0<r.url.trim().length&&(n=r.html,a=V(t,n),o=i(i({},a),{source:r.url,embed:n}),e.setData(K(o)))}},Y=function(e,t){var r=e.dom.select("img[data-mce-object]");e.insertContent(t),function(e,t){for(var r=e.dom.select("img[data-mce-object]"),n=0;n<t.length;n++)for(var i=r.length-1;0<=i;i--)t[n]===r[i]&&r.splice(i,1);e.selection.select(r[0])}(e,r),e.nodeChanged()},Z=function(e,t,r){var n;t.embed=E(t.embed,t),t.embed&&(e.source===t.source||(n=t.source,B.hasOwnProperty(n)))?Y(r,t.embed):G(r,t).then(function(e){Y(r,e.html)})["catch"](Q(r))},ee=function(e){var t,r,n,a,o=(a=(r=n=(t=e).selection.getNode()).getAttribute("data-mce-object")||r.getAttribute("data-ephox-embed-iri")?t.serializer.serialize(n,{selection:!0}):"",i({embed:a},P(O(t),a))),c=w(o),u=K(o),s={title:"General",name:"general",items:function(e){for(var t=[],r=0,n=e.length;r<n;++r){if(!p(e[r]))throw new Error("Arr.flatten item "+r+" was not an array, input: "+e);g.apply(t,e[r])}return t}([[{name:"source",type:"urlinput",filetype:"media",label:"Source"}],e.getParam("media_dimensions",!0)?[{type:"sizeinput",name:"dimensions",label:"Constrain proportions",constrain:!0}]:[]])},l={title:"Embed",items:[{type:"textarea",name:"embed",label:"Paste your embed code below:"}]},m=[];e.getParam("media_alt_source",!0)&&m.push({name:"altsource",type:"urlinput",filetype:"media",label:"Alternative source URL"}),e.getParam("media_poster",!0)&&m.push({name:"poster",type:"urlinput",filetype:"image",label:"Media poster (Image URL)"});var d={title:"Advanced",name:"advanced",items:m},h=[s,l];0<m.length&&h.push(d);var f={type:"tabpanel",tabs:h},v=e.windowManager.open({title:"Insert/Edit Media",size:"normal",body:f,buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],onSubmit:function(t){var r=J(t.getData());Z(c.get(),r,e),t.close()},onChange:function(t,r){switch(r.name){case"source":d=c.get(),h=J(t.getData(),"source"),d.source!==h.source&&(X(v,e)({url:h.source,html:""}),G(e,h).then(X(v,e))["catch"](Q(e)));break;case"embed":l=J((s=t).getData()),m=V(e,l.embed),s.setData(K(m));break;case"dimensions":case"altsource":case"poster":n=t,a=r.name,o=J(n.getData(),a),u=I(e,o),n.setData(K(i(i({},o),{embed:u})))}var n,a,o,u,s,l,m,d,h;c.set(J(t.getData()))},initialData:u})},te=tinymce.util.Tools.resolve("tinymce.html.Node"),re=tinymce.util.Tools.resolve("tinymce.Env"),ne=function(e,t){if(!1===e.getParam("media_filter_html",!0))return t;var r,n=F();return k({validate:!1,allow_conditional_comments:!1,comment:function(e){n.comment(e)},cdata:function(e){n.cdata(e)},text:function(e,t){n.text(e,t)},start:function(t,i,a){if(r=!0,"script"!==t&&"noscript"!==t&&"svg"!==t){for(var o=i.length-1;0<=o;o--){var c=i[o].name;0===c.indexOf("on")&&(delete i.map[c],i.splice(o,1)),"style"===c&&(i[o].value=e.dom.serializeStyle(e.dom.parseStyle(i[o].value),t))}n.start(t,i,a),r=!1}},end:function(e){r||n.end(e)}},$({})).parse(t),n.getContent()},ie=function(e,t,r){for(var n,i,a=t.attributes,o=a.length;o--;)n=a[o].name,i=a[o].value,"width"!==n&&"height"!==n&&"style"!==n&&("data"!==n&&"src"!==n||(i=e.convertURL(i,n)),r.attr("data-mce-p-"+n,i));var c=t.firstChild&&t.firstChild.value;c&&(r.attr("data-mce-html",escape(ne(e,c))),r.firstChild=null)},ae=function(e){for(;e=e.parent;)if(e.attr("data-ephox-embed-iri")||(t=e.attr("class"))&&/\btiny-pageembed\b/.test(t))return!0;var t;return!1},oe=function(e){return function(t){for(var r,n,i,a,o,c,u=t.length;u--;)(r=t[u]).parent&&(r.parent.attr("data-mce-object")||"script"===r.name&&!(n=A(O(e),r.attr("src")))||(n&&(n.width&&r.attr("width",n.width.toString()),n.height&&r.attr("height",n.height.toString())),"iframe"===r.name&&e.getParam("media_live_embeds",!0)&&re.ceFalse?ae(r)||r.replace(function(e,t){var r=t.name,n=new te("span",1);n.attr({contentEditable:"false",style:t.attr("style"),"data-mce-object":r,"class":"mce-preview-object mce-object-"+r}),ie(e,t,n);var i=new te(r,1);i.attr({src:t.attr("src"),allowfullscreen:t.attr("allowfullscreen"),style:t.attr("style"),"class":t.attr("class"),width:t.attr("width"),height:t.attr("height"),frameborder:"0"});var a=new te("span",1);return a.attr("class","mce-shim"),n.append(i),n.append(a),n}(e,r)):ae(r)||r.replace((i=e,c=void 0,o=(a=r).name,(c=new te("img",1)).shortEnded=!0,ie(i,a,c),c.attr({width:a.attr("width")||"300",height:a.attr("height")||("audio"===o?"30":"150"),style:a.attr("style"),src:re.transparentSrc,"data-mce-object":o,"class":"mce-object mce-object-"+o}),c))))}},ce=function(e){var t,r;e.ui.registry.addToggleButton("media",{tooltip:"Insert/edit media",icon:"embed",onAction:function(){e.execCommand("mceMedia")},onSetup:(t=e,r=["img[data-mce-object]","span[data-mce-object]","div[data-ephox-embed-iri]"],function(e){return t.selection.selectorChangedWithUnbind(r.join(","),e.setActive).unbind})}),e.ui.registry.addMenuItem("media",{icon:"embed",text:"Media...",onAction:function(){e.execCommand("mceMedia")}})};n.add("media",function(e){var t,r,n,i;return(t=e).addCommand("mceMedia",function(){ee(t)}),ce(e),e.on("ResolveName",function(e){var t;1===e.target.nodeType&&(t=e.target.getAttribute("data-mce-object"))&&(e.name=t)}),(r=e).on("preInit",function(){var e=r.schema.getSpecialElements();S.each("video audio iframe object".split(" "),function(t){e[t]=new RegExp("</"+t+"[^>]*>","gi")});var t=r.schema.getBoolAttrs();S.each("webkitallowfullscreen mozallowfullscreen allowfullscreen".split(" "),function(e){t[e]={}}),r.parser.addNodeFilter("iframe,video,audio,object,embed,script",oe(r)),r.serializer.addAttributeFilter("data-mce-object",function(e,t){for(var n,i,a,o,c,u,s,l,m=e.length;m--;)if((n=e[m]).parent){for(s=n.attr(t),i=new te(s,1),"audio"!==s&&"script"!==s&&((l=n.attr("class"))&&-1!==l.indexOf("mce-preview-object")?i.attr({width:n.firstChild.attr("width"),height:n.firstChild.attr("height")}):i.attr({width:n.attr("width"),height:n.attr("height")})),i.attr({style:n.attr("style")}),a=(o=n.attributes).length;a--;){var d=o[a].name;0===d.indexOf("data-mce-p-")&&i.attr(d.substr(11),o[a].value)}"script"===s&&i.attr("type","text/javascript"),(c=n.attr("data-mce-html"))&&((u=new te("#text",3)).raw=!0,u.value=ne(r,unescape(c)),i.append(u)),n.replace(i)}})}),r.on("SetContent",function(){r.$("span.mce-preview-object").each(function(e,t){var n=r.$(t);0===n.find("span.mce-shim").length&&n.append('<span class="mce-shim"></span>')})}),(n=e).on("click keyup touchend",function(){var e=n.selection.getNode();e&&n.dom.hasClass(e,"mce-preview-object")&&n.dom.getAttrib(e,"data-mce-selected")&&e.setAttribute("data-mce-selected","2")}),n.on("ObjectSelected",function(e){var t=e.target.getAttribute("data-mce-object");"audio"!==t&&"script"!==t||e.preventDefault()}),n.on("ObjectResized",function(e){var t,r=e.target;r.getAttribute("data-mce-object")&&(t=r.getAttribute("data-mce-html"))&&(t=unescape(t),r.setAttribute("data-mce-html",escape(E(t,{width:String(e.width),height:String(e.height)}))))}),i=e,{showDialog:function(){ee(i)}}})}();