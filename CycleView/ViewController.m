//
//  ViewController.m
//  CycleView
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 HYR. All rights reserved.
//

#import "ViewController.h"
#import "CycleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testCycleView];
    
}

-(void)testCycleView {
    
    NSArray *arr = @[@"http://g.hiphotos.baidu.com/image/h%3D300/sign=6f4318466e2762d09f3ea2bf90ed0849/5243fbf2b211931376d158d568380cd790238dc1.jpg",@"http://f.hiphotos.baidu.com/image/h%3D300/sign=c6464e3f0e4f78f09f0b9cf349300a83/63d0f703918fa0ec3551b4662b9759ee3c6ddbc3.jpg",@"http://h.hiphotos.baidu.com/image/h%3D300/sign=5573dd5fbede9c82b965ff8f5c8180d2/d1160924ab18972b132c39acebcd7b899e510a45.jpg",@"http://a.hiphotos.baidu.com/image/h%3D300/sign=b18b23079522720e64cee4fa4bca0a3a/4a36acaf2edda3ccc4a53e450ce93901213f9216.jpg"];
    
    CycleView *cycleView = [[CycleView alloc] initCycleViewWithListArray:arr frame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.width *9/16.0)];
    cycleView.cycleViewDidSelected = ^(NSInteger index) {
        NSLog(@"%ld",index);
        
    };
    [self.view addSubview:cycleView];
    
}
@end
