

import UIKit

public typealias Point = ((Int, Int))

typealias Line = (Point, Point)

typealias Triangle = (Point, Point, Point)


class CoordinateSystemView: UIView {
    
    var points: [Point] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var triangles: [Triangle] = [] {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
                            
        let context = UIGraphicsGetCurrentContext()!
        let width = rect.width
        let height = rect.height
        
        // Draw the x-axis
        context.move(to: CGPoint(x: 0, y: height/2))
        context.addLine(to: CGPoint(x: width, y: height/2))
        context.setStrokeColor(UIColor.white.cgColor)
        context.strokePath()
        
        // Draw the y-axis
        context.move(to: CGPoint(x: width/2, y: 0))
        context.addLine(to: CGPoint(x: width/2, y: height))
        context.setStrokeColor(UIColor.white.cgColor)
        context.strokePath()
        
        // Draw the grid
        let gridSize: CGFloat = 20
        context.setLineWidth(0.5)
        context.setStrokeColor(UIColor.lightGray.cgColor)
        
        // Draw vertical lines
        var x: CGFloat = 0
        while x < width {
            context.move(to: CGPoint(x: x, y: 0))
            context.addLine(to: CGPoint(x: x, y: height))
            context.strokePath()
            x += gridSize
        }
        
        // Draw horizontal lines
        var y: CGFloat = 0
        while y < height {
            context.move(to: CGPoint(x: 0, y: y))
            context.addLine(to: CGPoint(x: width, y: y))
            context.strokePath()
            y += gridSize
        }
    }
    
}

//MARK: - Functionality

extension CoordinateSystemView {
    func addPoint(x: Int, y: Int) {
        let point = CGPoint(x: x * 10, y: -y * 10)
        
        // define the transformation matrix
        let transform = CGAffineTransform(scaleX: 2, y: 2)

        // apply the transformation matrix to the point
        let transformedPoint = point.applying(transform)

        // plot the point in the coordinate system
        let circlePath = UIBezierPath(ovalIn: CGRect(x: transformedPoint.x + 193, y: transformedPoint.y + 355, width: 10, height: 10))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.red.cgColor
        layer.addSublayer(circleLayer)
    }
    
    func drawLine(point1: Point, point2: Point) {
        // define the transformation matrix
        let startPoint = CGPoint(x: point1.0 * 20 + 196, y: -point1.1 * 20 + 361)
        let endPoint = CGPoint(x: point2.0 * 20 + 196, y: -point2.1 * 20 + 361)
    

        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 5.0
        
        shapeLayer.path = linePath.cgPath
        layer.addSublayer(shapeLayer)
    }
    
    func drawTriangle(triangle: Triangle) {
        let firstPoint = CGPoint(x: triangle.0.0 * 20 + 196, y: -triangle.0.1 * 20 + 361)
        let secondPoint = CGPoint(x: triangle.1.0 * 20 + 196, y: -triangle.1.1 * 20 + 361)
        let thirdPoint = CGPoint(x: triangle.2.0 * 20 + 196, y: -triangle.2.1 * 20 + 361)

        let linePath = UIBezierPath()
        linePath.move(to: firstPoint)
        linePath.addLine(to: secondPoint)
        linePath.move(to: secondPoint)
        linePath.addLine(to: thirdPoint)
        linePath.move(to: thirdPoint)
        linePath.addLine(to: firstPoint)

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 5.0

        shapeLayer.path = linePath.cgPath
        layer.addSublayer(shapeLayer)
    }
    

}
