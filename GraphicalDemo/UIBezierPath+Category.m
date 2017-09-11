//
//  UIBezierPath+Category.m
//  GraphicalDemo
//
//  Created by BillBo on 2017/9/8.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "UIBezierPath+Category.h"

@implementation UIBezierPath (Category)


+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center Length:(double)length edgesNumber:(NSUInteger)edgesNum
{
   
    NSMutableArray *lengths = [NSMutableArray array];
    
    for (NSUInteger i = 0 ; i < edgesNum; i ++) {
        
        [lengths addObject:@(length)];
        
    }
    
    return [self drawPentagonWithCenter:center LengthArray:lengths];
}

+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center LengthArray:(NSArray *)lengths
{
    
    NSArray *coordinates = [self converCoordinateFromLength:lengths Center:center];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    for (int i = 0; i < [coordinates count]; i++) {
       
        CGPoint point = [[coordinates objectAtIndex:i] CGPointValue];
        
        if (i == 0) {
        
            [bezierPath moveToPoint:point];
        
        } else {
        
            [bezierPath addLineToPoint:point];
        
        }
    
    }
    
    [bezierPath closePath];
    
    return bezierPath.CGPath;

}

+ (NSArray *)converCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center {
    
    NSMutableArray *coordinateArray = [NSMutableArray array];
   
    NSUInteger count = lengthArray.count;
    
    CGFloat center_X = center.x;
    
    CGFloat center_Y = center.y;
    
    if (count == 5) {
        
        for (int i = 0; i < count ; i++) {
            
            double length = [[lengthArray objectAtIndex:i] doubleValue];
            
            CGPoint point = CGPointZero;
            
            if (i == 0) {
                
                point =  CGPointMake(center_X - length * sin(M_PI / 5.0), center_Y - length * cos(M_PI / 5.0));
                
            } else if (i == 1) {
                
                point = CGPointMake(center_X + length * sin(M_PI / 5.0),center_Y - length * cos(M_PI / 5.0));
                
            } else if (i == 2) {
                
                point = CGPointMake(center_X + length * cos(M_PI / 10.0),center_Y + length * sin(M_PI / 10.0));
                
            } else if (i == 3) {
                
                point = CGPointMake(center_X,center_Y +length);
                
            } else {
                
                point = CGPointMake(center.x - length * cos(M_PI / 10.0),center.y + length * sin(M_PI / 10.0));
            }
            
            [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
            
        }

    }
    
    if (count == 8) {
        
        double angle = M_PI/4;
        
        for (int i = 0; i < count ; i++) {
        
            double length = [[lengthArray objectAtIndex:i] doubleValue];
            
            CGPoint point = CGPointZero;

            if (i == 0) {
                
                point = CGPointMake(center_X + length , center_Y);
                
            }else if (i == 1){
                
                point = CGPointMake(center_X + cos(angle) * length, center_Y + sin(angle) * length);
                
            }else if (i == 2){
                point = CGPointMake(center_X, center_Y + length);
            }else if (i == 3){
                point = CGPointMake(center_X - cos(angle) * length, center_Y + sin(angle) * length);
                
            }else if (i == 4){
                point = CGPointMake(center_X - length, center_Y);
            }else if (i == 5){
                point = CGPointMake(center_X - length * cos(angle), center_Y - length * sin(angle));
                
            }else if (i == 6){
                point = CGPointMake(center_X, center_Y - length);
            }else{
                point = CGPointMake(center_X + length * cos(angle), center_Y - length*sin(angle));
            }

            [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
        }
        
    }
    
    return coordinateArray;
    
}

@end
