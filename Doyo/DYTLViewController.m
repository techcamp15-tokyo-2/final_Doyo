//
//  DYTLViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTLViewController.h"
#import "DYCell.h"
#import "DYManager.h"
#import "DYCommentPostViewController.h"

@interface DYTLViewController ()

@end

@implementation DYTLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"TL";
        self.navigationItem.title = @"タイムライン";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    commentArray = [[NSMutableArray alloc] initWithArray:@[@"hello", @"hora!!!!", @"こんにちわーーーーー", @"もーーーーー！"]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    DYCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DYCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /*
    STModel *tweetModel = [modelArray objectAtIndex:indexPath.row];
    cell.userNameLabel.text = tweetModel.userName;
    cell.IDNameLabel.text = tweetModel.IDName;
    cell.contentLabel.text = tweetModel.content;
    [cell.contentLabel sizeToFit];
    */
    
    //cell.favBtn.tag = indexPath.row;
    
    //cell.selectionStyle = u
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", tweetModel.content];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [commentArray objectAtIndex:indexPath.row]];
    
    return cell;
     
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    STModel *tweetModel = [modelArray objectAtIndex:indexPath.row];
    
    CGSize cellSize = [tweetModel.content sizeWithFont:[UIFont systemFontOfSize:13.0]
                                     constrainedToSize:CGSizeMake(320, CGFLOAT_MAX)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    //NSLog(@"height:%d:%f", indexPath.row, cellSize.height);
    
    float height = 60.0 + cellSize.height + 35.0;
    //NSLog(@"height::%d::%f", indexPath.row, height);
    //return 410.0;
     */
    return 120.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSLog(@"%d", indexPath.row);
    
    DYCommentPostViewController *viewCtl = [[DYCommentPostViewController alloc] initWithNibName:@"DYCommentPostViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtl animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
