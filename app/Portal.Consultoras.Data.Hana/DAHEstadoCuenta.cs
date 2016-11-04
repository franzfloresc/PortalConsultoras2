﻿using System;
using System.Configuration;
using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data.Hana.Entities;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;

namespace Portal.Consultoras.Data.Hana
{
    public class DAHEstadoCuenta
    {       
        public List<BEEstadoCuenta> GetEstadoCuentaConsultora(int paisId, long consultoraId)
        {
            var listBE = new List<BEEstadoCuenta>();
            var listaHana = new List<EstadoCuentaHana>();

            try
            {
                var codigoIsoHana = Util.GetCodigoIsoHana(paisId);
                string rutaServiceHana = ConfigurationManager.AppSettings.Get("RutaServiceHana");
                const int cantidadRegistros = 20;

                string urlConParametros = rutaServiceHana + "ObtenerCuentaCorrienteConsultora/" + codigoIsoHana + "/" + consultoraId + "/" + cantidadRegistros;

                string responseFromServer = Util.ObtenerJsonServicioHana(urlConParametros);

                listaHana = JsonConvert.DeserializeObject<List<EstadoCuentaHana>>(responseFromServer);

                foreach (var estadoCuenta in listaHana)
                {
                    var beEstadoCuenta = new BEEstadoCuenta();
                    DateTime fechaRegistro;
                    bool esFecha = DateTime.TryParseExact(estadoCuenta.fechaRegistro, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaRegistro);
                    if (esFecha)
                        beEstadoCuenta.FechaRegistro = fechaRegistro;
                    beEstadoCuenta.DescripcionOperacion = estadoCuenta.descripcionOperacion;

                    decimal montoOperacion;
                    bool esMontoOperacion = Decimal.TryParse(estadoCuenta.montoOperacion, out montoOperacion);
                    if (esMontoOperacion)
                        beEstadoCuenta.MontoOperacion = montoOperacion;

                    if (estadoCuenta.tipoCargoAbono == "D")
                    {
                        if (!string.IsNullOrEmpty(estadoCuenta.anoCampanaCargo))
                        {
                            beEstadoCuenta.DescripcionOperacion = string.Format("{0} C{1}-{2}", estadoCuenta.descripcionOperacion, estadoCuenta.anoCampanaCargo.Substring(4), estadoCuenta.anoCampanaCargo.Substring(0, 4));
                        }
                        beEstadoCuenta.Cargo = montoOperacion;
                    }

                    if (estadoCuenta.tipoCargoAbono == "H")
                    {
                        beEstadoCuenta.Abono = montoOperacion;
                    }

                    beEstadoCuenta.Orden = 0;

                    listBE.Add(beEstadoCuenta);
                }
            }
            catch (Exception ex)
            {
                listBE = new List<BEEstadoCuenta>();
            }            

            return listBE;
        }
    }
}
