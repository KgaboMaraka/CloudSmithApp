using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CloudSmithApp.Models
{
    [Serializable]
    public class IDNumber
    {
        [Key]
        public int ID { get; set; }
        public string IDNo { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string Gender { get; set; }
        public Boolean SACitizen { get; set; }
        public int Counter { get; set; }
    }
}