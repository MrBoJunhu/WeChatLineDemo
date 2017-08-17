//
//  HistogramView.m
//  DemoWebView
//
//  Created by BillBo on 2017/8/3.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "HistogramView.h"

#import "NSString+Category.h"

static CGFloat titleFontSize = 15;

static CGFloat detailFontSize = 8;

@interface HistogramView()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *yLeftData;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *yRightData;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *yData;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *xData;

@end

@implementation HistogramView


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title YAxisLeftData:(NSMutableArray<NSNumber *> *)yLeftData YAxisRightData:(NSMutableArray<NSNumber *> *)yRightData YData:(NSMutableArray<NSNumber *> *)yData XData:(NSMutableArray<NSString *> *)xData{
    
    self = [super initWithFrame:frame];
    
    if (self) {
       
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.yLeftData = [NSMutableArray arrayWithArray:yLeftData];
        
        self.yRightData = [NSMutableArray arrayWithArray:yRightData];
        
        self.yData = [NSMutableArray arrayWithArray:yData];
        
        self.xData = [NSMutableArray arrayWithArray:xData];
     
        title = @"测试title";
        
        self.title = title;
    
    }
    
    return self;
    
}

- (void)drawRect:(CGRect)rect {
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    
    //数据组
    NSArray *arr = self.yData;
    
    //Y轴左侧数据组
    NSArray *Y_LeftArray = self.yLeftData;
 
    //Y轴右侧数据组
    NSArray *Y_RightArray = self.yRightData;
    
    
    //横轴简介
    NSArray *x_Array = self.xData;
    
    //获取最大值
    CGFloat maxValue1 = [[Y_LeftArray valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat maxValue2 = [[Y_RightArray valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat maxValue3 = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];
    NSArray *maxValueArray = @[@(maxValue1),@(maxValue2),@(maxValue3)];
    CGFloat maxValue = [[maxValueArray valueForKeyPath:@"@max.floatValue"] floatValue];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat title_Height;
    //创建文字属性字典
    if (self.title.length > 0 ) {
      
        //title
        NSDictionary *titleDic = @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:titleFontSize],
                                   NSForegroundColorAttributeName : [UIColor blackColor],
                                   NSStrokeWidthAttributeName:@6
                                   };
        
        CGFloat title_Width = [NSString widthForString:self.title fontSize:18];
        title_Height = [NSString heightForString:self.title fontSize:18];
        CGPoint title_Point = CGPointMake(rect.size.width/2  - title_Width/2, 0);
        [self.title drawAtPoint:title_Point withAttributes:titleDic];
        
    }
 
    //显示文字
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:detailFontSize],
                          NSForegroundColorAttributeName:[UIColor blackColor],
                          NSStrokeWidthAttributeName:@5
                          };

    
    //四周边距
    CGFloat edge_Space = 20;
    
    CGFloat view_Width = self.bounds.size.width;
    
    CGFloat view_Height = self.bounds.size.height;
    
    NSUInteger histogram_Count = arr.count;
    
    
    //画坐标轴
    CGFloat line_Width = 2; //标记点宽度
    CGFloat small_edgeSpace = 0.5;
    CGPoint aPoints[5]; //坐标点组
   
    aPoints[0] = CGPointMake(edge_Space - small_edgeSpace, edge_Space ); //坐标0(左上角,Y轴加titleHeight)
    
    aPoints[1] = CGPointMake(edge_Space,view_Height - edge_Space + small_edgeSpace); //坐标1(原点)
    
    aPoints[2] = CGPointMake(view_Width - edge_Space + small_edgeSpace, aPoints[1].y); //坐标2(x轴最大)
    
    aPoints[3] = CGPointMake(aPoints[2].x, aPoints[0].y);
    
    CGContextAddLines(ctx, aPoints, 4);
    
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    //柱状最大高度
    CGFloat histogram_maxH = view_Height - 2 * edge_Space;

    //绘制Y轴文字时候向上平移
    CGFloat YMove_Space = 5;
    //绘制Y轴文字时候向左/右平移
    CGFloat XMove_Space = 5;
    
    //Y轴左侧文字与横轴
    for (NSUInteger i = 0 ; i < Y_LeftArray.count; i ++) {
        
        //Y轴左侧最大值
        CGFloat Y_LeftMaxValue = maxValue;
        
        NSNumber *leftY = Y_LeftArray[i];
        
        NSString *leftY_String = leftY.stringValue;
        
        CGFloat leftY_String_Width = [leftY_String boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.width;
        
        CGFloat leftY_H = ([leftY integerValue]/Y_LeftMaxValue) * histogram_maxH;
        
        //分割点Y轴位置
        CGFloat leftY_Y = view_Height - edge_Space - leftY_H;
        
        CGPoint  leftY_Point = CGPointMake(edge_Space - leftY_String_Width - XMove_Space, leftY_Y);
        
        [leftY_String drawAtPoint:CGPointMake(leftY_Point.x, leftY_Point.y - YMove_Space) withAttributes:dic];
        
        //坐标轴上的点
        CGPoint leftPoint[2];
        leftPoint[0] = CGPointMake(aPoints[0].x - line_Width, leftY_Point.y);
        leftPoint[1] = CGPointMake(aPoints[0].x, leftPoint[0].y);
        CGContextAddLines(ctx, leftPoint, 2);
        //绘制路径
        CGContextDrawPath(ctx, kCGPathStroke);
        
        //绘制其他X横轴
        CGPoint xPoints[2];
        xPoints[0] = CGPointMake(aPoints[0].x + 0.5, leftY_Y);
        xPoints[1] = CGPointMake(aPoints[2].x, leftY_Y);
        //线条颜色
        CGContextSetRGBStrokeColor(ctx, 240/255, 240/255, 240/255, 1);
        //线宽度
        CGContextSetLineWidth(ctx, 0.5);
        CGContextAddLines(ctx, xPoints, 2);
        CGContextDrawPath(ctx, kCGPathStroke);
        
        
    }

    
    //Y轴右侧文字及点
    for (NSUInteger i = 0 ; i < Y_RightArray.count; i ++) {
        
        NSNumber *y_R = Y_RightArray[i];
        
        NSString *y_RStr = y_R.stringValue;
        
        CGPoint rPoints[2];
        
        CGFloat y_R_H = ([y_R floatValue]/maxValue) * histogram_maxH;
       
        CGFloat y_R_Y = view_Height - edge_Space - y_R_H;
        
        CGFloat y_R_X = aPoints[2].x;
        
        rPoints[0] = CGPointMake(y_R_X, y_R_Y);
        
        rPoints[1] = CGPointMake(y_R_X + line_Width, y_R_Y);
        
        CGContextAddLines(ctx, rPoints, 2);
        
        CGContextDrawPath(ctx, kCGPathStroke);
        
        [y_RStr drawAtPoint:CGPointMake(rPoints[1].x + 2, y_R_Y - YMove_Space) withAttributes:dic];
    
    }
    
    
    
    //画柱状图
    CGFloat w = (view_Width - 2 * edge_Space)/(histogram_Count * 2 - 1);
    CGFloat x = edge_Space;
    CGFloat y = edge_Space;

    CGFloat h = 0;

    
    for (NSUInteger i = 0 ; i < histogram_Count ; i++) {
        
        x = i * w * 2 + edge_Space;
      
        h = ([arr[i] integerValue]/maxValue) * histogram_maxH;
        
        y = view_Height - edge_Space - h;
        
        //画矩形柱体
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        //填充颜色
        if (i%2 == 0) {
            [[UIColor redColor] set];
        }else{
            [[UIColor greenColor] set];
        }
        
        CGContextAddPath(ctx, path.CGPath);
        
        CGContextFillPath(ctx);
        
        //文本绘制
        //X轴文字
        CGFloat word_Height = 30;
        NSString *str = x_Array[i];
        CGFloat string_width = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, word_Height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.width;
        //设置文字矩形的左上角位置, 并且不会自动换行
        CGFloat word_topSpace =  2;//文字距离X轴的距离
        CGFloat path_MaxY = CGRectGetMaxY(path.bounds);
        CGPoint p = CGPointMake(x + w * 0.5 - string_width/2, path_MaxY + word_topSpace);
        //drawInRect :会自动换行
        //drawAtPoint: 不会制动换行
        [str drawAtPoint:p withAttributes:dic];
        
        
        //柱状图上显示数字
        NSNumber *valueNumber = arr[i];
        NSString *valueString = valueNumber.stringValue;
        CGFloat valueString_Width = [valueString boundingRectWithSize:CGSizeMake(MAXFLOAT, word_Height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.width;
        CGFloat valueString_Height = [valueString boundingRectWithSize:CGSizeMake(valueString_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
        CGFloat path_MinY = CGRectGetMinY(path.bounds);
        
        CGPoint str_p = CGPointMake(x + w * 0.5 - valueString_Width/2, path_MinY - valueString_Height - word_topSpace);
        
        [valueString drawAtPoint:str_p withAttributes:dic];
        
        
        //柱状图增加渐变色
        CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.frame = path.bounds;
        gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor,(id)[UIColor whiteColor].CGColor, nil];
        [self.layer insertSublayer:gradientLayer atIndex:0];
        
    }
    
}


@end
