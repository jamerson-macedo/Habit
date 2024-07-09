//
//  BoxChartView.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import SwiftUI
import Charts

struct BoxChartView: UIViewRepresentable{
    @Binding var entries:[ChartDataEntry]
    @Binding var dates : [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView()
        
        uiView.legend.enabled = false
        uiView.chartDescription.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = false
        uiView.xAxis.valueFormatter = DateAxisValueFormatter(dates:dates)
        uiView.leftAxis.axisLineColor = .orange
        uiView.animate(yAxisDuration: 1.0)
        uiView.data = addData()
        
        
        return uiView
    }
    private func addData() ->LineChartData{
        let dataSet = LineChartDataSet(entries: entries, label: "")
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.orange)
        dataSet.drawFilledEnabled = true
        dataSet.circleColors = [.red]
        dataSet.valueColors = [.red]
        dataSet.fillColor = .orange
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        
        return LineChartData(dataSet: dataSet)
    }
    
    func updateUIView(_ uiView: Charts.LineChartView, context: Context) {
        
    }
    
    typealias UIViewType = LineChartView
    
    
    
}
class DateAxisValueFormatter : AxisValueFormatter{
    let dates :[String]
    
    init(dates:[String]){
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        let position = Int(value)
        let df = DateFormatter()
        df.locale = Locale (identifier: "en_US_POSIX")
        df.dateFormat="yyyy-MM-dd"
        
        if position > 0 && position < dates.count{
            let date = df.date(from: dates[position])
            
            guard let date = date else {
                return ""
            }
            
            let df = DateFormatter()
            df.dateFormat = "dd/MM"
            let createdAt = df.string(from: date)
            return createdAt
        }else {
            return ""
        }
    }
    
    
    
}

#Preview {
    BoxChartView(entries: .constant([ChartDataEntry(x: 2.0, y: 2.0),
                                     ChartDataEntry(x: 3.0, y: 2.3),
                                     ChartDataEntry(x: 5.0, y: 1.0)
                                    ]), dates: .constant(["09/12/1998","09/12/1998","09/12/1998"])).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 350)
}
