using System;
using System.Data;
using System.Reflection;
using System.Collections;
using System.Web;
using NHibernate;
using NHibernate.Cfg;
using NHibernate.Tool.hbm2ddl;

namespace WC.Common
{
    public class SessionFactory
    {
        public SessionFactory() { }

        private static ISessionFactory sessions;
        private static Configuration cfg;
        static readonly object padlock = new object();

        public static ISession OpenSession(string AssemblyName)
        {
            if (sessions == null)
            {
                lock (padlock)
                {
                    if (sessions == null)
                    {
                        BuildSessionFactory(AssemblyName);
                    }
                }
            }
            return sessions.OpenSession();
        }

        private static void BuildSessionFactory(string AssemblyName)
        {
            Hashtable ht = HttpContext.Current.Application["hbm"] as Hashtable;

            cfg = new Configuration();

            cfg.SetProperty("hibernate.connection.provider", ht["hibernate.connection.provider"] + "");
            cfg.SetProperty("hibernate.dialect", ht["hibernate.dialect"] + "");
            cfg.SetProperty("hibernate.connection.driver_class", ht["hibernate.connection.driver_class"] + "");
            cfg.SetProperty("hibernate.connection.connection_string", ht["hibernate.connection.connection_string"] + "");
            cfg.SetProperty("hibernate.cache.provider_class", ht["hibernate.cache.provider_class"] + "");
            cfg.SetProperty("hibernate.cache.use_query_cache", ht["hibernate.cache.use_query_cache"] + "");

            cfg.AddAssembly(AssemblyName);

            sessions = cfg.BuildSessionFactory();
        }
    }
}
