//
//  Tools.swift
//  CAShapeLayer_test
//
//  Created by 易联互动 on 17/6/19.
//  Copyright © 2017年 易联互动. All rights reserved.
//

import UIKit

class Tools: NSObject {
    var totalTime = 0.0
    // 心跳效果
    func addHeartAnimation(layer: CALayer) {
        let group = CAAnimationGroup()
        group.duration = 0.5
        group.repeatCount = HUGE
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.toValue = 1.2
        let alpthaAnim = CABasicAnimation(keyPath: "opacity")
        alpthaAnim.toValue = 0.3
        group.animations = [scaleAnim, alpthaAnim]
        layer.add(group, forKey: nil)
    }
    
    // MARK: - 坐标轴转换
    
    // 根据时间换取坐标点
    func getMiniteTime(timeStr: String?) -> Float {
        if timeStr == "" || timeStr == nil {
            return 0.0
        }
        let tempArr = timeStr?.components(separatedBy: ":")
        let minte = Int((tempArr?[0])!)! * 60 + Int((tempArr?[1])!)!
        let aveWidth = sWidth / 240.0
        if minte > Int(sWidth/2) {
//            totalTime = aveWidth *
        }
        return 0.0
    }
    //
    /*
     /**根据时间获取坐标点*/
     -(CGFloat)miniteTimeWithTimeStr:(NSString*)timeStr {
     if (timeStr == nil || [timeStr isEqualToString:@""]) return 0.0;
     NSArray *temp = [timeStr componentsSeparatedByString:@":"];
     NSInteger minte = [temp[0] integerValue]*60 + [temp[1] integerValue];
     //每分钟代表的宽度
     CGFloat aveWidth = DPW/ 240.0;
     if (minte DPW *0.5) {
     totalTime = aveWidth * point.x + 11*60;//下午
     }
     int h = totalTime / 60;
     int m =  ((int)(totalTime + 0.5)) % 60;
     str = [NSString stringWithFormat:@"%d:%d",h,m];
     return str;
     }
     */
}
