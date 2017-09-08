using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServicePROLConsultas;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Transactions;

namespace Portal.Consultoras.BizLogic
{
    public class BLFichaProducto
    {
        public List<BEFichaProducto> GetFichaProducto(BEFichaProducto entidad)
        {
            var fichasProductosResult = new List<BEFichaProducto>();
            var fichasProductos = new List<BEFichaProducto>();
            var codigoIso = Util.GetPaisISO(entidad.PaisID);

            var daFichaProducto = new DAFichaProducto(entidad.PaisID);
            using (var reader = daFichaProducto.GetFichaProducto(entidad))
            {
                while (reader.Read()) fichasProductos.Add(new BEFichaProducto(reader));
            }

            var esFacturacion = false;
            if (entidad.ValidarPeriodoFacturacion)
            {
                var fechaHoy = DateTime.Now.AddHours(entidad.ZonaHoraria).Date;
                esFacturacion = fechaHoy >= entidad.FechaInicioFacturacion.Date;
            }

            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                var listaTieneStock = new List<Lista>();
                try
                {
                    var codigoSap = string.Join("|", fichasProductos.Where(e => !string.IsNullOrEmpty(e.CodigoProducto)).Select(e => e.CodigoProducto));
                    if (!string.IsNullOrEmpty(codigoSap))
                    {
                        using (var sv = new wsConsulta())
                        {
                            sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                            listaTieneStock = sv.ConsultaStock(codigoSap, codigoIso).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.SaveLog(ex, entidad.ConsultoraID, entidad.PaisID.ToString());
                    listaTieneStock = new List<Lista>();
                }

                fichasProductos.ForEach(fichaProducto =>
                {
                    if (fichaProducto.Precio2 > 0)
                    {
                        fichasProductosResult.Add(fichaProducto);
                    }
                });
            }
            else fichasProductosResult.AddRange(fichasProductos);

            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso; //pais ISO
            fichasProductosResult.ForEach(fichaProducto =>
            {
                fichaProducto.CampaniaID = entidad.CampaniaID;
                fichaProducto.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, fichaProducto.ImagenURL, carpetaPais);
                fichaProducto.Simbolo = entidad.Simbolo;
                fichaProducto.TieneStockProl = true;
                fichaProducto.PrecioString = Util.DecimalToStringFormat(fichaProducto.Precio2, codigoIso);
                fichaProducto.PrecioTachado = Util.DecimalToStringFormat(fichaProducto.Precio, codigoIso);
                fichaProducto.FotoProducto01 = string.IsNullOrEmpty(fichaProducto.FotoProducto01) ? string.Empty : fichaProducto.FotoProducto01;
                fichaProducto.URLCompartir = Util.GetUrlCompartirFB(codigoIso);
                fichaProducto.CodigoTipoOferta = Util.Trim(fichaProducto.CodigoTipoOferta);
            });
            return fichasProductosResult;
        }
    }
}
