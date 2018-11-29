using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities.ProgramaNuevas;

namespace Portal.Consultoras.Data.ProgramaNuevas
{
    public class DAPremioNuevas : DataAccess
    {
        public DAPremioNuevas(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader ListarPremioNuevasPaginado(BEPremioNuevas entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.SP_ListarActivarPremioNuevas"))
            {
                Context.Database.AddInParameter(command, "@PageNumber", DbType.Int32, entidad.NumeroPagina);
                Context.Database.AddInParameter(command, "@RowspPage", DbType.Int32, entidad.FilasPorPagina);
                Context.Database.AddInParameter(command, "@SortDirection", DbType.String, entidad.SortDirection);
                Context.Database.AddInParameter(command, "@SortColumn", DbType.String, entidad.SortColumna);
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@AnoCampana", DbType.Int32, entidad.AnoCampanaIni);
                Context.Database.AddInParameter(command, "@Nivel", DbType.String, entidad.Nivel);
                Context.Database.AddInParameter(command, "@Active", DbType.Boolean, entidad.Active);

                return Context.ExecuteReader(command);
            }

        }
        public IDataReader Editar(BEPremioNuevas entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.SP_EditarActivarPremioNuevas"))
            {
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@AnoCampana", DbType.Int32, entidad.AnoCampanaIni);
                Context.Database.AddInParameter(command, "@AnoCampaniaFin", DbType.Int32, entidad.AnoCampanaFin);
                Context.Database.AddInParameter(command, "@Nivel", DbType.String, entidad.Nivel);
                Context.Database.AddInParameter(command, "@ActiveTooltip", DbType.Boolean, entidad.ActiveTooltip);
                Context.Database.AddInParameter(command, "@ActiveTooltipMonto", DbType.Boolean, entidad.ActiveTooltipMonto);
                Context.Database.AddInParameter(command, "@Active", DbType.Boolean, entidad.Active);
                Context.Database.AddInParameter(command, "@IND_CUPO_ELEC", DbType.Boolean, entidad.Ind_Cupo_Elec);
                Context.Database.AddInParameter(command, "@IdActivarPremioNuevas", DbType.Int32, entidad.IdActivarPremioNuevas);

                return Context.ExecuteReader(command);
            }

        }
        public IDataReader Insertar(BEPremioNuevas entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.SP_RegistarActivarPremioNuevas"))
            {
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@AnoCampana", DbType.Int32, entidad.AnoCampanaIni);
                Context.Database.AddInParameter(command, "@AnoCampaniaFin", DbType.Int32, entidad.AnoCampanaFin);
                Context.Database.AddInParameter(command, "@Nivel", DbType.String, entidad.Nivel);
                Context.Database.AddInParameter(command, "@ActiveTooltip", DbType.String, entidad.ActiveTooltip);
                Context.Database.AddInParameter(command, "@ActiveTooltipMonto", DbType.Boolean, entidad.ActiveTooltipMonto);
                Context.Database.AddInParameter(command, "@Active", DbType.Boolean, entidad.Active);
                Context.Database.AddInParameter(command, "@IND_CUPO_ELEC", DbType.Boolean, entidad.Ind_Cupo_Elec);
                return Context.ExecuteReader(command);
            }

        }


    }
}
