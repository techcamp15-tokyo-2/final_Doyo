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
#import "DYManager.h"
#import "SVProgressHUD.h"

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

    [[DYManager sharedManager] requestTopicNewDataCompletion:^(BOOL sucsess, NSArray *array) {
        //NSLog(@"newArray:%@", array);
        if (sucsess) {
            newArray = [NSMutableArray arrayWithArray:array];
            [_tableView reloadData];
        }
        
    }];
    
    //ランキング情報取得
    [[DYManager sharedManager] requestTopicRankDataCompletion:^(BOOL sucsess, NSArray *array) {
        if (sucsess) {
            rankingArray = [NSMutableArray arrayWithArray:array];
            [_tableView reloadData];
        }
        
    }];
    
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
    
    //[self createArray];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTopicPointDone:) name:@"updateTopicPoint" object:nil];
    
    
    
    //pull to refresh    
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - 50, 320, 50)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    
	textPull = @"画面を引き下げて...";
    textRelease = @"指を離して更新...";
    textLoading = @"読み込み中...";
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(50 - 20) / 2), floorf((50 - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshSpinner];
    
    [_tableView addSubview:refreshHeaderView];
    [_tableView sendSubviewToBack:refreshHeaderView];
    
    //BtnArray = [NSMutableArray array];
    //alredyBtnArray = [NSMutableArray array];
    //[self niceArray];
    
    
}
/*
-(void)niceArray
{
    //一度押したボタンはもう押すことは出来ません。
    [[DYManager sharedManager] requestSelectUserTopicIDDataCompletion:^(BOOL success, NSArray *array) {
        if (success) {
            //NSLog(@"success:%@", array);
            [BtnArray addObjectsFromArray:array];
            
            for (NSDictionary *d in BtnArray) {
                //[d objectForKey:@"topic_ID"];
                NSLog(@"%@", [d objectForKey:@"topic_ID"]);
                [alredyBtnArray addObject:[d objectForKey:@"topic_ID"]];
            }
            NSLog(@"alredyBtn:%@", alredyBtnArray);
            //[_tableView reloadData];
        }
    }];
}
*/
-(void)updateTopicPointDone:(NSNotification*)notif
{
    int updateTopicID = [notif.object intValue];
    NSLog(@"topicID:%d", updateTopicID);
    
    /*
    if (segNum == 1) {
        //新着画面
    }else if (segNum == 2) {
        //ランキング画面
        
    }
    */
    
    [[DYManager sharedManager] niceArray];
    
    
    for (DYTopicModel *model in newArray) {
        if ([model.topicIDStr intValue] == updateTopicID) {
            model.point++;
            break;
        }
    }
    for (DYTopicModel *model in rankingArray) {
        if ([model.topicIDStr intValue] == updateTopicID) {
            model.point++;
            break;
        }
    }
    
    [_tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    if ([DYManager sharedManager].isPostFlag) {
        //新着情報取得
        [[DYManager sharedManager] requestTopicNewDataCompletion:^(BOOL sucsess, NSArray *array) {
            //NSLog(@"newArray:%@", array);
            if (sucsess) {
                newArray = [NSMutableArray arrayWithArray:array];
                [_tableView reloadData];
            }
            
        }];
        
        //ランキング情報取得
        [[DYManager sharedManager] requestTopicRankDataCompletion:^(BOOL sucsess, NSArray *array) {
            if (sucsess) {
                rankingArray = [NSMutableArray arrayWithArray:array];
                [_tableView reloadData];
            }
            
        }];
    }else {

    }
    
    [DYManager sharedManager].isPostFlag = NO;
    
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
    
    //newArray = [[NSMutableArray alloc] init];
    //rankingArray = [[NSMutableArray alloc] init];
    
    /*
    for (int i = 0; i < 10; i++) {
        DYTopicModel *model = [[DYTopicModel alloc] init];
        model.titleStr = [NSString stringWithFormat:@"%dたいとるだーーー！", i];
        model.nameStr = [NSString stringWithFormat:@"%d様だーー！", i];
        model.point = i * arc4random() %10;
        
        [newArray addObject:model];
    }
    */
    
    /*
    for (int i = 10; i > 0; i--) {
        DYTopicModel *model = [[DYTopicModel alloc] init];
        model.titleStr = [NSString stringWithFormat:@"%dっていうタイトルだよ", i];
        model.nameStr = [NSString stringWithFormat:@"%dなまえー", i];
        model.point = i;
        
        [rankingArray addObject:model];
    }
    */
}

-(void)refresh
{
    [[DYManager sharedManager] requestTopicNewDataCompletion:^(BOOL sucsess, NSArray *array) {
        //NSLog(@"newArray:%@", array);
        if (sucsess) {
            [newArray removeAllObjects];
            [newArray addObjectsFromArray:array];
            
            [_tableView reloadData];
        }
        [self stopLoading];
    }];
    
    //ランキング情報取得
    [[DYManager sharedManager] requestTopicRankDataCompletion:^(BOOL sucsess, NSArray *array) {
        if (sucsess) {
            [rankingArray removeAllObjects];
            [rankingArray addObjectsFromArray:array];
            
            [_tableView reloadData];
        }
        [self stopLoading];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changePage:(SVSegmentedControl*)seg
{
    [self refresh];
    
    [_tableView setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
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

-(BOOL)isOnceTabBtnTopic_ID:(int)topic_ID
{
    BOOL flag = NO;
    
    for (NSString *i in [DYManager sharedManager].alredyBtnArray) {
        if ([i intValue] == topic_ID) {
            flag = YES;
            break;
        }
    }
    NSLog(@"topic_ID::%d::flag::%d", topic_ID, flag);
    return flag;
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
            //cell.iconImgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.iconImgStr]]];
            cell.iconImgView.image = model.iconImg;
            cell.titleLbl.text = model.titleStr;
            [cell.titleLbl sizeToFit];
            cell.nameLbl.text = model.nameStr;
            cell.pointLbl.text = [NSString stringWithFormat:@"%d", model.point];
            cell.niceBtn.frame = CGRectMake(70, cell.titleLbl.frame.origin.y + cell.titleLbl.frame.size.height + 10, 40, 40);
            cell.niceBtn.tag = indexPath.row;
            cell.niceBtn.accessibilityIdentifier = [NSString stringWithString:model.topicIDStr];
            cell.niceBtn.enabled = ([self isOnceTabBtnTopic_ID:[cell.niceBtn.accessibilityIdentifier intValue]]) ? NO : YES;
            /*
            for (int i in alradyBtnArray) {
                <#statements#>
            }
            */
            
            cell.pointLbl.frame = CGRectMake(cell.niceBtn.frame.origin.x + cell.niceBtn.frame.size.width + 80,
                                             cell.titleLbl.frame.origin.y + cell.titleLbl.frame.size.height + 10,
                                             40, 40);
            break;
        }
        case 1:
        {
            DYTopicModel *model = [rankingArray objectAtIndex:indexPath.row];
            //cell.iconImgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.iconImgStr]]];
            cell.iconImgView.image = model.iconImg;
            cell.titleLbl.text = model.titleStr;
            [cell.titleLbl sizeToFit];
            cell.nameLbl.text = model.nameStr;
            cell.pointLbl.text = [NSString stringWithFormat:@"%d", model.point];
            cell.rankLbl.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
            
            cell.niceBtn.frame = CGRectMake(70, cell.titleLbl.frame.origin.y + cell.titleLbl.frame.size.height + 10, 40, 40);
            cell.niceBtn.tag = indexPath.row;
            cell.niceBtn.accessibilityIdentifier = [NSString stringWithString:model.topicIDStr];
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


#pragma mark - Pull to refresh data source

-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
	return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"dragStart");
    
    if (isLoading) {
        return;
    }
    isDragging = YES;
     
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
    
    NSLog(@"%f", _tableView.contentOffset.y);
    
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView_.contentOffset.y > 0)
            _tableView.contentInset = UIEdgeInsetsZero;
        else if (scrollView_.contentOffset.y >= -50)
            _tableView.contentInset = UIEdgeInsetsMake(- scrollView_.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView_.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView_.contentOffset.y < -50) {
                // User is scrolling above the header
                refreshLabel.text = textRelease;
                //[refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else {
                // User is scrolling somewhere within the header
                refreshLabel.text = textPull;
                //[refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
     
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView_ willDecelerate:(BOOL)decelerate{
    NSLog(@"dragEnd");
    
    if (isLoading) return;
    isDragging = NO;
    if (scrollView_.contentOffset.y <= - 50.0) {
        // Released above the header
        [self startLoading];
    }
     
}

- (void)startLoading {
    
    isLoading = YES;
    
    [SVProgressHUD showWithStatus:@"Loading"];
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        _tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        //refreshLabel.text = textLoading;
        //refreshArrow.hidden = YES;
    }];
    [refreshSpinner startAnimating];
    
    // Refresh action!
    [self pullRefresh];
     
}

- (void)stopLoading {
    
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        _tableView.contentInset = UIEdgeInsetsZero;
        //[refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
     
}

- (void)stopLoadingComplete {
    // Reset the header
    
    //refreshLabel.text = textPull;
    //refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
    [SVProgressHUD dismiss];
    
}

-(void)pullRefresh{
    //NSLog(@"pullRefresh");
	
	//[self progressView];
    //refreshFlag = YES;
    //[self getTweetData];
    
    [self refresh];
    
    //t[self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
    
    //[self stopLoading];
    
     
}


@end
