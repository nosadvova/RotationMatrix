//
//  ViewController.swift
//  CoordinateSystem
//
//  Created by Vova Novosad on 11.03.2023.
//

import UIKit

class ViewController: UIViewController {
        
    lazy var addPoint: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(systemName: "plus"), for: .normal)
       button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
       
       return button
   }()
    
    lazy var connectPoints: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(systemName: "pencil.line"), for: .normal)
       button.addTarget(self, action: #selector(connectTapped), for: .touchUpInside)
       
       return button
   }()
    
    lazy var deleteButton: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(systemName: "trash"), for: .normal)
       button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
       
       return button
   }()
    
    lazy var transportButton: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(systemName: "arrowshape.left"), for: .normal)
       button.addTarget(self, action: #selector(transportTapped), for: .touchUpInside)
       
       return button
   }()
    
    let coordinateSystemView = CoordinateSystemView()
    var point: Point?
    
    //MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configure()
    }
    
    //MARK: - Selectors

    @objc private func addTapped() {
        let addPointVC = AddPointVC()
        addPointVC.deelgate = self
        present(addPointVC, animated: true)
    }
    
    @objc private func connectTapped() {
        let connectVC = ConnectPointsVC()
        connectVC.delegate = self
        present(connectVC, animated: true)
    }
    
    @objc private func deleteTapped() {
        coordinateSystemView.points.removeAll()
        coordinateSystemView.triangles.removeAll()
        coordinateSystemView.layer.sublayers?.removeAll()
    }
    
    @objc private func transportTapped() {
        let matrixVC = MatrixVC()
        matrixVC.delegate = self
        present(matrixVC, animated: true)
    }
    
    //MARK: - Functionality
    
    private func configure() {
        let connectButton = UIBarButtonItem(customView: connectPoints)
        let addPointButton = UIBarButtonItem(customView: addPoint)
        navigationItem.rightBarButtonItems = [connectButton, addPointButton]
        
        let deleteButton = UIBarButtonItem(customView: deleteButton)
        let transportButton = UIBarButtonItem(customView: transportButton)
        navigationItem.leftBarButtonItems = [deleteButton, transportButton]
                        
        view.addSubview(coordinateSystemView)
        coordinateSystemView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
}

extension ViewController: AddPointDelegate {
    func newPoint(point: Point) {
        self.point = point
        coordinateSystemView.points.append(point)
        coordinateSystemView.addPoint(x: point.0, y: point.1)
    }
}

extension ViewController: ConnectPointsDelegate {
    func connectPoints(points: Int) {
        guard points >= 2 else {return}
        let coordinatePoints = coordinateSystemView.points
        
        if points == 2 {
            let line = Line(coordinatePoints[0], coordinatePoints[1])
            coordinateSystemView.drawLine(point1: line.0, point2: line.1)
        } else
        if points == 3 {
            let last = coordinatePoints.count - 1
            guard last != 0 else {return}
            let triangle = Triangle(firstPoint: coordinatePoints[last - 2], secondPoint: coordinatePoints[last - 1], thirdPoint: coordinatePoints[last])
            
            coordinateSystemView.drawTriangle(triangle: triangle)
            coordinateSystemView.triangles.append(triangle)
        }
    }
}

extension ViewController: MatrixDelegate {
    
    func transformTriangle(matrix: [[Int?]]) {
        var array = Array(repeating: Array(repeating: 0, count: 2), count: 3)
        
        let rows = 3
        let columns = 2
        
        let triangle = coordinateSystemView.triangles[0]
        
        let matrix1 = [[triangle.0.0, triangle.0.1],
                       [triangle.1.0, triangle.1.1],
                       [triangle.2.0, triangle.2.1]]
        
        for x in 0..<columns {
           for y in 0..<rows {
              for z in 0..<columns {
                  array[y][x] += matrix[z][x]! * matrix1[y][z]
              }
           }
        }
        
        
        coordinateSystemView.points.append(Point(array[0][0], array[0][1]))
        coordinateSystemView.points.append(Point(array[1][0], array[1][1]))
        coordinateSystemView.points.append(Point(array[2][0], array[2][1]))
    }
}
