using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.ServiceCatalogoPersonalizado.Entities
{
    public class ProductoPcm
    {
        public List<Product> products { get; set; }
        public string catalog { get; set; }
        public string version { get; set; }
        public int totalProductCount { get; set; }
        public int totalPageCount { get; set; }
        public int currentPage { get; set; }
    }

    public class Image
    {
        public string imageType { get; set; }
        public string format { get; set; }
        public string url { get; set; }
        public string altText { get; set; }
    }

    public class Category
    {
        public string code { get; set; }
        public string url { get; set; }
        public int sequence { get; set; }
    }

    public class Product
    {
        public string code { get; set; }
        public string name { get; set; }
        public string url { get; set; }
        public bool purchasable { get; set; }
        public decimal averageRating { get; set; }
        public string manufacturer { get; set; }
        public List<Image> images { get; set; }
        public List<Category> categories { get; set; }
        public List<object> baseOptions { get; set; }
    }
}