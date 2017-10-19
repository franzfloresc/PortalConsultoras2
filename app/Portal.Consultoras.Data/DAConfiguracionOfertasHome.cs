﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionOfertasHome : DataAccess
    {

        public DAConfiguracionOfertasHome(int OfertasHomeID)
            : base(OfertasHomeID, EDbSource.Portal)
        {

        }

        public IDataReader GetList(int campaniaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionOfertasHomeList");
            Context.Database.AddInParameter(command, "CampaniaId", DbType.Int32, campaniaId);
            return Context.ExecuteReader(command);
        }

        public IDataReader Get(int configuracionOfertasHomeId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionOfertasHomeGet");
            Context.Database.AddInParameter(command, "ConfiguracionOfertasHomeID", DbType.Int32, configuracionOfertasHomeId);
            return Context.ExecuteReader(command);
        }

        public IDataReader Update(BEConfiguracionOfertasHome entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionOfertasHomeUpdate");
            Context.Database.AddInParameter(command, "ConfiguracionOfertasHomeID", DbType.Int32, entity.ConfiguracionOfertasHomeID);
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.Int32, entity.ConfiguracionPaisID);
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "DesktopOrden", DbType.Int32, entity.DesktopOrden);
            Context.Database.AddInParameter(command, "MobileOrden", DbType.Int32, entity.MobileOrden);
            Context.Database.AddInParameter(command, "DesktopImagenFondo", DbType.String, entity.DesktopImagenFondo);
            Context.Database.AddInParameter(command, "MobileImagenFondo", DbType.String, entity.MobileImagenFondo);
            Context.Database.AddInParameter(command, "DesktopTitulo", DbType.String, entity.DesktopTitulo);
            Context.Database.AddInParameter(command, "MobileTitulo", DbType.String, entity.MobileTitulo);
            Context.Database.AddInParameter(command, "DesktopSubTitulo", DbType.String, entity.DesktopSubTitulo);
            Context.Database.AddInParameter(command, "MobileSubTitulo", DbType.String, entity.MobileSubTitulo);
            Context.Database.AddInParameter(command, "DesktopTipoPresentacion", DbType.Int32, entity.DesktopTipoPresentacion);
            Context.Database.AddInParameter(command, "MobileTipoPresentacion", DbType.Int32, entity.MobileTipoPresentacion);
            Context.Database.AddInParameter(command, "DesktopTipoEstrategia", DbType.String, entity.DesktopTipoEstrategia);
            Context.Database.AddInParameter(command, "MobileTipoEstrategia", DbType.String, entity.MobileTipoEstrategia);
            Context.Database.AddInParameter(command, "DesktopCantidadProductos", DbType.Int32, entity.DesktopCantidadProductos);
            Context.Database.AddInParameter(command, "MobileCantidadProductos", DbType.Int32, entity.MobileCantidadProductos);
            Context.Database.AddInParameter(command, "DesktopActivo", DbType.Boolean, entity.DesktopActivo);
            Context.Database.AddInParameter(command, "MobileActivo", DbType.Boolean, entity.MobileActivo);
            Context.Database.AddInParameter(command, "UrlSeccion", DbType.String, entity.UrlSeccion);

            // BPT 353
            Context.Database.AddInParameter(command, "DesktopOrdenBpt", DbType.String, entity.DesktopOrdenBpt);
            Context.Database.AddInParameter(command, "MobileOrdenBpt", DbType.String, entity.MobileOrdenBpt);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetListarSeccion(int campaniaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionOfertasHomeListarSecciones");
            Context.Database.AddInParameter(command, "CampaniaId", DbType.Int32, campaniaId);
            return Context.ExecuteReader(command);
        }
    }
}
