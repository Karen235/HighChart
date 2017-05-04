<%@ Page Language="C#" AutoEventWireup="true" CodeFile="myChart.aspx.cs" Inherits="myChart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="Content/highcharts.css" rel="stylesheet" />
  
    <script src="Scripts/Jquery/jquery-3.1.1.js"></script>
  
    <script src="Scripts/HighChart/highcharts.js"></script>
    <script src="Scripts/HighChart/exporting.js"></script>
   


   


</head>
<body>
    <form id="form1" runat="server">
    
<div id="container" class="highcharts-container" style="height:410px; margin: 0 2em; clear:both; min-width: 600px"></div>



		
    </form>


     <script type="text/javascript">
        //下面範例大部分都是COPY官網上的範例
        var chart;
        jQuery(document).ready(function () {
            chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'container',
                    defaultSeriesType: 'areaspline',
                    events: {
                        //圖表載入後執行GetReportData這個Function
                        load: GetReportData
                    }
                },
                title: {
                    text: 'HighCharts 使用 Demo'
                },
                //自訂X軸座標，也可以從Server塞資料進來
                xAxis: {
                    categories: ["一月", "二月", "三月", "四月", "五月"
                                , "六月", "七月", "八月", "九月", "十月"
                                , "十一月", "十二月", ]
                },
                yAxis: {
                    title: {
                        text: '數量'
                    }
                },
                tooltip: {
                    formatter: function () {
                        //這地方有什麼資料可用可以開FireBug來看
                        //也可以從後端傳進來
                        return '類別1:' + this.points[0].y + '<br/>類別2:' + this.points[1].y;

                    },
                    shared: true,
                    crosshairs: true
                },
                //兩份資料，一開始都是空的
                series: [{
                    name: '類別1',
                    data: [],
                    fillOpacity: 0.5
                }, {
                    name: '類別2',
                    data: [],
                    fillOpacity: 0.4
                }]
            });
        });

        function GetReportData() {
            $.ajax({
                type: "post",
                url: 'myChart.aspx/getData',
                contentType: "application/json; charset=utf-8",
                datatype: 'json',
                data: {},
                //成功之後，會收到Server端返回的資料，也就是自訂的型別ReportData
                //有兩個屬性可以用
                success: function (result) {
                    
                    var data = JSON.parse(result.d);
                    chart.series[0].setData(data.Category1);
                    chart.series[1].setData(data.Category2);
                },
                cache: false
            });

        }
	</script>
</body>
</html>
