using CloudSmithApp.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Web;

namespace CloudSmithApp.Mapping
{
    public class HolidayMap : EntityTypeConfiguration<Holiday>
    {
        public HolidayMap()
        {
            ToTable("Holiday");
            Property(t => t.ID).HasColumnName("ID");
            Property(t => t.IDNo).HasColumnName("IDNo");
            Property(t => t.Name).HasColumnName("Name");
            Property(t => t.Description).HasColumnName("Description");
            Property(t => t.Date).HasColumnName("Date");
            Property(t => t.Type).HasColumnName("Type");
        }
    }
}