//
//  BrokenBasicView.m
//  GraphicalDemo
//
//  Created by BillBo on 2017/8/17.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "BrokenBasicView.h"

#import "BrokenLineView.h"

@interface BrokenBasicView()

@property (nonatomic, strong) BrokenLineView *lineVeiw ;

@end


@implementation BrokenBasicView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title XArray:(NSMutableArray <NSString *>*)xArray YArray:(NSMutableArray <NSNumber *>*)yArray{
    
    if (self = [super initWithFrame:frame]) {
        
        self.lineVeiw = [[BrokenLineView alloc] initWithFrame:self.bounds title:title XArray:xArray YArray:yArray];
        
        [self addSubview:_lineVeiw];
        
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    self.lineVeiw.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    [_lineVeiw setNeedsDisplay];

}


- (void)drawRect:(CGRect)rect {
   
    self.layer.cornerRadius = 5;
    
    self.layer.masksToBounds = YES;
    
    //增加渐变色
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    
    //startPoint  endPoint 渐变的方向(从左上角到右下角)
    gradientLayer.startPoint = CGPointMake(0, 0);
    
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    gradientLayer.frame = self.bounds;
    
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor yellowColor].CGColor, (id)[UIColor cyanColor].CGColor, (id)[UIColor redColor].CGColor,nil];
    
    gradientLayer.locations = @[@0.0,@0.5,@0.8,@1];
    
    [self.layer addSublayer:gradientLayer];
    
    [self.layer addSublayer:self.lineVeiw.layer];

}

@end
