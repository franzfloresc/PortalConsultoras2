using Portal.Consultoras.Entities.Pedido;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DADireccionEntega : DataAccess
    {
        public DADireccionEntega(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader Insertar(BEDireccionEntrega direccion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarDireccionEntrega");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, direccion.ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, direccion.CampaniaID);
            Context.Database.AddInParameter(command, "@CampaniaAnteriorID", DbType.Int32, direccion.CampaniaAnteriorID);
            Context.Database.AddInParameter(command, "@CiudadID", DbType.Int32, direccion.CiudadID);
            Context.Database.AddInParameter(command, "@ComunaID", DbType.Int32, direccion.ComunaID);
            Context.Database.AddInParameter(command, "@CiudadAnteriorID", DbType.Int32, direccion.CiudadAnteriorID);
            Context.Database.AddInParameter(command, "@ComunaAnteriorID", DbType.Int32, direccion.ComunaAnteriorID);
            Context.Database.AddInParameter(command, "@DireccionAnterior", DbType.String, direccion.DireccionAnterior);
            Context.Database.AddInParameter(command, "@Direccion", DbType.String, direccion.Direccion);
            Context.Database.AddInParameter(command, "@Referencia", DbType.String, direccion.Referencia);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, direccion.CodigoConsultora);
            Context.Database.AddInParameter(command, "@NombreConsultora", DbType.String, direccion.NombreConsultora);
            Context.Database.AddInParameter(command, "@LatitudAnterior", DbType.Int32, direccion.LatitudAnterior);
            Context.Database.AddInParameter(command, "@LongitudAnterior", DbType.Int32, direccion.LongitudAnterior);
            Context.Database.AddInParameter(command, "@Latitud", DbType.Int32, direccion.Latitud);
            Context.Database.AddInParameter(command, "@Longitud", DbType.Int32, direccion.Longitud);
            return Context.ExecuteReader(command);
        }
        public IDataReader Editar(BEDireccionEntrega direccion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.EditarDireccionEntrega");
            Context.Database.AddInParameter(command, "@DireccionEntregaID", DbType.Int32, direccion.DireccionEntregaID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, direccion.CampaniaID);
            Context.Database.AddInParameter(command, "@CampaniaAnteriorID", DbType.Int32, direccion.CampaniaAnteriorID);
            Context.Database.AddInParameter(command, "@CiudadID", DbType.Int32, direccion.CiudadID);
            Context.Database.AddInParameter(command, "@ComunaID", DbType.Int32, direccion.ComunaID);
            Context.Database.AddInParameter(command, "@CiudadAnteriorID", DbType.Int32, direccion.CiudadAnteriorID);
            Context.Database.AddInParameter(command, "@ComunaAnteriorID", DbType.Int32, direccion.ComunaAnteriorID);
            Context.Database.AddInParameter(command, "@DireccionAnterior", DbType.String, direccion.DireccionAnterior);
            Context.Database.AddInParameter(command, "@Direccion", DbType.String, direccion.Direccion);
            Context.Database.AddInParameter(command, "@Referencia", DbType.String, direccion.Referencia);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, direccion.CodigoConsultora);
            Context.Database.AddInParameter(command, "@NombreConsultora", DbType.String, direccion.NombreConsultora);
            Context.Database.AddInParameter(command, "@LatitudAnterior", DbType.Int32, direccion.LatitudAnterior);
            Context.Database.AddInParameter(command, "@LongitudAnterior", DbType.Int32, direccion.LongitudAnterior);
            Context.Database.AddInParameter(command, "@Latitud", DbType.Int32, direccion.Latitud);
            Context.Database.AddInParameter(command, "@Longitud", DbType.Int32, direccion.Longitud);
            return Context.ExecuteReader(command);
        }
    }
}
