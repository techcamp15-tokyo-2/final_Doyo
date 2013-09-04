//
//  DYViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/04.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYViewController.h"

@interface DYViewController ()

@end

@implementation DYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //btn.frame = CGRectMake(50, 100, 80, 50);
    //btn
    
    NSLog(@"%f", _btn.frame.origin.x);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
