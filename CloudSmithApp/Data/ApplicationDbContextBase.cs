using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace CloudSmithApp.Data
{
    public class ApplicationDbContextBase : DbContext
    {
        public ApplicationDbContextBase(string connectionString) : base(GetPathedConnectionString(connectionString))
        {

        }

        private static string GetPathedConnectionString(string connectionString)
        {
            return ConfigurationManager.AppSettings["CloudSmithsConn"];
        }
    }
}