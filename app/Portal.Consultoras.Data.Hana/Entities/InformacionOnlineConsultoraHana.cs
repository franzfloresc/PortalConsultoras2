namespace Portal.Consultoras.Data.Hana.Entities
{
    public class InformacionOnlineConsultoraHana
    {
        public int AutorizaPedido { get; set; }
        public string COD_CAMP { get; set; }
        public string COD_CLIE { get; set; }
        public string ConsultoraID { get; set; }
        public string FECHAVEN { get; set; }
        public string FECHAVENCAM { get; set; }
        public string FEC_CREA { get; set; }
        public string IMP_MONT_MINI { get; set; }
        public decimal IMP_SALD_CAMP { get; set; }
        public int Indicador_Activa { get; set; }
        public int Invitada { get; set; }
        public string MontoMaximoPedido { get; set; }
        public string MontoMinimoPedido { get; set; }
        public string SALDOTOTAL { get; set; }
        public decimal SALDOTOTALCAM { get; set; }
    }
}