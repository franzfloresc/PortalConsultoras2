namespace Portal.Consultoras.BizLogic
{
    using Common;
    using Data;
    using Entities;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Transactions;

    public class BLPedidoDD
    {
        public BEPedidoDD GetPedidoDDByCampaniaConsultora(int paisID, int campaniaID, long consultoraID)
        {
            BEPedidoDD bePedidoDD = null;
            DAPedidoDD daPedidoDD = new DAPedidoDD(paisID);

            using (IDataReader reader = daPedidoDD.GetPedidoDDByCampaniaConsultora(campaniaID, consultoraID))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    bePedidoDD = new BEPedidoDD(reader, columns);
                }
            }
            return bePedidoDD;
        }

        public void HabiliatPedidoIndividual(int paisID, int campaniaID, long consultoraID, string usuarioDigitador, bool indicadoEnviado)
        {
            BLPedidoWeb blPedidoWeb = new BLPedidoWeb();

            BEPedidoWeb bePedidoWeb = blPedidoWeb.GetPedidoWebByCampaniaConsultora(paisID, campaniaID, consultoraID);
            BEPedidoDD bePedidoDD = GetPedidoDDByCampaniaConsultora(paisID, campaniaID, consultoraID);

            if (bePedidoWeb != null)
            {
                if (bePedidoDD != null)
                {
                    BLPedidoDDDetalle blPedidoDDDetalle = new BLPedidoDDDetalle();
                    BLPedidoWebDetalle blPedidoWebDetalle = new BLPedidoWebDetalle();

                    IList<BEPedidoDDDetalle> listaBEPedidoDDDetalle = blPedidoDDDetalle.GetPedidoDDDetalleByPedidoID(paisID, campaniaID, bePedidoDD.PedidoID);
                    IList<BEPedidoWebDetalle> listaBEPedidoWebDetalle = blPedidoWebDetalle.GetPedidoWebDetalleByPedidoID(paisID, campaniaID, bePedidoWeb.PedidoID);

                    bePedidoDD.IndicadorActivo = true;
                    bePedidoDD.IndicadorEnviado = indicadoEnviado;
                    bePedidoDD.CodigoUsuarioModificacion = usuarioDigitador;
                    bePedidoDD.PedidoDDDetalle = new List<BEPedidoDDDetalle>(listaBEPedidoDDDetalle);

                    foreach (var detalleWeb in listaBEPedidoWebDetalle)
                    {
                        var bePedidoDDDetalle = bePedidoDD.PedidoDDDetalle.FirstOrDefault(p => p.CUV.CompareTo(detalleWeb.CUV) == 0);
                        if (bePedidoDDDetalle == null)
                        {
                            bePedidoDDDetalle = new BEPedidoDDDetalle();
                            bePedidoDDDetalle.CampaniaID = campaniaID;
                            bePedidoDDDetalle.ConsultoraID = consultoraID;
                            bePedidoDDDetalle.Cantidad = detalleWeb.Cantidad;
                            bePedidoDDDetalle.CUV = detalleWeb.CUV;
                            bePedidoDDDetalle.IndicadorActivo = true;
                            bePedidoDDDetalle.CodigoUsuarioCreacion = usuarioDigitador;

                            bePedidoDD.PedidoDDDetalle.Add(bePedidoDDDetalle);
                        }
                        else
                        {
                            bePedidoDDDetalle.Cantidad += detalleWeb.Cantidad;
                            bePedidoDDDetalle.CodigoUsuarioModificacion = usuarioDigitador;
                        }
                    }

                    UpdPedidoDD(bePedidoDD);
                }
                else
                {
                    BLPedidoWebDetalle blPedidoWebDetalle = new BLPedidoWebDetalle();
                    IList<BEPedidoWebDetalle> listaBEPedidoWebDetalle = blPedidoWebDetalle.GetPedidoWebDetalleByPedidoID(paisID, campaniaID, bePedidoWeb.PedidoID);

                    bePedidoDD = new BEPedidoDD();
                    bePedidoDD.PaisID = paisID;
                    bePedidoDD.CampaniaID = campaniaID;
                    bePedidoDD.ConsultoraID = consultoraID;
                    bePedidoDD.IndicadorEnviado = indicadoEnviado;
                    bePedidoDD.IPUsuario = "0.0.0.0";
                    bePedidoDD.NumeroClientes = bePedidoWeb.Clientes;
                    bePedidoDD.CodigoUsuarioCreacion = usuarioDigitador;
                    bePedidoDD.PedidoDDDetalle = new List<BEPedidoDDDetalle>();

                    foreach (var detalleWeb in listaBEPedidoWebDetalle)
                    {
                        BEPedidoDDDetalle bePedidoDDDetalle = new BEPedidoDDDetalle();
                        bePedidoDDDetalle.CampaniaID = campaniaID;
                        bePedidoDDDetalle.ConsultoraID = consultoraID;
                        bePedidoDDDetalle.Cantidad = detalleWeb.Cantidad;
                        bePedidoDDDetalle.CUV = detalleWeb.CUV;
                        bePedidoDDDetalle.CodigoUsuarioCreacion = usuarioDigitador;

                        bePedidoDD.PedidoDDDetalle.Add(bePedidoDDDetalle);
                    }

                    InsPedidoDD(bePedidoDD);
                }
            }
            else
            {
                if (bePedidoDD != null)
                {
                    bePedidoDD.IndicadorEnviado = !indicadoEnviado;
                    UpdPedidoDDIndicadoEnviado(bePedidoDD);
                }
                else
                {
                    throw new BizLogicException(string.Format("La consultora ({0}) no tiene pedidos registrados para la campña {1}.", consultoraID, campaniaID));
                }
            }
        }

        public string HabilitaPedidoMultiple(int paisID, IList<string> infoConsultoras)
        {
            IList<string> consultorasProcesadas = new List<string>();
            IList<string> consultorasSinPedido = new List<string>();

            foreach (var info in infoConsultoras)
            {
                var datos = info.Split(';');
                var consultoraID = datos[0];
                var consultoraCodigo = datos[1];
                var campaniaID = datos[2];
                var DigitadorCodigo = datos[3];

                BEPedidoDD bePedidoDD = GetPedidoDDByCampaniaConsultoraHabilitarPedido(paisID, Convert.ToInt32(campaniaID), Convert.ToInt32(consultoraID));

                if (bePedidoDD != null)
                {
                    bePedidoDD.IndicadorEnviado = false;
                    bePedidoDD.CodigoUsuarioModificacion = DigitadorCodigo;

                    UpdPedidoDDIndicadoEnviado(bePedidoDD);
                    consultorasProcesadas.Add(consultoraCodigo);
                }
                else
                {
                    BLPedidoWeb blPedidoWeb = new BLPedidoWeb();
                    BEPedidoWeb bePedidoWeb = blPedidoWeb.GetPedidoWebByCampaniaConsultora(paisID, Convert.ToInt32(campaniaID), Convert.ToInt32(consultoraID));

                    if (bePedidoWeb != null)
                    {
                        BLPedidoWebDetalle blPedidoWebDetalle = new BLPedidoWebDetalle();
                        IList<BEPedidoWebDetalle> listaBEPedidoWebDetalle = blPedidoWebDetalle.GetPedidoWebDetalleByPedidoID(paisID, bePedidoWeb.CampaniaID, bePedidoWeb.PedidoID);

                        bePedidoDD = new BEPedidoDD();
                        bePedidoDD.PaisID = paisID;
                        bePedidoDD.CampaniaID = bePedidoWeb.CampaniaID;
                        bePedidoDD.ConsultoraID = bePedidoWeb.ConsultoraID;
                        bePedidoDD.IndicadorEnviado = false;
                        bePedidoDD.IPUsuario = "0.0.0.0";
                        bePedidoDD.NumeroClientes = bePedidoWeb.Clientes;
                        bePedidoDD.CodigoUsuarioCreacion = DigitadorCodigo;
                        bePedidoDD.PedidoDDDetalle = new List<BEPedidoDDDetalle>();

                        foreach (var detalleWeb in listaBEPedidoWebDetalle)
                        {
                            BEPedidoDDDetalle bePedidoDDDetalle = new BEPedidoDDDetalle();
                            bePedidoDDDetalle.CampaniaID = bePedidoWeb.CampaniaID;
                            bePedidoDDDetalle.ConsultoraID = bePedidoWeb.ConsultoraID;
                            bePedidoDDDetalle.Cantidad = detalleWeb.Cantidad;
                            bePedidoDDDetalle.CUV = detalleWeb.CUV;
                            bePedidoDDDetalle.CodigoUsuarioCreacion = DigitadorCodigo;

                            bePedidoDD.PedidoDDDetalle.Add(bePedidoDDDetalle);
                        }

                        InsPedidoDD(bePedidoDD);
                        consultorasProcesadas.Add(consultoraCodigo);
                    }
                    else
                    {
                        consultorasSinPedido.Add(consultoraCodigo);
                    }
                }
            }

            string cadenaConsultorasSinPedidos = String.Join(", ", consultorasSinPedido.ToArray());
            string resultado = string.Format("{0};{1}", consultorasProcesadas.Count, cadenaConsultorasSinPedidos);

            return resultado;
        }

        public void InsPedidoDD(BEPedidoDD bePedidoDD)
        {
            try
            {
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoDD daPedidoDD = new DAPedidoDD(bePedidoDD.PaisID);

                    int pedidoID = daPedidoDD.InsPedidoDD(bePedidoDD);

                    BLPedidoDDDetalle blPedidoDDDetalle = new BLPedidoDDDetalle();

                    foreach (var detalleDD in bePedidoDD.PedidoDDDetalle)
                    {
                        detalleDD.PedidoID = pedidoID;
                        blPedidoDDDetalle.InsPedidoDetalleDD(bePedidoDD.PaisID, detalleDD);
                    }

                    oTransactionScope.Complete();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void UpdPedidoDD(BEPedidoDD bePedidoDD)
        {
            try
            {
                TransactionOptions oTransactionOptions = new TransactionOptions();
                oTransactionOptions.IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted;

                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoDD daPedidoDD = new DAPedidoDD(bePedidoDD.PaisID);
                    daPedidoDD.UpdPedidoDD(bePedidoDD);

                    BLPedidoDDDetalle blPedidoDDDetalle = new BLPedidoDDDetalle();
                    //Obtenemos la lista de detalles historicos del pedido
                    IList<BEPedidoDDDetalle> detallesHist = blPedidoDDDetalle.GetPedidoDDDetalleByPedidoID(bePedidoDD.PaisID, bePedidoDD.CampaniaID, bePedidoDD.PedidoID);
                    foreach (var detalleDD in bePedidoDD.PedidoDDDetalle)
                    {
                        detalleDD.PedidoID = bePedidoDD.PedidoID;
                        //Buscamos si el detalle ya existe en el detalle historico del pedido, y actualizamos sus datos
                        foreach (var detalleDDHist in detallesHist)
                        {
                            if (detalleDDHist.CUV == detalleDD.CUV && detalleDDHist.IndicadorActivo)
                            {
                                detalleDD.Cantidad += detalleDDHist.Cantidad;
                                detalleDD.IndicadorActivo = detalleDDHist.IndicadorActivo;
                                detalleDD.PedidoDetalleID = detalleDDHist.PedidoDetalleID;
                                break;
                            }
                        }
                        blPedidoDDDetalle.UpdPedidoDetalleDD(bePedidoDD.PaisID, detalleDD);
                    }

                    oTransactionScope.Complete();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public void UpdPedidoDDIndicadoEnviado(BEPedidoDD bePedidoDD)
        {
            DAPedidoDD daPedidoDD = new DAPedidoDD(bePedidoDD.PaisID);

            daPedidoDD.UpdIndicadoEnviado(bePedidoDD);
        }

        public IList<BEPedidoDD> GetPedidosIngresados(int paisID, string codigoUsuario, DateTime fechaIngreso, string codigoConsultora, int campaniaID, string codigoZona, bool indicadorActivo)
        {
            List<BEPedidoDD> pedidosIngresados = new List<BEPedidoDD>();
            if (string.IsNullOrEmpty(codigoUsuario) && fechaIngreso == DateTime.MinValue && string.IsNullOrEmpty(codigoConsultora) && string.IsNullOrEmpty(codigoZona) && campaniaID == 0)
                return pedidosIngresados;

            var daPedidoDD = new DAPedidoDD(paisID);

            using (IDataReader reader = daPedidoDD.GetPedidosIngresados(codigoUsuario, fechaIngreso, codigoConsultora, campaniaID, codigoZona, indicadorActivo))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                while (reader.Read())
                {
                    pedidosIngresados.Add(new BEPedidoDD(reader, columns));
                }
            }
            return pedidosIngresados;
        }

        public void AnularPedido(int paisID, int campaniaID, int pedidoID)
        {
            var daPedidoDD = new DAPedidoDD(paisID);
            daPedidoDD.AnularPedido(campaniaID, pedidoID);
        }

        public bool VerificarAsistenciaCompartamos(int paisID, int campaniaID, long consultoraID)
        {
            bool resultado;
            try
            {
                var daPedidoDD = new DAPedidoDD(paisID);
                resultado = daPedidoDD.VerificarAsistenciaCompartamos(campaniaID, consultoraID);
            }
            catch (Exception)
            {
                resultado = false;
            }

            return resultado;
        }

        public int ValidarCuvDescargado(int paisID, int anioCampania, string codigoVenta, string codigoConsultora)
        {
            int resultado;
            resultado = 0;
            var DAPedidoDD = new DAPedidoDD(paisID);
            using (IDataReader reader = DAPedidoDD.ValidarCuvDescargado(anioCampania, codigoVenta, codigoConsultora))
                while (reader.Read())
                {
                    resultado = Convert.ToInt32(reader[0]);
                }
            return resultado;
        }

        public void RegistrarAsistenciaCompartamos(int paisID, BEAsistenciaCompartamos beAsistenciaCompartamos)
        {
            try
            {
                var daPedidoDD = new DAPedidoDD(paisID);
                daPedidoDD.RegistrarAsistenciaCompartamos(beAsistenciaCompartamos);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public BEPedidoDD GetPedidoDDByCampaniaConsultoraHabilitarPedido(int paisID, int campaniaID, long consultoraID)
        {
            BEPedidoDD bePedidoDD = null;
            DAPedidoDD daPedidoDD = new DAPedidoDD(paisID);

            using (IDataReader reader = daPedidoDD.GetPedidoDDByCampaniaConsultoraHabilitarPedido(campaniaID, consultoraID))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    bePedidoDD = new BEPedidoDD(reader, columns);
                }
            }
            return bePedidoDD;
        }

        public IList<string> HabilitaPedidoMultipleInformacionConsultoras(int paisID, IDictionary<string, string> listaConsultoras)
        {
            var listConsultorasPedido = new List<string>();
            var blConsultora = new BLConsultora();

            foreach (var item in listaConsultoras)
            {
                string codigoConsultora = item.Key;
                string codigoUsuarioDigitador = item.Value;

                BEConsultoraDD beConsultora = blConsultora.GetConsultoraByCodigoHabilitarPedido(paisID, codigoConsultora);

                if (beConsultora != null)
                {
                    listConsultorasPedido.Add(string.Format("{0};{1};{2};{3};{4}", beConsultora.ConsultoraID, codigoConsultora, beConsultora.CampaniaID, codigoUsuarioDigitador, 1));
                }
                else
                {
                    listConsultorasPedido.Add(string.Format("{0};{1};{2};{3};{4}", 0, codigoConsultora, 0, codigoUsuarioDigitador, 0));
                }
            }

            return listConsultorasPedido;
        }
    }
}
