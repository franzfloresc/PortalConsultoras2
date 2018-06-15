using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System.Data;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DABotmakerApiLog : DataAccess
    {
        public DABotmakerApiLog(int paisID) : base(paisID, EDbSource.Portal) { }

        public void Insert(DEChatbotProactivaResultado resultado)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.InsertBotmakerApiLog"))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandTimeout = 30;

                Context.Database.AddInParameter(command, "@Url", DbType.String, resultado.Url ?? "");
                Context.Database.AddInParameter(command, "@Exitoso", DbType.Boolean, resultado.Exitoso);
                Context.Database.AddInParameter(command, "@RespuestaBotmaker", DbType.String, resultado.Respuesta ?? "");
                Context.Database.AddInParameter(command, "@ErrorLog", DbType.String, resultado.ErrorLog ?? "");
                
                var parDetalle = new SqlParameter("@Detalle", SqlDbType.Structured)
                {
                    TypeName = "dbo.BotmakerApiLogDetalleType",
                    Value = new GenericDataReader<DEChatbotProactivaMensaje>(resultado.ListMensaje)
                };
               
                command.Parameters.Add(parDetalle);
                
                Context.ExecuteNonQuery(command);
            }
        }
    }
}