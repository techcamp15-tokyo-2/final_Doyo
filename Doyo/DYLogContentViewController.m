//
//  DYLogContentViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/10.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYLogContentViewController.h"
#import "DYManager.h"
#import "DYModel.h"
#import "DYCell.h"

@interface DYLogContentViewController ()

@end

@implementation DYLogContentViewController

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
    
    //_label.text = _topicID;
    NSLog(@"topic_ID::%d", [_topicID intValue]);
    NSLog(@"topic_title:%@", _topicTitle);
    
    timeLineArray = [NSMutableArray array];
    [[DYManager sharedManager] requestLogPushDataTopic_ID:[_topicID intValue] Completion:^(BOOL success, NSArray *array) {
        if (success) {
            [timeLineArray addObjectsFromArray:array];
            [_tabelView reloadData];
            NSLog(@"%d", timeLineArray.count);
            /*
            if (timeLineArray.count > 0) {
                for (DYModel *model in timeLineArray) {
                    NSLog(@"%@", model.contentStr);
                }
            }
             */
        }
    }];
    
    //tableView
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    view.backgroundColor = [UIColor redColor];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, -20, 280, 70)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = _topicTitle;
    lbl.font = [UIFont boldSystemFontOfSize:14.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor whiteColor];
    [view addSubview:lbl];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count:%d", timeLineArray.count);
    return timeLineArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DYTLCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DYTLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else {
        [cell reflesh];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    DYModel *model = [timeLineArray objectAtIndex:indexPath.row];
    cell.iconImgView.image = model.iconImg;
    cell.nameLbl.text = model.nameStr;
    cell.contentLbl.text = model.contentStr;
    [cell.contentLbl sizeToFit];
    
    /*
     DYModel *model = [commentArray objectAtIndex:indexPath.row];
     cell.nameLbl.text = model.nameStr;
     cell.contentLbl.text = model.contentStr;
     [cell.contentLbl sizeToFit];
     */
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    DYModel *model = [timeLineArray objectAtIndex:indexPath.row];
    CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                          constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                              lineBreakMode:NSLineBreakByWordWrapping];
    return contentTextSize.height + 70.0;
    
     
}


@end
