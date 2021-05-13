using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CloudSmithApp.Models
{
    public class Holiday
    {
        [Key]
        public int ID { get; set; }
        public string IDNo { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Date { get; set; }
        public string Type { get; set; }
    }
}