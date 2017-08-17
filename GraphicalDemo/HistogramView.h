//
//  HistogramView.h
//  DemoWebView
//
//  Created by BillBo on 2017/8/3.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistogramView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title YAxisLeftData:(NSMutableArray<NSNumber *> *)yLeftData YAxisRightData:(NSMutableArray<NSNumber *>*)yRightData YData:(NSMutableArray<NSNumber *>*)yData XData:(NSMutableArray<NSString*>*)xData;

@end
