//
//  HistogramViewController.h
//  GraphicalDemo
//
//  Created by BillBo on 2017/8/17.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Type) {
    
    Histogram_Type = 0 ,//柱状图
    
    BrokenLine_Type = 1, //折线图
    
};

@interface HistogramViewController : UIViewController

- (instancetype)initWithType:(Type)type title:(NSString *)title;

@end
