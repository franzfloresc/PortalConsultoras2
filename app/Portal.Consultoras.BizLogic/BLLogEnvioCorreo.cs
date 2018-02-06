namespace Portal.Consultoras.BizLogic
{
    using Data;
    using Entities;
    using System;
    using System.Collections.Generic;

    public class BLLogEnvioCorreo
    {
        public bool InsLogEnvioCorreoPedidoValidado(int paisID,BELogCabeceraEnvioCorreo beLogCabeceraEnvioCorreo,List<BELogDetalleEnvioCorreo> listLogDetalleEnvioCorreo)
        {
            try
            {
                DALogCabeceraEnvioCorreo daLogCabeceraEnvioCorreo = new DALogCabeceraEnvioCorreo(paisID);
                int cabeceraId = daLogCabeceraEnvioCorreo.InsLogCabeceraEnvioCorreo(beLogCabeceraEnvioCorreo);
                DALogDetalleEnvioCorreo daLogDetalleEnvioCorreo = new DALogDetalleEnvioCorreo(paisID);
                foreach (BELogDetalleEnvioCorreo beLogDetalleEnvioCorreo in listLogDetalleEnvioCorreo)
                {
                    daLogDetalleEnvioCorreo.InsLogDetalleEnvioCorreo(cabeceraId, beLogDetalleEnvioCorreo);
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        
        }
    }
}
