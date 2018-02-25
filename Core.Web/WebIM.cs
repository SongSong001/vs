using Core;
using System;
using System.Collections;
using System.Threading;
using System.Web;

public class WebIM : CommandHandler
{
    public WebIM(HttpContext context, string sessionId, string id, string data) : base(context, sessionId, id, data)
    {
    }

    public override string Process()
    {
        Hashtable param = Utility.ParseJson(base.Data) as Hashtable;
        string action = param["Action"] as string;
        if (action != "NewMessage")
        {
            throw new NotImplementedException();
        }
        Thread.Sleep(0x3e8);
        string receiver = param["Receiver"] as string;
        string sender = param["Sender"] as string;
        string content = param["Content"] as string;
        return Utility.RenderJson(MessageImpl.Instance.NewMessage(receiver, sender, content, param));
    }

    public override void Process(object data)
    {
        throw new NotImplementedException();
    }
}

