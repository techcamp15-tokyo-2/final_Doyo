//
//  DYTopicViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTopicViewController.h"
#import "SVSegmentedControl.h"

@interface DYTopicViewController ()
{
    NSArray *array;
}

@end

@implementation DYTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"topic";
        self.navigationItem.title = @"話題";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    SVSegmentedControl *sv = [[SVSegmentedControl alloc] initWithSectionTitles:@[@"new", @"ranking"]];
    [sv addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [sv setSelectedSegmentIndex:0 animated:NO];
    sv.frame = CGRectMake(0, 0, 150, 35);
    sv.crossFadeLabelsOnDrag = YES;
    sv.thumb.tintColor = [UIColor colorWithRed:0.999 green:0.889 blue:0.312 alpha:1.000];
    self.navigationItem.titleView = sv;
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    array = @[@"a", @"b", @"c", @"d", @"e"];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changePage:(SVSegmentedControl*)seg
{
    if (seg.selectedSegmentIndex == 0) {
        //open new
        
        [_tableView reloadData];
    }else if (seg.selectedSegmentIndex == 1) {
        //open ranking
        
        [_tableView reloadData];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [array objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

@end
