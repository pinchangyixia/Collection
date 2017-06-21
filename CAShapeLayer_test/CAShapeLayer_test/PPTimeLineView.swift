//
//  PPTimeLineView.swift
//  CAShapeLayer_test
//
//  Created by 易联互动 on 17/6/19.
//  Copyright © 2017年 易联互动. All rights reserved.
//

import UIKit

class PPTimeLineView: UIView {

    var max: Double!
    var mid: Double!
    var min: Double!
    var currentPoint: CGPoint!
    var isNeedBackGroundColor: Bool!
    lazy var linePath: UIBezierPath = { return UIBezierPath() }()
    lazy var heartLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()
    lazy var timeLineLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.lineWidth = 0.5
        return layer
    }()
    lazy var crossLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineDashPattern = [1, 2]
        return layer
    }()
    lazy var crossTimeLayer: CATextLayer = { return CATextLayer() }()
    lazy var crossPriceLayer: CATextLayer = { return CATextLayer() }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupGestureRecognize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGestureRecognize() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PPTimeLineView.tapAction))
        self.addGestureRecognizer(tapGesture)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(PPTimeLineView.longPressAction))
        self.addGestureRecognizer(longPress)
    }
    
    func tapAction(gesture: UITapGestureRecognizer) {
        crossLayer.path = nil
        crossTimeLayer.removeFromSuperlayer()
        crossPriceLayer.removeFromSuperlayer()
    }
    
    func longPressAction(gesture: UILongPressGestureRecognizer) {
        var tempPoint = gesture.location(in: self)
        //越界控制
        if tempPoint.x >= sWidth {
            tempPoint = CGPoint(x: sWidth, y: tempPoint.y)
        }
        if tempPoint.x == sWidth - 60 {
            tempPoint = CGPoint(x: tempPoint.x, y: sHeight - 60)
        }
        if tempPoint.y <= 0 {
            tempPoint = CGPoint(x: tempPoint.x, y: 0)
        }
        
        switch gesture.state {
        case .began:
            drawCrossLine(point: tempPoint)
            break
        case .changed:
            drawCrossLine(point: tempPoint)
            break
        case .ended:
            break
        default:
            break
        }
    }
    
    func drawCrossLine(point: CGPoint) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: point.x, y: 0))
        path.addLine(to: CGPoint(x: point.x, y: sHeight - 60))
        path.move(to: CGPoint(x: 0, y: point.y))
        path.addLine(to: CGPoint(x: sHeight, y: point.y))
        crossLayer.strokeColor = UIColor.blue.cgColor
        crossLayer.path = path.cgPath
        self.layer.addSublayer(crossLayer)
        //画坐标点对于文字
        let price = getPirce(point: point)
        let time = getTime(point: point)
        drawCrossLabel(textLayer: crossPriceLayer, atRect: CGRect(x: 0, y: point.y, width: 30, height: 20), textStr: price)
        drawCrossLabel(textLayer: crossTimeLayer, atRect: CGRect(x: point.x, y: sHeight - 60, width: 30, height: 20), textStr: time)
    }
    
    func getPirce(point: CGPoint) -> String {
        var price = ""
        let avePrice = (max - min) / Double(sHeight - 60)
        price = String(format: "%.2f", max - Double(point.y) * avePrice)
        return price
    }
    
    func getTime(point: CGPoint) -> String {
        return "000"
    }
    
    func drawCrossLabel(textLayer: CATextLayer, atRect rect: CGRect, textStr: String) {
        textLayer.frame = rect
        layer.addSublayer(textLayer)
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.alignmentMode = kCAAlignmentJustified
        textLayer.isWrapped = true
        let font = UIFont.systemFont(ofSize: 10)
        let fontName = font.fontName
        let fontRef = CGFont(fontName as CFString)
        textLayer.font = fontRef
        textLayer.fontSize = font.pointSize
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.string = textStr
        
    }
    
    func setupHeartLayer() {
        heartLayer.frame = CGRect(x: 0, y: 0, width: 4, height: 4)
        heartLayer.position = currentPoint
        heartLayer.cornerRadius = heartLayer.frame.size.width * 0.5
        heartLayer.masksToBounds = true
        self.layer.addSublayer(heartLayer)
        heartAnimation(layer: heartLayer)
    }
    
    func heartAnimation(layer: CALayer) {
        let group = CAAnimationGroup()
        group.duration = 0.5
        group.repeatCount = HUGE
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.toValue = 1.2
        let alphaAnim = CABasicAnimation(keyPath: "opacity")
        alphaAnim.toValue = 0.3
        group.animations = [scaleAnim, alphaAnim]
        layer.add(group, forKey: nil)
    }
    
    
    
    
    
    
    
    
}
