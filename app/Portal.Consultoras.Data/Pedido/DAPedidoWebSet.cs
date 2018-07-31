using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.Pedido;

namespace Portal.Consultoras.Data.Pedido
{
    public class DAPedidoWebSet : DataAccess
    {
        public DAPedidoWebSet(int paisId)
            : base(paisId, EDbSource.Portal)
        { }

        public BEPedidoWebSet Obtener(int setId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.PedidoWebSet_Select"))
            {
                Context.Database.AddInParameter(command, "@SetId", DbType.Int32, setId);

                var reader = Context.ExecuteReader(command);

                var data = reader.MapToObject<BEPedidoWebSet>(nullable: true, closeReaderFinishing: true);
                return data;
            }
        }

        public IEnumerable<BEPedidoWebSetDetalle> ObtenerDetalles(int setId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.PedidoWebSetDetalle_Select"))
            {
                Context.Database.AddInParameter(command, "@SetId", DbType.Int32, setId);

                var reader = Context.ExecuteReader(command);

                var data = reader.MapToCollection<BEPedidoWebSetDetalle>(closeReaderFinishing: true);
                return data;
            }
        }

        /// <summary>
        /// Eliminar set por id
        /// </summary>
        /// <param name="setId"></param>
        /// <returns></returns>
        public int Eliminar(int setId)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.PedidoWebSet_Eliminar"))
            {
                Context.Database.AddInParameter(command, "@SetId", DbType.Int32, setId);

                var reader = Context.ExecuteReader(command);

                var data = reader.RecordsAffected;

                reader.Close();
                return data;
            }
        }

        public DateTime? ObtenerFechaInicioSets()
        {
            DateTime? response = null;

            using (var command = Context.Database.GetStoredProcCommand("dbo.ObtenerFechaInicioSets"))
            {
                var reader = Context.ExecuteReader(command);

                while (reader.Read())
                {
                    var resultReader = reader[0].ToString();
                    if (!resultReader.IsNullOrEmptyTrim())
                    {
                        var array = resultReader.Split('-');
                        if (array.Length > 0)
                        {
                            response = new DateTime(array[0].ToInt(), array[1].ToInt(), array[2].ToInt(), 0, 0, 0);
                        }
                    }
                }

                return response;
            }
        }
    }
}
