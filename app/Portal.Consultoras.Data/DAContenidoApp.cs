using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAContenidoApp : DataAccess
    {
        public DAContenidoApp(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader Get(string Codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppGet");
            Context.Database.AddInParameter(command, "@Codigo", DbType.AnsiString, Codigo);
            return Context.ExecuteReader(command);

        }

        public void UpdContenidoApp(BEContenidoAppHistoria p)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppUpd");
            Context.Database.AddInParameter(command, "@IdContenido", DbType.Int32, p.IdContenido);
            Context.Database.AddInParameter(command, "@UrlMiniatura", DbType.AnsiString, p.UrlMiniatura);

            Context.ExecuteNonQuery(command);

        }

        public IDataReader GetList(BEContenidoAppList p)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppDetaList");
            Context.Database.AddInParameter(command, "@IdContenido", DbType.Int32, p.IdContenido);
            return Context.ExecuteReader(command);
        }

        public void InsertContenidoAppDeta(BEContenidoAppDeta p)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppDetaInsert");
            Context.Database.AddInParameter(command, "@Proc", DbType.Int32, p.Proc);
            Context.Database.AddInParameter(command, "@IdContenidoDeta", DbType.Int32, p.IdContenidoDeta);
            Context.Database.AddInParameter(command, "@IdContenido", DbType.Int32, p.IdContenido);
            Context.Database.AddInParameter(command, "@RutaContenido", DbType.AnsiString, p.RutaContenido);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, p.Campania);
            Context.Database.AddInParameter(command, "@Accion", DbType.AnsiString, p.Accion);
            Context.Database.AddInParameter(command, "@CodigoDetalle", DbType.AnsiString, p.CodigoDetalle);
            Context.Database.AddInParameter(command, "@tipo", DbType.AnsiString, p.Tipo);

            Context.ExecuteNonQuery(command);
        }

        public int UpdContenidoAppDeta(BEContenidoAppDeta p)
        {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppDetaUpd");
            Context.Database.AddInParameter(command, "@IdContenidoDeta", DbType.Int32, p.IdContenidoDeta);
            Context.Database.AddInParameter(command, "@IdContenido", DbType.Int32, p.IdContenido);
            Context.Database.AddOutParameter(command, "@respuesta", DbType.Int32, 1000);

            Context.ExecuteNonQuery(command);
            return Convert.ToInt32(command.Parameters["@respuesta"].Value);


        }

        public IDataReader GetContenidoAppDetaActList()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ContenidoAppDetaActList");
            return Context.ExecuteReader(command);

        }
    }
}