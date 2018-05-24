using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;

using System;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public class BLRecordatorio : IRecordatorioBusinessLogic
    {
        public ResponseType<int> Insertar(int paisId, BEClienteRecordatorio recordatorio)
        {
            var daCliente = new DACliente(paisId);
            var result = daCliente.RecordatorioInsertar(recordatorio);
            if (result == 0)
                ResponseType<int>.Build(false, Constantes.ClienteValidacion.Code.ERROR_RECORDATORIOINVALIDA, Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_RECORDATORIOINVALIDA]);

            return ResponseType<int>.Build(data: result);
        }

        public List<BEClienteRecordatorio> Listar(int paisId, long consultoraId, short clienteId = 0)
        {
            var recordatorios = new List<BEClienteRecordatorio>();

            try
            {
                using (var reader = new DACliente(paisId).RecordatorioObtener(consultoraId, clienteId))
                {
                    while (reader.Read())
                    {
                        var recordatorio = new BEClienteRecordatorio(reader);
                        recordatorios.Add(recordatorio);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraId, paisId);
            }

            return recordatorios ?? new List<BEClienteRecordatorio>();
        }

        public ResponseType<bool> Actualizar(int paisId, BEClienteRecordatorio recordatorio)
        {
            var daCliente = new DACliente(paisId);
            var result = daCliente.RecordatorioActualizar(recordatorio);
            if (!result)
                return ResponseType<bool>.Build(false, Constantes.ClienteValidacion.Code.ERROR_RECORDATORIOINVALIDA, Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_RECORDATORIOINVALIDA]);

            return ResponseType<bool>.Build(data: true);
        }

        public ResponseType<bool> Eliminar(int paisId, short clienteId, long consultoraId, int recordatorioId)
        {
            var daCliente = new DACliente(paisId);
            var result = daCliente.RecordatorioEliminar(clienteId, consultoraId, recordatorioId);
            if (!result)
                return ResponseType<bool>.Build(false, Constantes.ClienteValidacion.Code.ERROR_RECORDATORIOINVALIDA, Constantes.ClienteValidacion.Message[Constantes.ClienteValidacion.Code.ERROR_RECORDATORIOINVALIDA]);

            return ResponseType<bool>.Build(data: true);
        }

        public ResponseType<List<BEClienteRecordatorio>> Procesar(int paisID, BEClienteDB clienteDB)
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
                        if (!resultEliminar.Success)
                        {
                            result.Success = false;
                            result.Code = resultEliminar.Code;
                            result.Message = resultEliminar.Message;

                            recordatorio.Code = resultEliminar.Code;
                            recordatorio.Message = resultEliminar.Message;
                            result.Data.Add(recordatorio);
                        }

                        continue;
                    }

                    if (recordatorio.ClienteRecordatorioId == 0)
                    {
                        var resultInsert = Insertar(paisID, recordatorio);
                        if (!resultInsert.Success)
                        {
                            result.Success = false;
                            result.Code = resultInsert.Code;
                            result.Message = resultInsert.Message;
                        }

                        recordatorio.ClienteRecordatorioId = resultInsert.Data;
                        recordatorio.Code = resultInsert.Code;
                        recordatorio.Message = resultInsert.Message;

                    }
                    else
                    {
                        var resultUpdate = Actualizar(paisID, recordatorio);
                        if (!resultUpdate.Success)
                        {
                            result.Success = false;
                            result.Code = resultUpdate.Code;
                            result.Message = resultUpdate.Message;
                        }

                        recordatorio.Code = resultUpdate.Code;
                        recordatorio.Message = resultUpdate.Message;
                    }

                    result.Data.Add(recordatorio);
                }
            }

            clienteDB.Recordatorios = result.Data;
            return result;
        }
    }
}