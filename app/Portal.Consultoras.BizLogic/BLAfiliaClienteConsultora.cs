using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using System.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    //R2319 - JLCS
    public class BLAfiliaClienteConsultora
    {

        public BLAfiliaClienteConsultora()
        {
        }

        //R2319 - JLCS
        public BEAfiliaClienteConsultora GetAfiliaClienteConsultoraByConsultora(int paisID,string ConsultoraID)
        {
            BEAfiliaClienteConsultora beAfiliacionClienteConsultora = new BEAfiliaClienteConsultora();

            var DAAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            using (IDataReader reader =  DAAfiliaClienteConsultora.GetAfiliaClienteConsultoraByConsultora(ConsultoraID))
            {
                while (reader.Read())
                {
                    beAfiliacionClienteConsultora = new BEAfiliaClienteConsultora(reader);// ha sido afiliado y activo -> 1 //afiliado y inactivo -> 0
                }
            }

            return beAfiliacionClienteConsultora;
        }

        //R2319 - JLCS
        public int InsAfiliaClienteConsultora(int paisID,long ConsultoraID)
        {
            var DAAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return DAAfiliaClienteConsultora.InsAfiliaClienteConsultora(ConsultoraID);
        }

        //R2319 - JLCS
        public int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion)
        {
            var DAAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return DAAfiliaClienteConsultora.UpdAfiliaClienteConsultora(ConsultoraID, EsAfiliacion);
        }

        public int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion, int MotivoDesafiliacionID)
        {
            var DAAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return DAAfiliaClienteConsultora.UpdAfiliaClienteConsultora(ConsultoraID, EsAfiliacion, MotivoDesafiliacionID);
        }
    }
}
