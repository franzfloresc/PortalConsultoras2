using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Cliente;
using Portal.Consultoras.Entities.Framework;

namespace Portal.Consultoras.BizLogic.Cliente
{
    public class BLNotas : INotasBusinessLogic
    {
        private readonly BLTablaLogicaDatos _blTablaLogicaDatos;

        public BLNotas()
        {
            _blTablaLogicaDatos = new BLTablaLogicaDatos();
        }

        public ResponseType<long> NotaInsertar(int paisId, BENota nota)
        {
            var validacionNotas = PuedeAgregarMasNotas(paisId, nota.ConsultoraId, nota.ClienteId);
            if (!validacionNotas.Success)
                return ResponseType<long>.Build(false, validacionNotas.Code, validacionNotas.Message);


            var daCliente = new DACliente(paisId);
            nota.Fecha = nota.Fecha.HasValue ? nota.Fecha.Value.ToUniversalTime() : DateTime.UtcNow;

            var result = daCliente.NotaInsertar(nota);

            return ResponseType<long>.Build(data: result);
        }

        public ResponseType<List<BENota>> NotaListar(int paisId, long consultoraId)
        {
            var notas = new List<BENota>();
            var daCliente = new DACliente(paisId);

            using (IDataReader reader = daCliente.NotaObtener(consultoraId))
                while (reader.Read())
                {
                    var nota = new BENota(reader);
                    notas.Add(nota);
                }

            return ResponseType<List<BENota>>.Build(data: notas);
        }

        public ResponseType<bool> NotaActualizar(int paisId, BENota nota)
        {
            var daCliente = new DACliente(paisId);
            nota.Fecha = nota.Fecha.HasValue ? nota.Fecha.Value.ToUniversalTime() : DateTime.UtcNow;

            var result = daCliente.NotaActualizar(nota);

            return ResponseType<bool>.Build(data: result);
        }

        public ResponseType<bool> NotaEliminar(int paisId, short clienteId, long consultoraId, long clienteNotaId)
        {
            var daCliente = new DACliente(paisId);
            var result = daCliente.NotaEliminar(clienteId, consultoraId, clienteNotaId);
            return ResponseType<bool>.Build(data: result);
        }

        public ResponseType<List<BENota>> NotaProcesar(int paisId, BEClienteDB clienteDb)
        {
            var result = ResponseType<List<BENota>>.Build();
            result.Data = new List<BENota>();

            foreach (var nota in clienteDb.Notas)
            {
                nota.ClienteId = (short)clienteDb.ClienteIDSB;
                nota.ConsultoraId = clienteDb.ConsultoraID;

                //todo: improve
                if (nota.ClienteNotaId == 0)
                {
                    var resultInsert = NotaInsertar(paisId, nota);
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
                    var resultUdate = NotaActualizar(paisId, nota);
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

            return result;
        }

        public ResponseType<bool> PuedeAgregarMasNotas(int paisId, long consultoraId, short clienteId)
        {
            var variablesApp = _blTablaLogicaDatos.GetTablaLogicaDatos(paisId, Constantes.TablaLogica.App);
            var notaMaximaConfiguracion = variablesApp.FirstOrDefault(v => v.Codigo == Constantes.TablaLogica.Keys.NotaCantidadMaxima);
            int notaMaxima = 10; //todo: consantes defaults?
            if (notaMaximaConfiguracion != null)
            {
                int.TryParse(notaMaximaConfiguracion.Descripcion, out notaMaxima);
            }

            var notas = NotaListar(paisId, consultoraId);
            var notasCliente = notas.Data.Count(n => n.ClienteId == clienteId);

            var result = ResponseType<bool>.Build();
            result.Success = notasCliente < notaMaxima;
            result.Code = Constantes.ClienteValidacion.Code.ERROR_NOTACANTIDADMAXIMA; ;
            result.Message = string.Format(Resources.ClienteValidationMessages.NotaCantidadMaximaSuperada, notaMaxima);

            return result;
        }
    }
}
