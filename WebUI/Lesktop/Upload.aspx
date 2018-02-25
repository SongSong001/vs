<%@ Page Language="C#" AutoEventWireup="true" Inherits="Upload" %>

<%@ Register Src="Script/SubScript.ascx" TagName="SubScript" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>无标题页</title>
    <uc1:SubScript ID="SubScript1" runat="server" />
    <style type="text/css">
        html
        {
            padding: 0px;
            margin: 0px;
            overflow: hidden;
            border: 0px;
        }
        body
        {
            padding: 6px;
            margin: 0px;
            background-color: #EFF0F2;
            overflow: hidden;
            font-family: 宋体;
            font-size: 12px;
            border: 0px;
        }
        #UploadFile
        {
            width: 100%;
        }
        #BtnOk
        {
            font-family: 宋体;
            font-size: 12px;
            height: 24px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function init() {
            var data_str = document.getElementById("data").value;
            if (data_str != "") {
                var data = Core.Utility.ParseJson(data_str);
                if (data.Result) CurrentWindow.GetTag().AfterUpload(data.Path);
                else Core.Utility.ShowError(data.Exception.toString());
            }
        }
        //增加图片判断
        function BtnOk_onclick() {
            if (Core.Params["Type"] != undefined && Core.Params["Type"] == "Img") {
                var objFileUpload = document.getElementById('UploadFile'); //FileUpload
                var fileName = new String(objFileUpload.value); //文件名
                var extension = new String(fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length)); //文件扩展名
                if (extension.toUpperCase() == "JPG" || extension.toUpperCase() == "GIF"
                || extension.toUpperCase() == "JPEG" || extension.toUpperCase() == "PMG"
                || extension.toUpperCase() == "PNG" || extension.toUpperCase() == "JPE" || extension.toUpperCase() == "BMP")//你可以添加扩展名 
                {
                }
                else {
                    Core.Utility.ShowWarning("请选择正确的图片格式!正确格式包含(.JPG|.GIF|.JPEG|.PMG|.PNG|.JPE|.BMP)");
                    return false;
                }
            }
            if (document.getElementById("UploadFile").value == "") {
                Core.Utility.ShowWarning("请选择要上传的文件！");
                return false;
            }
            CurrentWindow.Waiting("正在上传文件...");
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="divMsg">
        </div>
        <br />
        <asp:FileUpload ID="UploadFile" runat="server" /></div>
    <div style="text-align: right; margin-top: 12px;">
        <input id="BtnOk" name="BtnOk" type="submit" value="确 定" onclick="return BtnOk_onclick()" /></div>
    <input runat="server" type="hidden" id="data" name="data" />

    <script>
        if (Core.Params["Type"] != undefined && Core.Params["Type"] == "Img") {
            if (document.getElementById("divMsg") != undefined)
                document.getElementById("divMsg").innerHTML = "图片格式|*.png;*.gif;*.jpg;*.jpeg;*.bmp;*.jpe";
        }
    </script>

    </form>
</body>
</html>
