using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class ValidacionStockModel
    {
        public string CUV
        {
            get;
            set;
        }

        public int Flag
        {
            get;
            set;
        }

        public int Stock
        {
            get;
            set;
        }

        public int PedidoDetalleID
        {
            get;
            set;
        }

        public int PedidoID
        {
            get;
            set;
        }

        public int Cantidad
        {
            get;
            set;
        }

        public int CantidadAnterior
        {
            get;
            set;
        }
    }
}