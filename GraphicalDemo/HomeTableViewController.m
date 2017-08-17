//
//  HomeTableViewController.m
//  GraphicalDemo
//
//  Created by BillBo on 2017/8/17.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "HomeTableViewController.h"

#import "HistogramViewController.h"

@interface HomeTableViewController ()

/**
 曲线图类型
 */
@property (nonatomic, strong) NSArray *typesArray;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.title = @"图形绘制";
    self.typesArray = @[@"柱状图", @"折线图"];

    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.typesArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_Idenfitier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Idenfitier];

    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_Idenfitier];
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_Idenfitier];
    
    }
    
    cell.textLabel.text = self.typesArray[indexPath.row];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    HistogramViewController *vc = [[HistogramViewController alloc] initWithType:indexPath.row title:self.typesArray[indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end
