﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;

// R2073 - Toda la clase
namespace Portal.Consultoras.Data
{
    public class DAValidacionAutomatica : DataAccess
    {
        public DAValidacionAutomatica(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        #region PROL AUTO MOVIL

        public IDataReader InsValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsValidacionMovilPROLLog");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, oBEValidacionMovil.CampaniaId);
            Context.Database.AddInParameter(command, "@PedidoId", DbType.Int32, oBEValidacionMovil.PedidoId);
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, oBEValidacionMovil.ConsultoraId);

            return Context.ExecuteReader(command);
        }

        public void UpdValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdValidacionMovilPROLLog");
            Context.Database.AddInParameter(command, "@ValidacionMovilPROLLogId", DbType.Int64, oBEValidacionMovil.ValidacionMovilPROLLogId);
            Context.Database.AddInParameter(command, "@NumeroItemsEnviados", DbType.Int32, oBEValidacionMovil.NumeroItemsEnviados);
            Context.Database.AddInParameter(command, "@Estado", DbType.Int32, oBEValidacionMovil.Estado);
            Context.Database.AddInParameter(command, "@EstadoPROL", DbType.AnsiString, oBEValidacionMovil.EstadoPROL);
            Context.Database.AddInParameter(command, "@Observaciones", DbType.AnsiString, oBEValidacionMovil.Observaciones);
            Context.Database.AddInParameter(command, "@Error", DbType.AnsiString, oBEValidacionMovil.Error);
            Context.Database.AddInParameter(command, "@EsMontoMinimo", DbType.Boolean, oBEValidacionMovil.EsMontoMinimo);
            Context.Database.AddInParameter(command, "@MontoTotalProl", DbType.Decimal, oBEValidacionMovil.MontoTotalProl);
            Context.Database.AddInParameter(command, "@DescuentoProl", DbType.Decimal, oBEValidacionMovil.DescuentoProl);

            Context.ExecuteNonQuery(command);
        }

        public string GetValidacionMovilPROLLog(BEValidacionMovil oBEValidacionMovil)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetValidacionMovilPROLLog");
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, oBEValidacionMovil.CampaniaId);
            Context.Database.AddInParameter(command, "@PedidoId", DbType.Int32, oBEValidacionMovil.PedidoId);
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, oBEValidacionMovil.ConsultoraId);

            return Convert.ToString(Context.ExecuteScalar(command));
        }

        public void UpdValAutoPROLPedidoWeb(int CampaniaId, int PedidoId, int EstadoPedido, bool ItemsEliminados, decimal montoTotalProl, decimal descuentoProl)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("UpdValAutoPROLPedidoWeb", CampaniaId, PedidoId, EstadoPedido, ItemsEliminados, montoTotalProl, descuentoProl);
            Context.ExecuteNonQuery(command);
        }

        public void InsPedidoWebAccionesPROLAuto(BEAccionesPROL oBEAccionesPROL)
        {
            //TipoOrigen 2: Validacion Automatica Movil
            DbCommand command = Context.Database.GetStoredProcCommand("InsPedidoWebAccionesPROL",
                oBEAccionesPROL.CampaniaID,
                oBEAccionesPROL.PedidoID,
                oBEAccionesPROL.PedidoDetalleID,
                oBEAccionesPROL.ConsultoraID,
                oBEAccionesPROL.CUV,
                oBEAccionesPROL.Cantidad,
                oBEAccionesPROL.PrecioUnidad,
                oBEAccionesPROL.Tipo,
                oBEAccionesPROL.Accion,
                oBEAccionesPROL.MensajePROL,
                oBEAccionesPROL.ValAutomaticaPROLLogId,
                oBEAccionesPROL.CodigoObservacion,
                2);

            Context.ExecuteNonQuery(command);
        }

        public void DelPedidoWebDetalleValAuto(int CampaniaID, int PedidoID, int PedidoDetalleID, long ConsultoraID, int MarcaID, string CUV, int Cantidad, decimal PrecioUnidad, DateTime FechaCreacion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("DelPedidoWebDetalleValAuto",
                CampaniaID,
                PedidoID,
                PedidoDetalleID,
                ConsultoraID,
                MarcaID,
                CUV,
                Cantidad,
                PrecioUnidad,
                FechaCreacion);

            Context.ExecuteNonQuery(command);
        }

        public void UpdPedidoWebDetalleObsPROL(int CampaniaId, int PedidoId, int PedidoDetalleId, string ObservacionPROL, bool Tipo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdPedidoWebDetalleObsPROL",
                CampaniaId,
                PedidoId,
                PedidoDetalleId,
                ObservacionPROL,
                Tipo);
            Context.ExecuteNonQuery(command);
        }

        public List<BEPedidoWebDetalle> GetPedidoWebDetalleValidacionPROL(int CampaniaId, int PedidoId)
        {
            List<BEPedidoWebDetalle> olstPedidoDetallePROL = new List<BEPedidoWebDetalle>();
            DbCommand oDbCommand = Context.Database.GetStoredProcCommand("GetPedidoWebDetalleValidacionPROL", CampaniaId, PedidoId);

            using (IDataReader oReader = Context.Database.ExecuteReader(oDbCommand))
            {
                while (oReader.Read())
                {
                    BEPedidoWebDetalle oBEPedidoDetallePROL = new BEPedidoWebDetalle();
                    oBEPedidoDetallePROL.PedidoDetalleID = Convert.ToInt16(oReader["PedidoDetalleID"]);
                    oBEPedidoDetallePROL.CUV = Convert.ToString(oReader["CUV"]);
                    oBEPedidoDetallePROL.Cantidad = Convert.ToInt32(oReader["Cantidad"]);
                    oBEPedidoDetallePROL.PrecioUnidad = Convert.ToDecimal(oReader["PrecioUnidad"]);
                    oBEPedidoDetallePROL.TipoOfertaSisID = Convert.ToInt32(oReader["TipoOfertaSisID"]);
                    oBEPedidoDetallePROL.ImporteTotal = Convert.ToDecimal(oReader["ImporteTotal"]);
                    oBEPedidoDetallePROL.FechaCreacion = Convert.ToDateTime(oReader["FechaCreacion"]);
                    olstPedidoDetallePROL.Add(oBEPedidoDetallePROL);
                }
            }
            return olstPedidoDetallePROL;
        }

        public void InsPedidoWebCorreoPROL(long ValAutomaticaPROLLogId, int CampaniaID, int PedidoID)
        {
            //TipoOrigen 2: Validacion Automatica Movil
            DbCommand oDbCommand = Context.Database.GetStoredProcCommand("InsPedidoWebCorreoPROL",
                ValAutomaticaPROLLogId,
                CampaniaID,
                PedidoID,
                2);

            Context.Database.ExecuteNonQuery(oDbCommand);

        }

        #endregion

        #region PROL AUTO ADMIN

        //JZ_VAL_PROL_AUTO
        public int GetEstadoProcesoPROLAuto()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetEstadoProcesoPROLAuto");
            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        //JZ_VAL_PROL_AUTO
        public IDataReader GetEstadoProcesoPROLAutoDetalle()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("GetEstadoProcesoPROLAutoDetalle");
            return Context.ExecuteReader(command);
        }

        #endregion
    }
}
