using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.ServicePROLConsultas;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

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

                fichasProductos.ForEach(ficha =>
                {
                    if (ficha.Precio2 > 0)
                    {
                        var add = true;
                        if (ficha.TipoEstrategiaImagenMostrar ==
                            Constantes.TipoEstrategia.OfertaParaTi)
                        {
                            add = listaTieneStock.Any(p => p.Codsap.ToString() == ficha.CodigoProducto && p.estado == 1);
                        }
                        if (!add) return;

                        if (ficha.Precio >= ficha.Precio2)
                            ficha.Precio = Convert.ToDecimal(0.0);

                        fichasProductosResult.Add(ficha);
                    }
                });
            }
            else fichasProductosResult.AddRange(fichasProductos);

            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;
            fichasProductosResult.ForEach(ficha =>
            {
                ficha.CampaniaID = entidad.CampaniaID;
                ficha.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, ficha.ImagenURL, carpetaPais);
                ficha.Simbolo = entidad.Simbolo;
                ficha.TieneStockProl = true;
                ficha.PrecioString = Util.DecimalToStringFormat(ficha.Precio2, codigoIso);
                ficha.PrecioTachado = Util.DecimalToStringFormat(ficha.Precio, codigoIso);
                //ficha.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, ficha.FotoProducto01, carpetaPais);
                ficha.CodigoEstrategia = Util.Trim(ficha.CodigoEstrategia);
            });
            return fichasProductosResult;
        }
    }
}
