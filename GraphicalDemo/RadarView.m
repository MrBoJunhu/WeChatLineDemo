//
//  RadarView.m
//  GraphicalDemo
//
//  Created by BillBo on 2017/9/8.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "RadarView.h"
#import "UIBezierPath+Category.h"

@implementation RadarView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat space = 20;
    
    CGFloat count = 8;

    for (NSUInteger i  = 0; i < count; i ++) {
        
        CGPathRef path = [UIBezierPath drawPentagonWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2) Length:space * i edgesNumber:count];
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        
        [[UIColor redColor] set];
        
        bezierPath.CGPath = path;
        
        [bezierPath stroke];

    }

    CGContextDrawPath(context, kCGPathStroke);
    
}

@end
