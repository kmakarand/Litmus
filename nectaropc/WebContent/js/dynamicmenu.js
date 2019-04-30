                //Detect Browser
        var IE4 = (document.all && !document.getElementById) ? true : false;
        var NS4 = (document.layers) ? true : false;
        var IE5 = (document.all && document.getElementById) ? true : false;
        var N6 = (document.getElementById && !document.all) ? true : false;

var globheight;
var globwidth;
var globlevel;
var globdelay;
var globtype;
var menucount=0;
var N6count=0;
var populatemenuitems="false";

//menu_tpl.js from original starts here*****************************************************
var MENU_POS = new Array();
        MENU_POS['height'] = [];
        MENU_POS['width'] = [];
        MENU_POS['block_top'] = [0, 0,];
        MENU_POS['hide_delay'] = [];

var MENU_STYLES = new Array();
        MENU_STYLES['onmouseout'] = [
                'color', [],
                'background', []
        ];
        MENU_STYLES['onmouseover'] = [
                'color', [],
                'background', []
        ];
        
        MENU_STYLES['onmousedown'] = [
                'color', [],
                'background', []
        ];
        
//menu_tpl.js from original ends here*******************************************************


function initmenu(levels,height,width,delay,type)
{
if (populatemenuitems=="true")
{
for (i=0;i<=levels-1;i++)
{
MENU_ITEMS[i] = ITEMS[i+1];
}
}

//setting the height
globheight=height;
globlevel=levels;
globwidth=width;
globdelay=delay;

if (populatemenuitems=="false")
{
        if (type=="horizontal")
        {
                //Defaults for horizontal
                MENU_POS['block_left'] = [0, 0];
                MENU_POS['top'] = [0];
                MENU_POS['left'] = [globwidth];
                globtype="horizontal";
        }
        else
        {       
                //Defaults for vertical
                MENU_POS['block_left'] = [0, globwidth];
                MENU_POS['top']        = [0, 0];
                MENU_POS['left']       = [0, 0];
                globtype="vertical";
        }
}
}




//menu.js from original starts here********************************************************
var menus = [];

// --- menu class ---
function menu (item_struct, pos, styles) {
        // browser check
        this.item_struct = item_struct;
        this.pos = pos;
        this.styles = styles;
        this.id = menus.length;
        this.items = [];
        this.children = [];
        this.add_item = menu_add_item;
        this.hide = menu_hide;
        this.onclick = menu_onclick;
        this.onmouseout = menu_onmouseout;
        this.onmouseover = menu_onmouseover;
        this.onmousedown = menu_onmousedown;
        var i;
        for (i = 0; i < this.item_struct.length; i++)
                new menu_item(i, this, this);
        for (i = 0; i < this.children.length; i++)
                this.children[i].visibility(true);
        menus[this.id] = this;
}
function menu_add_item (item) {
        var id = this.items.length;
        this.items[id] = item;
        return (id);
}
function menu_hide () {
        for (var i = 0; i < this.items.length; i++) {
                this.items[i].visibility(false);
                this.items[i].switch_style('onmouseout');
        }
}
function menu_onclick (id) {
        var item = this.items[id];
        return (item.fields[1] ? true : false);
}
function menu_onmouseout (id) {
        this.hide_timer = setTimeout('menus['+ this.id +'].hide();',
                this.pos['hide_delay'][this.active_item.depth]);
        if (this.active_item.id == id)
                this.active_item = null;
}
function menu_onmouseover (id) {
        this.active_item = this.items[id];
        clearTimeout(this.hide_timer);
        var curr_item, visib;
        for (var i = 0; i < this.items.length; i++) {
                curr_item = this.items[i];
                visib = (curr_item.arrpath.slice(0, curr_item.depth).join('_') ==
                        this.active_item.arrpath.slice(0, curr_item.depth).join('_'));
                if (visib)
                        curr_item.switch_style (
                                curr_item == this.active_item ? 'onmouseover' : 'onmouseout');
                curr_item.visibility(visib);
        }
}
function menu_onmousedown (id) {
        this.items[id].switch_style('onmousedown');
}
// --- menu item Class ---
function menu_item (path, parent, container) {
        this.path = new String (path);
        this.parent = parent;
        this.container = container;
        this.arrpath = this.path.split('_');
        this.depth = this.arrpath.length - 1;
        // get pointer to item's data in the structure
        var struct_path = '', i;
        for (i = 0; i <= this.depth; i++)
                struct_path += '[' + (Number(this.arrpath[i]) + (i ? 2 : 0)) + ']';
        eval('this.fields = this.container.item_struct' + struct_path);
        if (!this.fields) return;
        
        // assign methods       
        this.get_x = mitem_get_x;
        this.get_y = mitem_get_y;
        // these methods may be different for different browsers (i.e. non DOM compatible)
        this.init = mitem_init;
        this.visibility = mitem_visibility;
        this.switch_style = mitem_switch_style;
        
        // register in the collections
        this.id = this.container.add_item(this);
        parent.children[parent.children.length] = this;
        
        // init recursively
        this.init();
        this.children = [];
        var child_count = this.fields.length - 2;
        for (i = 0; i < child_count; i++)
                new menu_item (this.path + '_' + i, this, this.container);
        this.switch_style('onmouseout');
}

function mitem_init() {
        document.write (
                '<a id="mi_' + this.container.id + '_'
                        + this.id +'" class="m' + this.container.id + 'l' + this.depth 
                        +'o" target="main_page" href="' + this.fields[1] + '" style="position: absolute; top: '
                        + this.get_y() + 'px; left: '   + this.get_x() + 'px; width: '
                        + this.container.pos['width'][this.depth] + 'px; height: '
                        + this.container.pos['height'][this.depth] + 'px; visibility: hidden;'
                        +' background-color:lightblue; color: white; z-index: ' + this.depth + ';" '
                        + 'onclick="return menus[' + this.container.id + '].onclick('
                        + this.id + ');" onmouseout="menus[' + this.container.id + '].onmouseout('
                        + this.id + ');" onmouseover="menus[' + this.container.id + '].onmouseover('
                        + this.id + ');" onmousedown="menus[' + this.container.id + '].onmousedown('
                        + this.id + ');"><div id="menudivs" class="m'  + this.container.id + 'l' + this.depth + 'i">'
                        + this.fields[0] + "</div></a>\n"
                );
                
                if (globtype=="horizontal")
                {
                        MENU_POS['block_top'][1]=document.getElementById('menudivs').offsetHeight;
                   for (d=1;d<=MENU_POS['top'].length-1;d++)
                    {
                    MENU_POS['top'][d]= document.getElementById('menudivs').offsetHeight;
                        }
                }
                if (globtype=="vertical")
                {
                   for (h=0;h<=MENU_POS['top'].length-1;h++)
                   {
                    MENU_POS['top'][h]= document.getElementById('menudivs').offsetHeight;
                        }
                }
        this.element = document.getElementById('mi_' + this.container.id + '_' + this.id);
        //document.getElementById('holdmenu').innerHTML+=this.element.outerHTML;
}
function mitem_visibility(make_visible) {
        if (make_visible != null) {
                if (this.visible == make_visible) return;
                this.visible = make_visible;
                if (make_visible)
                        this.element.style.visibility = 'visible';
                else if (this.depth)
                        this.element.style.visibility = 'hidden';
        }
        return (this.visible);
}
function mitem_get_x() {
        var value = 0;
        for (var i = 0; i <= this.depth; i++)
                value += this.container.pos['block_left'][i]
                + this.arrpath[i] * this.container.pos['left'][i];
        return (value);
}
function mitem_get_y() {
        var value = 0;
        for (var i = 0; i <= this.depth; i++)
                value += this.container.pos['block_top'][i]
                + this.arrpath[i] * this.container.pos['top'][i];
        return (value);
}
function mitem_switch_style(state) {
        if (this.state == state) return;
        this.state = state;
        var style = this.container.styles[state];
        for (var i = 0; i < style.length; i += 2)
                if (style[i] && style[i+1])
                        eval('this.element.style.' + style[i] + "='" 
                        + style[i+1][this.depth] + "';");
}
// menu.js from original ends here************************************************



//menu_items.js from original starts here******************************************
var arraywith10values=new Array();
var arraywith10valuescount=0;
var splitvalarray;
var doflag;
var newarraystr=new Array();
mainarray=new Array();
mainarraywithcommas=new Array();
fullmainarray=new Array();
var MENU_ITEMS=new Array();
var ITEMS=new Array();
var splitarray=new Array();
var count=0;

//This is the new function added. This function replaces all the occurances of a particular character/substring in a string with the given character/string***********************
function replace(string,text,by)
{
    var strLength = string.length, txtLength = text.length;
    if ((strLength == 0) || (txtLength == 0)) return string;

    var i = string.indexOf(text);
    if ((!i) && (text != string.substring(0,txtLength))) return string;
    if (i == -1) return string;

    var newstr = string.substring(0,i) + by;

    if (i+txtLength < strLength)
        newstr += replace(string.substring(i+txtLength,strLength),text,by);

    return newstr;
}
//******************************************************************************************

function addmenuitem(val,desc,url,onmouseovrtxtcol,onmouseovrbgndcol,onmouseouttxtcol,onmouseoutbgndcol,onmousedowntxtcol,onmousedownbgndcol,fontstyles)
{
/*
val=Node level
desc=description which shows up
url=url linked to description
onmouseovertxtcol=Onmouseover Text color
*/
doflag="yes";
splitvalarray=val.split(",");
        for (b=0;b<=splitvalarray.length-1;b++)
        {
                if ((splitvalarray[b]=="10") || (splitvalarray[b]=="20"))
                {
                doflag="no";
                }
        }
        
        //populate array values for only those inputs which have a level of 10,20etc only after first level,ex:1,10,1;1,1,10,1etc************************************************************
        if ((doflag=="no") && (splitvalarray[0].length!=2))
        {
                        arraywith10values[arraywith10valuescount]=new Array(val,desc,url);
                        arraywith10valuescount=arraywith10valuescount+1;
        }
        //********************************************************************************
        
        //populate array values for only those inputs which have a level of 10,20etc only after first level,ex:10,1,1;10,1,10,1etc***********************************************************
        if ((doflag=="no") && (splitvalarray[0].length==2) && (splitvalarray.length>1))
        {
                        arraywith10values[arraywith10valuescount]=new Array(val,desc,url);
                        arraywith10valuescount=arraywith10valuescount+1;
        }
        //********************************************************************************

        
        
        //for first level
        if ((doflag=="no") && (val.length==2))
        {
                ITEMS[splitvalarray[0]]=new Array(desc,url);
        }       
        

        if (doflag=="yes")
        {
var val1=replace(val,",","0");
var val2=replace(val,",","");
                        //calculate no of commas in val,this will give us the level************
                                         var noofcommascount=0;
                                         for (h=0;h<=val.length-1;h++)
                                         {
                                         if (val.charAt(h)==",")
                                         {
                                         noofcommascount=noofcommascount+1;
                                         }
                                         }
                        //*********************************************************
MENU_STYLES['onmouseover'][1][noofcommascount] = onmouseovrtxtcol;
MENU_STYLES['onmouseover'][3][noofcommascount] = onmouseovrbgndcol;
MENU_STYLES['onmouseout'][1][noofcommascount] = onmouseouttxtcol;                                                 
MENU_STYLES['onmouseout'][3][noofcommascount] = onmouseoutbgndcol;                                                
MENU_STYLES['onmousedown'][1][noofcommascount] = onmousedowntxtcol;                                               
MENU_STYLES['onmousedown'][3][noofcommascount] = onmousedownbgndcol;
MENU_POS['hide_delay'][noofcommascount] = globdelay;
MENU_POS['height'][noofcommascount]=globheight;
MENU_POS['width'][noofcommascount]=globwidth;
//defining classes for setting font-family,size etc*******
if (N6)
{
var x = document.styleSheets[0];
x.insertRule('PRE {font: 14px verdana}',x.cssRules.length);
x.insertRule(".m0l"+noofcommascount+"o {text-decoration : none; border : 1px solid grey}",x.cssRules.length);
x.insertRule(".m0l"+noofcommascount+"i {"+fontstyles+"}",x.cssRules.length);
}
else
{
 document.styleSheets[0].addRule(".m0l"+noofcommascount+"o", "text-decoration : none; border : 1px solid grey");
 document.styleSheets[0].addRule(".m0l"+noofcommascount+"i", fontstyles);
}
//**********************************************************



if (noofcommascount>1)
{
        MENU_POS['block_left'][noofcommascount] = globwidth+1;
        MENU_POS['block_top'][noofcommascount] = 0;
}
if (noofcommascount>0)
{
MENU_POS['left'][noofcommascount] = 0;
MENU_POS['top'][noofcommascount] = 0;//need not be 23,you can assign any number.
}

                                  
if (val.lastIndexOf(",")=="-1")
{
var substrextract=val;
}
else
{
var substrextract=val.substring(0,val.lastIndexOf(","));
}
var replacedstr=replace(substrextract,",","0");
var val1=replace(val,",","0");
ITEMS[val1]=new Array(desc,url);
mainarray[count]=replacedstr; 
fullmainarray[count]=val1;
mainarraywithcommas[fullmainarray[count]]=val;
count=count+1;
        }
}

function doCompare(a,b)
{
return a-b
}
 
function createmenu()
{
mainarray.sort(doCompare);
fullmainarray.sort(doCompare);
var count1=2;
                for (i=mainarray.length-1;i>=0;i--)
                {
                                        mainarray[i]=mainarray[i]+"";
                                         var len=mainarray[i].length;
                                         for (j=0;j<=fullmainarray.length-1;j++)
                                         {
                                         //calculate no of zeros in fullmainarray[j]************
                                         var noofzeroscount=0;
                                         for (u=0;u<=fullmainarray[j].length-1;u++)
                                         {
                                         if (fullmainarray[j].charAt(u)=="0")
                                         {
                                         noofzeroscount=noofzeroscount+1;
                                         }
                                         }
                                         //*********************************************************
                                         //calculate no of zeros in mainarray[i]************
                                         var noofzeroscounti=0;
                                         for (v=0;v<=mainarray[i].length-1;v++)
                                         {
                                         if (mainarray[i].charAt(v)=="0")
                                         {
                                         noofzeroscounti=noofzeroscounti+1;
                                         }
                                         }
                                         //*********************************************************
                                         
                                         
                                         splitarray=mainarraywithcommas[fullmainarray[j]].split(",");
                                                 if (mainarray[i]!=fullmainarray[j])
                                                {
                                                 fullmainarray[j]=fullmainarray[j]+"";
                                                           if ((fullmainarray[j].substring(0,len)==mainarray[i]) && (mainarray[i].length==(fullmainarray[j].length-noofzeroscount)-(splitarray[splitarray.length-1].length-noofzeroscounti)))
                                                           {
                                                           ITEMS[mainarray[i]][count1]=ITEMS[fullmainarray[j]];
                                                           count1=count1+1;
                                                           }
                                                  }
                                          }
count1=2;
                 }
                 populatemenuitems="true";
                 initmenu(globlevel,globheight,globwidth);
} 

function add10xitems()
{
for (p=0;p<=arraywith10values.length-1;p++)
{
var position=arraywith10values[p][0].substring(arraywith10values[p][0].lastIndexOf(",")+1,arraywith10values[p][0].length);
var substrextract=arraywith10values[p][0].substring(0,arraywith10values[p][0].lastIndexOf(","));
var replacedstr=replace(substrextract,",","0");
var replacedwholestr=replace(arraywith10values[p][0],",","0");
//change indexes
                for (r=ITEMS[replacedstr].length;r>=parseInt(position);r--)
                {
                        ITEMS[replacedstr][r+1]=ITEMS[replacedstr][r];
                }
ITEMS[replacedwholestr]=new Array(arraywith10values[p][1],arraywith10values[p][2]);
ITEMS[replacedstr][parseInt(position)+1]=ITEMS[replacedwholestr];
}
}

//menu_items.js from original ends here*****************************************************

