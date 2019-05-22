﻿using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Comunicado;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Portal.Consultoras.BizLogic
{
    public class BLBelcorpResponde : IBelcorpRespondeBusinessLogic
    {
        public IList<BEBelcorpResponde> GetBelcorpResponde(int paisID)
        {
            IList<BEBelcorpResponde> lista = (IList<BEBelcorpResponde>)CacheManager<BEBelcorpResponde>.GetData(paisID, ECacheItem.BelcorpResponde);
            if (lista == null)
            {
                lista = new List<BEBelcorpResponde>();
                var daBelcorpResponde = new DABelcorpResponde();

                using (IDataReader reader = daBelcorpResponde.GetBelcorpResponde(paisID))
                    while (reader.Read())
                    {
                        var entidad = new BEBelcorpResponde(reader);
                        lista.Add(entidad);
                    }
                CacheManager<BEBelcorpResponde>.AddData(paisID, ECacheItem.BelcorpResponde, lista);
            }
            return lista;
        }

        public IList<BEBelcorpResponde> GetBelcorpRespondeAdministrador(int paisID)
        {
            var lista = new List<BEBelcorpResponde>();
            var daBelcorpResponde = new DABelcorpResponde();

            using (IDataReader reader = daBelcorpResponde.GetBelcorpResponde(paisID))
                while (reader.Read())
                {
                    var entidad = new BEBelcorpResponde(reader);
                    lista.Add(entidad);
                }

            return lista;
        }

        public void InsBelcorpResponde(BEBelcorpResponde BEBelcorpResponde)
        {
            var daBelcorpResponde = new DABelcorpResponde();
            daBelcorpResponde.InsBelcorpResponde(BEBelcorpResponde);

            CacheManager<BEBelcorpResponde>.RemoveData(BEBelcorpResponde.PaisID, ECacheItem.BelcorpResponde);
        }

        public void DeleteBelcorpRespondeCache(int paisID)
        {
            CacheManager<BEBelcorpResponde>.RemoveData(paisID, ECacheItem.BelcorpResponde);
        }

        #region Gestor de Popups
        public List<BEComunicado> GetListaPopup(int estado, string campania, int Paginas, int Filas, int PaisID)
        {
            List<BEComunicado> listsBEComunicado = new List<BEComunicado>();

            var daBelcorpResponde = new DABelcorpResponde(PaisID);

            using (IDataReader reader = daBelcorpResponde.GetListaPopup(estado, campania, Paginas, Filas))
            {
                while (reader.Read())
                {
                    listsBEComunicado.Add(new BEComunicado()
                    {
                        Numero = reader[0] == DBNull.Value ? 0 : int.Parse(reader[0].ToString()),
                        ComunicadoId = reader[1] == DBNull.Value ? 0 : int.Parse(reader[1].ToString()),
                        UrlImagen = reader[2] == null ? string.Empty : reader[2].ToString(),
                        FechaInicio = reader[3] == null ? string.Empty : reader[3].ToString(),
                        FechaFin = reader[4] == null ? string.Empty : reader[4].ToString(),
                        Titulo = reader[5] == null ? string.Empty : reader[5].ToString(),
                        DescripcionAccion = reader[6] == null ? string.Empty : reader[6].ToString(),
                        Activo = Convert.ToBoolean(reader[7]),
                        PaginasMaximas = reader[8] == DBNull.Value ? 0 : int.Parse(reader[8].ToString()),
                    });
                }

            }
            return listsBEComunicado;
        }

        public BEComunicado GetDetallePopup(int comunicadoid, int PaisID)
        {
            BEComunicado objetoBEComunicado = new BEComunicado();

            var daBelcorpResponde = new DABelcorpResponde(PaisID);

            using (IDataReader reader = daBelcorpResponde.GetDetallePopup(comunicadoid))
            {
                while (reader.Read())
                {
                    objetoBEComunicado.ComunicadoId = reader[0] == DBNull.Value ? 0 : int.Parse(reader[0].ToString());
                    objetoBEComunicado.Descripcion = reader[1] == null ? string.Empty : reader[1].ToString();
                    objetoBEComunicado.Activo = Convert.ToBoolean(reader[2]);
                    objetoBEComunicado.DescripcionAccion = reader[3] == null ? string.Empty : reader[3].ToString();
                    objetoBEComunicado.SegmentacionID = reader[4] == DBNull.Value ? 0 : int.Parse(reader[4].ToString());
                    objetoBEComunicado.UrlImagen = reader[5] == null ? string.Empty : reader[5].ToString();
                    objetoBEComunicado.Orden = reader[6] == DBNull.Value ? 0 : int.Parse(reader[6].ToString());
                    objetoBEComunicado.NombreArchivoCCV = reader[7] == null ? string.Empty : reader[7].ToString();
                    objetoBEComunicado.FechaInicio = reader[8] == null ? string.Empty : reader[8].ToString();
                    objetoBEComunicado.FechaFin = reader[9] == null ? string.Empty : reader[9].ToString();
                    objetoBEComunicado.TipoDispositivo = reader[10] == DBNull.Value ? 0 : int.Parse(reader[10].ToString());
                    objetoBEComunicado.Comentario = reader[11] == null ? string.Empty : reader[11].ToString();
                }

            }
            return objetoBEComunicado;
        }


        public int GuardarPopups(string tituloPrincipal, string descripcion, string UrlImagen, string fechaMaxima, string fechaMinima, bool checkDesktop, bool checkMobile, int accionID, List<BEComunicadoSegmentacion> listdatosCSV, string comunicadoId, string nombreArchivo, string codigoCampania, string descripcionAccion, int PaisID)
        {
            var daBelcorpResponde = new DABelcorpResponde(PaisID);
            string[] arrayColumnasBEComunicadoSegmentacion = GetArrayColumnas(listdatosCSV);
            return daBelcorpResponde.GuardarPopups(tituloPrincipal, descripcion, UrlImagen, fechaMaxima, fechaMinima, checkDesktop, checkMobile, accionID, arrayColumnasBEComunicadoSegmentacion, comunicadoId, nombreArchivo, codigoCampania, descripcionAccion);

        }

        private string[] GetArrayColumnas(List<BEComunicadoSegmentacion> listdatosCSV)
        {
            string[] arrayColumnas = new string[4];
            string separar = "@";

            if (listdatosCSV.Any())
            {
                var col0 = new StringBuilder();
                var col1 = new StringBuilder();
                var col2 = new StringBuilder();
                var col3 = new StringBuilder();

                foreach (var objDato in listdatosCSV)
                {
                    col0.Append(objDato.RegionId.ToString());
                    col1.Append(objDato.ZonaId.ToString());
                    col2.Append(objDato.Estado.ToString());
                    col3.Append(objDato.Consultoraid);

                    col0.Append(separar);
                    col1.Append(separar);
                    col2.Append(separar);
                    col3.Append(separar);

                    //arrayColumnas[0] += string.Concat(objDato.RegionId.ToString(), separar);
                    //arrayColumnas[1] += string.Concat(objDato.ZonaId.ToString(), separar);
                    //arrayColumnas[2] += string.Concat(objDato.Estado.ToString(), separar);
                    //arrayColumnas[3] += string.Concat(objDato.Consultoraid.ToString(), separar);
                }

                arrayColumnas[0] = col0.ToString();
                arrayColumnas[1] = col1.ToString();
                arrayColumnas[2] = col2.ToString();
                arrayColumnas[3] = col3.ToString();

                for (int j = 0; j < arrayColumnas.Length; j++)
                    arrayColumnas[j] = arrayColumnas[j].Length > 0 ? arrayColumnas[j].Substring(0, arrayColumnas[j].Length - 1) : string.Empty;

                return arrayColumnas;
            }

            arrayColumnas[0] = separar;
            arrayColumnas[1] = separar;
            arrayColumnas[2] = separar;
            arrayColumnas[3] = separar;
            return arrayColumnas;
        }

        public int ActualizaOrden(string comunicado, string orden, int PaisID)
        {
            var daBelcorpResponde = new DABelcorpResponde(PaisID);
            return daBelcorpResponde.ActualizaOrden(comunicado, orden);
        }

        public int EliminarArchivoCsv(int comunicadoid, int PaisID)
        {
            var daBelcorpResponde = new DABelcorpResponde(PaisID);
            return daBelcorpResponde.EliminarArchivoCsv(comunicadoid);
        }


        public int CargaEstadoValidadorDatos(int paisId)
        {
            int estado = 0;
            var daBelcorpResponde = new DABelcorpResponde(paisId);
            using (IDataReader reader = daBelcorpResponde.CargaEstadoValidadorDatos())
            {
                while (reader.Read())
                {
                    estado = reader[0] == DBNull.Value ? 0 : int.Parse(reader[0].ToString());
                }
            }
            return estado;
        }

        public int GuardarPopupsValidador(bool checkDesktop, List<BEComunicadoSegmentacion> listdatosCSV, int paisID)
        {
            var daBelcorpResponde = new DABelcorpResponde(paisID);
            string[] arrayColumnasBEComunicadoSegmentacion = GetArrayColumnas(listdatosCSV);
            return daBelcorpResponde.GuardarPopupsValidador(checkDesktop, arrayColumnasBEComunicadoSegmentacion, paisID);

        }

        public int EliminarArchivoCsvValidador(int paisId)
        {
            var daBelcorpResponde = new DABelcorpResponde(paisId);
            return daBelcorpResponde.EliminarArchivoCsvValidador();
        }

        public List<BEComunicadoSegmentacion> GetCargaListadoPopupValidador(int paisID)
        {

            List<BEComunicadoSegmentacion> listsBEComunicado = new List<BEComunicadoSegmentacion>();

            var daBelcorpResponde = new DABelcorpResponde(paisID);

            using (IDataReader reader = daBelcorpResponde.GetCargaListadoPopupValidador())
            {
                while (reader.Read())
                {
                    listsBEComunicado.Add(new BEComunicadoSegmentacion()
                    {
                        CodigoRegion = reader[0] == null ? string.Empty : reader[0].ToString(),
                        CodigoZona = reader[1] == null ? string.Empty : reader[1].ToString(),
                        IdEstadoActividad = reader[2] == DBNull.Value ? 0 : int.Parse(reader[2].ToString()),
                        CodigoConsultora = reader[3] == null ? string.Empty : reader[3].ToString(),
                    });
                }

            }
            return listsBEComunicado;

        }


        #endregion
    }
}
