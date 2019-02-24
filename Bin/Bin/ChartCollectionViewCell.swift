//
//  ChartCollectionViewCell.swift
//  Bin
//
//  Created by Mike Choi on 2/24/19.
//  Copyright © 2019 Mike JS. Choi. All rights reserved.
//

import UIKit

class ChartCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var chart: AAChartView!
    
    func setup(index: IndexPath) {
        var aaChartModel: AAChartModel
        
        switch index.item {
        case 0:
            aaChartModel = AAChartModel()
                .chartType(.Area)
                .animationType(.Bounce)
                .title("Monthly Recycling Trend")
                .subtitle("")
                .dataLabelEnabled(false)
                .tooltipValueSuffix("#")
                .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                             "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
                .colorsTheme(["#fe117c","#ffc069","#06caf4"])
                .series([
                    AASeriesElement()
                        .name("Plastic")
                        .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                        .toDic()!,
                    AASeriesElement()
                        .name("Recyclable")
                        .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                        .toDic()!,
                    AASeriesElement()
                        .name("Landfill")
                        .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                        .toDic()!
            ])
        case 1:
            aaChartModel = AAChartModel()
                .chartType(.Pie)
                .animationType(.Bounce)
                .title("Weekly Recycling Trend")
                .subtitle("")
                .dataLabelEnabled(false)
                .tooltipValueSuffix("#")
                .categories([""])
                .colorsTheme(["#fe117c","#ffc069","#06caf4"])
                .series([
                    AASeriesElement()
                        .name("Plastic")
                        .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                        .toDic()!,
                    AASeriesElement()
                        .name("Recyclable")
                        .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                        .toDic()!,
                    AASeriesElement()
                        .name("Landfill")
                        .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                        .toDic()!
                    ])
        case 2:
            aaChartModel = AAChartModel()
                .chartType(.Area)
                .animationType(.Bounce)
                .title("Daily Recycling Trend")
                .subtitle("")
                .dataLabelEnabled(false)
                .tooltipValueSuffix("#")
                .categories([""])
                .colorsTheme(["#fe117c","#ffc069","#06caf4"])
                .series([
                    AASeriesElement()
                        .name("Plastic")
                        .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                        .toDic()!,
                    AASeriesElement()
                        .name("Recyclable")
                        .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                        .toDic()!,
                    AASeriesElement()
                        .name("Landfill")
                        .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                        .toDic()!
                    ])
        default:
            return
        }
        
        chart.aa_drawChartWithChartModel(aaChartModel)
    }
}
