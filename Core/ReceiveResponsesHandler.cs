namespace Core
{
    using System;
    using System.Threading;
    using System.Web;

    public class ReceiveResponsesHandler : IHttpAsyncHandler, IHttpHandler
    {
        private HttpContext m_Context = null;

        IAsyncResult IHttpAsyncHandler.BeginProcessRequest(HttpContext context, AsyncCallback cb, object extraData)
        {
            this.m_Context = context;
            string sessionId = context.Request.Params["SessionID"];
            string clientVersion = context.Request.Params["ClientVersion"];
            string serverVersion = context.Request.Params["ServerVersion"];
            ResponsesListener asyncResult = new ResponsesListener(sessionId, cb, extraData);
            try
            {
                if (serverVersion != ServerImpl.Instance.Version)
                {
                    throw new IncompatibleException();
                }
                if (!(string.IsNullOrEmpty(clientVersion) || !(clientVersion != "1.0.1.7")))
                {
                    throw new IncompatibleException();
                }
                string username = ServerImpl.Instance.GetUserName(context);
                if (string.IsNullOrEmpty(username))
                {
                    throw new UnauthorizedException();
                }
                if (SessionManagement.Instance.GetAccountState(username).Receive(sessionId, asyncResult))
                {
                    ThreadPool.QueueUserWorkItem(new WaitCallback(asyncResult.Complete));
                }
            }
            catch (Exception ex)
            {
                asyncResult.Cache(Utility.RenderHashJson(new object[] { "IsSucceed", false, "Exception", ex }));
                ThreadPool.QueueUserWorkItem(new WaitCallback(asyncResult.Complete));
            }
            return asyncResult;
        }

        void IHttpAsyncHandler.EndProcessRequest(IAsyncResult result)
        {
            (result as ResponsesListener).Send(this.m_Context);
        }

        void IHttpHandler.ProcessRequest(HttpContext context)
        {
        }

        bool IHttpHandler.IsReusable
        {
            get
            {
                return true;
            }
        }
    }
}

