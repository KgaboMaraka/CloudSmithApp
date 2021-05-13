using CloudSmithApp.Data;
using CloudSmithApp.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudSmithApp
{
    public partial class _Default : Page
    {
        private const string URL = "https://calendarific.com/api/v2/holidays";
        private string urlParameters = "?api_key=6222ecd1228ac4c98beee4b7dd32d537a2a60a15";
        SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["CloudSmithsConn"]);
        protected void Page_Load(object sender, EventArgs e)
        {
            btnSearch.Enabled = false;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            using (var _context = new ApplicationDbContext())
            {
                try
                {
                    string idNo = Request.Form["idno"];
                    
                    var yearPart = Convert.ToInt32(idNo.Substring(0, 2));
                    var Year = yearPart <= 20 ? 2000 + yearPart : 1900 + yearPart;
                    var Month = Convert.ToInt32(idNo.Substring(2, 2));
                    var Day = Convert.ToInt32(idNo.Substring(4, 2));
                    IDNumber idNumber = new IDNumber();

                    idNumber.IDNo = idNo;
                    idNumber.DateOfBirth = new DateTime(Year, Month, Day);
                    idNumber.Gender = Convert.ToInt32(idNo.Substring(6, 1)) < 5 ? "F" : "M";
                    idNumber.SACitizen = idNo.Substring(10, 1) == "0";

                    var prevIDNumber = _context.IDNumbers.Where(i => i.IDNo == idNumber.IDNo);
                    
                    if (prevIDNumber.Count() == 0)
                    {
                        idNumber.Counter = 1;
                        _context.IDNumbers.Add(idNumber);
                        _context.SaveChanges();
                    }
                    else
                    {
                        var counter = _context.IDNumbers.Where(i => i.IDNo == idNumber.IDNo).FirstOrDefault().Counter;
                        idNumber.Counter = counter + 1;
                        SqlCommand cmd = new SqlCommand("UpdateCounter", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IDNumber", idNo);
                        cmd.Parameters.AddWithValue("@Counter", counter + 1);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }

                    var holidayList = APICall(idNo, Year, Month, Day);
                    DisplayInfo(holidayList, idNumber);
                }
                catch (Exception)
                {

                    throw;
                }
            }
        }

        protected List<Holiday> APICall(string IDNo, int Year, int Month, int Day)
        {
            List<Holiday> lstHoliday = new List<Holiday>();
            try
            {
                string dobqs = "&country=ZA&year=" + Year;// + "&month=" + Month + "&day=" + Day;
                urlParameters = urlParameters + dobqs;
                HttpClient client = new HttpClient();
                client.BaseAddress = new Uri(URL);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync(urlParameters).Result;
                response.EnsureSuccessStatusCode();
                string responseBody = response.Content.ReadAsStringAsync().Result;
                string jsonResult = JsonConvert.DeserializeObject(responseBody).ToString();
                var dynamicresponse = JsonConvert.DeserializeObject<dynamic>(jsonResult);
                using (var _context = new ApplicationDbContext())
                {
                    foreach (var value1 in dynamicresponse.response.holidays)
                    {
                        Holiday holiday = new Holiday()
                        {
                            IDNo = IDNo,
                            Name = value1.name,
                            Description = value1.description,
                            Date = value1.date.iso,
                            Type = value1.type.First
                        };

                        _context.holidays.Add(holiday);
                        _context.SaveChanges();
                        lstHoliday.Add(holiday);
                    }
                }
                return lstHoliday;
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void DisplayInfo(List<Holiday> lstHoliday, IDNumber idNumber)
        {
            try
            {
                dvResults.Visible = true;
                lblIDNumber.Text = idNumber.IDNo;
                lblDateOfBirth.Text = idNumber.DateOfBirth.HasValue ? idNumber.DateOfBirth.Value.ToShortDateString() : string.Empty;
                lblGender.Text = idNumber.Gender == "M" ? "Male" : "Female";
                lblSACitizen.Text = idNumber.SACitizen ? "Yes" : "No";
                lblCounter.Text = idNumber.Counter.ToString();
                gvIDInfo.DataSource = lstHoliday;
                gvIDInfo.DataBind();
            }
            catch (Exception ex)
            {
                dvResults.Visible = false;
                throw ex;
            }
            finally
            {
            }
        }
    }
}
