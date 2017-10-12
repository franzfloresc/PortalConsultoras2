using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public class BLRecordatorio : IRecordatorioBusinessLogic
    {
        public int Insertar(int paisId, BEClienteRecordatorio recordatorio)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.RecordatorioInsertar(recordatorio);
        }

        public List<BEClienteRecordatorio> Listar(int paisId, long consultoraId, short clienteId = 0)
        {
            var recordatorios = new List<BEClienteRecordatorio>();
            var daCliente = new DACliente(paisId);

            using (IDataReader reader = daCliente.RecordatorioObtener(consultoraId, clienteId))
                while (reader.Read())
                {
                    var recordatorio = new BEClienteRecordatorio(reader);
                    recordatorios.Add(recordatorio);
                }

            return recordatorios;
        }

        public bool Actualizar(int paisId, BEClienteRecordatorio recordatorio)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.RecordatorioActualizar(recordatorio);
        }

        public bool Eliminar(int paisId, short clienteId, long consultoraId, int recordatorioId)
        {
            var daCliente = new DACliente(paisId);
            return daCliente.RecordatorioEliminar(clienteId, consultoraId, recordatorioId);
        }

        public void Procesar(int paisID, BEClienteDB clienteDB)
        {
            var result = ResponseType<List<BEClienteRecordatorio>>.Build();
            result.Data = new List<BEClienteRecordatorio>();

            if (clienteDB.Recordatorios != null)
            {
                foreach (var recordatorio in clienteDB.Recordatorios)
                {
                    recordatorio.ClienteId = (short)clienteDB.ClienteID;
                    recordatorio.ConsultoraId = clienteDB.ConsultoraID;

                    if (recordatorio.StatusEnum == StatusEnum.Delete)
                    {
                        var resultEliminar = Eliminar(paisID, recordatorio.ClienteId, recordatorio.ConsultoraId, recordatorio.ClienteRecordatorioId);
                        if (!resultEliminar)
                            result.Data.Add(recordatorio);

                        continue;

                        //todo;
                    }

                    if (recordatorio.ClienteRecordatorioId == 0)
                        recordatorio.ClienteRecordatorioId = Insertar(paisID, recordatorio);
                    else
                        Actualizar(paisID, recordatorio);

                    result.Data.Add(recordatorio);
                }
            }

            clienteDB.Recordatorios = result.Data;
        }
    }
}
