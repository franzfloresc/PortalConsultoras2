using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Comunicado;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic
{
    public class BLComunicado : IComunicadoBusinessLogic
    {
        public BEComunicado GetComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            BEComunicado oBeComunicado;
            var daComunicado = new DAComunicado(paisID);

            using (IDataReader reader = daComunicado.GetComunicadoByConsultora(CodigoConsultora))
                oBeComunicado = reader.MapToObject<BEComunicado>();

            return oBeComunicado;
        }

        public void UpdComunicadoByConsultora(int paisID, string CodigoConsultora)
        {
            var daComunicado = new DAComunicado(paisID);
            daComunicado.UpdComunicadoByConsultora(CodigoConsultora);
        }

        /// <summary>
        /// Obtener los comunicados por consultora y tipo de dispositivo(Desktop o Mobile).
        /// </summary>
        /// <param name="PaisID"></param>
        /// <param name="CodigoConsultora"></param>
        /// <param name="TipoDispositivo"></param>
        /// <returns></returns>
        public List<BEComunicado> ObtenerComunicadoPorConsultora(int paisID, string CodigoConsultora, short TipoDispositivo, string CodigoRegion,
            string CodigoZona, int IdEstadoActividad)
        {
            List<BEComunicado> lstComunicado;
            var lstComunicadoVista = new List<BEComunicadoVista>();
            var lstComunicadoSegmentacion = new List<BEComunicadoSegmentacion>();

            using (var reader = new DAComunicado(paisID).ObtenerComunicadoPorConsultora(CodigoConsultora, TipoDispositivo))
            {
                lstComunicado = reader.MapToCollection<BEComunicado>();

                if (reader.NextResult()) lstComunicadoVista = reader.MapToCollection<BEComunicadoVista>();
                if (reader.NextResult()) lstComunicadoSegmentacion = reader.MapToCollection<BEComunicadoSegmentacion>();
            }

            var lstComunicadoFinal = new List<BEComunicado>();

            foreach (var item in lstComunicado)
            {
                item.Vistas = lstComunicadoVista.Where(x => x.ComunicadoId == item.ComunicadoId).ToList();
                var Segmentaciones = lstComunicadoSegmentacion.Where(x => x.ComunicadoId == item.ComunicadoId).ToList();

                if (item.SegmentacionID == null)
                {
                    lstComunicadoFinal.Add(item);
                    continue;
                }

                if (item.SegmentacionConsultora)
                {
                    if (Segmentaciones.Any(x => x.CodigoConsultora == CodigoConsultora))
                    {
                        lstComunicadoFinal.Add(item);
                    }
                    continue;
                }

                if (!item.SegmentacionRegionZona && !item.SegmentacionEstadoActividad)
                {
                    lstComunicadoFinal.Add(item);
                    continue;
                }

                if (item.SegmentacionRegionZona && item.SegmentacionEstadoActividad)
                {
                    if (Segmentaciones.Any(x => x.CodigoRegion == CodigoRegion && (string.IsNullOrEmpty(x.CodigoZona) ? CodigoZona : x.CodigoZona) == CodigoZona)
                        && Segmentaciones.Any(x => x.IdEstadoActividad == IdEstadoActividad))
                    {
                        lstComunicadoFinal.Add(item);
                    }
                    continue;
                }

                if (item.SegmentacionRegionZona && !item.SegmentacionEstadoActividad)
                {
                    if (Segmentaciones.Any(x => x.CodigoRegion == CodigoRegion && (string.IsNullOrEmpty(x.CodigoZona) ? CodigoZona : x.CodigoZona) == CodigoZona))
                    {
                        lstComunicadoFinal.Add(item);
                    }
                    continue;
                }

                if (!item.SegmentacionRegionZona && item.SegmentacionEstadoActividad 
                    && Segmentaciones.Any(x => x.IdEstadoActividad == IdEstadoActividad))
                {
                    lstComunicadoFinal.Add(item);
                }
            }

            return lstComunicadoFinal;
        }

        public void InsertarComunicadoVisualizado(int PaisID, string CodigoConsultora, int ComunicadoID)
        {
            DAComunicado daComunicado = new DAComunicado(PaisID);
            daComunicado.InsertarComunicadoVisualizado(CodigoConsultora, ComunicadoID);

        }

        public void ActualizarVisualizoComunicado(int PaisId, string CodigoConsultora, int ComunicadoId)
        {
            DAComunicado daComunicado = new DAComunicado(PaisId);
            daComunicado.ActualizarVisualizoComunicado(CodigoConsultora, ComunicadoId);
        }

        public void InsertarDonacionConsultora(int PaisId, string CodigoISO, string CodigoConsultora, string Campania, string IPUsuario)
        {
            DAComunicado daComunicado = new DAComunicado(PaisId);
            daComunicado.InsertarDonacionConsultora(CodigoISO, CodigoConsultora, Campania, IPUsuario);
        }
    }
}