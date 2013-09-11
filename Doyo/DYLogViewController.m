//
//  DYLogViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYLogViewController.h"
#import "DYManager.h"
#import "DYTopicModel.h"
#import "SVSegmentedControl.h"
#import "DYCell.h"
#import "DYLogContentViewController.h"
#import "SVProgressHUD.h"

@interface DYLogViewController ()

@end

@implementation DYLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"log";
        //self.navigationItem.title = @"人気ログ";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor brownColor];
    
    //初期起動では新着画面
    segNum = 1;
    
    //[self requestFirst];
    
    //tableView
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self requestFirst];
    
    //segment切り替え
    SVSegmentedControl *sv = [[SVSegmentedControl alloc] initWithSectionTitles:@[@"new", @"ranking"]];
    [sv addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [sv setSelectedSegmentIndex:0 animated:NO];
    sv.frame = CGRectMake(0, 0, 150, 35);
    sv.crossFadeLabelsOnDrag = YES;
    sv.thumb.tintColor = [UIColor colorWithRed:0.905 green:0.409 blue:0.312 alpha:1.000];
    self.navigationItem.titleView = sv;
    
    
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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTopicPointDone:) name:@"updateTopicPoint" object:nil];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

-(void)requestFirst
{
    //ログ情報取得
    [SVProgressHUD showWithStatus:@"Loading"];
    newArray = [NSMutableArray array];
    [[DYManager sharedManager] requestTopicLogNewDataCompletion:^(BOOL success, NSArray *array) {
        if (success) {
            [newArray addObjectsFromArray:array];
            [_tableView reloadData];
        }
    }];
    rankingArray = [NSMutableArray array];
    [[DYManager sharedManager] requestTopicLogDataCompletion:^(BOOL success, NSArray *array) {
        if (success) {
            //NSLog(@"%@", array);
            /*
             for (DYTopicModel *model in array) {
             NSLog(@"%@", model.titleStr);
             
             }
             */
            [rankingArray addObjectsFromArray:array];
            [_tableView reloadData];
        }
    }];
    
    [SVProgressHUD dismiss];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self requestFirst];
    
    
}


#pragma mark - segment

-(void)changePage:(SVSegmentedControl*)seg
{
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
            cell.niceBtn.enabled = ([self isOnceTabBtnTopic_ID:[cell.niceBtn.accessibilityIdentifier intValue]]) ? NO : YES;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (segNum) {
        case 1:
        {
            DYTopicModel *model = [newArray objectAtIndex:indexPath.row];
            
            
            DYLogContentViewController *viewCtl = [[DYLogContentViewController alloc] initWithNibName:@"DYLogContentViewController" bundle:nil];
            viewCtl.topicID = model.topicIDStr;
            viewCtl.topicTitle = model.titleStr;
            
            [self.navigationController pushViewController:viewCtl animated:YES];
            break;
        }
        case 2:
        {
            DYTopicModel *model = [rankingArray objectAtIndex:indexPath.row];
            
            
            DYLogContentViewController *viewCtl = [[DYLogContentViewController alloc] initWithNibName:@"DYLogContentViewController" bundle:nil];
            viewCtl.topicID = model.topicIDStr;
            viewCtl.topicTitle = model.titleStr;
            
            [self.navigationController pushViewController:viewCtl animated:YES];
            break;
        }
            
        default:
            break;
    }
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
    
    //NSLog(@"%f", _tableView.contentOffset.y);
    
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
    
    //[self performSelector:@selector(stopLoading) withObject:nil afterDelay:1.0];
    
    //[self stopLoading];
    
    
}

-(void)refresh
{
    [[DYManager sharedManager] requestTopicLogNewDataCompletion:^(BOOL sucsess, NSArray *array) {
        //NSLog(@"newArray:%@", array);
        if (sucsess) {
            [newArray removeAllObjects];
            [newArray addObjectsFromArray:array];
            
            [_tableView reloadData];
        }
       
    }];
    
    //ランキング情報取得
    [[DYManager sharedManager] requestTopicLogDataCompletion:^(BOOL sucsess, NSArray *array) {
        if (sucsess) {
            [rankingArray removeAllObjects];
            [rankingArray addObjectsFromArray:array];
            
            [_tableView reloadData];
        }
     
    }];
    
    [self stopLoading];
}




@end
