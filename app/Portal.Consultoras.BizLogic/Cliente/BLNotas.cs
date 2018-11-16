using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public class BLNotas : INotasBusinessLogic
    {
        private readonly BLTablaLogicaDatos _blTablaLogicaDatos;

        public BLNotas()
        {
            _blTablaLogicaDatos = new BLTablaLogicaDatos();
        }

        public ResponseType<long> Insertar(int paisId, BENota nota)
        {
            var validacionNotas = PuedeAgregarMasNotas(paisId, nota.ConsultoraId, nota.ClienteId);
            if (!validacionNotas.Success)
                return ResponseType<long>.Build(false, validacionNotas.Code, validacionNotas.Message);


            var daCliente = new DACliente(paisId);
            nota.Fecha = nota.Fecha.HasValue ? nota.Fecha.Value.ToUniversalTime() : DateTime.UtcNow;

            var result = daCliente.NotaInsertar(nota);

            if (result == 0)
                return ResponseType<long>.Build(false, Constantes.ClienteValidacion.Code.ERROR_NOTAINVALIDA);

            return ResponseType<long>.Build(data: result);
        }

        public ResponseType<List<BENota>> Listar(int paisId, long consultoraId, short clienteId = 0)
        {
            var notas = new List<BENota>();

            try
            {
                using (var reader = new DACliente(paisId).NotaObtener(consultoraId, clienteId))
                {
                    notas = reader.MapToCollection<BENota>();
                }
            }
            catch (Exception ex)
            {
                LogManager.SaveLog(ex, consultoraId, paisId);
            }

            return ResponseType<List<BENota>>.Build(data: notas ?? new List<BENota>());
        }

        public ResponseType<bool> Actualizar(int paisId, BENota nota)
        {
            var daCliente = new DACliente(paisId);
            nota.Fecha = nota.Fecha.HasValue ? nota.Fecha.Value.ToUniversalTime() : DateTime.UtcNow;

            var result = daCliente.NotaActualizar(nota);
            if (!result)
                return ResponseType<bool>.Build(false, Constantes.ClienteValidacion.Code.ERROR_NOTAINVALIDA);

            return ResponseType<bool>.Build(result);
        }

        public ResponseType<bool> Eliminar(int paisId, short clienteId, long consultoraId, long clienteNotaId)
        {
            var daCliente = new DACliente(paisId);
            var result = daCliente.NotaEliminar(clienteId, consultoraId, clienteNotaId);
            if (!result)
                return ResponseType<bool>.Build(false, Constantes.ClienteValidacion.Code.ERROR_NOTAINVALIDA);

            return ResponseType<bool>.Build(result);
        }

        public ResponseType<List<BENota>> Procesar(int paisId, BEClienteDB clienteDb)
        {
            var result = ResponseType<List<BENota>>.Build();
            result.Data = new List<BENota>();

            if (clienteDb.Notas != null)
            {
                foreach (var nota in clienteDb.Notas)
                {
                    nota.ClienteId = (short)clienteDb.ClienteID;
                    nota.ConsultoraId = clienteDb.ConsultoraID;

                    if (nota.StatusEnum == StatusEnum.Delete)
                    {
                        var resultEliminar = Eliminar(paisId, nota.ClienteId, nota.ConsultoraId, nota.ClienteNotaId);
                        if (!resultEliminar.Success)
                        {
                            result.Success = false;
                            result.Code = resultEliminar.Code;
                            result.Message = resultEliminar.Message;

                            nota.Code = resultEliminar.Code;
                            nota.Message = resultEliminar.Message;
                            result.Data.Add(nota);
                        }

                        continue;
                    }

                    if (nota.ClienteNotaId == 0)
                    {
                        var resultInsert = Insertar(paisId, nota);
                        if (!resultInsert.Success)
                        {
                            result.Success = false;
                            result.Code = resultInsert.Code;
                            result.Message = resultInsert.Message;
                        }

                        nota.ClienteNotaId = resultInsert.Data;
                        nota.Code = resultInsert.Code;
                        nota.Message = resultInsert.Message;
                    }
                    else
                    {
                        var resultUdate = Actualizar(paisId, nota);
                        if (!resultUdate.Success)
                        {
                            result.Success = false;
                            result.Code = resultUdate.Code;
                            result.Message = resultUdate.Message;
                        }

                        nota.Code = resultUdate.Code;
                        nota.Message = resultUdate.Message;
                    }

                    result.Data.Add(nota);
                }
            }

            clienteDb.Notas = result.Data;
            return result;
        }

        public ResponseType<bool> PuedeAgregarMasNotas(int paisId, long consultoraId, short clienteId)
        {
            var variablesApp = _blTablaLogicaDatos.GetList(paisId, Constantes.TablaLogica.App);
            var notaMaximaConfiguracion = variablesApp.FirstOrDefault(v => v.Codigo == Constantes.TablaLogica.Keys.NotaCantidadMaxima);
            int notaMaxima = 10;
            if (notaMaximaConfiguracion != null)
            {
                int.TryParse(notaMaximaConfiguracion.Descripcion, out notaMaxima);
            }

            var notas = Listar(paisId, consultoraId);
            var notasCliente = notas.Data.Count(n => n.ClienteId == clienteId);

            var result = ResponseType<bool>.Build();
            result.Success = notasCliente < notaMaxima;
            result.Code = Constantes.ClienteValidacion.Code.ERROR_NOTACANTIDADMAXIMA;
            result.Message = string.Format(Resources.ClienteValidationMessages.NotaCantidadMaximaSuperada, notaMaxima);

            return result;
        }
    }
}