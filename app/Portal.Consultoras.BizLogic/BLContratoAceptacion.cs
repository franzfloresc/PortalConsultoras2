using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLContratoAceptacion
    {
        public int AceptarContratoAceptacion(int paisID, long consultoraid, string codigoConsultora, string origen, string direccionIP, string InformacionSOMobile)
        {
            var daContratoAceptacion = new DAContratoAceptacion(paisID);
            return daContratoAceptacion.AceptarContratoAceptacion(consultoraid, codigoConsultora, origen, direccionIP, InformacionSOMobile);
        }



        public List<BeReporteContrato> ReporteContratoAceptacion(int paisID,string codigoconsultora, string cedula, DateTime? fechaInicio, DateTime? FechaFin)
        {
            List<BeReporteContrato> listsBeReporteContrato = new List<BeReporteContrato>();

            //if (string.IsNullOrEmpty(codigoUsuario) && fechaIngreso == DateTime.MinValue && string.IsNullOrEmpty(codigoConsultora) && string.IsNullOrEmpty(codigoZona) && campaniaID == 0)
            //    return pedidosIngresados;

            var daContratoAc = new DAContratoAceptacion(paisID);

            using (IDataReader reader = daContratoAc.ReporteContratoAceptacion(codigoconsultora, cedula, fechaInicio, FechaFin))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                while (reader.Read())
                {
                    listsBeReporteContrato.Add(new BeReporteContrato() {
                        Registro = Convert.ToInt32(reader[0]),
                        CodigoConsultora = reader[1].ToString(),
                        NombreConsultora= reader[2].ToString(),
                        AceptoContrato = reader[3].ToString(),
                        FechaAceptacion= reader[4].ToString(),
                        Origen= reader[5].ToString(),
                        DireccionIP= reader[6].ToString(),
                        InformacionSOMobile= reader[7].ToString()
                    });
                }

            }
            return listsBeReporteContrato;
        }


    }
}