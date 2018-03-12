namespace Portal.Consultoras.Common
{
    public class BETuplaEditable<T, U>
    {
        public T Item1 { get; set; }
        public U Item2 { get; set; }

        public BETuplaEditable(T item1, U item2)
        {
            this.Item1 = item1;
            this.Item2 = item2;
        }
    }

    public class BETuplaEditable<T, U, V>
    {
        public T Item1 { get; set; }
        public U Item2 { get; set; }
        public V Item3 { get; set; }

        public BETuplaEditable(T item1, U item2, V item3)
        {
            this.Item1 = item1;
            this.Item2 = item2;
            this.Item3 = item3;
        }
    }
}