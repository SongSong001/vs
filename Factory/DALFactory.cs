using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Configuration;
using WC.IDAL;

namespace WC.Factory
{
    public class DALFactory
    {
        private static readonly string path = ConfigurationManager.AppSettings["WebDAL"];

        /// <summary>
        /// 获取Bas_ComDAL
        /// </summary>
        /// <returns>IBas_Com</returns>
        public static IBas_Com CreateBas_ComDAL()
        {
            string className = path + ".Bas_ComDAL";
            return (IBas_Com)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sys_DepDAL
        /// </summary>
        /// <returns>ISys_Dep</returns>
        public static ISys_Dep CreateSys_DepDAL()
        {
            string className = path + ".Sys_DepDAL";
            return (ISys_Dep)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sys_Dep_ModuleDAL
        /// </summary>
        /// <returns>ISys_Dep_Module</returns>
        public static ISys_Dep_Module CreateSys_Dep_ModuleDAL()
        {
            string className = path + ".Sys_Dep_ModuleDAL";
            return (ISys_Dep_Module)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sys_ModuleDAL
        /// </summary>
        /// <returns>ISys_Module</returns>
        public static ISys_Module CreateSys_ModuleDAL()
        {
            string className = path + ".Sys_ModuleDAL";
            return (ISys_Module)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sys_RoleDAL
        /// </summary>
        /// <returns>ISys_Role</returns>
        public static ISys_Role CreateSys_RoleDAL()
        {
            string className = path + ".Sys_RoleDAL";
            return (ISys_Role)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sys_Role_ModuleDAL
        /// </summary>
        /// <returns>ISys_Role_Module</returns>
        public static ISys_Role_Module CreateSys_Role_ModuleDAL()
        {
            string className = path + ".Sys_Role_ModuleDAL";
            return (ISys_Role_Module)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sys_UserDAL
        /// </summary>
        /// <returns>ISys_User</returns>
        public static ISys_User CreateSys_UserDAL()
        {
            string className = path + ".Sys_UserDAL";
            return (ISys_User)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取MailsDAL
        /// </summary>
        /// <returns>IMails</returns>
        public static IMails CreateMailsDAL()
        {
            string className = path + ".MailsDAL";
            return (IMails)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取FlowsDAL
        /// </summary>
        /// <returns>IFlows</returns>
        public static IFlows CreateFlowsDAL()
        {
            string className = path + ".FlowsDAL";
            return (IFlows)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Flows_ModelDAL
        /// </summary>
        /// <returns>IFlows_Model</returns>
        public static IFlows_Model CreateFlows_ModelDAL()
        {
            string className = path + ".Flows_ModelDAL";
            return (IFlows_Model)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Flows_ModelFileDAL
        /// </summary>
        /// <returns>IFlows_ModelFile</returns>
        public static IFlows_ModelFile CreateFlows_ModelFileDAL()
        {
            string className = path + ".Flows_ModelFileDAL";
            return (IFlows_ModelFile)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Flows_ModelStepDAL
        /// </summary>
        /// <returns>IFlows_ModelStep</returns>
        public static IFlows_ModelStep CreateFlows_ModelStepDAL()
        {
            string className = path + ".Flows_ModelStepDAL";
            return (IFlows_ModelStep)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Flows_StepDAL
        /// </summary>
        /// <returns>IFlows_Step</returns>
        public static IFlows_Step CreateFlows_StepDAL()
        {
            string className = path + ".Flows_StepDAL";
            return (IFlows_Step)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Flows_StepActionDAL
        /// </summary>
        /// <returns>IFlows_StepAction</returns>
        public static IFlows_StepAction CreateFlows_StepActionDAL()
        {
            string className = path + ".Flows_StepActionDAL";
            return (IFlows_StepAction)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取NoteBookDAL
        /// </summary>
        /// <returns>INoteBook</returns>
        public static INoteBook CreateNoteBookDAL()
        {
            string className = path + ".NoteBookDAL";
            return (INoteBook)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取PhoneBookDAL
        /// </summary>
        /// <returns>IPhoneBook</returns>
        public static IPhoneBook CreatePhoneBookDAL()
        {
            string className = path + ".PhoneBookDAL";
            return (IPhoneBook)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Docs_DocDAL
        /// </summary>
        /// <returns>IDocs_Doc</returns>
        public static IDocs_Doc CreateDocs_DocDAL()
        {
            string className = path + ".Docs_DocDAL";
            return (IDocs_Doc)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取News_TypeDAL
        /// </summary>
        /// <returns>INews_Type</returns>
        public static INews_Type CreateNews_TypeDAL()
        {
            string className = path + ".News_TypeDAL";
            return (INews_Type)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取News_ArticleDAL
        /// </summary>
        /// <returns>INews_Article</returns>
        public static INews_Article CreateNews_ArticleDAL()
        {
            string className = path + ".News_ArticleDAL";
            return (INews_Article)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Mails_DetailDAL
        /// </summary>
        /// <returns>IMails_Detail</returns>
        public static IMails_Detail CreateMails_DetailDAL()
        {
            string className = path + ".Mails_DetailDAL";
            return (IMails_Detail)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取CRM_ContactDAL
        /// </summary>
        /// <returns>ICRM_Contact</returns>
        public static ICRM_Contact CreateCRM_ContactDAL()
        {
            string className = path + ".CRM_ContactDAL";
            return (ICRM_Contact)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取CRMDAL
        /// </summary>
        /// <returns>ICRM</returns>
        public static ICRM CreateCRMDAL()
        {
            string className = path + ".CRMDAL";
            return (ICRM)Assembly.Load(path).CreateInstance(className);
        }



        /// <summary>
        /// 获取Docs_OfficeDAL
        /// </summary>
        /// <returns>IDocs_Office</returns>
        public static IDocs_Office CreateDocs_OfficeDAL()
        {
            string className = path + ".Docs_OfficeDAL";
            return (IDocs_Office)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取GovDAL
        /// </summary>
        /// <returns>IGov</returns>
        public static IGov CreateGovDAL()
        {
            string className = path + ".GovDAL";
            return (IGov)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Gov_DocDAL
        /// </summary>
        /// <returns>IGov_Doc</returns>
        public static IGov_Doc CreateGov_DocDAL()
        {
            string className = path + ".Gov_DocDAL";
            return (IGov_Doc)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Gov_ModelDAL
        /// </summary>
        /// <returns>IGov_Model</returns>
        public static IGov_Model CreateGov_ModelDAL()
        {
            string className = path + ".Gov_ModelDAL";
            return (IGov_Model)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Gov_ModelFileDAL
        /// </summary>
        /// <returns>IGov_ModelFile</returns>
        public static IGov_ModelFile CreateGov_ModelFileDAL()
        {
            string className = path + ".Gov_ModelFileDAL";
            return (IGov_ModelFile)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Gov_ModelStepDAL
        /// </summary>
        /// <returns>IGov_ModelStep</returns>
        public static IGov_ModelStep CreateGov_ModelStepDAL()
        {
            string className = path + ".Gov_ModelStepDAL";
            return (IGov_ModelStep)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Gov_RecipientDAL
        /// </summary>
        /// <returns>IGov_Recipient</returns>
        public static IGov_Recipient CreateGov_RecipientDAL()
        {
            string className = path + ".Gov_RecipientDAL";
            return (IGov_Recipient)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Gov_StepDAL
        /// </summary>
        /// <returns>IGov_Step</returns>
        public static IGov_Step CreateGov_StepDAL()
        {
            string className = path + ".Gov_StepDAL";
            return (IGov_Step)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Gov_StepActionDAL
        /// </summary>
        /// <returns>IGov_StepAction</returns>
        public static IGov_StepAction CreateGov_StepActionDAL()
        {
            string className = path + ".Gov_StepActionDAL";
            return (IGov_StepAction)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Flows_DocDAL
        /// </summary>
        /// <returns>IFlows_Doc</returns>
        public static IFlows_Doc CreateFlows_DocDAL()
        {
            string className = path + ".Flows_DocDAL";
            return (IFlows_Doc)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Docs_DocTypeDAL
        /// </summary>
        /// <returns>IDocs_DocType</returns>
        public static IDocs_DocType CreateDocs_DocTypeDAL()
        {
            string className = path + ".Docs_DocTypeDAL";
            return (IDocs_DocType)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取CRM_SupDAL
        /// </summary>
        /// <returns>ICRM_Sup</returns>
        public static ICRM_Sup CreateCRM_SupDAL()
        {
            string className = path + ".CRM_SupDAL";
            return (ICRM_Sup)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sys_SealDAL
        /// </summary>
        /// <returns>ISys_Seal</returns>
        public static ISys_Seal CreateSys_SealDAL()
        {
            string className = path + ".Sys_SealDAL";
            return (ISys_Seal)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Bas_ComType_ModuleDAL
        /// </summary>
        /// <returns>IBas_ComType_Module</returns>
        public static IBas_ComType_Module CreateBas_ComType_ModuleDAL()
        {
            string className = path + ".Bas_ComType_ModuleDAL";
            return (IBas_ComType_Module)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Bas_ComTypeDAL
        /// </summary>
        /// <returns>IBas_ComType</returns>
        public static IBas_ComType CreateBas_ComTypeDAL()
        {
            string className = path + ".Bas_ComTypeDAL";
            return (IBas_ComType)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取TipsDAL
        /// </summary>
        /// <returns>ITips</returns>
        public static ITips CreateTipsDAL()
        {
            string className = path + ".TipsDAL";
            return (ITips)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取ZEX1DAL
        /// </summary>
        /// <returns>IZEX1</returns>
        public static IZEX1 CreateZEX1DAL()
        {
            string className = path + ".ZEX1DAL";
            return (IZEX1)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取ZEX2DAL
        /// </summary>
        /// <returns>IZEX2</returns>
        public static IZEX2 CreateZEX2DAL()
        {
            string className = path + ".ZEX2DAL";
            return (IZEX2)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取ZEX3DAL
        /// </summary>
        /// <returns>IZEX3</returns>
        public static IZEX3 CreateZEX3DAL()
        {
            string className = path + ".ZEX3DAL";
            return (IZEX3)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取ZEX4DAL
        /// </summary>
        /// <returns>IZEX4</returns>
        public static IZEX4 CreateZEX4DAL()
        {
            string className = path + ".ZEX4DAL";
            return (IZEX4)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取ZEX5DAL
        /// </summary>
        /// <returns>IZEX5</returns>
        public static IZEX5 CreateZEX5DAL()
        {
            string className = path + ".ZEX5DAL";
            return (IZEX5)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取MeetingDAL
        /// </summary>
        /// <returns>IMeeting</returns>
        public static IMeeting CreateMeetingDAL()
        {
            string className = path + ".MeetingDAL";
            return (IMeeting)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取VoteDAL
        /// </summary>
        /// <returns>IVote</returns>
        public static IVote CreateVoteDAL()
        {
            string className = path + ".VoteDAL";
            return (IVote)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取VoteDetailDAL
        /// </summary>
        /// <returns>IVoteDetail</returns>
        public static IVoteDetail CreateVoteDetailDAL()
        {
            string className = path + ".VoteDetailDAL";
            return (IVoteDetail)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Work_AttendSetDAL
        /// </summary>
        /// <returns>IWork_AttendSet</returns>
        public static IWork_AttendSet CreateWork_AttendSetDAL()
        {
            string className = path + ".Work_AttendSetDAL";
            return (IWork_AttendSet)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Work_AttendDAL
        /// </summary>
        /// <returns>IWork_Attend</returns>
        public static IWork_Attend CreateWork_AttendDAL()
        {
            string className = path + ".Work_AttendDAL";
            return (IWork_Attend)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sys_UserLoginDAL
        /// </summary>
        /// <returns>ISys_UserLogin</returns>
        public static ISys_UserLogin CreateSys_UserLoginDAL()
        {
            string className = path + ".Sys_UserLoginDAL";
            return (ISys_UserLogin)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取TasksDAL
        /// </summary>
        /// <returns>ITasks</returns>
        public static ITasks CreateTasksDAL()
        {
            string className = path + ".TasksDAL";
            return (ITasks)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Tasks_TypeDAL
        /// </summary>
        /// <returns>ITasks_Type</returns>
        public static ITasks_Type CreateTasks_TypeDAL()
        {
            string className = path + ".Tasks_TypeDAL";
            return (ITasks_Type)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Tasks_UserDAL
        /// </summary>
        /// <returns>ITasks_User</returns>
        public static ITasks_User CreateTasks_UserDAL()
        {
            string className = path + ".Tasks_UserDAL";
            return (ITasks_User)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取PaperDownloadDAL
        /// </summary>
        /// <returns>IPaperDownload</returns>
        public static IPaperDownload CreatePaperDownloadDAL()
        {
            string className = path + ".PaperDownloadDAL";
            return (IPaperDownload)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取PaperTypeDAL
        /// </summary>
        /// <returns>IPaperType</returns>
        public static IPaperType CreatePaperTypeDAL()
        {
            string className = path + ".PaperTypeDAL";
            return (IPaperType)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取PaperDAL
        /// </summary>
        /// <returns>IPaper</returns>
        public static IPaper CreatePaperDAL()
        {
            string className = path + ".PaperDAL";
            return (IPaper)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Flows_Model_TypeDAL
        /// </summary>
        /// <returns>IFlows_Model_Type</returns>
        public static IFlows_Model_Type CreateFlows_Model_TypeDAL()
        {
            string className = path + ".Flows_Model_TypeDAL";
            return (IFlows_Model_Type)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Gov_Model_TypeDAL
        /// </summary>
        /// <returns>IGov_Model_Type</returns>
        public static IGov_Model_Type CreateGov_Model_TypeDAL()
        {
            string className = path + ".Gov_Model_TypeDAL";
            return (IGov_Model_Type)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取CarsDAL
        /// </summary>
        /// <returns>ICars</returns>
        public static ICars CreateCarsDAL()
        {
            string className = path + ".CarsDAL";
            return (ICars)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Cars_ActionDAL
        /// </summary>
        /// <returns>ICars_Action</returns>
        public static ICars_Action CreateCars_ActionDAL()
        {
            string className = path + ".Cars_ActionDAL";
            return (ICars_Action)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Cars_TypeDAL
        /// </summary>
        /// <returns>ICars_Type</returns>
        public static ICars_Type CreateCars_TypeDAL()
        {
            string className = path + ".Cars_TypeDAL";
            return (ICars_Type)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取C_GoodDAL
        /// </summary>
        /// <returns>IC_Good</returns>
        public static IC_Good CreateC_GoodDAL()
        {
            string className = path + ".C_GoodDAL";
            return (IC_Good)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取C_GoodActionDAL
        /// </summary>
        /// <returns>IC_GoodAction</returns>
        public static IC_GoodAction CreateC_GoodActionDAL()
        {
            string className = path + ".C_GoodActionDAL";
            return (IC_GoodAction)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取C_GoodTypeDAL
        /// </summary>
        /// <returns>IC_GoodType</returns>
        public static IC_GoodType CreateC_GoodTypeDAL()
        {
            string className = path + ".C_GoodTypeDAL";
            return (IC_GoodType)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取Sms_DataDAL
        /// </summary>
        /// <returns>ISms_Data</returns>
        public static ISms_Data CreateSms_DataDAL()
        {
            string className = path + ".Sms_DataDAL";
            return (ISms_Data)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取WorkLogDAL
        /// </summary>
        /// <returns>IWorkLog</returns>
        public static IWorkLog CreateWorkLogDAL()
        {
            string className = path + ".WorkLogDAL";
            return (IWorkLog)Assembly.Load(path).CreateInstance(className);
        }

        /// <summary>
        /// 获取SysHRDAL
        /// </summary>
        /// <returns>ISysHR</returns>
        public static ISysHR CreateSysHRDAL()
        {
            string className = path + ".SysHRDAL";
            return (ISysHR)Assembly.Load(path).CreateInstance(className);
        }

    }
}
