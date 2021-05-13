using CloudSmithApp.Mapping;
using CloudSmithApp.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace CloudSmithApp.Data
{
    public class ApplicationDbContext : ApplicationDbContextBase
    {
        static ApplicationDbContext()
        {
            Database.SetInitializer<ApplicationDbContext>(null);
        }

        public ApplicationDbContext() : base("Name=ApplicationDbContext")
        {

        }

        public DbSet<IDNumber> IDNumbers { get; set; }
        public DbSet<Holiday> holidays { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new IDNumberMap());
            modelBuilder.Configurations.Add(new HolidayMap());
        }
    }
}