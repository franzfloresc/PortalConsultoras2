using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLAfiliaClienteConsultora
    {

        public BLAfiliaClienteConsultora()
        {
        }

        public BEAfiliaClienteConsultora GetAfiliaClienteConsultoraByConsultora(int paisID,string ConsultoraID)
        {
            BEAfiliaClienteConsultora beAfiliacionClienteConsultora = new BEAfiliaClienteConsultora();

            var daAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            using (IDataReader reader =  daAfiliaClienteConsultora.GetAfiliaClienteConsultoraByConsultora(ConsultoraID))
            {
                while (reader.Read())
                {
                    // ha sido afiliado y activo -> 1 //afiliado y inactivo -> 0
                    beAfiliacionClienteConsultora = new BEAfiliaClienteConsultora(reader);
                }
            }

            return beAfiliacionClienteConsultora;
        }

        public int InsAfiliaClienteConsultora(int paisID,long ConsultoraID)
        {
            var daAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return daAfiliaClienteConsultora.InsAfiliaClienteConsultora(ConsultoraID);
        }

        public int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion)
        {
            var daAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return daAfiliaClienteConsultora.UpdAfiliaClienteConsultora(ConsultoraID, EsAfiliacion);
        }

        public int UpdAfiliaClienteConsultora(int paisID, long ConsultoraID, bool EsAfiliacion, int MotivoDesafiliacionID)
        {
            var daAfiliaClienteConsultora = new DAAfiliaClienteConsultora(paisID);
            return daAfiliaClienteConsultora.UpdAfiliaClienteConsultora(ConsultoraID, EsAfiliacion, MotivoDesafiliacionID);
        }
    }
}
