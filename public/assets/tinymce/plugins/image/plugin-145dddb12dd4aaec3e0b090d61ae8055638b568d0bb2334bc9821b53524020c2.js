/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";function e(e){var t=function(t,n,r,a){var i=new XMLHttpRequest;i.open("POST",e.url),i.withCredentials=e.credentials,i.upload.onprogress=function(e){a(e.loaded/e.total*100)},i.onerror=function(){r("Image upload failed due to a XHR Transport error. Code: "+i.status)},i.onload=function(){var t,a,o;i.status<200||300<=i.status?r("HTTP Error: "+i.status):(t=JSON.parse(i.responseText))&&"string"==typeof t.location?n((a=e.basePath,o=t.location,a?a.replace(/\/$/,"")+"/"+o.replace(/^\//,""):o)):r("Invalid JSON: "+i.responseText)};var o=new FormData;o.append("file",t.blob(),t.filename()),i.send(o)};return e=ve.extend({credentials:!1,handler:t},e),{upload:function(n){return e.url||e.handler!==t?(a=n,i=e.handler,new N(function(e,t){try{i(a,e,t,h)}catch(r){t(r.message)}})):N.reject("Upload url missing from the settings.");var a,i}}}var t,n,r,a,i,o=tinymce.util.Tools.resolve("tinymce.PluginManager"),l=function(){return(l=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var a in t=arguments[n])Object.prototype.hasOwnProperty.call(t,a)&&(e[a]=t[a]);return e}).apply(this,arguments)},s=function(e){return function(t){return r=typeof(n=t),(null===n?"null":"object"==r&&(Array.prototype.isPrototypeOf(n)||n.constructor&&"Array"===n.constructor.name)?"array":"object"==r&&(String.prototype.isPrototypeOf(n)||n.constructor&&"String"===n.constructor.name)?"string":r)===e;var n,r}},u=function(e){return function(t){return typeof t===e}},c=s("string"),m=s("object"),d=s("array"),g=function(e){return t===e},f=u("boolean"),p=u("number"),h=function(){},b=function(e){return function(){return e}},v=b(!1),y=b(!(t=null)),D=function(){return w},w=(n=function(e){return e.isNone()},{fold:function(e){return e()},is:v,isSome:v,isNone:y,getOr:a=function(e){return e},getOrThunk:r=function(e){return e()},getOrDie:function(e){throw new Error(e||"error: getOrDie called on none.")},getOrNull:b(null),getOrUndefined:b(undefined),or:a,orThunk:r,map:D,each:h,bind:D,exists:v,forall:y,filter:D,equals:n,equals_:n,toArray:function(){return[]},toString:b("none()")}),A=function(e){var t=b(e),n=function(){return a},r=function(t){return t(e)},a={fold:function(t,n){return n(e)},is:function(t){return e===t},isSome:y,isNone:v,getOr:t,getOrThunk:t,getOrDie:t,getOrNull:t,getOrUndefined:t,or:n,orThunk:n,map:function(t){return A(t(e))},each:function(t){t(e)},bind:r,exists:r,forall:r,filter:function(t){return t(e)?a:w},toArray:function(){return[e]},toString:function(){return"some("+e+")"},equals:function(t){return t.is(e)},equals_:function(t,n){return t.fold(v,function(t){return n(e,t)})}};return a},S={some:A,none:D,from:function(e){return null===e||e===undefined?w:A(e)}},x=Array.prototype.push,T=function(e){for(var t=[],n=0,r=e.length;n<r;++n){if(!d(e[n]))throw new Error("Arr.flatten item "+n+" was not an array, input: "+e);x.apply(t,e[n])}return t},C=("undefined"!=typeof window||Function("return this;")(),function(e,t,n){!function(e,t,n){if(!(c(n)||f(n)||p(n)))throw console.error("Invalid call to Attribute.set. Key ",t,":: Value ",n,":: Element ",e),new Error("Attribute value was not simple");e.setAttribute(t,n+"")}(e.dom,t,n)}),U=function(e){if(null===e||e===undefined)throw new Error("Node cannot be null or undefined");return{dom:e}},O={fromHtml:function(e,t){var n=(t||document).createElement("div");if(n.innerHTML=e,!n.hasChildNodes()||1<n.childNodes.length)throw console.error("HTML does not have a single root node",e),new Error("HTML must have a single root node");return U(n.childNodes[0])},fromTag:function(e,t){var n=(t||document).createElement(e);return U(n)},fromText:function(e,t){var n=(t||document).createTextNode(e);return U(n)},fromDom:U,fromPoint:function(e,t,n){return S.from(e.dom.elementFromPoint(t,n)).map(U)}},I=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),N=tinymce.util.Tools.resolve("tinymce.util.Promise"),P=tinymce.util.Tools.resolve("tinymce.util.XHR"),_=function(e){return e.getParam("image_dimensions",!0,"boolean")},L=function(e){return e.getParam("images_upload_url","","string")},E=function(e){return e.getParam("images_upload_handler",undefined,"function")},M=function(e,t){return Math.max(parseInt(e,10),parseInt(t,10))},R=function(e){return e&&e.replace(/px$/,"")},z=function(e){return 0<e.length&&/^[0-9]+$/.test(e)&&(e+="px"),e},H=function(e){if(e.margin){var t=String(e.margin).split(" ");switch(t.length){case 1:e["margin-top"]=e["margin-top"]||t[0],e["margin-right"]=e["margin-right"]||t[0],e["margin-bottom"]=e["margin-bottom"]||t[0],e["margin-left"]=e["margin-left"]||t[0];break;case 2:e["margin-top"]=e["margin-top"]||t[0],e["margin-right"]=e["margin-right"]||t[1],e["margin-bottom"]=e["margin-bottom"]||t[0],e["margin-left"]=e["margin-left"]||t[1];break;case 3:e["margin-top"]=e["margin-top"]||t[0],e["margin-right"]=e["margin-right"]||t[1],e["margin-bottom"]=e["margin-bottom"]||t[2],e["margin-left"]=e["margin-left"]||t[1];break;case 4:e["margin-top"]=e["margin-top"]||t[0],e["margin-right"]=e["margin-right"]||t[1],e["margin-bottom"]=e["margin-bottom"]||t[2],e["margin-left"]=e["margin-left"]||t[3]}delete e.margin}return e},k=function(e){return"IMG"===e.nodeName&&(e.hasAttribute("data-mce-object")||e.hasAttribute("data-mce-placeholder"))},j=I.DOM,B=function(e){return e.style.marginLeft&&e.style.marginRight&&e.style.marginLeft===e.style.marginRight?R(e.style.marginLeft):""},F=function(e){return e.style.marginTop&&e.style.marginBottom&&e.style.marginTop===e.style.marginBottom?R(e.style.marginTop):""},G=function(e){return e.style.borderWidth?R(e.style.borderWidth):""},W=function(e,t){return e.hasAttribute(t)?e.getAttribute(t):""},q=function(e,t){return e.style[t]?e.style[t]:""},$=function(e){return null!==e.parentNode&&"FIGURE"===e.parentNode.nodeName},J=function(e,t,n){""===n?e.removeAttribute(t):e.setAttribute(t,n)},X=function(e){var t,n,r,a;$(e)?(a=(r=e).parentNode,j.insertAfter(r,a),j.remove(a)):(t=e,n=j.create("figure",{"class":"image"}),j.insertAfter(n,t),n.appendChild(t),n.appendChild(j.create("figcaption",{contentEditable:"true"},"Caption")),n.contentEditable="false")},V=function(e,t){var n=e.getAttribute("style"),r=t(null!==n?n:"");0<r.length?(e.setAttribute("style",r),e.setAttribute("data-mce-style",r)):e.removeAttribute("style")},K=function(e,t){return function(e,n,r){e.style[n]?(e.style[n]=z(r),V(e,t)):J(e,n,r)}},Z=function(e,t){return e.style[t]?R(e.style[t]):W(e,t)},Q=function(e,t){var n=z(t);e.style.marginLeft=n,e.style.marginRight=n},Y=function(e,t){var n=z(t);e.style.marginTop=n,e.style.marginBottom=n},ee=function(e,t){var n=z(t);e.style.borderWidth=n},te=function(e,t){e.style.borderStyle=t},ne=function(e){return"FIGURE"===e.nodeName},re=function(e){return 0===j.getAttrib(e,"alt").length&&"presentation"===j.getAttrib(e,"role")},ae=function(){return{src:"",alt:"",title:"",width:"",height:"","class":"",style:"",caption:!1,hspace:"",vspace:"",border:"",borderStyle:"",isDecorative:!1}},ie=function(e,t){var n=document.createElement("img");return J(n,"style",t.style),!B(n)&&""===t.hspace||Q(n,t.hspace),!F(n)&&""===t.vspace||Y(n,t.vspace),!G(n)&&""===t.border||ee(n,t.border),!q(n,"borderStyle")&&""===t.borderStyle||te(n,t.borderStyle),e(n.getAttribute("style"))},oe=function(e,t){return{src:W(t,"src"),alt:re(n=t)?"":W(n,"alt"),title:W(t,"title"),width:Z(t,"width"),height:Z(t,"height"),"class":W(t,"class"),style:e(W(t,"style")),caption:$(t),hspace:B(t),vspace:F(t),border:G(t),borderStyle:q(t,"borderStyle"),isDecorative:re(t)};var n},le=function(e,t,n,r,a){n[r]!==t[r]&&a(e,r,n[r])},se=function(e,t,n){var r,a;n?(j.setAttrib(e,"role","presentation"),r=O.fromDom(e),C(r,"alt","")):(g(t)?(a="alt",(r=O.fromDom(e)).dom.removeAttribute(a)):(r=O.fromDom(e),C(r,"alt",t)),"presentation"===j.getAttrib(e,"role")&&j.setAttrib(e,"role",""))},ue=function(e,t){return function(n,r,a){e(n,a),V(n,t)}},ce=function(e,t,n){var r,a,i,o=oe(e,n);le(n,o,t,"caption",function(e){return X(e),0}),le(n,o,t,"src",J),le(n,o,t,"title",J),le(n,o,t,"width",K(0,e)),le(n,o,t,"height",K(0,e)),le(n,o,t,"class",J),le(n,o,t,"style",ue(function(e,t){return J(e,"style",t),0},e)),le(n,o,t,"hspace",ue(Q,e)),le(n,o,t,"vspace",ue(Y,e)),le(n,o,t,"border",ue(ee,e)),le(n,o,t,"borderStyle",ue(te,e)),r=n,a=o,(i=t).alt===a.alt&&i.isDecorative===a.isDecorative||se(r,i.alt,i.isDecorative)},me=function(e,t){var n=e.dom.styles.parse(t),r=H(n),a=e.dom.styles.parse(e.dom.styles.serialize(r));return e.dom.styles.serialize(a)},de=function(e){var t=e.selection.getNode(),n=e.dom.getParent(t,"figure.image");return n?e.dom.select("img",n)[0]:t&&("IMG"!==t.nodeName||k(t))?null:t},ge=function(e,t){var n=e.dom,r=n.getParent(t.parentNode,function(t){return!!e.schema.getTextBlockElements()[t.nodeName]},e.getBody());return r?n.split(r,t):t},fe=function(e,t){var n=function(e,t){var n=document.createElement("img");if(ce(e,l(l({},t),{caption:!1}),n),se(n,t.alt,t.isDecorative),t.caption){var r=j.create("figure",{"class":"image"});return r.appendChild(n),r.appendChild(j.create("figcaption",{contentEditable:"true"},"Caption")),r.contentEditable="false",r}return n}(function(t){return me(e,t)},t);e.dom.setAttrib(n,"data-mce-id","__mcenew"),e.focus(),e.selection.setContent(n.outerHTML);var r,a=e.dom.select('*[data-mce-id="__mcenew"]')[0];e.dom.setAttrib(a,"data-mce-id",null),ne(a)?(r=ge(e,a),e.selection.select(r)):e.selection.select(a)},pe=function(e,t){var n,r,a,i,o,l,s=de(e);ce(function(t){return me(e,t)},t,s),n=s,e.dom.setAttrib(n,"src",n.getAttribute("src")),ne(s.parentNode)?(r=s.parentNode,ge(e,r),e.selection.select(s.parentNode)):(e.selection.select(s),a=e,i=t,l=function(){o.onload=o.onerror=null,a.selection&&(a.selection.select(o),a.nodeChanged())},(o=s).onload=function(){i.width||i.height||!_(a)||a.dom.setAttribs(o,{width:String(o.clientWidth),height:String(o.clientHeight)}),l()},o.onerror=l)},he=Object.prototype.hasOwnProperty,be=(i=function(e,t){return m(e)&&m(t)?be(e,t):t},function(){for(var e=new Array(arguments.length),t=0;t<e.length;t++)e[t]=arguments[t];if(0===e.length)throw new Error("Can't merge zero objects");for(var n={},r=0;r<e.length;r++){var a=e[r];for(var o in a)he.call(a,o)&&(n[o]=i(n[o],a[o]))}return n}),ve=tinymce.util.Tools.resolve("tinymce.util.Tools"),ye=function(e){return c(e.value)?e.value:""},De=function(e,t){var n=[];return ve.each(e,function(e){var r,a,i=c(e.text)?e.text:c(e.title)?e.title:"";e.menu!==undefined?(r=De(e.menu,t),n.push({text:i,items:r})):(a=t(e),n.push({text:i,value:a}))}),n},we=function(e){return void 0===e&&(e=ye),function(t){return t?S.from(t).map(function(t){return De(t,e)}):S.none()}},Ae=function(e,t){return function(e,t){for(var n=0;n<e.length;n++){var r=t(e[n],n);if(r.isSome())return r}return S.none()}(e,function(e){return n=e,Object.prototype.hasOwnProperty.call(n,"items")?Ae(e.items,t):e.value===t?S.some(e):S.none();var n})},Se=we,xe=function(e){return we(ye)(e)},Te=function(e,t){return e.bind(function(e){return Ae(e,t)})},Ce=function(){return{title:"Advanced",name:"advanced",items:[{type:"input",label:"Style",name:"style"},{type:"grid",columns:2,items:[{type:"input",label:"Vertical space",name:"vspace",inputMode:"numeric"},{type:"input",label:"Horizontal space",name:"hspace",inputMode:"numeric"},{type:"input",label:"Border width",name:"border",inputMode:"numeric"},{type:"listbox",name:"borderstyle",label:"Border style",items:[{text:"Select...",value:""},{text:"Solid",value:"solid"},{text:"Dotted",value:"dotted"},{text:"Dashed",value:"dashed"},{text:"Double",value:"double"},{text:"Groove",value:"groove"},{text:"Ridge",value:"ridge"},{text:"Inset",value:"inset"},{text:"Outset",value:"outset"},{text:"None",value:"none"},{text:"Hidden",value:"hidden"}]}]}]}},Ue=function(e){var t,n,r=Se(function(t){return e.convertURL(t.value||t.url,"src")}),a=new N(function(t){var n,a;n=function(e){t(r(e).map(function(e){return T([[{text:"None",value:""}],e])}))},"string"==typeof(a=e.getParam("image_list",!1))?P.send({url:a,success:function(e){n(JSON.parse(e))}}):"function"==typeof a?a(n):n(a)}),i=xe(e.getParam("image_class_list")),o=e.getParam("image_advtab",!1,"boolean"),l=e.getParam("image_uploadtab",!0,"boolean"),s=!!L(e),u=!!E(e),m=(n=de(t=e))?oe(function(e){return me(t,e)},n):ae(),d=e.getParam("image_description",!0,"boolean"),g=e.getParam("image_title",!1,"boolean"),f=_(e),p=e.getParam("image_caption",!1,"boolean"),h=e.getParam("a11y_advanced_options",!1,"boolean"),b=L(e),v=e.getParam("images_upload_base_path",undefined,"string"),y=e.getParam("images_upload_credentials",!1,"boolean"),D=E(e),w=e.getParam("automatic_uploads",!0,"boolean"),A=S.some(e.getParam("image_prepend_url","","string")).filter(function(e){return c(e)&&0<e.length});return a.then(function(e){return{image:m,imageList:e,classList:i,hasAdvTab:o,hasUploadTab:l,hasUploadUrl:s,hasUploadHandler:u,hasDescription:d,hasImageTitle:g,hasDimensions:f,hasImageCaption:p,url:b,basePath:v,credentials:y,handler:D,prependURL:A,hasAccessibilityOptions:h,automaticUploads:w}})},Oe=function(e){var t=e.imageList.map(function(e){return{name:"images",type:"listbox",label:"Image list",items:e}}),n={name:"alt",type:"input",label:"Alternative description",disabled:e.hasAccessibilityOptions&&e.image.isDecorative},r=e.classList.map(function(e){return{name:"classes",type:"listbox",label:"Class",items:e}});return T([[{name:"src",type:"urlinput",filetype:"image",label:"Source"}],t.toArray(),e.hasAccessibilityOptions&&e.hasDescription?[{type:"label",label:"Accessibility",items:[{name:"isDecorative",type:"checkbox",label:"Image is decorative"}]}]:[],e.hasDescription?[n]:[],e.hasImageTitle?[{name:"title",type:"input",label:"Image title"}]:[],e.hasDimensions?[{name:"dimensions",type:"sizeinput"}]:[],[{type:"grid",columns:2,items:T([r.toArray(),e.hasImageCaption?[{type:"label",label:"Caption",items:[{type:"checkbox",name:"caption",label:"Show caption"}]}]:[]])}]])},Ie=function(e){return{title:"General",name:"general",items:Oe(e)}},Ne=Oe,Pe=function(){return{title:"Upload",name:"upload",items:[{type:"dropzone",name:"fileinput"}]}},_e=function(e){return{src:{value:e.src,meta:{}},images:e.src,alt:e.alt,title:e.title,dimensions:{width:e.width,height:e.height},classes:e["class"],caption:e.caption,style:e.style,vspace:e.vspace,border:e.border,hspace:e.hspace,borderstyle:e.borderStyle,fileinput:[],isDecorative:e.isDecorative}},Le=function(e,t){return{src:e.src.value,alt:0===e.alt.length&&t?null:e.alt,title:e.title,width:e.dimensions.width,height:e.dimensions.height,"class":e.classes,style:e.style,caption:e.caption,hspace:e.hspace,vspace:e.vspace,border:e.border,borderStyle:e.borderstyle,isDecorative:e.isDecorative}},Ee=function(e,t){var n,r,a=t.getData();n=e,r=a.src.value,(/^(?:[a-zA-Z]+:)?\/\//.test(r)?S.none():n.prependURL.bind(function(e){return r.substring(0,e.length)!==e?S.some(e+r):S.none()})).each(function(e){t.setData({src:{value:e,meta:a.src.meta}})})},Me=function(e,t){var n,r,a,i,o=t.getData(),l=o.src.meta;l!==undefined&&(n=be({},o),a=n,i=l,(r=e).hasDescription&&c(i.alt)&&(a.alt=i.alt),r.hasAccessibilityOptions&&(a.isDecorative=i.isDecorative||a.isDecorative||!1),r.hasImageTitle&&c(i.title)&&(a.title=i.title),r.hasDimensions&&(c(i.width)&&(a.dimensions.width=i.width),c(i.height)&&(a.dimensions.height=i.height)),c(i["class"])&&Te(r.classList,i["class"]).each(function(e){a.classes=e.value}),r.hasImageCaption&&f(i.caption)&&(a.caption=i.caption),r.hasAdvTab&&(c(i.style)&&(a.style=i.style),c(i.vspace)&&(a.vspace=i.vspace),c(i.border)&&(a.border=i.border),c(i.hspace)&&(a.hspace=i.hspace),c(i.borderstyle)&&(a.borderstyle=i.borderstyle)),t.setData(n))},Re=function(e,t,n,r){var a,i,o,l,s,u,c,m,d,g,f,p;Ee(t,r),Me(t,r),a=e,i=t,o=n,u=(s=(l=r).getData()).src.value,(c=s.src.meta||{}).width||c.height||!i.hasDimensions||a.imageSize(u).then(function(e){o.open&&l.setData({dimensions:e})}),m=t,d=n,f=(g=r).getData(),p=Te(m.imageList,f.src.value),d.prevImage=p,g.setData({images:p.map(function(e){return e.value}).getOr("")})},ze=function(e,t,n){var r,a,i,o,l,s=H(e(n.style)),u=be({},n);return u.vspace=(r=s)["margin-top"]&&r["margin-bottom"]&&r["margin-top"]===r["margin-bottom"]?R(String(r["margin-top"])):"",u.hspace=(a=s)["margin-right"]&&a["margin-left"]&&a["margin-right"]===a["margin-left"]?R(String(a["margin-right"])):"",u.border=(i=s)["border-width"]?R(String(i["border-width"])):"",u.borderstyle=(o=s)["border-style"]?String(o["border-style"]):"",u.style=(l=t)(e(l(s))),u},He=function(t,n,r,a){var i,o=a.getData();a.block("Uploading image"),(0===(i=o.fileinput).length?S.none():S.some(i[0])).fold(function(){a.unblock()},function(i){var o,l=URL.createObjectURL(i),s=e({url:n.url,basePath:n.basePath,credentials:n.credentials,handler:n.handler}),u=function(){a.unblock(),URL.revokeObjectURL(l)},c=function(e){a.setData({src:{value:e,meta:{}}}),a.showTab("general"),Re(t,n,r,a)};o=i,new N(function(e,t){var n=new FileReader;n.onload=function(){e(n.result)},n.onerror=function(){t(n.error.message)},n.readAsDataURL(o)}).then(function(e){var r=t.createBlobCache(i,l,e);n.automaticUploads?s.upload(r).then(function(e){c(e),u()})["catch"](function(e){u(),t.alertErr(e)}):(t.addToBlobCache(r),c(r.blobUri()),a.unblock())})})},ke=function(e,t,n){return function(r,a){var i,o,l,s,u,c,m,d,g,f,p,h,b,v;"src"===a.name?Re(e,t,n,r):"images"===a.name?(g=e,f=t,p=n,b=(h=r).getData(),(v=Te(f.imageList,b.images)).each(function(e){""===b.alt||p.prevImage.map(function(e){return e.text===b.alt}).getOr(!1)?""===e.value?h.setData({src:e,alt:p.prevAlt}):h.setData({src:e,alt:e.text}):h.setData({src:e})}),p.prevImage=v,Re(g,f,p,h)):"alt"===a.name?n.prevAlt=r.getData().alt:"style"===a.name?(u=e,m=(c=r).getData(),d=ze(u.parseStyle,u.serializeStyle,m),c.setData(d)):"vspace"===a.name||"hspace"===a.name||"border"===a.name||"borderstyle"===a.name?(i=e,o=r,l=be(_e(t.image),o.getData()),s=ie(i.normalizeCss,Le(l,!1)),o.setData({style:s})):"fileinput"===a.name?He(e,t,n,r):"isDecorative"===a.name&&(r.getData().isDecorative?r.disable("alt"):r.enable("alt"))}},je=function(e){return function(t){var n,r,a,i={prevImage:Te((n=t).imageList,n.image.src),prevAlt:n.image.alt,open:!0};return{title:"Insert/Edit Image",size:"normal",body:(a=t).hasAdvTab||a.hasUploadUrl||a.hasUploadHandler?{type:"tabpanel",tabs:T([[Ie(a)],a.hasAdvTab?[Ce(a)]:[],a.hasUploadTab&&(a.hasUploadUrl||a.hasUploadHandler)?[Pe(a)]:[]])}:{type:"panel",items:Ne(a)},buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],initialData:_e(t.image),onSubmit:e.onSubmit(t),onChange:ke(e,t,i),onClose:(r=i,function(){r.open=!1})}}},Be=function(e){return function(t){return n=e.documentBaseURI.toAbsolute(t),new N(function(e){var t=document.createElement("img"),r=function(n){t.parentNode&&t.parentNode.removeChild(t),e(n)};t.onload=function(){var e={width:M(t.width,t.clientWidth),height:M(t.height,t.clientHeight)};r(N.resolve(e))},t.onerror=function(){r(N.reject("Failed to get image dimensions for: "+n))};var a=t.style;a.visibility="hidden",a.position="fixed",a.bottom=a.left="0px",a.width=a.height="auto",document.body.appendChild(t),t.src=n}).then(function(e){return{width:String(e.width),height:String(e.height)}});var n}},Fe=function(e){var t,n,r,a,i,o,l,s={onSubmit:function(e){return function(t){var n=be(_e(e.image),t.getData());l.execCommand("mceUpdateImage",!1,Le(n,e.hasAccessibilityOptions)),l.editorUpload.uploadImagesAuto(),t.close()}},imageSize:Be(l=e),addToBlobCache:function(e){o.editorUpload.blobCache.add(e)},createBlobCache:function(e,t,n){return i.editorUpload.blobCache.create({blob:e,blobUri:t,name:e.name?e.name.replace(/\.[^\.]+$/,""):null,base64:n.split(",")[1]})},alertErr:function(e){a.windowManager.alert(e)},normalizeCss:function(e){return me(r,e)},parseStyle:function(e){return n.dom.parseStyle(e)},serializeStyle:(t=n=r=a=i=o=e,function(e,n){return t.dom.serializeStyle(e,n)})};return{open:function(){Ue(e).then(je(s)).then(e.windowManager.open)}}},Ge=function(e){e.addCommand("mceImage",Fe(e).open),e.addCommand("mceUpdateImage",function(t,n){e.undoManager.transact(function(){return r=n,void((c=de(t=e))?(a=oe(function(e){return me(t,e)},c),(i=l(l({},a),r)).src?pe(t,i):(o=t,(s=c)&&(u=o.dom.is(s.parentNode,"figure.image")?s.parentNode:s,o.dom.remove(u),o.focus(),o.nodeChanged(),o.dom.isEmpty(o.getBody())&&(o.setContent(""),o.selection.setCursorLocation())))):r.src&&fe(t,l(l({},ae()),r)));var t,r,a,i,o,s,u,c})})},We=function(e){return function(t){for(var n,r=t.length,a=function(t){t.attr("contenteditable",e?"true":null)};r--;){var i=t[r];(n=i.attr("class"))&&/\bimage\b/.test(n)&&(i.attr("contenteditable",e?"false":null),ve.each(i.getAll("figcaption"),a))}}};o.add("image",function(e){var t,n;(t=e).on("PreInit",function(){t.parser.addNodeFilter("figure",We(!0)),t.serializer.addNodeFilter("figure",We(!1))}),(n=e).ui.registry.addToggleButton("image",{icon:"image",tooltip:"Insert/edit image",onAction:Fe(n).open,onSetup:function(e){return n.selection.selectorChangedWithUnbind("img:not([data-mce-object],[data-mce-placeholder]),figure.image",e.setActive).unbind}}),n.ui.registry.addMenuItem("image",{icon:"image",text:"Image...",onAction:Fe(n).open}),n.ui.registry.addContextMenu("image",{update:function(e){return ne(e)||"IMG"===e.nodeName&&!k(e)?["image"]:[]}}),Ge(e)})}();