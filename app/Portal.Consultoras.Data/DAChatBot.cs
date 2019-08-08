using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAChatBot : DataAccess
    {
        public DAChatBot(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader ChatBotListResultados(BEChatBotListResultados p)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("chatbot.ListResultados");
            Context.Database.AddInParameter(command, "@Pais", DbType.AnsiString, p.Pais);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, p.CodigoConsultora);
            Context.Database.AddInParameter(command, "@NombreOperador", DbType.AnsiString, p.NombreOperador);
            Context.Database.AddInParameter(command, "@FechaInicio", DbType.Date, p.FechaInicio);
            Context.Database.AddInParameter(command, "@FechaFin", DbType.Date, p.FechaFin);
            return Context.ExecuteReader(command);
        }
    
        public int ChatBotInsertResultados(BEChatBotInsertResultadosRequest p)
        {
            
            DbCommand command = Context.Database.GetStoredProcCommand("chatbot.InsertResultados");
            Context.Database.AddInParameter(command, "@OperadorID", DbType.AnsiString, p.OperadorID);
            Context.Database.AddInParameter(command, "@NombreOperador", DbType.AnsiString, p.NombreOperador);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, p.CodigoConsultora);
            Context.Database.AddInParameter(command, "@NombreConsultora", DbType.AnsiString, p.NombreConsultora);
            Context.Database.AddInParameter(command, "@FechaInicio", DbType.DateTime, p.FechaInicio);
            Context.Database.AddInParameter(command, "@Campania", DbType.AnsiString, p.Campania);
            Context.Database.AddInParameter(command, "@Pais", DbType.AnsiString, p.Pais);
            Context.Database.AddInParameter(command, "@ConversacionID", DbType.AnsiString, p.ConversacionID);
            Context.Database.AddInParameter(command, "@CanalID", DbType.Int32, p.CanalID);
            Context.Database.AddOutParameter(command, "@new_identity", DbType.Int32, 1000);

            Context.ExecuteNonQuery(command);

           return Convert.ToInt32(command.Parameters["@new_identity"].Value);

        }

        public bool ChatBotUpdateResultados(BEChatBotInsertDetalleResultadosRequest p)
        {
            bool iresult = false;
            DbCommand command = Context.Database.GetStoredProcCommand("chatbot.UpdateResultados");
            Context.Database.AddInParameter(command, "@ResultadosID", DbType.AnsiString, p.ResultadosID);
            Context.Database.AddInParameter(command, "@FechaFin", DbType.DateTime, p.FechaFin);

            try
            {
                iresult = Context.ExecuteNonQuery(command) == 1 ? true : false;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            return iresult;

        }

        public bool ChatBotInsertDetalleResultados(BEChatBotInsertDetalleResultadosRequest.RespuestasModel p)
        {
            bool iresult = false;
            DbCommand command = Context.Database.GetStoredProcCommand("chatbot.InsertDetalleResultados");
            Context.Database.AddInParameter(command, "@ResultadosID", DbType.AnsiString, p.ResultadosID);
            Context.Database.AddInParameter(command, "@PreguntaID", DbType.AnsiString, p.PreguntaID);
            Context.Database.AddInParameter(command, "@CalificacionID", DbType.AnsiString, p.CalificacionID);
            Context.Database.AddInParameter(command, "@Cualitativo", DbType.AnsiString, p.Cualitativo);

            try
            {                
                iresult = Context.ExecuteNonQuery(command) == 1 ? true : false;                         
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            return iresult;
     
        }



    }
}