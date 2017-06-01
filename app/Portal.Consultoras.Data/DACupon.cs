﻿using Portal.Consultoras.Entities.Cupon;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DACupon : DataAccess
    {
        public void CrearCupon(BECupon cupon)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CrearCupon");
            Context.Database.AddInParameter(command, "@Tipo", DbType.String, cupon.Tipo);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, cupon.Descripcion);
            Context.Database.AddInParameter(command, "@CampaniaId", DbType.Int32, cupon.CampaniaId);

            Context.ExecuteNonQuery(command);
        }

        public void ActualizarCupon(BECupon cupon)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActualizarCupon");
            Context.Database.AddInParameter(command, "@CuponId", DbType.Int32, cupon.CuponId);
            Context.Database.AddInParameter(command, "@Tipo", DbType.String, cupon.Tipo);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.String, cupon.Descripcion);
            Context.Database.AddInParameter(command, "@Estado", DbType.Boolean, cupon.Estado);

            Context.ExecuteNonQuery(command);
        }

        public IDataReader ListarCupones()
        {
            try
            {
                using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarCupones"))
                {
                    return Context.ExecuteReader(command);
                }
            }
            catch (Exception ex) { throw ex; }
        }
    }
}