namespace Portal.Consultoras.Data.Estrategia
{
    using System.Collections.Generic;
    using System.Data;
    using Portal.Consultoras.Common;
    using Portal.Consultoras.Entities.Estrategia;



    public class EstrategiaDataAccess : DataAccess
    {
        public EstrategiaDataAccess(int paisID) : base(paisID, EDbSource.Portal) { }

        public List<EstrategiaProductoSet> ObtenerProductoEstrategia(int Campania, string CodigoConsultora, string TipoConsulta, string Texto, int CantidadResultado)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.ObtenerProductoEstrategia"))
            {
                Context.Database.AddInParameter(command, "@Campania", DbType.Int32, Campania);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
                Context.Database.AddInParameter(command, "@TipoConsulta", DbType.String, TipoConsulta);
                Context.Database.AddInParameter(command, "@Texto", DbType.String, Texto);
                Context.Database.AddInParameter(command, "@CantidadResultado", DbType.Int32, CantidadResultado);
                var reader = Context.ExecuteReader(command);
                return reader.MapToCollection<EstrategiaProductoSet>(closeReaderFinishing: true);
            }
        }
    }
}
