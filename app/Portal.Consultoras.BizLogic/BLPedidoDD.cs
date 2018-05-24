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
            BEPedidoDD bePedidoDd = null;
            DAPedidoDD daPedidoDd = new DAPedidoDD(paisID);

            using (IDataReader reader = daPedidoDd.GetPedidoDDByCampaniaConsultora(campaniaID, consultoraID))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    bePedidoDd = new BEPedidoDD(reader, columns);
                }
            }
            return bePedidoDd;
        }

        public void HabiliatPedidoIndividual(int paisID, int campaniaID, long consultoraID, string usuarioDigitador, bool indicadoEnviado)
        {
            BLPedidoWeb blPedidoWeb = new BLPedidoWeb();

            BEPedidoWeb bePedidoWeb = blPedidoWeb.GetPedidoWebByCampaniaConsultora(paisID, campaniaID, consultoraID);
            BEPedidoDD bePedidoDd = GetPedidoDDByCampaniaConsultora(paisID, campaniaID, consultoraID);

            if (bePedidoWeb != null)
            {
                if (bePedidoDd != null)
                {
                    BLPedidoDDDetalle blPedidoDdDetalle = new BLPedidoDDDetalle();
                    BLPedidoWebDetalle blPedidoWebDetalle = new BLPedidoWebDetalle();

                    IList<BEPedidoDDDetalle> listaBePedidoDdDetalle = blPedidoDdDetalle.GetPedidoDDDetalleByPedidoID(paisID, campaniaID, bePedidoDd.PedidoID);
                    IList<BEPedidoWebDetalle> listaBePedidoWebDetalle = blPedidoWebDetalle.GetPedidoWebDetalleByPedidoID(paisID, campaniaID, bePedidoWeb.PedidoID);

                    bePedidoDd.IndicadorActivo = true;
                    bePedidoDd.IndicadorEnviado = indicadoEnviado;
                    bePedidoDd.CodigoUsuarioModificacion = usuarioDigitador;
                    bePedidoDd.PedidoDDDetalle = new List<BEPedidoDDDetalle>(listaBePedidoDdDetalle);

                    foreach (var detalleWeb in listaBePedidoWebDetalle)
                    {
                        var bePedidoDdDetalle = bePedidoDd.PedidoDDDetalle.FirstOrDefault(p => p.CUV.CompareTo(detalleWeb.CUV) == 0);
                        if (bePedidoDdDetalle == null)
                        {
                            bePedidoDdDetalle = new BEPedidoDDDetalle
                            {
                                CampaniaID = campaniaID,
                                ConsultoraID = consultoraID,
                                Cantidad = detalleWeb.Cantidad,
                                CUV = detalleWeb.CUV,
                                IndicadorActivo = true,
                                CodigoUsuarioCreacion = usuarioDigitador
                            };

                            bePedidoDd.PedidoDDDetalle.Add(bePedidoDdDetalle);
                        }
                        else
                        {
                            bePedidoDdDetalle.Cantidad += detalleWeb.Cantidad;
                            bePedidoDdDetalle.CodigoUsuarioModificacion = usuarioDigitador;
                        }
                    }

                    UpdPedidoDD(bePedidoDd);
                }
                else
                {
                    BLPedidoWebDetalle blPedidoWebDetalle = new BLPedidoWebDetalle();
                    IList<BEPedidoWebDetalle> listaBePedidoWebDetalle = blPedidoWebDetalle.GetPedidoWebDetalleByPedidoID(paisID, campaniaID, bePedidoWeb.PedidoID);

                    bePedidoDd = new BEPedidoDD
                    {
                        PaisID = paisID,
                        CampaniaID = campaniaID,
                        ConsultoraID = consultoraID,
                        IndicadorEnviado = indicadoEnviado,
                        IPUsuario = "0.0.0.0",
                        NumeroClientes = bePedidoWeb.Clientes,
                        CodigoUsuarioCreacion = usuarioDigitador,
                        PedidoDDDetalle = new List<BEPedidoDDDetalle>()
                    };

                    foreach (var detalleWeb in listaBePedidoWebDetalle)
                    {
                        BEPedidoDDDetalle bePedidoDdDetalle = new BEPedidoDDDetalle
                        {
                            CampaniaID = campaniaID,
                            ConsultoraID = consultoraID,
                            Cantidad = detalleWeb.Cantidad,
                            CUV = detalleWeb.CUV,
                            CodigoUsuarioCreacion = usuarioDigitador
                        };

                        bePedidoDd.PedidoDDDetalle.Add(bePedidoDdDetalle);
                    }

                    InsPedidoDD(bePedidoDd);
                }
            }
            else
            {
                if (bePedidoDd != null)
                {
                    bePedidoDd.IndicadorEnviado = !indicadoEnviado;
                    UpdPedidoDDIndicadoEnviado(bePedidoDd);
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
                var consultoraId = datos[0];
                var consultoraCodigo = datos[1];
                var campaniaId = datos[2];
                var digitadorCodigo = datos[3];

                BEPedidoDD bePedidoDd = GetPedidoDDByCampaniaConsultoraHabilitarPedido(paisID, Convert.ToInt32(campaniaId), Convert.ToInt32(consultoraId));

                if (bePedidoDd != null)
                {
                    bePedidoDd.IndicadorEnviado = false;
                    bePedidoDd.CodigoUsuarioModificacion = digitadorCodigo;

                    UpdPedidoDDIndicadoEnviado(bePedidoDd);
                    consultorasProcesadas.Add(consultoraCodigo);
                }
                else
                {
                    BLPedidoWeb blPedidoWeb = new BLPedidoWeb();
                    BEPedidoWeb bePedidoWeb = blPedidoWeb.GetPedidoWebByCampaniaConsultora(paisID, Convert.ToInt32(campaniaId), Convert.ToInt32(consultoraId));

                    if (bePedidoWeb != null)
                    {
                        BLPedidoWebDetalle blPedidoWebDetalle = new BLPedidoWebDetalle();
                        IList<BEPedidoWebDetalle> listaBePedidoWebDetalle = blPedidoWebDetalle.GetPedidoWebDetalleByPedidoID(paisID, bePedidoWeb.CampaniaID, bePedidoWeb.PedidoID);

                        bePedidoDd = new BEPedidoDD
                        {
                            PaisID = paisID,
                            CampaniaID = bePedidoWeb.CampaniaID,
                            ConsultoraID = bePedidoWeb.ConsultoraID,
                            IndicadorEnviado = false,
                            IPUsuario = "0.0.0.0",
                            NumeroClientes = bePedidoWeb.Clientes,
                            CodigoUsuarioCreacion = digitadorCodigo,
                            PedidoDDDetalle = new List<BEPedidoDDDetalle>()
                        };

                        foreach (var detalleWeb in listaBePedidoWebDetalle)
                        {
                            BEPedidoDDDetalle bePedidoDdDetalle =
                                new BEPedidoDDDetalle
                                {
                                    CampaniaID = bePedidoWeb.CampaniaID,
                                    ConsultoraID = bePedidoWeb.ConsultoraID,
                                    Cantidad = detalleWeb.Cantidad,
                                    CUV = detalleWeb.CUV,
                                    CodigoUsuarioCreacion = digitadorCodigo
                                };

                            bePedidoDd.PedidoDDDetalle.Add(bePedidoDdDetalle);
                        }

                        InsPedidoDD(bePedidoDd);
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
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };

                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoDD daPedidoDd = new DAPedidoDD(bePedidoDD.PaisID);

                    int pedidoId = daPedidoDd.InsPedidoDD(bePedidoDD);

                    BLPedidoDDDetalle blPedidoDdDetalle = new BLPedidoDDDetalle();

                    foreach (var detalleDd in bePedidoDD.PedidoDDDetalle)
                    {
                        detalleDd.PedidoID = pedidoId;
                        blPedidoDdDetalle.InsPedidoDetalleDD(bePedidoDD.PaisID, detalleDd);
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
                TransactionOptions oTransactionOptions = new TransactionOptions
                {
                    IsolationLevel = System.Transactions.IsolationLevel.ReadUncommitted
                };

                using (TransactionScope oTransactionScope = new TransactionScope(TransactionScopeOption.Required, oTransactionOptions))
                {
                    DAPedidoDD daPedidoDd = new DAPedidoDD(bePedidoDD.PaisID);
                    daPedidoDd.UpdPedidoDD(bePedidoDD);

                    BLPedidoDDDetalle blPedidoDdDetalle = new BLPedidoDDDetalle();
                    //Obtenemos la lista de detalles historicos del pedido
                    IList<BEPedidoDDDetalle> detallesHist = blPedidoDdDetalle.GetPedidoDDDetalleByPedidoID(bePedidoDD.PaisID, bePedidoDD.CampaniaID, bePedidoDD.PedidoID);
                    foreach (var detalleDd in bePedidoDD.PedidoDDDetalle)
                    {
                        detalleDd.PedidoID = bePedidoDD.PedidoID;
                        //Buscamos si el detalle ya existe en el detalle historico del pedido, y actualizamos sus datos
                        foreach (var detalleDdHist in detallesHist)
                        {
                            if (detalleDdHist.CUV == detalleDd.CUV && detalleDdHist.IndicadorActivo)
                            {
                                detalleDd.Cantidad += detalleDdHist.Cantidad;
                                detalleDd.IndicadorActivo = detalleDdHist.IndicadorActivo;
                                detalleDd.PedidoDetalleID = detalleDdHist.PedidoDetalleID;
                                break;
                            }
                        }
                        blPedidoDdDetalle.UpdPedidoDetalleDD(bePedidoDD.PaisID, detalleDd);
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
            DAPedidoDD daPedidoDd = new DAPedidoDD(bePedidoDD.PaisID);

            daPedidoDd.UpdIndicadoEnviado(bePedidoDD);
        }

        public IList<BEPedidoDD> GetPedidosIngresados(int paisID, string codigoUsuario, DateTime fechaIngreso, string codigoConsultora, int campaniaID, string codigoZona, bool indicadorActivo)
        {
            List<BEPedidoDD> pedidosIngresados = new List<BEPedidoDD>();
            if (string.IsNullOrEmpty(codigoUsuario) && fechaIngreso == DateTime.MinValue && string.IsNullOrEmpty(codigoConsultora) && string.IsNullOrEmpty(codigoZona) && campaniaID == 0)
                return pedidosIngresados;

            var daPedidoDd = new DAPedidoDD(paisID);

            using (IDataReader reader = daPedidoDd.GetPedidosIngresados(codigoUsuario, fechaIngreso, codigoConsultora, campaniaID, codigoZona, indicadorActivo))
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
            var daPedidoDd = new DAPedidoDD(paisID);
            daPedidoDd.AnularPedido(campaniaID, pedidoID);
        }

        public bool VerificarAsistenciaCompartamos(int paisID, int campaniaID, long consultoraID)
        {
            bool resultado;
            try
            {
                var daPedidoDd = new DAPedidoDD(paisID);
                resultado = daPedidoDd.VerificarAsistenciaCompartamos(campaniaID, consultoraID);
            }
            catch (Exception)
            {
                resultado = false;
            }

            return resultado;
        }

        public int ValidarCuvDescargado(int paisID, int anioCampania, string codigoVenta, string codigoConsultora)
        {
            var resultado = 0;
            var daPedidoDd = new DAPedidoDD(paisID);
            using (IDataReader reader = daPedidoDd.ValidarCuvDescargado(anioCampania, codigoVenta, codigoConsultora))
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
                var daPedidoDd = new DAPedidoDD(paisID);
                daPedidoDd.RegistrarAsistenciaCompartamos(beAsistenciaCompartamos);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        public BEPedidoDD GetPedidoDDByCampaniaConsultoraHabilitarPedido(int paisID, int campaniaID, long consultoraID)
        {
            BEPedidoDD bePedidoDd = null;
            DAPedidoDD daPedidoDd = new DAPedidoDD(paisID);

            using (IDataReader reader = daPedidoDd.GetPedidoDDByCampaniaConsultoraHabilitarPedido(campaniaID, consultoraID))
            {
                var columns = ((IDataRecord)reader).GetAllNames();

                if (reader.Read())
                {
                    bePedidoDd = new BEPedidoDD(reader, columns);
                }
            }
            return bePedidoDd;
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
