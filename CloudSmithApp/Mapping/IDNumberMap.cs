using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity.ModelConfiguration;
using CloudSmithApp.Models;

namespace CloudSmithApp.Mapping
{
    public class IDNumberMap : EntityTypeConfiguration<IDNumber>
    {
        public IDNumberMap()
        {
            ToTable("IDNumber");
            Property(t => t.ID).HasColumnName("ID");
            Property(t => t.IDNo).HasColumnName("IDNo");
            Property(t => t.DateOfBirth).HasColumnName("DateOfBirth");
            Property(t => t.Gender).HasColumnName("Gender");
            Property(t => t.SACitizen).HasColumnName("SACitizen");
            Property(t => t.Counter).HasColumnName("Counter");
        }
    }
}