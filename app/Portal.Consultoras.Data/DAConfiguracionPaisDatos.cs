using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionPaisDatos : DataAccess
    {
        public DAConfiguracionPaisDatos(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetList(BEConfiguracionPaisDatos entity)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ListConfiguracionPaisDatos"))
            {
                Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
                Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.String, entity.ConfiguracionPaisID);
                Context.Database.AddInParameter(command, "Codigo", DbType.String, entity.ConfiguracionPais.Codigo);
                Context.Database.AddInParameter(command, "CodigoRegion", DbType.String, entity.ConfiguracionPais.Detalle.CodigoRegion);
                Context.Database.AddInParameter(command, "CodigoZona", DbType.String, entity.ConfiguracionPais.Detalle.CodigoZona);
                Context.Database.AddInParameter(command, "CodigoSeccion", DbType.String, entity.ConfiguracionPais.Detalle.CodigoSeccion);
                Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.ConfiguracionPais.Detalle.CodigoConsultora);


                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetListComponente(BEConfiguracionPaisDatos entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListConfiguracionPaisComponente");
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.String, entity.ConfiguracionPaisID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "PalancaCodigo", DbType.String, entity.ConfiguracionPais.Codigo);
            Context.Database.AddInParameter(command, "Componente", DbType.String, entity.Componente);

            return Context.ExecuteReader(command);
        }

        public IDataReader Get(BEConfiguracionPaisDatos entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionPaisDatos");
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "PalancaCodigo", DbType.String, entity.ConfiguracionPais.Codigo);
            Context.Database.AddInParameter(command, "Codigo", DbType.String, entity.Codigo);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetListComponenteDatos(BEConfiguracionPaisDatos entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListConfiguracionPaisComponenteDatos");
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.String, entity.ConfiguracionPaisID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "PalancaCodigo", DbType.String, entity.ConfiguracionPais.Codigo);
            Context.Database.AddInParameter(command, "Componente", DbType.String, entity.Componente);

            return Context.ExecuteReader(command);

        }

        public int Guardar(BEConfiguracionPaisDatos entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPaisDatos_Guardar");
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.Int32, entity.ConfiguracionPaisID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "Codigo", DbType.String, entity.Codigo);
            Context.Database.AddInParameter(command, "Valor1", DbType.String, entity.Valor1);
            Context.Database.AddInParameter(command, "Valor2", DbType.String, entity.Valor2);
            Context.Database.AddInParameter(command, "Valor3", DbType.String, entity.Valor3);
            Context.Database.AddInParameter(command, "Estado", DbType.String, entity.Estado);
            Context.Database.AddInParameter(command, "Componente", DbType.String, entity.Componente);

            Context.Database.AddOutParameter(command, "@respuesta", DbType.Int32, 1000);

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@respuesta"].Value);

        }

        public int ConfiguracionPaisComponenteDeshabilitar(BEConfiguracionPaisDatos entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPaisComponente_Deshabilitar");
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.String, entity.ConfiguracionPaisID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "Componente", DbType.String, entity.Componente);

            int result = Context.ExecuteNonQuery(command);
            return result;
        }
    }
}