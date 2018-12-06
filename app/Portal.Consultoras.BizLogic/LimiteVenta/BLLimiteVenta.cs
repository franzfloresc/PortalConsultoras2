using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.LimiteVenta;
using Portal.Consultoras.Data.ProgramaNuevas;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.LimiteVenta;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic.LimiteVenta
{
    public class BLLimiteVenta : ILimiteVentaBusinessLogic
    {
        public BLLimiteVenta() { }

        public BERespValidarLimiteVenta CuvTieneLimiteVenta(int paisID, int campaniaID, string region, string zona, string cuv, int cantidadIngresada, int cantidadActual)
        {
            var limMaximo = new DAGestionStock(paisID).GetLimMaxByCampaniaAndCuv(campaniaID.ToString(), cuv, region, zona);
            if(limMaximo <= 0) return new BERespValidarLimiteVenta(false);            
            if(cantidadIngresada + cantidadActual <= limMaximo) return new BERespValidarLimiteVenta(false);

            return new BERespValidarLimiteVenta(true, limMaximo);
        }
    }
}
