using System;
using System.Data;
using System.Data.Common;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DATracking : DataAccess
    {
        public DATracking(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPedidosByConsultora(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosByConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            return Context.ExecuteReader(command);
        }

        /* PCABRERA GR-1883 - INICIO */
        //public IDataReader GetTrackingByPedido(string codigo, string campana, DateTime fecha)
        public IDataReader GetTrackingByPedido(string codigo, string campana, string nropedido)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTrackingByConsultoraCampaniaFecha");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigo);
            Context.Database.AddInParameter(command, "@Campana", DbType.String, campana);
            //Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, fecha);
            Context.Database.AddInParameter(command, "@NroPedido", DbType.String, nropedido);
            return Context.ExecuteReader(command);
        }
        /* PCABRERA GR-1883 - INICIO */

        //Inicio ITG 1793 HFMG
        public IDataReader GetNovedadesTracking(string NumeroPedido)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("BelEntrega.GetNovedadesTracking");
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.String, NumeroPedido);
            return Context.ExecuteReader(command);
        }
        //Fin ITG 1793 HFMG

        // Req. 1717 - Inicio
        public int InsConfirmacionEntrega(BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("BelEntrega.InsConfirmacionEntrega");
            Context.Database.AddInParameter(command, "@IdentificadorEntrega", DbType.Int32, oBEConfirmacionEntrega.IdentificadorEntrega);
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.AnsiString, oBEConfirmacionEntrega.NumeroPedido);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, oBEConfirmacionEntrega.CodigoConsultora);
            Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, oBEConfirmacionEntrega.Fecha);
            Context.Database.AddInParameter(command, "@Latitud", DbType.AnsiString, oBEConfirmacionEntrega.Latitud);
            Context.Database.AddInParameter(command, "@Longitud", DbType.AnsiString, oBEConfirmacionEntrega.Longitud);
            Context.Database.AddInParameter(command, "@TipoEntrega", DbType.AnsiString, oBEConfirmacionEntrega.TipoEntrega);
            Context.Database.AddInParameter(command, "@Novedad", DbType.AnsiString, oBEConfirmacionEntrega.Novedad);
            Context.Database.AddInParameter(command, "@Observacion", DbType.AnsiString, oBEConfirmacionEntrega.Observacion);
            Context.Database.AddInParameter(command, "@CodigoPlataforma", DbType.AnsiString, oBEConfirmacionEntrega.CodigoPlataforma);
            Context.Database.AddInParameter(command, "@Foto1", DbType.AnsiString, oBEConfirmacionEntrega.Foto1);
            Context.Database.AddInParameter(command, "@Foto2", DbType.AnsiString, oBEConfirmacionEntrega.Foto2);
            Context.Database.AddInParameter(command, "@Foto3", DbType.AnsiString, oBEConfirmacionEntrega.Foto3);
            Context.Database.AddInParameter(command, "@Firma", DbType.AnsiString, oBEConfirmacionEntrega.Firma);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public int UpdConfirmacionEntrega(BEConfirmacionEntrega oBEConfirmacionEntrega)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("BelEntrega.UpdConfirmacionEntrega");
            Context.Database.AddInParameter(command, "@IdentificadorEntrega", DbType.Int32, oBEConfirmacionEntrega.IdentificadorEntrega);
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.AnsiString, oBEConfirmacionEntrega.NumeroPedido);
            Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, oBEConfirmacionEntrega.Fecha);
            Context.Database.AddInParameter(command, "@Foto1", DbType.AnsiString, oBEConfirmacionEntrega.Foto1);
            Context.Database.AddInParameter(command, "@Foto2", DbType.AnsiString, oBEConfirmacionEntrega.Foto2);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        /* EPD-665 - INICIO */
        public void InsLogConfirmacionEntrega(BELogConfirmacionEntrega oBELogConfirmacionEntrega)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("BelEntrega.InsLogConfirmacionEntrega");
            Context.Database.AddInParameter(command, "@LogTipoReg", DbType.Int32, oBELogConfirmacionEntrega.LogTipoReg);
            Context.Database.AddInParameter(command, "@LogResult", DbType.Int32, oBELogConfirmacionEntrega.LogResult);
            //Context.Database.AddInParameter(command, "@ConfirmacionEntregaId", DbType.Int32, oBELogConfirmacionEntrega.ConfirmacionEntregaId);

            Context.Database.AddInParameter(command, "@IdentificadorEntrega", DbType.Int32, oBELogConfirmacionEntrega.IdentificadorEntrega);
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.AnsiString, oBELogConfirmacionEntrega.NumeroPedido);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, oBELogConfirmacionEntrega.CodigoConsultora);
            Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, oBELogConfirmacionEntrega.Fecha);
            Context.Database.AddInParameter(command, "@Latitud", DbType.AnsiString, oBELogConfirmacionEntrega.Latitud);
            Context.Database.AddInParameter(command, "@Longitud", DbType.AnsiString, oBELogConfirmacionEntrega.Longitud);
            Context.Database.AddInParameter(command, "@TipoEntrega", DbType.AnsiString, oBELogConfirmacionEntrega.TipoEntrega);
            Context.Database.AddInParameter(command, "@Novedad", DbType.AnsiString, oBELogConfirmacionEntrega.Novedad);
            Context.Database.AddInParameter(command, "@Observacion", DbType.AnsiString, oBELogConfirmacionEntrega.Observacion);
            Context.Database.AddInParameter(command, "@CodigoPlataforma", DbType.AnsiString, oBELogConfirmacionEntrega.CodigoPlataforma);
            Context.Database.AddInParameter(command, "@Foto1", DbType.AnsiString, oBELogConfirmacionEntrega.Foto1);
            Context.Database.AddInParameter(command, "@Foto2", DbType.AnsiString, oBELogConfirmacionEntrega.Foto2);
            Context.Database.AddInParameter(command, "@Foto3", DbType.AnsiString, oBELogConfirmacionEntrega.Foto3);
            Context.Database.AddInParameter(command, "@Firma", DbType.AnsiString, oBELogConfirmacionEntrega.Firma);

            Context.ExecuteNonQuery(command);
        }
        /* EPD-665 - FIN */

        //R2004
        public IDataReader GetPedidoRechazadoByConsultora(string CampaniaId, string CodigoConsultora, DateTime Fecha)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("BelEntrega.GetPedidoRechazadoByConsultora");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, Fecha);
            return Context.ExecuteReader(command);
        }

        //R2004
        public IDataReader GetPedidoAnuladoByConsultora(string CampaniaId, string CodigoConsultora, DateTime Fecha, string NumeroPedido)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("BelEntrega.GetPedidoAnuladoByConsultora");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, CampaniaId);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, Fecha);
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.String, NumeroPedido);
            return Context.ExecuteReader(command);
        }

        //RQ 20150711 - Inicio
        public int InsConfirmacionRecojo(BEConfirmacionRecojo oBEConfirmacionRecojo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("BelEntrega.InsConfirmacionRecojo");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, oBEConfirmacionRecojo.Campania);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, oBEConfirmacionRecojo.CodigoConsultora);
            Context.Database.AddInParameter(command, "@CodigoPlataforma", DbType.AnsiString, oBEConfirmacionRecojo.CodigoPlataforma);
            Context.Database.AddInParameter(command, "@NumeroRecojo", DbType.AnsiString, oBEConfirmacionRecojo.NumeroRecojo);
            Context.Database.AddInParameter(command, "@NumeroPedido", DbType.AnsiString, oBEConfirmacionRecojo.NumeroPedido);
            Context.Database.AddInParameter(command, "@FechaRecojo", DbType.DateTime, oBEConfirmacionRecojo.FechaRecojo);
            Context.Database.AddInParameter(command, "@FechaEstimadaRecojo", DbType.DateTime, oBEConfirmacionRecojo.FechaEstimadoRecojo);
            Context.Database.AddInParameter(command, "@Latitud", DbType.AnsiString, oBEConfirmacionRecojo.Latitud);
            Context.Database.AddInParameter(command, "@Longitud", DbType.AnsiString, oBEConfirmacionRecojo.Longitud);
            Context.Database.AddInParameter(command, "@EstadoRecojoID", DbType.AnsiString, oBEConfirmacionRecojo.EstadoRecojo);
            Context.Database.AddInParameter(command, "@CodigoTipoNovedadRecojo", DbType.AnsiString, oBEConfirmacionRecojo.CodigoTipoNovedadRecojo);
            Context.Database.AddInParameter(command, "@Foto1", DbType.AnsiString, oBEConfirmacionRecojo.Foto1);
            Context.Database.AddInParameter(command, "@Foto2", DbType.AnsiString, oBEConfirmacionRecojo.Foto2);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }

        public IDataReader GetMisPostVentaByConsultora(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetMisPostVentaByConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetSeguimientoPostVenta(string numeroRecojo, int estadoRecojoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetSeguimientoPostVenta");
            Context.Database.AddInParameter(command, "@NumeroRecojo", DbType.String, numeroRecojo);
            Context.Database.AddInParameter(command, "@EstadoRecojoID", DbType.Int32, estadoRecojoID);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetNovedadPostVenta(string numeroRecojo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetNovedadPostVenta");
            Context.Database.AddInParameter(command, "@NumeroRecojo", DbType.String, numeroRecojo);
            return Context.ExecuteReader(command);
        }
        //RQ 20150711 - FIN

    }
}