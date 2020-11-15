/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.5.1 (2020-10-01)
 */
!function(){"use strict";var e=function(e){var t=e;return{get:function(){return t},set:function(e){t=e}}},t=tinymce.util.Tools.resolve("tinymce.PluginManager"),n=function(){return(n=Object.assign||function(e){for(var t,n=1,l=arguments.length;n<l;n++)for(var i in t=arguments[n])Object.prototype.hasOwnProperty.call(t,i)&&(e[i]=t[i]);return e}).apply(this,arguments)},l=tinymce.util.Tools.resolve("tinymce.util.Tools"),i=tinymce.util.Tools.resolve("tinymce.html.DomParser"),o=tinymce.util.Tools.resolve("tinymce.html.Node"),r=tinymce.util.Tools.resolve("tinymce.html.Serializer"),a=function(e){return e.getParam("fullpage_hide_in_source_view")},c=function(e){return e.getParam("fullpage_default_encoding")},s=function(e){return e.getParam("fullpage_default_font_family")},d=function(e){return e.getParam("fullpage_default_font_size")},u=function(e){return i({validate:!1,root_name:"#document"}).parse(e,{format:"xhtml"})},m=function(e,t){function i(e,t){return e.attr(t)||""}var a,c,m,f,g,p,y=(a=e,c=t.get(),g=u(c),(p={}).fontface=s(a),p.fontsize=d(a),7===(m=g.firstChild).type&&(p.xml_pi=!0,(f=/encoding="([^"]+)"/.exec(m.value))&&(p.docencoding=f[1])),(m=g.getAll("#doctype")[0])&&(p.doctype="<!DOCTYPE"+m.value+">"),(m=g.getAll("title")[0])&&m.firstChild&&(p.title=m.firstChild.value),l.each(g.getAll("meta"),function(e){var t,n=e.attr("name"),l=e.attr("http-equiv");n?p[n.toLowerCase()]=e.attr("content"):"Content-Type"===l&&(t=/charset\s*=\s*(.*)\s*/gi.exec(e.attr("content")))&&(p.docencoding=t[1])}),(m=g.getAll("html")[0])&&(p.langcode=i(m,"lang")||i(m,"xml:lang")),p.stylesheets=[],l.each(g.getAll("link"),function(e){"stylesheet"===e.attr("rel")&&p.stylesheets.push(e.attr("href"))}),(m=g.getAll("body")[0])&&(p.langdir=i(m,"dir"),p.style=i(m,"style"),p.visited_color=i(m,"vlink"),p.link_color=i(m,"link"),p.active_color=i(m,"alink")),p),h=n(n({},{title:"",keywords:"",description:"",robots:"",author:"",docencoding:""}),y);e.windowManager.open({title:"Metadata and Document Properties",size:"normal",body:{type:"panel",items:[{name:"title",type:"input",label:"Title"},{name:"keywords",type:"input",label:"Keywords"},{name:"description",type:"input",label:"Description"},{name:"robots",type:"input",label:"Robots"},{name:"author",type:"input",label:"Author"},{name:"docencoding",type:"input",label:"Encoding"}]},buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],initialData:h,onSubmit:function(n){var i=n.getData(),a=function(e,t,n){function i(e,t,n){e.attr(t,n||undefined)}function a(e){d.firstChild?d.insert(e,d.firstChild):d.append(e)}var c,s,d,m=e.dom,f=u(n);(d=f.getAll("head")[0])||(c=f.getAll("html")[0],d=new o("head",1),c.firstChild?c.insert(d,c.firstChild,!0):c.append(d)),c=f.firstChild,t.xml_pi?(s='version="1.0"',t.docencoding&&(s+=' encoding="'+t.docencoding+'"'),7!==c.type&&(c=new o("xml",7),f.insert(c,f.firstChild,!0)),c.value=s):c&&7===c.type&&c.remove(),c=f.getAll("#doctype")[0],t.doctype?(c||(c=new o("#doctype",10),t.xml_pi?f.insert(c,f.firstChild):a(c)),c.value=t.doctype.substring(9,t.doctype.length-1)):c&&c.remove(),c=null,l.each(f.getAll("meta"),function(e){"Content-Type"===e.attr("http-equiv")&&(c=e)}),t.docencoding?(c||((c=new o("meta",1)).attr("http-equiv","Content-Type"),c.shortEnded=!0,a(c)),c.attr("content","text/html; charset="+t.docencoding)):c&&c.remove(),c=f.getAll("title")[0],t.title?(c?c.empty():a(c=new o("title",1)),c.append(new o("#text",3)).value=t.title):c&&c.remove(),l.each("keywords,description,author,copyright,robots".split(","),function(e){for(var n,l=f.getAll("meta"),i=t[e],r=0;r<l.length;r++)if((n=l[r]).attr("name")===e)return void(i?n.attr("content",i):n.remove());i&&((c=new o("meta",1)).attr("name",e),c.attr("content",i),c.shortEnded=!0,a(c))});var g={};l.each(f.getAll("link"),function(e){"stylesheet"===e.attr("rel")&&(g[e.attr("href")]=e)}),l.each(t.stylesheets,function(e){g[e]||((c=new o("link",1)).attr({rel:"stylesheet",text:"text/css",href:e}),c.shortEnded=!0,a(c)),delete g[e]}),l.each(g,function(e){e.remove()}),(c=f.getAll("body")[0])&&(i(c,"dir",t.langdir),i(c,"style",t.style),i(c,"vlink",t.visited_color),i(c,"link",t.link_color),i(c,"alink",t.active_color),m.setAttribs(e.getBody(),{style:t.style,dir:t.dir,vLink:t.visited_color,link:t.link_color,aLink:t.active_color})),(c=f.getAll("html")[0])&&(i(c,"lang",t.langcode),i(c,"xml:lang",t.langcode)),d.firstChild||d.remove();var p=r({validate:!1,indent:!0,indent_before:"head,html,body,meta,title,script,link,style",indent_after:"head,html,body,meta,title,script,link,style"}).serialize(f);return p.substring(0,p.indexOf("</body>"))}(e,l.extend(y,i),t.get());t.set(a),n.close()}})},f=l.each,g=function(e){return e.replace(/<\/?[A-Z]+/g,function(e){return e.toLowerCase()})},p=function(e,t,n,i){var o,r,c,s,d,m,p,h,v,_="",b=e.dom;i.selection||(s=e.getParam("protect"),d=i.content,l.each(s,function(e){d=d.replace(e,function(e){return"<!--mce:protected "+escape(e)+"-->"})}),c=d,"raw"===i.format&&t.get()||i.source_view&&a(e)||(0!==c.length||i.source_view||(c=l.trim(t.get())+"\n"+l.trim(c)+"\n"+l.trim(n.get())),-1!==(o=(c=c.replace(/<(\/?)BODY/gi,"<$1body")).indexOf("<body"))?(o=c.indexOf(">",o),t.set(g(c.substring(0,o+1))),-1===(r=c.indexOf("</body",o))&&(r=c.length),i.content=l.trim(c.substring(o+1,r)),n.set(g(c.substring(r)))):(t.set(y(e)),n.set("\n</body>\n</html>")),m=u(t.get()),f(m.getAll("style"),function(e){e.firstChild&&(_+=e.firstChild.value)}),(p=m.getAll("body")[0])&&b.setAttribs(e.getBody(),{style:p.attr("style")||"",dir:p.attr("dir")||"",vLink:p.attr("vlink")||"",link:p.attr("link")||"",aLink:p.attr("alink")||""}),b.remove("fullpage_styles"),h=e.getDoc().getElementsByTagName("head")[0],_&&b.add(h,"style",{id:"fullpage_styles"}).appendChild(document.createTextNode(_)),v={},l.each(h.getElementsByTagName("link"),function(e){"stylesheet"===e.rel&&e.getAttribute("data-mce-fullpage")&&(v[e.href]=e)}),l.each(m.getAll("link"),function(e){var t=e.attr("href");if(!t)return!0;v[t]||"stylesheet"!==e.attr("rel")||b.add(h,"link",{rel:"stylesheet",text:"text/css",href:t,"data-mce-fullpage":"1"}),delete v[t]}),l.each(v,function(e){e.parentNode.removeChild(e)})))},y=function(e){var t,n="",l="";return e.getParam("fullpage_default_xml_pi")&&(n+='<?xml version="1.0" encoding="'+(c(e)||"ISO-8859-1")+'" ?>\n'),n+=e.getParam("fullpage_default_doctype","<!DOCTYPE html>"),n+="\n<html>\n<head>\n",(t=e.getParam("fullpage_default_title"))&&(n+="<title>"+t+"</title>\n"),(t=c(e))&&(n+='<meta http-equiv="Content-Type" content="text/html; charset='+t+'" />\n'),(t=s(e))&&(l+="font-family: "+t+";"),(t=d(e))&&(l+="font-size: "+t+";"),(t=e.getParam("fullpage_default_text_color"))&&(l+="color: "+t+";"),n+"</head>\n<body"+(l?' style="'+l+'"':"")+">\n"},h=function(e,t,n,i){i.selection||i.source_view&&a(e)||(i.content=(l.trim(t)+"\n"+l.trim(i.content)+"\n"+l.trim(n)).replace(/<!--mce:protected ([\s\S]*?)-->/g,function(e,t){return unescape(t)}))};t.add("fullpage",function(t){var n,l,i,o,r,a,c=e(""),s=e("");l=c,(n=t).addCommand("mceFullPageProperties",function(){m(n,l)}),(i=t).ui.registry.addButton("fullpage",{tooltip:"Metadata and document properties",icon:"document-properties",onAction:function(){i.execCommand("mceFullPageProperties")}}),i.ui.registry.addMenuItem("fullpage",{text:"Metadata and document properties",icon:"document-properties",onAction:function(){i.execCommand("mceFullPageProperties")}}),r=c,a=s,(o=t).on("BeforeSetContent",function(e){p(o,r,a,e)}),o.on("GetContent",function(e){h(o,r.get(),a.get(),e)})})}();