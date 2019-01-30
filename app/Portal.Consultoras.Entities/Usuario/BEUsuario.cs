﻿using OpenSource.Library.DataAccess;

using Portal.Consultoras.Common;

using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;
using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuario
    {
        public BEUsuario()
        {
        }

        [Column("Sobrenombre")]
        public string msSobrenombre { get; set; }
        [Column("PrimerNombre")]
        public string msPrimerNombre { get; set; }
        
        [Column("ESCONSULTORALIDER")]
        public int mesConsultoraLider { get; set; }
 
        private readonly bool bEsquemaDAConsultora;
       
        [Column("TIENEHANA")]
        public bool tieneHana { get; set; }

        [Column("TieneODD")]
        public int tieneOdd { get; set; }

        [Column("TieneLoginExterno")]
        public int tieneLoginExterno { get; set; }
         
        [Obsolete("Use MapUtil.MapToCollection")]
        public BEUsuario(IDataRecord row)
        {
            CodigoConsultora = row.ToString("CodigoConsultora");
            CodigoUsuario = row.ToString("CodigoUsuario");
            PaisID = row.ToInt32("PaisID");
            Nombre = row.ToString("Nombre");
            ClaveSecreta = row.ToString("ClaveSecreta");
            EMail = row.ToString("EMail");
            EMailActivo = row.ToBoolean("EMailActivo");
            Telefono = row.ToString("Telefono");
            Celular = row.ToString("Celular");
            msSobrenombre = row.ToString("Sobrenombre");
            CompartirDatos = row.ToBoolean("CompartirDatos");
            Activo = row.ToBoolean("Activo");
            TipoUsuario = row.ToInt16("TipoUsuario");
            CambioClave = row.ToBoolean("CambioClave");
            TelefonoTrabajo = row.ToString("TelefonoTrabajo");
            AceptoContrato = row.ToBoolean("AceptoContrato");
            MostrarAyudaWebTraking = row.ToBoolean("MostrarAyudaWebTraking");
            CodigoISO = row.ToString("CodigoISO");
            NombrePais = row.ToString("NombrePais");
            RolID = row.ToByte("RolID");
            BanderaImagen = row.ToString("BanderaImagen");
            Simbolo = row.ToString("Simbolo");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            Rol = row.ToString("Rol");
            ZonaID = row.ToInt32("ZonaID");
            SegmentoConstancia = row.ToString("SegmentoConstancia");
            SeccionAnalytics = row.ToString("Seccion");
            DescripcionNivel = row.ToString("DescripcionNivel");
            esConsultoraLider = row.ToBoolean("esConsultoraLider");
            EstadoSimplificacionCUV = row.ToBoolean("EstadoSimplificacionCUV");
            bEsquemaDAConsultora = row.ToBoolean("EsquemaDAConsultora");
            DigitoVerificador = row.ToString("DigitoVerificador");
            TieneCDRExpress = row.ToBoolean("TieneCDRExpress");
            EsConsecutivoNueva = row.ToBoolean("EsConsecutivoNueva");
            IndicadorConsultoraDigital = row.ToInt32("IndicadorConsultoraDigital");
        }

        [Obsolete("Use MapUtil.MapToCollection")]
        public BEUsuario(IDataRecord row, bool Tipo)
        {
            PaisID = row.ToInt32("PaisID");
            CodigoISO = row.ToString("CodigoISO", "");
            RegionID = row.ToInt32("RegionID");
            CodigorRegion = row.ToString("CodigorRegion", "");
            ZonaID = row.ToInt32("ZonaID");
            CodigoZona = row.ToString("CodigoZona", "");
            ConsultoraID = row.ToInt64("ConsultoraID");
            CodigoConsultora = row.ToString("CodigoConsultora", "");
            CodigoUsuario = row.ToString("CodigoUsuario", "");
            Nombre = row.ToString("NombreCompleto", "");
           RolID = row.ToInt16("RolID");
            EMail = row.ToString("EMail", "");
            Simbolo = row.ToString("Simbolo", "");
            TerritorioID = row.ToInt32("TerritorioID");
            CodigoTerritorio = row.ToString("CodigoTerritorio", "");
            MontoMinimoPedido = row.ToDecimal("MontoMinimoPedido");
            MontoMaximoPedido = row.ToDecimal("MontoMaximoPedido");
            BanderaImagen = row.ToString("BanderaImagen", "");
            CodigoFuente = row.ToString("CodigoFuente", "");
            NombrePais = row.ToString("NombrePais", "");
            CambioClave = row.ToBoolean("CambioClave");
            ConsultoraNueva = row.ToInt32("ConsultoraNueva");
            CodigoUsuario = row.ToString("CodigoUsuario", "");
            Telefono = row.ToString("Telefono", "");
            Celular = row.ToString("Celular", "");
            Segmento = row.ToString("Segmento", "");
            SegmentoAbreviatura = row.ToString("SegmentoAbreviatura", "");
            Sobrenombre = row.ToString("Sobrenombre", "");

            if (string.IsNullOrEmpty(msSobrenombre) && DataRecord.HasColumn(row, "PrimerNombre"))
                Sobrenombre = Convert.ToString(row["PrimerNombre"]);

            IndicadorDupla = row.ToInt32("IndicadorDupla");
            UsuarioPrueba = row.ToInt32("UsuarioPrueba");
            PasePedidoWeb = row.ToInt32("PasePedidoWeb");
            TipoOferta2 = row.ToInt32("TipoOferta2");
            CompraKitDupla = row.ToInt32("CompraKitDupla");
            CompraOfertaDupla = row.ToInt32("CompraOfertaDupla");
            CompraOfertaEspecial = row.ToInt32("CompraOfertaEspecial");
            IndicadorMeta = row.ToInt32("IndicadorMeta");
            ProgramaReconocimiento = row.ToInt32("ProgramaReconocimiento");
            NivelEducacion = row.ToInt32("NivelEducacion");
            SegmentoID = row.ToInt32("SegmentoID");
            FechaNacimiento = row.ToDateTime("FechaNacimiento");
            FechaLimPago = row.ToDateTime("FechaLimitePago");
            VioVideo = row.ToInt32("VioVideo");
            VioTutorial = row.ToInt32("VioTutorial");
            VioTutorialDesktop = row.ToInt32("VioTutorialDesktop");
            Nivel = row.ToString("Nivel");
            Direccion = row.ToString("Direccion");
            TelefonoTrabajo = row.ToString("TelefonoTrabajo");
            AnoCampaniaIngreso = row.ToString("AnoCampanaIngreso");
            PrimerNombre = row.ToString("PrimerNombre");
            PrimerApellido = row.ToString("PrimerApellido");
            IndicadorFlexiPago = row.ToInt32("IndicadorFlexiPago");
            IndicadorPermisoFIC = row.ToInt32("IndicadorPermisoFIC");
            PedidoFICActivo = row.ToBoolean("PedidoFICActivo");
            MostrarAyudaWebTraking = row.ToBoolean("MostrarAyudaWebTraking");
            RolDescripcion = row.ToString("RolDescripcion");
            NroCampanias = row.ToInt32("NroCampanias");
            Lider = row.ToInt32("Lider");
            ConsultoraAsociada = row.ToString("ConsultoraAsociada", string.Empty);
            CampaniaInicioLider = row.ToString("CampaniaInicioLider", string.Empty);
            SeccionGestionLider = row.ToString("SeccionGestionLider", string.Empty);
            NivelLider = row.ToInt32("NivelLider");
            PortalLideres = row.ToBoolean("PortalLideres");
            LogoLideres = row.ToString("LogoLideres", string.Empty);
            IndicadorContrato = row.ToInt32("IndicadorContrato");
            EsJoven = row.ToInt32("EsJoven");
            CodigoISO = row.ToString("CodigoISO");
            NombrePais = row.ToString("NombrePais");
            RolID = row.ToByte("RolID");
            BanderaImagen = row.ToString("BanderaImagen");
            Simbolo = row.ToString("Simbolo");
            FechaModificacion = row.ToDateTime("FechaModificacion");
            Rol = row.ToString("Rol");
            CampanaInvitada = row.ToString("CampanaInvitada");
            InscritaFlexipago = row.ToString("InscritaFlexipago");
            InvitacionRechazada = row.ToString("InvitacionRechazada");
            SegmentoConstancia = row.ToString("SegmentoConstancia");
            SeccionAnalytics = row.ToString("Seccion");
            DescripcionNivel = row.ToString("DescripcionNivel");
            esConsultoraLider = row.ToBoolean("esConsultoraLider");
            EMailActivo = row.ToBoolean("EMailActivo");
            SegmentoInternoID = row.ToInt32("SegmentoInternoId");
            EstadoSimplificacionCUV = row.ToBoolean("EstadoSimplificacionCUV");
            bEsquemaDAConsultora = row.ToBoolean("EsquemaDAConsultora");
            OfertaFinal = row.ToInt32("OfertaFinal");
            EsOfertaFinalZonaValida = row.ToBoolean("EsOfertaFinalZonaValida");
            OfertaFinalGanaMas = row.ToInt32("OfertaFinalGanaMas");
            EsOFGanaMasZonaValida = row.ToBoolean("EsOFGanaMasZonaValida");
            CatalogoPersonalizado = row.ToInt32("CatalogoPersonalizado");
            EsCatalogoPersonalizadoZonaValida = row.ToBoolean("EsCatalogoPersonalizadoZonaValida");
            VioTutorialSalvavidas = row.ToInt32("VioTutorialSalvavidas");
            TieneHana = row.ToInt32("TieneHana");
            IndicadorBloqueoCDR = row.ToInt32("IndicadorBloqueoCDR");
            EsCDRWebZonaValida = row.ToInt32("EsCDRWebZonaValida");
            TieneCDR = row.ToInt32("TieneCDR");
            TieneCupon = row.ToInt32("TieneCupon");
            TieneMasVendidos = row.ToInt32("TieneMasVendidos");
            TieneAsesoraOnline = row.ToInt32("TieneAsesoraOnline");
            TieneOfertaLog = row.ToInt32("TieneOfertaLog");
            IndicadorGPRSB = row.ToInt32("IndicadorGPRSB");
            EstadoPedido = row.ToInt32("EstadoPedido");
            ValidacionAbierta = row.ToBoolean("ValidacionAbierta");
            NombreGerenteZona = row.ToString("GerenteZona");
            DigitoVerificador = row.ToString("DigitoVerificador");
            OfertaDelDia = row.ToBoolean("TieneODD");
            ConsultoraAsociadaID = row.ToInt64("ConsultoraAsociadoID");
            DocumentoIdentidad = row.ToString("DocumentoIdentidad");
            TipoUsuario = row.ToInt16("TipoUsuario");
            TieneLoginExterno = row.ToBoolean("TieneLoginExterno");
            TieneCDRExpress = row.ToBoolean("TieneCDRExpress");
            EsConsecutivoNueva = row.ToBoolean("EsConsecutivoNueva");
            FechaInicioFacturacion = row.ToDateTime("FechaInicioFacturacion");
            FechaFinFacturacion = row.ToDateTime("FechaFinFacturacion");

            if (DataRecord.HasColumn(row, "HoraInicio"))
                HoraInicio = DbConvert.ToTimeSpan(row["HoraInicio"]);
            if (DataRecord.HasColumn(row, "HoraFin"))
                HoraFin = DbConvert.ToTimeSpan(row["HoraFin"]);

            DiasAntes = row.ToByte("DiasAntes");

            if (DataRecord.HasColumn(row, "ZonaValida"))
                ZonaValida = Convert.ToInt32(row["ZonaValida"]) != -1;
            if (DataRecord.HasColumn(row, "HoraInicioNoFacturable"))
                HoraInicioNoFacturable = DbConvert.ToTimeSpan(row["HoraInicioNoFacturable"]);
            if (DataRecord.HasColumn(row, "HoraCierreNoFacturable"))
                HoraCierreNoFacturable = DbConvert.ToTimeSpan(row["HoraCierreNoFacturable"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaNormal"))
                HoraCierreZonaNormal = DbConvert.ToTimeSpan(row["HoraCierreZonaNormal"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaDemAnti"))
                HoraCierreZonaDemAnti = DbConvert.ToTimeSpan(row["HoraCierreZonaDemAnti"]);

            ZonaHoraria = row.ToDouble("ZonaHoraria");
            EsZonaDemAnti = row.ToInt32("EsZonaDemAnti");
            DiasDuracionCronograma = row.ToByte("DiasDuracionCronograma");
            HabilitarRestriccionHoraria = row.ToBoolean("HabilitarRestriccionHoraria");
            HorasDuracionRestriccion = row.ToInt32("HorasDuracionRestriccion");
            PROLSinStock = row.ToBoolean("PROLSinStock");
            NuevoPROL = row.ToBoolean("NuevoPROL");
            ZonaNuevoPROL = row.ToBoolean("ZonaNuevoPROL");

            if (DataRecord.HasColumn(row, "HoraCierreZonaDemAntiCierre"))
                HoraCierreZonaDemAntiCierre = DbConvert.ToTimeSpan(row["HoraCierreZonaDemAntiCierre"]);

            ValidacionInteractiva = row.ToBoolean("ValidacionInteractiva");
            MensajeValidacionInteractiva = row.ToString("MensajeValidacionInteractiva");
            EstadoPedido = row.ToInt32("EstadoPedido");
            ValidacionAbierta = row.ToBoolean("ValidacionAbierta");
            FechaActualPais = row.ToDateTime("FechaActualPais");
            AceptacionConsultoraDA = row.ToInt32("AceptacionConsultoraDA");
            CompartirDatos = row.ToBoolean("CompartirDatos");
            FotoPerfil = row.ToString("FotoPerfil");
            ConsecutivoNueva = row.ToInt32("ConsecutivoNueva");
            CodigoPrograma = row.ToString("CodigoPrograma");
            CompraVDirecta = row.ToDouble("CompraVDirecta");
            IVACompraVDirecta = row.ToDouble("IVACompraVDirecta");
            Retail = row.ToDouble("Retail");
            IVARetail = row.ToDouble("IVARetail");
            TotalCompra = row.ToDouble("TotalCompra");
            IvaTotal = row.ToDouble("IvaTotal");
            EsConsultoraOficina = row.ToInt32("IndicadorConsultoraOficina") == 1;
            PromedioVenta = row.ToDouble("PromedioVenta");
            NovedadBuscador = row.ToInt32("NovedadBuscador");
        }

        [Column("ConsultoraAsociadoID")]
        [DataMember]
        public long ConsultoraAsociadaID { get; set; }

        [DataMember]
        public string RolDescripcion { get; set; }

        [Column("NroCampanias")]
        [DataMember]
        public int NroCampanias { get; set; }
        [DataMember]
        public int IndicadorDupla { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaNormal { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaDemAnti { get; set; }
        [DataMember]
        public double ZonaHoraria { get; set; }
        [DataMember]
        public int EsZonaDemAnti { get; set; }

        [Column("UsuarioPrueba")]
        public bool usuarioPrueba { get; set; }

        private int _UsuarioPrueba;
        [DataMember]
        public int UsuarioPrueba
        {
            get
            {
                return usuarioPrueba ? 1 : _UsuarioPrueba;
            }
            set
            {
                _UsuarioPrueba = value;
            }
        }
        [DataMember]
        public int PasePedidoWeb { get; set; }
        [DataMember]
        public int TipoOferta2 { get; set; }
        [DataMember]
        public int CompraKitDupla { get; set; }
        [DataMember]
        public int CompraOfertaDupla { get; set; }
        [DataMember]
        public int CompraOfertaEspecial { get; set; }
        [DataMember]
        public int IndicadorMeta { get; set; }
        [DataMember]
        public int ProgramaReconocimiento { get; set; }
        [DataMember]
        public int NivelEducacion { get; set; }
        [DataMember]
        public int SegmentoID { get; set; }
        [DataMember]
        [Column("FechaNacimiento")]
        public DateTime FechaNacimiento { get; set; }

        [Column("FechaLimitePago")]
        [DataMember]
        public DateTime FechaLimPago { get; set; }
        [DataMember]
        public int VioVideo { get; set; }
        [DataMember]
        public int VioTutorial { get; set; }
        [DataMember]
        public int VioTutorialDesktop { get; set; }
        [DataMember]
        public String Nivel { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public int IndicadorFlexiPago { get; set; }
        [DataMember]
        public int IndicadorPermisoFIC { get; set; }

        [DataMember]
        public string CampanaInvitada { get; set; }
        [DataMember]
        public string InscritaFlexipago { get; set; }
        [DataMember]
        public string InvitacionRechazada { get; set; }

        [DataMember]
        public int EsJoven { get; set; }
        [DataMember]
        public TimeSpan HoraCierreZonaDemAntiCierre { get; set; }

        [DataMember]
        public bool ValidacionInteractiva { get; set; }
        [DataMember]
        public string MensajeValidacionInteractiva { get; set; }

        [DataMember]
        [Column("ConsultoraNueva")]
        public int ConsultoraNueva { get; set; }
        [DataMember]
        public bool EsConsultoraNueva { get; set; }

        [DataMember]
        public string NombrePais { get; set; }

        [DataMember]
        public string BanderaImagen { get; set; }

        [DataMember]
        public string CodigoFuente { get; set; }

        [Column("CodigoUsuario")]
        [DataMember]
        public string CodigoUsuario { get; set; }

        [Column("CodigoConsultora")]
        [DataMember]
        public string CodigoConsultora { get; set; }

        [Column("PaisID")]
        [DataMember]
        public int PaisID { get; set; }

        [Column("NombreCompleto")]
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string ClaveSecreta { get; set; }
        [DataMember]
        public string ActualizarClave { get; set; }
        [DataMember]
        public string ConfirmarClave { get; set; }

        [Column("EMail")]
        [DataMember]
        public string EMail { get; set; }
        [DataMember]
        public bool EMailActivo { get; set; }

        [Column("Telefono")]
        [DataMember]
        public string Telefono { get; set; }

        [Column("TelefonoTrabajo")]
        [DataMember]
        public string TelefonoTrabajo { get; set; }

        [Column("Celular")]
        [DataMember]
        public string Celular { get; set; }

        [DataMember]
        public string Sobrenombre
        {
            get
            {
                if (string.IsNullOrEmpty(msSobrenombre)) msSobrenombre = msPrimerNombre;
                return msSobrenombre;
            }
            set { msSobrenombre = value; }
        }
        [DataMember]
        public bool CompartirDatos { get; set; }
        [DataMember]
        public bool AceptoContrato { get; set; }
        [DataMember]
        public bool Activo { get; set; }

        [Column("TipoUsuario")]
        [DataMember]
        public Int16 TipoUsuario { get; set; }

        [Column("CambioClave")]
        [DataMember]
        public bool CambioClave { get; set; }

        [Column("CodigoISO")]
        [DataMember]
        public string CodigoISO { get; set; }

        [Column("RegionID")]
        [DataMember]
        public int RegionID { get; set; }

        [Column("CodigorRegion")]
        [DataMember]
        public string CodigorRegion { get; set; }

        [Column("ZonaID")]
        [DataMember]
        public int ZonaID { get; set; }

        [Column("CodigoZona")]
        [DataMember]
        public string CodigoZona { get; set; }

        [Column("ConsultoraID")]
        [DataMember]
        public long ConsultoraID { get; set; }

        [Column("RolID")]
        [DataMember]
        public short RolID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }

        [DataMember]
        public DateTime FechaFinFacturacion { get; set; }

        [DataMember]
        public string CampaniaDescripcion { get; set; }

        [DataMember]
        public TimeSpan HoraInicio { get; set; }

        [DataMember]
        public TimeSpan HoraFin { get; set; }

        [DataMember]
        public bool ZonaValida { get; set; }

        [Column("Simbolo")]
        [DataMember]
        public string Simbolo { get; set; }

        [DataMember]
        public int TerritorioID { get; set; }

        [DataMember]
        public string CodigoTerritorio { get; set; }

        [Column("MontoMinimoPedido")]
        [DataMember]
        public decimal MontoMinimoPedido { get; set; }

        [Column("MontoMaximoPedido")]
        [DataMember]
        public decimal MontoMaximoPedido { get; set; }

        [DataMember]
        public TimeSpan HoraInicioNoFacturable { get; set; }

        [DataMember]
        public TimeSpan HoraCierreNoFacturable { get; set; }

        [DataMember]
        public int DiasAntes { get; set; }

        [DataMember]
        public string Segmento { get; set; }

        [DataMember]
        public int DiasDuracionCronograma { get; set; }

        [DataMember]
        public bool HabilitarRestriccionHoraria { get; set; }

        [DataMember]
        public int HorasDuracionRestriccion { get; set; }

        [DataMember]
        [Column("AnoCampanaIngreso")]
        public string AnoCampaniaIngreso { get; set; }

        [DataMember]
        [Column("PrimerNombre")]
        public string PrimerNombre { get; set; }

        [DataMember]
        public string PrimerApellido { get; set; }

        [DataMember]
        public bool MostrarAyudaWebTraking { get; set; }

        [DataMember]
        public int IndicadorOfertaFIC { get; set; }
        [DataMember]
        public string ImagenURLOfertaFIC { get; set; }

        [DataMember]
        [Column("Lider")]
        public int Lider { get; set; }

        [Column("ConsultoraAsociada")]
        [DataMember]
        public string ConsultoraAsociada { get; set; }

        [DataMember]
        public string CampaniaInicioLider { get; set; }

        [Column("SeccionGestionLider")]
        [DataMember]
        public string SeccionGestionLider { get; set; }

        [DataMember]
        public int NivelLider { get; set; }

        [DataMember]
        public bool PortalLideres { get; set; }

        [DataMember]
        public string LogoLideres { get; set; }

        [DataMember]
        public int IndicadorContrato { get; set; }

        [DataMember]
        public DateTime FechaFinFIC { get; set; }

        [DataMember]
        public bool PROLSinStock { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public string Rol { get; set; }

        [Column("SegmentoConstancia")]
        [DataMember]
        public string SegmentoConstancia { get; set; }
        [DataMember]
        public string SeccionAnalytics { get; set; }
        [DataMember]
        public string DescripcionNivel { get; set; }

        [DataMember]
        public bool esConsultoraLider
        {
            get { return Convert.ToBoolean(mesConsultoraLider); }
            set { mesConsultoraLider = value ? 1 : 0; }
        }
        [DataMember]
        public string DigitoVerificador { get; set; }

        [DataMember]
        public bool NuevoPROL { get; set; }

        [DataMember]
        public bool ZonaNuevoPROL { get; set; }

        [DataMember]
        public string NumeroDocumento { get; set; }
        [DataMember]
        [Column("Seccion")]
        public string Seccion { get; set; }
        [DataMember]
        public string Zona { get; set; }
        [DataMember]
        public string Region { get; set; }
        [DataMember]
        public string Pais { get; set; }

        [Column("Campania")]
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public DateTime? FechaActualizacionEmail { get; set; }
        [DataMember]
        public DateTime? FechaActivacionSuscripcion { get; set; }
        [DataMember]
        public string FlagActivacionSuscripcion { get; set; }
        [DataMember]
        public DateTime? FechaCancelacionSuscripcion { get; set; }

        [DataMember]
        [Column("SegmentoInternoId")]
        public int? SegmentoInternoID { get; set; }

        [DataMember]
        public string SegmentoAbreviatura { get; set; }

        [DataMember]
        public bool EstadoSimplificacionCUV { get; set; }

        [DataMember]
        public bool EsquemaDAConsultora { get; set; }

        [DataMember]
        [Column("OfertaFinal")]
        public int OfertaFinal { get; set; }

        [DataMember]
        [Column("EsOfertaFinalZonaValida")]
        public bool EsOfertaFinalZonaValida { get; set; }

        [DataMember]
        public int OfertaFinalGanaMas { get; set; }

        [DataMember]
        public bool EsOFGanaMasZonaValida { get; set; }

        [DataMember]
        public int CatalogoPersonalizado { get; set; }

        [DataMember]
        public bool EsCatalogoPersonalizadoZonaValida { get; set; }

        [DataMember]
        public int VioTutorialSalvavidas { get; set; }

        [DataMember]
        public int TieneHana
        {
            get { return tieneHana ? 1 : 0; }
            set { tieneHana = value == 1; }
        }

        [DataMember]
        public int IndicadorBloqueoCDR { get; set; }

        [DataMember]
        public int EsCDRWebZonaValida { get; set; }

        [DataMember]
        public int TieneCDR { get; set; }
        [DataMember]
        public int TieneCupon { get; set; }
        [DataMember]
        public int TieneMasVendidos { get; set; }
        [DataMember]
        public int TieneAsesoraOnline { get; set; }
        [DataMember]
        public int TieneOfertaLog { get; set; }
        [DataMember]
        public decimal MontoDeuda { get; set; }

        [DataMember]
        public decimal MontoMinimoFlexipago { get; set; }

        [DataMember]
        public int ConsecutivoNueva { get; set; }

        [DataMember]
        public string CodigoPrograma { get; set; }

        [DataMember]
        public double CompraVDirecta { get; set; }

        [DataMember]
        public double IVACompraVDirecta { get; set; }

        [DataMember]
        public double Retail { get; set; }

        [DataMember]
        public double IVARetail { get; set; }

        [DataMember]
        public double TotalCompra { get; set; }

        [DataMember]
        public double IvaTotal { get; set; }

        public BEUsuario(IDataRecord row, string Lider)
        {
            Nombre = row.ToString("Nombre");
            NumeroDocumento = row.ToString("DocIdentidad");
            CodigoConsultora = row.ToString("CodigoConsultora");
            Seccion = row.ToString("Seccion");
            SeccionGestionLider = row.ToString("SeccionGestionLider");
            Telefono = row.ToString("Telefono");
            Celular = row.ToString("Celular");
            EMail = row.ToString("Email");
            CodigoConsultora = row.ToString("CodigoConsultora");
            Pais = row.ToString("Pais");
            Campania = row.ToString("Campania");
            Region = row.ToString("Region");
            Zona = row.ToString("Zona");
            FechaActualizacionEmail = row.ToDateTime("FechaActualizacionEmail");
            FechaActivacionSuscripcion = row.ToDateTime("FechaActivacionSuscripcion");
            FechaCancelacionSuscripcion = row.ToDateTime("FechaCancelacionSuscripcion");
            FlagActivacionSuscripcion = row.ToString("FlagActivacionSuscripcion");
            SegmentoConstancia = row.ToString("SegmentoConstancia");
            SeccionAnalytics = row.ToString("Seccion");
            DescripcionNivel = row.ToString("DescripcionNivel");
            esConsultoraLider = row.ToBoolean("esConsultoraLider");
            EstadoSimplificacionCUV = row.ToBoolean("EstadoSimplificacionCUV");
            bEsquemaDAConsultora = row.ToBoolean("EsquemaDAConsultora");
            DigitoVerificador = row.ToString("DigitoVerificador");
            TieneCDRExpress = row.ToBoolean("TieneCDRExpress");
        }

        [DataMember]
        private string msSeccion { get; set; }
        [DataMember]
        private string msCampaniaEncuesta { get; set; }
        [DataMember]
        private DateTime mdFechaEncuesta { get; set; }
        [DataMember]
        private string msCampaniaIngreso { get; set; }
        [DataMember]
        private string msRpta1 { get; set; }
        [DataMember]
        private string msRpta2 { get; set; }
        [DataMember]
        private string msRpta3 { get; set; }
        [DataMember]
        private string msRpta4 { get; set; }

        [DataMember]
        public int IndicadorGPRSB { get; set; }
        [DataMember]
        public int EstadoPedido { get; set; }
        [DataMember]
        public bool ValidacionAbierta { get; set; }
        [DataMember]
        public string NombreGerenteZona { get; set; }
        [DataMember]
        public DateTime FechaActualPais { get; set; }

        [DataMember]
        public bool OfertaDelDia
        {
            get { return Convert.ToBoolean(tieneOdd); }
            set { tieneOdd = value ? 1 : 0; }
        }

        [DataMember]
        public int AceptacionConsultoraDA { get; set; }

        [Column("DocumentoIdentidad")]
        [DataMember]
        public string DocumentoIdentidad { get; set; }

        public bool DiaPROL { get; set; }
        public bool EsHoraReserva { get; set; }

        [DataMember]
        public bool TieneLoginExterno
        {
            get { return Convert.ToBoolean(tieneLoginExterno); }
            set { tieneLoginExterno = value ? 1 : 0; }
        }

        public BEUsuario(IDataRecord row, string tipo1, string tipo2)
        {
            CodigoConsultora = row.ToString("Codigo");
            Nombre = row.ToString("Nombre");
            CodigoISO = row.ToString("Pais");
            Region = row.ToString("Region");
            Zona = row.ToString("Zona");
            msSeccion = row.ToString("Seccion");
            msCampaniaEncuesta = row.ToString("CampaniaEncuesta");
            mdFechaEncuesta = row.ToDateTime("FechaRespuesta");
            msCampaniaIngreso = row.ToString("CampaniaIngreso");
            msRpta1 = row.ToString("Rpta1");
            msRpta2 = row.ToString("Rpta2");
            msRpta3 = row.ToString("Rpta3");
            msRpta4 = row.ToString("Rpta4");
            FechaActualPais = row.ToDateTime("FechaActualPais");
            TieneCDRExpress = row.ToBoolean("TieneCDRExpress");
        }

        [DataMember]
        public int MensajePedidoDesktop { get; set; }

        [DataMember]
        public int MensajePedidoMobile { get; set; }

        [DataMember]
        public bool TieneCDRExpress { get; set; }
        [DataMember]
        public bool EsConsecutivoNueva { get; set; }

        [DataMember]
        public bool PedidoFICActivo { get; set; }

        [DataMember]
        [Column("FotoPerfil")]
        public string FotoPerfil { get; set; }

        [DataMember]
        public bool AceptaTerminosCondiciones { get; set; }

        [DataMember]
        public bool AceptaPoliticaPrivacidad { get; set; }

        [DataMember]
        public string DestinatariosFeedback { get; set; }

        [DataMember]
        public bool GPRMostrarBannerRechazo { get; set; }
        [DataMember]
        public string GPRBannerTitulo { get; set; }
        [DataMember]
        public string GPRBannerMensaje { get; set; }
        [DataMember]
        public Enumeradores.RechazoBannerUrl GPRBannerUrl { get; set; }
        [DataMember]
        public string GPRTextovinculo { get; set; }

        [DataMember]
        public string FechaVencimiento { get; set; }
        [DataMember]
        public int DiasCierre { get; set; }
        [DataMember]
        public bool EsAniversario { get; set; }
        [DataMember]
        public int AniosPermanencia { get; set; }
        [DataMember]
        public bool EsCumpleanio { get; set; }
        [DataMember]
        public string CodigosConcursos { get; set; }
        [DataMember]
        public string CodigosProgramaNuevas { get; set; }
        [DataMember]
        [Column("PasoSextoPedido")]
        public bool PasoSextoPedido { get; set; }
        [DataMember]
        public short RevistaDigitalSuscripcion { get; set; }
        [DataMember]
        public string UrlBannerGanaMas { get; set; }
        [DataMember]
        public bool TieneGND { get; set; }
        [DataMember]
        public int CuponEstado { get; set; }
        [DataMember]
        public decimal CuponPctDescuento { get; set; }
        [DataMember]
        public decimal CuponMontoMaxDscto { get; set; }
        [DataMember]
        public short CuponTipoCondicion { get; set; }
        [DataMember]
        public BERevistaDigital RevistaDigital { get; set; }
        [DataMember]
        public string CodigosRevistaImpresa { get; set; }
        [DataMember]
        public BEOfertaDelDia OfertaDelDiaModel { get; set; }
        [DataMember]
        public BEGuiaNegocio GuiaNegocio { get; set; }
        [DataMember]
        public bool OptBloqueoProductoDigital { get; set; }
        [DataMember]
        public bool TieneValidacionMontoMaximo { get; set; }
        [DataMember]
        public bool EsShowRoom { get; set; }
        [DataMember]
        public bool MostrarBotonValidar { get; set; }
        [DataMember]
        public BEOfertaFinal beOfertaFinal { get; set; }
        [DataMember]
        public string FotoOriginalSinModificar { get; set; }
        [DataMember]
        public bool PuedeActualizar { get; set; }
        [DataMember]
        public bool PuedeEnviarSMS { get; set; }
        [DataMember]
        public bool FotoPerfilAncha { get; set; }
        [DataMember]
        [Column("IndicadorConsultoraOficina")]
        public bool EsConsultoraOficina { get; set; }
        [DataMember]
        [Column("IndicadorConsultoraDigital")]
        public int IndicadorConsultoraDigital { get; set; }
        [DataMember]
        public string NivelProyectado { get; set; }
        [DataMember]
        public double PromedioVenta { get; set; }
        [DataMember]
        public int NovedadBuscador { get; set; }
        [DataMember]
        public bool CambioCorreoPendiente { get; set; }
        [DataMember]
        public string CorreoPendiente { get; set; }
        [DataMember]
        public bool PuedeActualizarEmail { get; set; }
        [DataMember]
        public bool PuedeActualizarCelular { get; set; }
        [DataMember]
        public int IndicadorContratoAceptacion { get; set; }
        [DataMember]
        public BEBuscadorYFiltrosConfiguracion BuscadorYFiltrosConfiguracion { get; set; }
        [DataMember]
        public int DiaFacturacion { get; set; }
        [DataMember]
        public bool TienePagoEnLinea { get; set; }
        [DataMember]
        public bool TieneMG { get; set; }
        [DataMember]
        public bool TieneChatbot { get; set; }
        [DataMember]
        public List<BEConfiguracionPaisDatos> RecomendacionesConfiguracion { get; set; }

        public BEUsuario(IDataRecord row, bool Tipo, bool ValidaHorario)
        {
            ConsultoraID = row.ToInt64("ConsultoraID");
            ConsultoraAsociadaID = row.ToInt64("ConsultoraAsociadoID");
            ZonaHoraria = row.ToDouble("ZonaHoraria");
            HabilitarRestriccionHoraria = row.ToBoolean("HabilitarRestriccionHoraria");
            FechaInicioFacturacion = row.ToDateTime("FechaInicioFacturacion");
            FechaFinFacturacion = row.ToDateTime("FechaFinFacturacion");
            HorasDuracionRestriccion = row.ToInt32("HorasDuracionRestriccion");
            EsZonaDemAnti = row.ToInt32("EsZonaDemAnti");
            if (DataRecord.HasColumn(row, "HoraCierreZonaDemAnti")) HoraCierreZonaDemAnti = DbConvert.ToTimeSpan(row["HoraCierreZonaDemAnti"]);
            if (DataRecord.HasColumn(row, "HoraCierreZonaNormal")) HoraCierreZonaNormal = DbConvert.ToTimeSpan(row["HoraCierreZonaNormal"]);
        }
    }
}
