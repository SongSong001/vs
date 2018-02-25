

var Control = null;
var Controls = null;

//默认格式
var DefautFormat = {
    Bold: false,
    Italic: false,
    Underline: false,
    FontSize: "10pt",
    FontName: "宋体",
    TextColor: "#000000"
};

//加载默认格式
Module.LoadDefaultFormat = function() {
//    if (ClientMode) {
//        var b = window.external.LocalSetting.GetValue("DefaultFormat");
//        if (b != "") {
//            try {
//                DefautFormat = Core.Utility.ParseJson(b)
//            } catch (a) { }
//        }
//    }
};
Module.LoadDefaultFormat();
//保存格式
Module.SaveDefaultFormat = function() {
//    if (ClientMode) {
//        window.external.LocalSetting.SetValue("DefaultFormat", Core.Utility.RenderJson(DefautFormat))
//    }
};

var PageTemp =
	"<html>\r\n" +
		"<head>\r\n" +
		"</head>\r\n" +
		"<body>\r\n" +
		"</body>\r\n" +
	"</html>\r\n";

var Fonts = [
	"宋体",
	"雅黑",
	"黑体",
	"隶书",
	"楷体",
	"幼圆",
	"Arial",
	"Courier New",
	"Times New Roman",
	"Verdana"
];

var Colors = ["#000000", "#0000FF", "#FF0000", "#00FF00", "#FFFF00", "#FF00FF", "#00FFFF", "#CCCC00", "#CC00CC", "#00CCCC", "#999900", "#990099"];

var HEX_NUM = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
for (var i = 15; i >= 0; i -= 3) {
    for (var j = 15; j >= 0; j -= 3) {
        var color = "#" + HEX_NUM[i] + HEX_NUM[i] + HEX_NUM[j] + HEX_NUM[j] + "FF";
        Colors[12 + (5 - i / 3) * 12 + 5 - j / 3] = color
    }
}
for (var i = 15; i >= 0; i -= 3) {
    for (var j = 15; j >= 0; j -= 3) {
        var color = "#" + HEX_NUM[i] + HEX_NUM[i] + HEX_NUM[j] + HEX_NUM[j] + "66";
        Colors[12 + (5 - i / 3) * 12 + 5 - j / 3 + 6] = color
    }
}

function init(completeCallback, errorCallback) {
    Core.LoadModules(
		function() {
		    Control = Core.GetModule("Controls.js").Control;

		    Controls = Core.GetModule("Controls.js");

		    completeCallback();
		},
		errorCallback,
		["Controls.js"]
	);
}

function SetNodeStyle(doc, node, name, value) {
    if (Core.Utility.IsTextNode(node)) {
        return node;
    }
    else {
        node.style[name] = value;

        for (var i = 0; i < node.childNodes.length; i++) {
            var cn = node.childNodes[i];
            if (!Core.Utility.IsTextNode(node)) {
                SetNodeStyle(doc, cn, name, value);
            }
        }

        return node;
    }
}

function SetStyle(doc, html, name, value) {
    var dom = doc.createElement("DIV");
    dom.innerHTML = html;

    for (var i = 0; i < dom.childNodes.length; i++) {
        var node = dom.childNodes[i];

        if (Core.Utility.IsTextNode(node)) {
            var span = doc.createElement("SPAN");
            span.style[name] = value;
            if (node.nodeValue != undefined) span.innerHTML = node.nodeValue.replace(/\</ig, function() { return "&lt;"; });
            else if (node.textContent != undefined) span.innetHTML = node.textContent.replace(/\</ig, function() { return "&lt;"; });
            dom.replaceChild(span, node);
        }
        else {
            SetNodeStyle(doc, node, name, value);
        }
    }

    return dom.innerHTML;
}

//表情窗口
var EmotionForm = (function() {
    var obj = {};

    var dom = document.createElement("DIV");
    dom.className = "EmotionForm";
    dom.id = Core.GenerateUniqueId();
    dom.style.display = "none";
    dom.style.width = "436px";
    dom.style.height = "175px";

    for (var y = 0; y < 6; y++) {
        for (var x = 0; x < 15; x++) {
            (function(x, y) {
                var emot_div = document.createElement("DIV");
                emot_div.className = "EmotUnit";
                Core.Utility.AttachButtonEvent(emot_div, "EmotUnit", "EmotUnit_hover", "EmotUnit_hover");
                emot_div.onmousedown = function(evt) {
                    Core.Utility.CancelBubble(evt == undefined ? window.event : evt);
                    obj.Close();
                    if (_callback != null) _callback(String.format("Public/Images/Emotion/e{0}.gif", y * 15 + x + 100));
                }
                dom.appendChild(emot_div);
            })(x, y)
        }
    }

    var _callback = null;

    obj.Popup = function(x, y, callback) {
        if (dom.style.display == "none") {
            Desktop.EnterMove("default");

            dom.style.left = Math.max(x, 0) + "px";
            dom.style.top = Math.max(y, 0) + "px";
            dom.style.display = "block";

            _callback = callback;
        }
    }

    obj.Close = function() {
        if (dom.style.display == "block") {
            dom.style.display = "none";
            Desktop.LeaveMove();
        }
    }

    obj.GetDom = function() {
        return dom;
    }

    obj.GetWidth = function() {
        return 436;
    }

    obj.GetHeight = function() {
        return 175;
    }

    document.body.appendChild(dom);

    Core.Utility.AttachEvent(
		document, "mousedown",
		function() {
		    obj.Close();
		}
	);

    return obj;
})();

//颜色选择窗口
var ColorSelForm = (function() {
    var obj = {};
    var dom = document.createElement("DIV");
    dom.className = "ColorSelForm";
    dom.id = Core.GenerateUniqueId();
    dom.style.display = "none";
    dom.style.width = "288px";
    dom.style.height = "144px";
    for (var e = 0; e < 6; e++) {
        for (var b = 0; b < 12; b++) {
            (function(f, h) {
                var g = document.createElement("DIV");
                g.className = "ColorUnit";
                g.innerHTML = "<div class='ColorPre'></div>";
                g.firstChild.style.backgroundColor = Colors[h * 12 + f];
                g.title = Colors[h * 12 + f];
                Core.Utility.AttachButtonEvent(g, "ColorUnit", "ColorUnit_hover", "ColorUnit_hover");
                g.onmousedown = function(k) {
                    Core.Utility.CancelBubble(k == undefined ? window.event : k);
                    obj.Close();
                    if (a != null) {
                        a(Colors[h * 12 + f])
                    }
                };
                dom.appendChild(g)
            })(b, e)
        }
    }
    Core.Utility.DisableSelect(dom, true);
    var a = null;
    obj.Popup = function(f, h, g) {
        if (dom.style.display == "none") {
            Desktop.EnterMove("default");
            dom.style.left = Math.max(f, 0) + "px";
            dom.style.top = Math.max(h, 0) + "px";
            dom.style.display = "block";
            a = g
        }
    };
    obj.Close = function() {
        if (dom.style.display == "block") {
            dom.style.display = "none";
            Desktop.LeaveMove()
        }
    };
    obj.GetDom = function() {
        return dom
    };
    obj.GetWidth = function() {
        return 288 + 2
    };
    obj.GetHeight = function() {
        return 144 + 2
    };
    document.body.appendChild(dom);
    Core.Utility.AttachEvent(document, "mousedown", function() {
        obj.Close()
    });
    return obj
})();

/*
config={
...：继承Controls
}
*/

function RichEditor(config) {
    var This = this;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    }

    This.is = function(type) { return type == This.GetType() ? true : Base.is(type); }
    This.GetType = function() { return "RichEditor"; }

    var m_Toolbar = new Controls.Toolbar(
		{
		    Left: 0, Top: 0, Width: This.GetClientWidth(), Height: 24,
		    BorderWidth: 0, Css: 'toolbar',
		    Parent: This,
		    AnchorStyle: Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top,
		    Text: "",
		    Items: [
				{ Css: "Image22_B", Text: "", Command: "B" },
				{ Css: "Image22_I", Text: "", Command: "I" },
				{ Css: "Image22_U", Text: "", Command: "U" },
				{ Type: "DropDownList", Width: 120 },
				{ Type: "DropDownList", Width: 50 },
				{ Type: "Image", Css: "Image22_TextColor", Text: "字体颜色", Command: "TextColor" },
				{ Type: "Image", Css: "Image22_BgColor", Text: "背景色", Command: "BgColor" },
				{ Type: "Image", Css: "Image22_Emotion", Text: "表情", Command: "AddEmotion" },
				{ Type: "Image", Css: "Image22_Clear", Text: "清除格式", Command: "Clear" },
				{ Type: "Image", Css: "Image22_Delete", Text: "清空", Command: "Empty" }
			]
		}
	);

    for (var i in Fonts) {
        m_Toolbar.GetControl(3).AddItem(Fonts[i]);
    }
    m_Toolbar.GetControl(3).SetValue(Fonts[0]);
    Core.Utility.DisableSelect(m_Toolbar.GetControl(3).GetDom(), true);
    Core.Utility.DisableSelect(m_Toolbar.GetControl(3).GetListDom(), true);

    m_Toolbar.GetControl(3).OnChanged.Attach(
		function() {
		    if (This.GetSelectionHtml() == "") {
		        DefautFormat.FontName = m_Toolbar.GetControl(3).GetValue();
		        ChangeFormat();
		        Module.SaveDefaultFormat()
		    } else {
		        m_EditorDoc.execCommand("FontName", false, m_Toolbar.GetControl(3).GetValue());
		    }
		}
	);

    for (var i = 12; i <= 24; i += 2) {
        m_Toolbar.GetControl(4).AddItem(i);
    }
    for (var i = 36; i <= 72; i += 12) {
        m_Toolbar.GetControl(4).AddItem(i);
    }
    m_Toolbar.GetControl(4).SetValue(12);
    Core.Utility.DisableSelect(m_Toolbar.GetControl(4).GetDom(), true);
    Core.Utility.DisableSelect(m_Toolbar.GetControl(4).GetListDom(), true);

    m_Toolbar.GetControl(4).OnChanged.Attach(
		function() {
		    if (This.GetSelectionHtml() == "") {
		        DefautFormat.FontSize = m_Toolbar.GetControl(4).GetText() + "pt";
		        ChangeFormat();
		        Module.SaveDefaultFormat()
		    } else {
		        var html = This.GetSelectionHtml();
		        This.SaveSelection();
		        This.ReplaceSaveSelection(SetStyle(m_EditorDoc, html, "fontSize", m_Toolbar.GetControl(4).GetText() + "pt"));
		    }
		}
	);
    var m_LastImagePath = "";

    m_Toolbar.OnCommand.Attach(
		function(command) {
		    switch (command) {
		        case "B":
		            {
		                if (This.GetSelectionHtml() == "") {
		                    DefautFormat.Bold = !DefautFormat.Bold;
		                    ChangeFormat();
		                    Module.SaveDefaultFormat()
		                } else {
		                    m_EditorDoc.execCommand("Bold", false, null);
		                    m_EditorWindow.focus();
		                }
		                break;
		            }
		        case "I":
		            {
		                if (This.GetSelectionHtml() == "") {
		                    DefautFormat.Bold = !DefautFormat.Italic;
		                    ChangeFormat();
		                    Module.SaveDefaultFormat()
		                } else {
		                    m_EditorDoc.execCommand("Italic", false, null);
		                    m_EditorWindow.focus();
		                }
		                break;
		            }
		        case "U":
		            {
		                if (This.GetSelectionHtml() == "") {
		                    DefautFormat.Bold = !DefautFormat.Underline;
		                    ChangeFormat();
		                    Module.SaveDefaultFormat()
		                } else {
		                    m_EditorDoc.execCommand("Underline", false, null);
		                    m_EditorWindow.focus();
		                }
		                break;
		            }
		        case "A":
		            {
		                m_EditorDoc.execCommand("CreateLink", false);
		                m_EditorWindow.focus();
		                break;
		            }
		        case "Clear":
		            {
		                var html = This.GetSelectionHtml();
		                This.SaveSelection();
		                var temp = m_EditorDoc.createElement("DIV");
		                temp.innerHTML = html;
		                This.ReplaceSaveSelection(Core.Utility.ClearHtml(temp));
		                break;
		            }
		        case "Empty":
		            {
		                This.SetValue("");
		                break;
		            }
		        case "AddEmotion":
		            {
		                var btnRect = Core.Utility.GetClientCoord(m_Toolbar.GetControl(5));
		                var bodyRect = Core.Utility.GetClientCoord(document.body);
		                var y = 0;
		                if (btnRect.Y - bodyRect.Y > EmotionForm.GetHeight()) y = btnRect.Y - bodyRect.Y - EmotionForm.GetHeight();
		                else y = btnRect.Y + m_Toolbar.GetControl(5).offsetHeight;

		                This.SaveSelection();

		                EmotionForm.Popup(
	                        btnRect.X - bodyRect.X - 300 + m_Toolbar.GetControl(5).offsetWidth,
	                        y,
	                        function(path) {
	                            var imgHTML = String.format(
	                            "<img src='download.aspx?FileName={0}'/>",
	                            escape(path)
	                            );
	                            if (!This.ReplaceSaveSelection(imgHTML)) {
	                                This.Append(imgHTML);
	                            }
	                        }
	                    );
		                break;
		            }
		        case "TextColor":
		            {
		                var btnRect = Core.Utility.GetClientCoord(m_Toolbar.GetControl(5));
		                var bodyRect = Core.Utility.GetClientCoord(document.body);
		                var y = 0;
		                if (btnRect.Y - bodyRect.Y > ColorSelForm.GetHeight()) y = btnRect.Y - bodyRect.Y - ColorSelForm.GetHeight();
		                else y = btnRect.Y + m_Toolbar.GetControl(5).offsetHeight;

		                This.SaveSelection();

		                ColorSelForm.Popup(btnRect.X - bodyRect.X - 240 + m_Toolbar.GetControl(5).offsetWidth, y, function(color) {
		                    if (This.GetSelectionHtml() == "") {
		                        DefautFormat.TextColor = color;
		                        ChangeFormat();
		                        Module.SaveDefaultFormat()
		                    } else {
		                        m_EditorDoc.execCommand("ForeColor", false, color)
		                    }
		                });
		                break;
		            }
		        case "BgColor":
		            {
		                var btnRect = Core.Utility.GetClientCoord(m_Toolbar.GetControl(5));
		                var bodyRect = Core.Utility.GetClientCoord(document.body);
		                var y = 0;
		                if (btnRect.Y - bodyRect.Y > ColorSelForm.GetHeight()) y = btnRect.Y - bodyRect.Y - ColorSelForm.GetHeight();
		                else y = btnRect.Y + m_Toolbar.GetControl(6).offsetHeight;

		                This.SaveSelection();

		                ColorSelForm.Popup(btnRect.X - bodyRect.X - 240 + m_Toolbar.GetControl(5).offsetWidth, y, function(color) {
		                    if (This.GetSelectionHtml() == "") {
		                        DefautFormat.BackColor = color;
		                        ChangeFormat();
		                        Module.SaveDefaultFormat()
		                    } else {
		                        m_EditorDoc.execCommand("BackColor", false, color)
		                    }
		                });
		                break;
		            }
		    }
		}
		);

    This.CreateFileHtml = function(paths) {
        var ret = "";
        for (var i in paths) {
            var aHTML = String.format(
		"<a href='download.los?FileName={{Accessory {0}}' target='_blank'>{1}</a>",
		escape(String.format("src='{0}'", paths[i])),
		Core.IO.Path.GetFileName(escape(paths[i]))
		);
            ret += aHTML;
        }
        return ret;
    }

    var m_Editor = new Editor();
    var m_Frame = m_Editor.GetFrame();
    var m_EditorDoc = m_Editor.GetFrame().contentWindow.document;
    var m_EditorWindow = m_Editor.GetFrame().contentWindow;

    if (Core.GetBrowser() == "Firefox") {
        m_Frame.onload = function() {
            m_EditorDoc.designMode = "on";
        }
    }
    else {
        m_EditorDoc.designMode = "on";
    }
    m_EditorDoc.open();
    m_EditorDoc.write(PageTemp);
    m_EditorDoc.close();

    Core.Utility.AttachEvent(
		m_EditorDoc, "mousedown",
		function() {
		    try {
		        if (m_EditorDoc.activeElement == null) {
		            m_EditorWindow.focus();
		        }
		        else {
		            m_EditorDoc.activeElement.focus();
		        }
		    }
		    catch (ex) {
		    }
		}
		);

    m_EditorDoc.onkeydown = function(e) {
        var evt = new Core.Event(e, m_EditorWindow);
        if (evt.GetEvent().keyCode == 116 || (evt.GetEvent().ctrlKey && evt.GetEvent().keyCode == 82)) {
            evt.GetEvent().keyCode = 0;
            evt.GetEvent().returnValue = false;
            return false;
        }
        if (evt.GetEvent().keyCode == 70 && evt.GetEvent().ctrlKey && !evt.GetEvent().altKey && !evt.GetEvent().shiftKey) {
            evt.GetEvent().keyCode = 0;
            evt.GetEvent().returnValue = false;
            return false;
        }
    }

    var range = null;

    This.SaveSelection = function() {
        if (Core.GetBrowser() == "IE") {
            range = m_EditorDoc.selection.createRange();
            if (range.parentElement().document != m_EditorDoc) {
                range = null;
            }
        }
        else if (Core.GetBrowser() == "Firefox" || Core.GetBrowser() == "Chrome") {
            var sel = m_EditorWindow.getSelection();
            if (sel.rangeCount > 0) range = sel.getRangeAt(0); else range = null;
        }
    }

    This.GetSelectionHtml = function() {
        if (Core.GetBrowser() == "IE") {
            var r = m_EditorDoc.selection.createRange();
            if (r.htmlText != undefined) return r.htmlText; else return "";
        }
        else if (Core.GetBrowser() == "Firefox" || Core.GetBrowser() == "Chrome") {
            var sel = m_EditorWindow.getSelection();
            if (sel.rangeCount > 0) {
                var r = null;
                r = sel.getRangeAt(0);
                return Core.Utility.GetInnerHTML(r.cloneContents().childNodes);
            }
            else {
                return "";
            }
        }
        else {
            return "";
        }
    }

    This.ReplaceSaveSelection = function(html) {
        if (range != null) {
            if (Core.GetBrowser() == "IE") {
                if (range.pasteHTML != undefined) {
                    range.select();
                    range.pasteHTML(html);
                    return true;
                }
            }
            else if (Core.GetBrowser() == "Firefox" || Core.GetBrowser() == "Chrome") {
                if (range.deleteContents != undefined && range.insertNode != undefined) {
                    var temp = m_EditorDoc.createElement("DIV");
                    temp.innerHTML = html;

                    var elems = [];
                    for (var i = 0; i < temp.childNodes.length; i++) {
                        elems.push(temp.childNodes[i]);
                    }

                    range.deleteContents();

                    for (var i in elems) {
                        temp.removeChild(elems[i]);
                        range.insertNode(elems[i]);
                    }
                    return true;
                }
            }
        }
        return false;
    }

    this.Blur = function() {
        m_Editor.Blur();
    }

    this.Append = function(content) {
        m_EditorDoc.body.innerHTML += content;
    }

    function Compare(w) {
        for (var v = 0; v < w.length; ) {
            var x = w.substr(v, 1);
            if (w.substr(v, 6).toLowerCase() == "&nbsp;") {
                v += 6
            } else {
                if (x == "\n" || x == "\r" || x == "\f" || x == "\t" || x == "\v" || x == " ") {
                    v++
                } else {
                    return false
                }
            }
        }
        return true
    }

    this.GetValue = function() {
        if (Compare(m_EditorDoc.body.innerHTML)) {
            return m_EditorDoc.body.innerHTML;
        }
        var v = "";
        v += String.format("font-family: {0};", DefautFormat.FontName);
        v += String.format("font-size: {0};", DefautFormat.FontSize);
        v += String.format("color: {0};", DefautFormat.TextColor);
        v += String.format("font-weight: {0};", DefautFormat.Bold ? "bold" : "normal");
        v += String.format("font-style: {0};", DefautFormat.Italic ? "italic" : "normal");
        v += String.format("text-decoration: {0};", DefautFormat.Underline ? "underline" : "none");
        return String.format("<div style='{0}; display:inline;'>{1}</div>", v, m_EditorDoc.body.innerHTML)
    }

    function ChangeFormat() {
        try {
            m_EditorDoc.body.style.fontFamily = DefautFormat.FontName;
            m_EditorDoc.body.style.fontSize = DefautFormat.FontSize;
            m_EditorDoc.body.style.color = DefautFormat.TextColor;
            m_EditorDoc.body.style.fontWeight = DefautFormat.Bold ? "bold" : "normal";
            m_EditorDoc.body.style.fontStyle = DefautFormat.Italic ? "italic" : "normal";
            m_EditorDoc.body.style.textDecoration = DefautFormat.Underline ? "underline" : "none"
        } catch (v) { }
    }
    this.SetValue = function(newValue) {
        if (newValue != undefined && newValue != null) {
            m_EditorDoc.body.innerHTML = newValue;
        }
    }

    this.Focus = function() {
        m_EditorWindow.focus();
    }

    this.GetDocument = function() {
        return m_EditorDoc;
    }

    this.GetFrame = function() {
        return m_Frame;
    }

    this.GetWindow = function() {
        return m_EditorWindow;
    }

    this.OnKeyDown = new Core.Delegate();

    Core.Utility.AttachEvent(
		m_EditorDoc,
		"keydown",
		function(evt) {
		    if (evt == undefined) evt = m_EditorWindow.event;
		    This.OnKeyDown.Call(evt);
		}
	);

    if (config.StyleSheet)
        m_Editor.Link("StyleSheet", config.StyleSheet, "text/css");

    This.SetCss("richEditor");

    function Editor() {
        var editor = this;

        var editorConfig = {
            Left: 0, Top: 24, Width: This.GetClientWidth(), Height: This.GetClientHeight() - 24,
            BorderWidth: 0, Css: 'editor',
            Parent: This,
            AnchorStyle: Controls.AnchorStyle.All
        };

        Controls.Frame.call(this, editorConfig);

        var Base = {
            GetType: this.GetType,
            is: this.is
        }

        editor.is = function(type) { return type == this.GetType() ? true : Base.is(type); }
        editor.GetType = function() { return "RichEditor.Editor"; }
    }

}


Module.RichEditor = RichEditor;
		