﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultoraOnline
    {
        public IList<BEMisPedidos> GetMisPedidos(int PaisID, long ConsultoraId, int Campania)
        {
            var DAMisPedidos = new DAConsultoraOnline(PaisID);
            var misPedidos = new List<BEMisPedidos>();
            using (IDataReader reader = DAMisPedidos.GetSolicitudesPedido(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidos(reader);
                    misPedidos.Add(entidad);
                }

                return misPedidos;
            }
        }

        public IList<BEMisPedidosDetalle> GetMisPedidosDetalle(int PaisID, long PedidoID)
        {
            var DAMisPedidos = new DAConsultoraOnline(PaisID);
            var miPedidoDetalles = new List<BEMisPedidosDetalle>();
            using (IDataReader reader = DAMisPedidos.GetSolicitudesPedidoDetalle(PedidoID))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidosDetalle(reader);
                    miPedidoDetalles.Add(entidad);
                }

                return miPedidoDetalles;
            }
        }

        public IList<BEMisPedidos> GetMisPedidosClienteOnline(int paisID, long consultoraId, int campania)
        {
            var DAMisPedidos = new DAConsultoraOnline(paisID);
            var misPedidos = new List<BEMisPedidos>();
            using (IDataReader reader = DAMisPedidos.GetMisPedidosClienteOnline(consultoraId, campania))
            {
                while (reader.Read())
                {
                    var entidad = new BEMisPedidos(reader);
                    misPedidos.Add(entidad);
                }
                return misPedidos;
            }
        }

        public BEMisPedidos GetPedidoClienteOnlineBySolicitudClienteId(int paisID, long solicitudClienteId)
        {
            var dAMisPedidos = new DAConsultoraOnline(paisID);
            BEMisPedidos miPedido = null;
            using (IDataReader reader = dAMisPedidos.GetPedidoClienteOnlineBySolicitudClienteId(solicitudClienteId))
            {
                if (reader.Read()) miPedido = new BEMisPedidos(reader);
            }
            return miPedido;
        }

        public int GetCantidadPedidosConsultoraOnline(int PaisID, long ConsultoraId)
        {
            var cantidad = -1;
            var DAConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = DAConsultoraOnline.GetCantidadPedidosConsultoraOnline(ConsultoraId))
            {
                while (reader.Read())
                {
                    cantidad = reader.GetInt32(reader.GetOrdinal("Cantidad"));
                }
            }
            return cantidad;
        }

        public IList<BEProducto> GetValidarCUVMisPedidos(int PaisID, int Campania, string InputCUV, int RegionID, int ZonaID, string CodigoRegion, string CodigoZona)
        {
            IList<BEProducto> productos = new List<BEProducto>();
            var DAConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = DAConsultoraOnline.GetValidarCUVSolicitudPedido(Campania, InputCUV, RegionID, ZonaID, CodigoRegion, CodigoZona))
            {
                while (reader.Read())
                {
                    productos.Add(new BEProducto(reader));
                }
            }
            return productos;
        }

        public int GetCantidadSolicitudesPedido(int PaisID, long ConsultoraId, int Campania)
        {
            var cant = -1;
            var DAConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = DAConsultoraOnline.GetCantidadSolicitudesPedido(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    cant = reader.GetInt32(reader.GetOrdinal("Cantidad"));
                }
            }
            return cant;
        }

        public string GetSaldoHorasSolicitudesPedido(int PaisID, long ConsultoraId, int Campania)
        {
            var saldo = "";
            var DAConsultoraOnline = new DAConsultoraOnline(PaisID);

            using (IDataReader reader = DAConsultoraOnline.GetSaldoHorasSolicitudesPedido(ConsultoraId, Campania))
            {
                while (reader.Read())
                {
                    saldo = reader.GetString(reader.GetOrdinal("SaldoHoras"));
                }
            }
            return saldo;
        }
    }
}
