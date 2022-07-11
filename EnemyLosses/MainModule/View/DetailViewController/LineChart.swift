//
//  LineChart.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 07.07.2022.
//

import UIKit

struct PointEntry {
    let systolic: Int
    let diastolic: Int
    let label: String
}

extension PointEntry: Comparable {
    static func <(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.systolic < rhs.systolic || lhs.systolic < rhs.systolic
    }
    static func ==(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.systolic == rhs.systolic && lhs.diastolic == rhs.diastolic
    }
}

class LineChart: UIView {

    /// gap between each point
    let lineGap: CGFloat = 30.0

    /// preseved space at top of the chart
    let topSpace: CGFloat = 20.0

    /// preserved space at bottom of the chart to show labels along the Y axis
    let bottomSpace: CGFloat = 40.0

    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0

    /// Dot inner Radius
    var innerRadius: CGFloat = 8

    /// Dot outer Radius
    var outerRadius: CGFloat = 12

    var dataEntries: [PointEntry]? {
        didSet {
            self.setNeedsLayout()
        }
    }

    /// Contains the main line which represents the data
    private let dataLayer: CALayer = CALayer()

    /// Contains dataLayer and gradientLayer
    private let mainLayer: CALayer = CALayer()

    /// Contains mainLayer and label for each data entry
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    /// Contains horizontal lines
    private let gridLayer: CALayer = CALayer()

    /// An array of CGPoint on dataLayer coordinate system that the main line will go through. These points will be calculated from dataEntries array
    private var systolicDataPoint: [CGPoint]?
    private var daistolicDataPoint: [CGPoint]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        mainLayer.addSublayer(gridLayer)
        scrollView.layer.addSublayer(mainLayer)

        self.addSubview(scrollView)
    }

    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        if let dataEntries = dataEntries {
            scrollView.contentSize = CGSize(width: CGFloat(dataEntries.count) * lineGap + 30, height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap + 30, height: self.frame.size.height)
            dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
//            systolicGradientLayer.frame = dataLayer.frame
//            diastolicGradientLayer.frame = dataLayer.frame
            systolicDataPoint = convertDataEntriesToPoints(entries: dataEntries, isSystolic: true)
            daistolicDataPoint = convertDataEntriesToPoints(entries: dataEntries, isSystolic: false)
            gridLayer.frame = CGRect(x: 0, y: topSpace, width: CGFloat(dataEntries.count) * lineGap + 30, height: mainLayer.frame.height - topSpace - bottomSpace)
            clean()
            drawHorizontalLines()
            drawVerticleLine()
            drawChart(for: systolicDataPoint, color: .blue)
            drawChart(for: daistolicDataPoint, color: .green)
            drawLables()
        }
    }

    /// Convert an array of PointEntry to an array of CGPoint on dataLayer coordinate system
    /// - Parameter entries: Arrays of PointEntry
    private func convertDataEntriesToPoints(entries: [PointEntry], isSystolic: Bool) -> [CGPoint] {
        var result: [CGPoint] = []
//         let gridValues: [CGFloat] = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0, 1.05]
        for (index, value) in entries.enumerated() {
            let difference: CGFloat = 0.125 / 30
            let userValue: CGFloat = isSystolic ? CGFloat(value.systolic) : CGFloat(value.diastolic)
            var height = (userValue - 30.0) * difference
            height = (1.0 - height) * gridLayer.frame.size.height
            let point = CGPoint(x: CGFloat(index)*lineGap + 40, y: height)
            result.append(point)
        }
        return result
    }

    /// Draw a zigzag line connecting all points in dataPoints
    private func drawChart(for points: [CGPoint]?, color: UIColor) {
        if let dataPoints = points, dataPoints.count > 0 {
            guard let path = createPath(for: points) else { return }
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = color.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }

    /// Create a zigzag bezier path that connects all points in dataPoints
    private func createPath(for points: [CGPoint]?) -> UIBezierPath? {
        guard let dataPoints = points, dataPoints.count > 0 else {
            return nil
        }
        let path = UIBezierPath()
        path.move(to: dataPoints[0])

        for i in 1..<dataPoints.count {
            path.addLine(to: dataPoints[i])
        }
        return path
    }

    /// Create titles at the bottom for all entries showed in the chart
    private func drawLables() {
        if let dataEntries = dataEntries,
            dataEntries.count > 0 {
            for i in 0..<dataEntries.count {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: lineGap*CGFloat(i) - lineGap/2 + 40, y: mainLayer.frame.size.height - bottomSpace/2 - 8, width: lineGap, height: 16)
                textLayer.foregroundColor = UIColor.black.cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = 11
                textLayer.string = dataEntries[i].label
                mainLayer.addSublayer(textLayer)
            }
        }
    }

    /// Create horizontal lines (grid lines) and show the value of each line
    private func drawHorizontalLines() {
        let gridValues: [CGFloat] = [1.05, 1.0, 0.875, 0.75, 0.625, 0.5, 0.375, 0.25, 0.125]
        let gridText = ["", "30", "60", "90", "120", "150", "180", "210", "240"]

        for (index, value) in gridValues.enumerated() {
            let height = value * gridLayer.frame.size.height

            let path = UIBezierPath()
            if value == gridValues.first! {
                path.move(to: CGPoint(x: 30, y: height))
            } else {
                path.move(to: CGPoint(x: 28, y: height))
            }
            path.addLine(to: CGPoint(x: gridLayer.frame.size.width, y: height))

            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.strokeColor = UIColor.black.cgColor
            if value != gridValues.first! {
                lineLayer.lineDashPattern = [4, 4]
            }
            lineLayer.lineWidth = 0.5

            gridLayer.addSublayer(lineLayer)

            let textLayer = CATextLayer()
            textLayer.frame = CGRect(x: 4, y: height-8, width: 50, height: 16)
            textLayer.foregroundColor = UIColor.black.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
            textLayer.fontSize = 12
            textLayer.string = gridText[index]

            gridLayer.addSublayer(textLayer)
        }
    }

    private func drawVerticleLine() {
        let height = gridLayer.frame.size.height * 1.05

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 30, y: 0))
        path.addLine(to: CGPoint(x: 30, y: height))

        let lineLayer = CAShapeLayer()
        lineLayer.path = path.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 0.5

        gridLayer.addSublayer(lineLayer)
    }

    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
        gridLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
}
