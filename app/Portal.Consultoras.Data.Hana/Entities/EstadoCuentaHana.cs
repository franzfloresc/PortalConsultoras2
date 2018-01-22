namespace Portal.Consultoras.Data.Hana.Entities
{
    public class EstadoCuentaHana
    {
        public string anoCampanaCargo { get; set; }
        public int codUni { get; set; }
        public int codigo { get; set; }
        public int consultoraID { get; set; }
        public int cuentaCorrienteID { get; set; }
        public string descripcionOperacion { get; set; }
        public int estadoActivo { get; set; }
        public string estadoOperacionCargo { get; set; }
        public string fechaLiquidacion { get; set; }
        public string fechaOperacion { get; set; }
        public string fechaRegistro { get; set; }
        public string fechaVencimiento { get; set; }
        public string glosa { get; set; }
        public string idNumeroCarga { get; set; }
        public string montoOperacion { get; set; }
        public string montoSaldo { get; set; }
        public int numeroCarga { get; set; }
        public string tipoCargoAbono { get; set; }
        public string tipoOri { get; set; }
    }
}
