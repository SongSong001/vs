
Core.main = parent;// (parent == window ? window.external.Desktop : parent);

Core.Taskbar = Core.main.Core.Taskbar;
Core.Desktop = Core.main.Core.Desktop;
Core.Login = Core.main.Core.Login;

function SetClientMode(cm, win) {
    ClientMode = cm;
    CurrentWindow = win;

    document.oncontextmenu = function() { return false; }

    if (Core.GetBrowser() == "IE") {
        try {
            document.execCommand("BackgroundImageCache", false, true);
        }
        catch (ex) {
        }
    }

    var enableSelTag = {
        "TEXTAREA": "",
        "INPUT": ""
    };

    document.onselectstart = function(evt) {
        var e = new Core.Event(evt, window);
        return (e.GetTarget().tagName != undefined && enableSelTag[e.GetTarget().tagName.toUpperCase()] != undefined)
    }

    Core.Utility.AttachEvent(
		document, "keydown",
		function() {
		    //当按下刷新时
		    if (event.keyCode == 116 || (event.ctrlKey && event.keyCode == 82)) {
		        event.keyCode = 0;
		        event.returnValue = false;
		        return false;
		    }
		    if (event.keyCode == 70 && event.ctrlKey && !event.altKey && !event.shiftKey) {
		        event.keyCode = 0;
		        event.returnValue = false;
		        return false;
		    }
		}
	);

    if (!ClientMode) {
        Core.Utility.AttachEvent(
			document, "mousedown",
			function() {
			    CurrentWindow.BringToTop();
			}
		);
    }

    if (ClientMode) {
        Core.CreateWindow = function (config) {
            var _config = {};
            _config.Left = Core.Utility.IsNull(config.Left, 100);
            _config.Top = Core.Utility.IsNull(config.Top, 100);
            _config.Width = Core.Utility.IsNull(config.Width, 400);
            _config.Height = Core.Utility.IsNull(config.Height, 300);
            _config.MinWidth = Core.Utility.IsNull(config.MinWidth, Math.min(_config.Width, 400));
            _config.MinHeight = Core.Utility.IsNull(config.MinHeight, Math.min(_config.Height, 300));
            _config.HasMinButton = Core.Utility.IsNull(config.HasMinButton, true);
            _config.HasMaxButton = Core.Utility.IsNull(config.HasMaxButton, true);
            _config.Resizable = Core.Utility.IsNull(config.Resizable, true);
            _config.Css = Core.Utility.IsNull(config.Css, "window");
            _config.BorderWidth = Core.Utility.IsNull(config.BorderWidth, 6);
            _config.ShowInTaskbar = Core.Utility.IsNull(config.ShowInTaskbar, _config.HasMinButton);
            _config.Tag = Core.Utility.IsNull(config.Tag, null);

            if (config.Title == undefined) {
                _config.Title = {
                    Height: 18,
                    InnerHTML: ""
                };
            }
            else {
                _config.Title = {};
                _config.Title.Height = Core.Utility.IsNull(config.Title.Height, 18);
                _config.Title.InnerHTML = Core.Utility.IsNull(config.Title.InnerHTML, "");
            }

            _config.OnClose = Core.Utility.IsNull(config.OnClose, null);

            var win = null;// window.external.CreateWindow(_config);
            Core.Session.GetGlobal("WindowManagement").Add(win);
            win.OnClosed.Attach(function (w) { Core.Session.GetGlobal("WindowManagement").Remove(w); });
            return win;
        }

       // Core.Session = window.external.Session;
        //Core.OutputPanel = window.external.Desktop.Core.OutputPanel;
    }
    else {
        Core.CreateWindow = parent.Core.CreateWindow;
        Core.Session = parent.Core.Session;
        Core.OutputPanel = parent.Core.OutputPanel;
    }

    Core.Initialize(
		{},
		function() {
		    if (window.init != undefined) window.init();
		}
	);
    return true;
}
/*
调用的页面必须实现init方法
*/