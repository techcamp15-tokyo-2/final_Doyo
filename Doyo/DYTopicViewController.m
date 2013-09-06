//
//  DYTopicViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTopicViewController.h"
#import "SVSegmentedControl.h"
#import "DYTopicPostViewController.h"

@interface DYTopicViewController ()
{
    
}

@end

@implementation DYTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"topic";
        //self.navigationItem.title = @"話題";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //segment切り替え
    SVSegmentedControl *sv = [[SVSegmentedControl alloc] initWithSectionTitles:@[@"new", @"ranking"]];
    [sv addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [sv setSelectedSegmentIndex:0 animated:NO];
    sv.frame = CGRectMake(0, 0, 150, 35);
    sv.crossFadeLabelsOnDrag = YES;
    sv.thumb.tintColor = [UIColor colorWithRed:0.345 green:0.889 blue:0.312 alpha:1.000];
    self.navigationItem.titleView = sv;
    
    //話題投稿画面show
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"post" style:UIBarButtonItemStyleBordered target:self action:@selector(showTopicPostCtl)];
    self.navigationItem.rightBarButtonItem = btn;
    
    //初期起動はnewを表示
    segNum = 1;
    
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self createArray];
    
}

-(void)showTopicPostCtl
{
    DYTopicPostViewController *topicPostCtl = [[DYTopicPostViewController alloc] initWithNibName:@"DYTopicPostViewController" bundle:nil];
    UINavigationController *navCtl = [[UINavigationController alloc] initWithRootViewController:topicPostCtl];
    [self.navigationController presentViewController:navCtl animated:YES completion:^{
        
    }];
}

-(void)createArray
{
    newArray = [NSMutableArray arrayWithArray:@[@"a", @"b", @"c", @"d", @"e"]];
    rankingArray = [NSMutableArray arrayWithArray:@[@"hello", @"こんにちはー", @"oooooaaaaa", @"bbbbbbbbbbbbb", @"ccccc"]];
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
        segNum = 1;
        [_tableView reloadData];
    }else if (seg.selectedSegmentIndex == 1) {
        //open ranking
        segNum = 2;
        [_tableView reloadData];
    }
    
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            if (segNum == 1) {
                return newArray.count;
            }else {
                return 0;
            }
            break;
        case 1:
            if (segNum == 2) {
                return rankingArray.count;
            }else {
                return 0;
            }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [newArray objectAtIndex:indexPath.row]];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [rankingArray objectAtIndex:indexPath.row]];
            break;
        default:
            break;
    }
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

@end
