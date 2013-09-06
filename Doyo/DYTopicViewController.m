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
#import "DYCell.h"
#import "DYTopicModel.h"

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
    //newArray = [NSMutableArray arrayWithArray:@[@"a", @"b", @"c", @"d", @"e"]];
    //rankingArray = [NSMutableArray arrayWithArray:@[@"hello", @"こんにちはー", @"oooooaaaaa", @"bbbbbbbbbbbbb", @"ccccc"]];
    
    newArray = [[NSMutableArray alloc] init];
    rankingArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        DYTopicModel *model = [[DYTopicModel alloc] init];
        model.titleStr = [NSString stringWithFormat:@"%dたいとるだーーー！", i];
        model.nameStr = [NSString stringWithFormat:@"%d様だーー！", i];
        model.point = i * arc4random() %10;
        
        [newArray addObject:model];
    }
    
    for (int i = 10; i > 0; i--) {
        DYTopicModel *model = [[DYTopicModel alloc] init];
        model.titleStr = [NSString stringWithFormat:@"%dっていうタイトルだよ", i];
        model.nameStr = [NSString stringWithFormat:@"%dなまえー", i];
        model.point = i;
        
        [rankingArray addObject:model];
    }
    
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
    DYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DYTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }else {
        [cell refresh];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 0:
        {
            DYTopicModel *model = [newArray objectAtIndex:indexPath.row];
            cell.titleLbl.text = model.titleStr;
            [cell.titleLbl sizeToFit];
            cell.nameLbl.text = model.nameStr;
            cell.pointLbl.text = [NSString stringWithFormat:@"%d", model.point];
            cell.niceBtn.frame = CGRectMake(70, cell.titleLbl.frame.origin.y + cell.titleLbl.frame.size.height + 10, 40, 40);
            cell.pointLbl.frame = CGRectMake(cell.niceBtn.frame.origin.x + cell.niceBtn.frame.size.width + 80,
                                             cell.titleLbl.frame.origin.y + cell.titleLbl.frame.size.height + 10,
                                             40, 40);
            break;
        }
        case 1:
        {
            DYTopicModel *model = [rankingArray objectAtIndex:indexPath.row];
            cell.titleLbl.text = model.titleStr;
            [cell.titleLbl sizeToFit];
            cell.nameLbl.text = model.nameStr;
            cell.pointLbl.text = [NSString stringWithFormat:@"%d", model.point];
            cell.rankLbl.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
            
            cell.niceBtn.frame = CGRectMake(70, cell.titleLbl.frame.origin.y + cell.titleLbl.frame.size.height + 10, 40, 40);
            cell.pointLbl.frame = CGRectMake(cell.niceBtn.frame.origin.x + cell.niceBtn.frame.size.width + 80,
                                             cell.titleLbl.frame.origin.y + cell.titleLbl.frame.size.height + 10,
                                             40, 40);
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            DYTopicModel *model = [newArray objectAtIndex:indexPath.row];
            CGSize size = [model.titleStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                     constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                         lineBreakMode:NSLineBreakByWordWrapping];
            return size.height + 120.0;
            break;
        }
        case 1:
        {
            DYTopicModel *model = [rankingArray objectAtIndex:indexPath.row];
            CGSize size = [model.titleStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                     constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                         lineBreakMode:NSLineBreakByWordWrapping];
            return size.height + 120.0;
            break;
        }
        default:
            return 100.0;
            break;
    }
    
    
    //return 150.0;
}

@end
