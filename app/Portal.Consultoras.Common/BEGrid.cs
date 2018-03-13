namespace Portal.Consultoras.Common
{
    public class BEGrid
    {
        public int PageSize { get; set; }
        public int CurrentPage { get; set; }
        public string SortColumn { get; set; }
        public string SortOrder { get; set; }
        public int RowsSize { get; set; }
        public int RecordCount { get; set; }

        public BEGrid() { }
        public BEGrid(string sidx, string sord, int page, int rows)
        {
            this.PageSize = rows <= 0 ? 10 : rows;
            this.CurrentPage = page <= 0 ? 1 : page;
            this.SortColumn = sidx ?? "";
            this.SortOrder = sord ?? "asc";
        }
    }
}