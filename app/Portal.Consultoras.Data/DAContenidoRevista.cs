using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.Data
{
    public class DAContenidoRevista:DataAccess
    {
        public DAContenidoRevista() {}
        public DAContenidoRevista(int paisId):base(paisId,EDbSource.Portal) {}

        public int Insertar(string nroCompania,string rutaImagenPortada)
        {
            int result;
            using (var storedProcCommand = Context.Database.GetStoredProcCommand("InsertContenidoRevista"))
            {
                Context.Database.AddInParameter(storedProcCommand, "@NroCampania", DbType.String, nroCompania);
                Context.Database.AddInParameter(storedProcCommand, "@RutaImagenPortada", DbType.String, rutaImagenPortada);
                var tempResult = Context.Database.ExecuteScalar(storedProcCommand);
                result=tempResult == null ? 0 : Convert.ToInt32(tempResult);
            }
            return result;
        }
        public int ActualizarById(int id,string rutaImagenPortada)
        {
            int result;
            using (var storedProcCommand = Context.Database.GetStoredProcCommand("UpdateContenidoRevista"))
            {
                Context.Database.AddInParameter(storedProcCommand, "@Id", DbType.Int32, id);
                Context.Database.AddInParameter(storedProcCommand, "@RutaImagenPortada", DbType.String, rutaImagenPortada);
                result = Context.Database.ExecuteNonQuery(storedProcCommand);
            }
            return result;
        }
        public int EliminarById(int id)
        {
            int result;
            using (var storedProcCommand = Context.Database.GetStoredProcCommand("DeleteContenidoRevistaById"))
            {
                Context.Database.AddInParameter(storedProcCommand, "@Id", DbType.Int32,id);
                result = Context.Database.ExecuteNonQuery(storedProcCommand);
            }
            return result;
        }
        public BEContenidoRevista ObtenerByCampania(string campania)
        {
            BEContenidoRevista result=null;
            using (var storedProcCommand = Context.Database.GetStoredProcCommand("SelectContenidoRevistaByCampania"))
            {
                Context.Database.AddInParameter(storedProcCommand, "@NroCampania", DbType.String, campania);
                using (var executeReader = Context.Database.ExecuteReader(storedProcCommand))
                {
                    if(executeReader.Read())
                    {
                        result = new BEContenidoRevista {
                            Id = GetDataValue<Int32>(executeReader, "Id"),
                            NroCampania = GetDataValue<String>(executeReader, "NroCampania"),
                            RutaImagenPortada = GetDataValue<String>(executeReader, "RutaImagenPortada")
                        };
                    }
                }
            }
            return result;
        }
        public BEContenidoRevista ObtenerById(int id)
        {
            BEContenidoRevista result =null;
            using (var storedProcCommand = Context.Database.GetStoredProcCommand("SelectContenidoRevistaById"))
            {
                Context.Database.AddInParameter(storedProcCommand, "@Id", DbType.Int32, id);
                using (var executeReader = Context.Database.ExecuteReader(storedProcCommand))
                {
                    if (executeReader.Read())
                    {
                        result = new BEContenidoRevista
                            {
                                Id = GetDataValue<Int32>(executeReader, "Id"),
                                NroCampania = GetDataValue<String>(executeReader, "NroCampania"),
                                RutaImagenPortada = GetDataValue<String>(executeReader, "RutaImagenPortada")
                            };
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// Obtiene listado contenido revista paginado desde la base de datos.
        /// </summary>
        /// <param name="campania">Campaña.</param>
        /// <param name="pageSize">Tamaño de la página.</param>
        /// <param name="pageNum">Página a consultar.</param>
        /// <param name="totalRows">El total de registros coincidentes con el filtro.</param>
        /// <returns>Listado contenido revista.</returns>
        public IList<BEContenidoRevista> ObtenerByCampania(string campania,int pageSize,int pageNum,out int totalRows)
        {
            IList<BEContenidoRevista> result = new List<BEContenidoRevista>();
            totalRows = 0;
            using (var storedProcCommand = Context.Database.GetStoredProcCommand("SelectContenidoRevistaByCampaniaPaging"))
            {
                Context.Database.AddInParameter(storedProcCommand, "@NroCampania", DbType.String, String.IsNullOrEmpty(campania) ? DBNull.Value : (object)campania);
                Context.Database.AddInParameter(storedProcCommand, "@PageSize", DbType.Int32, pageSize);
                Context.Database.AddInParameter(storedProcCommand, "@PageNum", DbType.Int32,pageNum);
                using (var executeReader = Context.Database.ExecuteReader(storedProcCommand))
                {
                    var pos=0;
                    while (executeReader.Read())
                    {
                        result.Add(new BEContenidoRevista
                        {
                            Id = GetDataValue<Int32>(executeReader, "Id"),
                            NroCampania = GetDataValue<String>(executeReader, "NroCampania"),
                            RutaImagenPortada = GetDataValue<String>(executeReader, "RutaImagenPortada")
                        });
                        if (pos >= 1) continue;
                        totalRows = GetDataValue<Int32>(executeReader, "TotalRows");
                        pos++;
                    }
                }
            }
            return result;
        }
    }
}
