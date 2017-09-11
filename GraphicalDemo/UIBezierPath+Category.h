//
//  UIBezierPath+Category.h
//  GraphicalDemo
//
//  Created by BillBo on 2017/9/8.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Category)


+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center Length:(double)length edgesNumber:(NSUInteger)edgesNum;

+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center LengthArray:(NSArray *)lengths;

+ (NSArray *)converCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center;

@end
