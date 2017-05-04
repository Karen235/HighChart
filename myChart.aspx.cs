using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Newtonsoft.Json;

public partial class myChart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [WebMethod]
    public static string getData() {



        ReportData data = new ReportData();

        //由於資料內容不是此篇重點，因此我就取12筆亂數囉。
        //以下的寫法是在 0~99 隨機取12個不重複的數字，很方便的寫法。
        data.Category1 = Enumerable.Range(0, 100)
                                   .OrderBy(p => Guid.NewGuid())
                                   .Take(12).ToList();
        data.Category2 = Enumerable.Range(0, 100)
                                   .OrderBy(p => Guid.NewGuid())
                                   .Take(12).ToList();

       
        return JsonConvert.SerializeObject(data);

    }


    public class ReportData
    {
        public List<int> Category1 { get; set; }
        public List<int> Category2 { get; set; }
    }
}