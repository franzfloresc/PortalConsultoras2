using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAHorario : DataAccess
    {
        public DAHorario(int paisID)
            : base(paisID, EDbSource.Portal)
        { }
        
        public BEHorario GetHorarioByCodigo(string codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetHorarioByCodigo");
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, codigo);

            BEHorario horario = null;
            using (var reader = Context.ExecuteReader(command))
            {
                if (reader.Read()) horario = new BEHorario(reader);
            }
            return horario;
        }

        public bool HorarioEstaDisponible(string codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.HorarioEstaDisponible");
            Context.Database.AddInParameter(command, "@CodigoHorario", DbType.String, codigo);

            return Convert.ToBoolean(Context.ExecuteScalar(command));
        }
    }
}
