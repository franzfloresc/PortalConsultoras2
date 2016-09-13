using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Configuration;
using Portal.Consultoras.Common;
using System.Collections;

namespace Portal.Consultoras.BizLogic
{
    public class BLContratoAceptacion
    {
        public int AceptarContratoAceptacion(int paisID,long consultoraid, string codigoConsultora)
        {
            var DAContratoAceptacion = new DAContratoAceptacion(paisID);
            return DAContratoAceptacion.AceptarContratoAceptacion(consultoraid,codigoConsultora);
        }
    }
}
