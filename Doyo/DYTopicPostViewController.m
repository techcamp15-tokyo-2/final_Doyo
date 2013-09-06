//
//  DYTopicPostViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTopicPostViewController.h"

@interface DYTopicPostViewController ()

@end

@implementation DYTopicPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@"dismissView" forControlEvents:UIControlEventTouchUpInside];
    dismissBtn.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    */
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    
    self.view.backgroundColor = [UIColor greenColor];
    
    //toolbar
    //UIToolbar *toolBar = [ [ UIToolbar alloc ] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //[self.view addSubview:toolBar];
    
    //キャンセルポタン
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"cansel" style:UIBarButtonItemStyleBordered target:self action:@selector(canselBtnTap)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    
    //投稿ボタン
    UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"post" style:UIBarButtonItemStyleBordered target:self action:@selector(postBtnTap)];
    self.navigationItem.rightBarButtonItem = postBtn;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)canselBtnTap
{
    //キャンセル時
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)postBtnTap
{
    //投稿時
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
