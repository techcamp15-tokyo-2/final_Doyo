//
//  DYTLViewController.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/06.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYTLViewController.h"
#import "DYCell.h"
#import "DYManager.h"
#import "DYModel.h"
#import "DYCommentPostViewController.h"
#import "SocketIOPacket.h"
#import <QuartzCore/QuartzCore.h>

@interface DYTLViewController ()

@end

@implementation DYTLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        self.title = @"どぅよ？";
        self.navigationItem.title = @"タイムライン";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.view.backgroundColor = [UIColor redColor];
    
    
    userID = [NSString stringWithString:[DYManager sharedManager].userID];
    
    //タブバー
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"tab_do_select"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_do_nomal"]];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:220.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:246.0/255.0 green:129.0/255.0 blue:35.0/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
    UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"tab_wa_select"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_wa_nomal"]];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:220.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:246.0/255.0 green:129.0/255.0 blue:35.0/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
    UITabBarItem *item3 = [tabBar.items objectAtIndex:2];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"tab_ro_select"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_ro_nomal"]];
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:220.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:246.0/255.0 green:129.0/255.0 blue:35.0/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
    UITabBarItem *item4 = [tabBar.items objectAtIndex:3];
    [item4 setFinishedSelectedImage:[UIImage imageNamed:@"tab_pu_select"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_pu_nomal"]];
    [item4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:220.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [item4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:246.0/255.0 green:129.0/255.0 blue:35.0/255.0 alpha:1.0], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    
    /*
    DYModel *model1 = [[DYModel alloc] init];
    model1.nameStr = @"yuma";
    model1.contentStr = @"helloooooooooooo";
    
    DYModel *model2 = [[DYModel alloc] init];
    model2.nameStr = @"kazunori";
    model2.contentStr = @"horaaaaaaaaa";
    
    DYModel *model3 = [[DYModel alloc] init];
    model3.nameStr = @"darekaaaa";
    model3.contentStr = @"こんにちはーーーーーーーー";
    
    DYModel *model4 = [[DYModel alloc] init];
    model4.nameStr = @"uooooooooo";
    model4.contentStr = @"paoooooonnnnnーーーーーーーー";
    
    DYModel *model5 = [[DYModel alloc] init];
    model5.nameStr = @"nayyyyyyyyyyyyyyyyyyy";
    model2.contentStr = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    
    DYModel *model6 = [[DYModel alloc] init];
    model6.nameStr = @"kazunori";
    model6.contentStr = @"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
    
    DYModel *model7 = [[DYModel alloc] init];
    model7.nameStr = @"kazunori";
    model7.contentStr = @"1111111111111111111111111111111111111111111111111111111111111111111111111112222gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggl";
    
    DYModel *model8 = [[DYModel alloc] init];
    model8.nameStr = @"kazunori";
    model8.contentStr = @"foooooooooooooo";
    */
    
    //commentPastArray = [[NSMutableArray alloc] initWithArray:@[model1, model2, model3, model4, model5, model6, model7, model8]];
    //commentCenterArray = [[NSMutableArray alloc] initWithArray:@[model1, model2, model3, model4, model5, model6, model7, model8]];
    //commentNewArray = [[NSMutableArray alloc] initWithArray:@[model1, model2, model3, model4, model5, model6, model7, model8]];
    
    commentPastArray = [NSMutableArray array];
    commentCenterArray = [NSMutableArray array];
    commentNewArray = [NSMutableArray array];
    
    topicArray = [NSMutableArray array];
    //[topicArray addObjectsFromArray:@[@"past", @"center", @"new"]];
    
    //[self createArray];
    
    
        
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    size = [UIScreen mainScreen].bounds.size;
    size.height -= 20.0;
    
    bottomView = [[UIView alloc] init];
    if (size.height == 460.0) {
        bottomView.frame = CGRectMake(0, 371, 320, 40);
    }else {
        bottomView.frame = CGRectMake(0, 459, 320, 40);
    }
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 5.0;
    bottomView.clipsToBounds = YES;
    bottomView.userInteractionEnabled = YES;
    
    _textField = [[UITextView alloc] init];
    _textField.frame = CGRectMake(10, 2.5, 240, 35);
    _textField.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
    _textField.delegate = self;
    //textField.font = [];
    _textField.textAlignment = NSTextAlignmentLeft;
    //_textField.clipsToBounds = NO;
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.layer.cornerRadius = 10.0;
    _textField.clipsToBounds = YES;
    [bottomView addSubview:_textField];
    
    postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.frame = CGRectMake(260, 5, 50, 30);
    [postBtn setImage:[UIImage imageNamed:@"postBtn"] forState:UIControlStateNormal];
    [postBtn setTitle:@"post" forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchUpInside];
    postBtn.enabled = NO;
    
    [bottomView addSubview:postBtn];
    
    [self.view addSubview:bottomView];
    
    _textField.inputAccessoryView = bottomView;
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    //inputAccessoryView
    
    /*
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postBtn.frame = CGRectMake(260, 2.5, 50, 30);
    [postBtn setTitle:@"post" forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchUpInside];
     */
    //[self.view addSubview:postBtn];
    //[self.view bringSubviewToFront:postBtn];
    
    /*
     inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 2.5, 240, 30)];
     inputTextView.backgroundColor = [UIColor blueColor];
     inputTextView.delegate = self;
     inputTextView.textAlignment = NSTextAlignmentLeft;
     //_textField.clipsToBounds = NO;
     inputTextView.keyboardType = UIKeyboardTypeDefault;
     */
    
    /*
    UIView *inputView = [[UIView alloc] init];
    //postView.tag = 100;
    //CGSize size = [UIScreen mainScreen].bounds.size;
    inputView.frame = CGRectMake(0, 420, 320, 35);
    inputView.backgroundColor = [UIColor cyanColor];
    inputView.userInteractionEnabled = YES;
    //[self.view addSubview:postView];
    
    [inputView addSubview:postBtn];
    [inputView addSubview:_textField];
    */
    
    //_textField.inputAccessoryView = bottomView;
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    //singleTap.delegate = self;
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
    //node.js系
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(applicationWillResignActive)
               name:@"applicationWillResignActive"
             object:nil];
    [nc addObserver:self
           selector:@selector(applicationDidBecomeActive)
               name:@"applicationDidBecomeActive"
             object:nil];
    
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    
    count = 0;
    
    self.view.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    
}

- (void)applicationDidBecomeActive
{
    // localhost:3000に接続開始
    [socketIO connectToHost:@"49.212.140.71" onPort:10001];
}

- (void)applicationWillResignActive
{
    // 接続終了
    [socketIO disconnect];
}

// イベント送信
/*
- (IBAction)sendEvent:(id)sender
{
    // 文字が入力されていなければ何もしない
    if (_textField.text.length == 0) {
        return;
    }
    
    // イベント送信
    [socketIO sendEvent:@"message:send" withData:@{@"user_ID" :[DYManager sharedManager].userID ,@"message" : _textField.text}];
    
    // テキストフィールドをリセット
    _textField.text = @"";
}
 */

#pragma mark - socket.IO-objC method

// サーバとの接続が成功したときに実行されるメソッド
- (void)socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"%s", __func__);
    
    //_textField.enabled = YES;
    //self.formCell.sendButton.enabled = YES;
}

// イベントを受信したときに実行されるメソッド
- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"%s", __func__);
    
    if ([packet.name isEqualToString:@"message:receive"]) {
        // メッセージが空でなければ追加
        if (packet.args[0][@"message"]) {
            //[commentArray insertObject:packet.args[0][@"message"] atIndex:0];
            //[commentArray addObject:packet.args[0][@"message"]];
            //[self.datas insertObject:packet.args[0][@"user_ID"] atIndex:0];
            //[commentArray addObject:packet.args[0]];
            
            DYModel *model = [[DYModel alloc] init];
            model.nameStr = [packet.args[0] objectForKey:@"name"];
            model.contentStr = [packet.args[0] objectForKey:@"message"];
            model.iconImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[packet.args[0] objectForKey:@"iconURL"]]]];
            model.userID = [packet.args[0] objectForKey:@"user_ID"];
            
            [commentNewArray addObject:model];
            [self.tableView reloadData];
        }
    }
    else if([packet.name isEqualToString:@"firstMessage"]) {
        //初期起動
        
        if (commentPastArray.count > 0) {
            [commentPastArray removeAllObjects];
        }
        if (commentCenterArray.count > 0) {
            [commentCenterArray removeAllObjects];
        }
        if (commentNewArray.count > 0) {
            [commentNewArray removeAllObjects];
        }
        
        int count2 = 0;
        for (NSArray *array in packet.args[0]) {
            
            //NSLog(@"####################%@", array);
            
            if (array.count > 0) {
                for (NSDictionary *dic in array) {
                    DYModel *model = [[DYModel alloc] init];
                    model.nameStr = [dic objectForKey:@"name"];
                    model.contentStr = [dic objectForKey:@"message"];
                    model.iconImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"iconURL"]]]];
                    model.userID = [dic objectForKey:@"user_ID"];
                    
                    switch (count2) {
                        case 0:
                            [commentPastArray addObject:model];
                            break;
                        case 1:
                            [commentCenterArray addObject:model];
                            break;
                        case 2:
                            [commentNewArray addObject:model];
                            break;
                        default:
                            break;
                    }
                    
                    
                }
            }else {
                
            }
            count2++;
            
        }
        
        [self.tableView reloadData];
    }
    else if ([packet.name isEqualToString:@"addTopic"]) {
        // メッセージが空でなければ追加
        
        for (NSDictionary *dic in packet.args[0]) {
            
            NSLog(@"%@", dic);
            
            //[commentArray insertObject:dic[@"title"] atIndex:0];
            
            //topicStr = dic[@"title"];
            [topicArray addObject:dic[@"title"]];
            [topicArray removeObjectAtIndex:0];
            
            [commentPastArray removeAllObjects];
            [commentPastArray addObjectsFromArray:commentCenterArray];
            [commentCenterArray removeAllObjects];
            [commentCenterArray addObjectsFromArray:commentNewArray];
            [commentNewArray removeAllObjects];
            
        }
        
        //topicStr = packet.args[0][0][@"title"];
        
        [self.tableView reloadData];
    }
    else if ([packet.name isEqualToString:@"firstTopic"]) {
        // メッセージが空でなければ追加
        
        if (topicArray.count > 0) {
            [topicArray removeAllObjects];
        }
        
        for (NSDictionary *dic in packet.args[0]) {
            
            NSLog(@"firstTopic##########::%@", dic);
            
            //[commentArray insertObject:dic[@"title"] atIndex:0];
            //topicStr = dic[@"title"];
            [topicArray addObject:dic[@"title"]];
        }
        
        //[commentArray packet.args[0][0][@"title"]];
        //topicStr = packet.args[0][0][@"title"];
        
        [self.tableView reloadData];
    }
    
}

// サーバとの接続が切断されたときに実行されるメソッド
- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"%s", __func__);
    
    //_textField.enabled = NO;
    //self.formCell.sendButton.enabled = NO;
    postBtn.enabled = NO;
}


/*
-(void)createArray
{
    //array1 = [[NSMutableArray alloc] init];
    array2 = [[NSMutableArray alloc] init];
    array3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        DYModel *model = [[DYModel alloc] init];
        model.nameStr = [NSString stringWithFormat:@"%d君", i];
        model.contentStr = [NSString stringWithFormat:@"%dだよ", i];
        [array2 addObject:model];
    }
    
    for (int i = 0; i < 7; i++) {
        DYModel *model = [[DYModel alloc] init];
        model.nameStr = [NSString stringWithFormat:@"%dちゃん", i];
        model.contentStr = [NSString stringWithFormat:@"%dざます", i];
        [array3 addObject:model];
    }
    
}
*/

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer
{
    if (![_textField isFirstResponder]) {
        if (isEditing) {
            [_textField becomeFirstResponder];
        }
    
    }

    [_textField resignFirstResponder];
    //NSLog(@"tap");
//    [self.view resignFirstResponder];
    
    //bottom投稿再配置
    
    bottomView = [[UIView alloc] init];
    if (size.height == 460.0) {
        bottomView.frame = CGRectMake(0, 371, 320, 40);
    }else {
        bottomView.frame = CGRectMake(0, 459, 320, 40);
    }
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 5.0;
    bottomView.clipsToBounds = YES;
    bottomView.userInteractionEnabled = YES;
    
    _textField = [[UITextView alloc] init];
    _textField.frame = CGRectMake(10, 2.5, 240, 35);
    _textField.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
    _textField.delegate = self;
    //textField.font = [];
    _textField.textAlignment = NSTextAlignmentLeft;
    //_textField.clipsToBounds = NO;
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.layer.cornerRadius = 10.0;
    _textField.clipsToBounds = YES;
    [bottomView addSubview:_textField];
    
    postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.frame = CGRectMake(260, 5, 50, 30);
    [postBtn setImage:[UIImage imageNamed:@"postBtn"] forState:UIControlStateNormal];
    [postBtn setTitle:@"post" forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:postBtn];
    postBtn.enabled = NO;
    
    [self.view addSubview:bottomView];
    
    _textField.inputAccessoryView = bottomView;
    
    scrollFlag = NO;
    
}

// イベント送信
-(void)commentPost
{
    //NSLog(@"commentPost");
    
    
    //[self.navigationController disablesAutomaticKeyboardDismissal];
    //[self disablesAutomaticKeyboardDismissal];
    
    // 文字が入力されていなければ何もしない
    if (_textField.text.length == 0) {
        return;
    }
    
    // イベント送信
    [socketIO sendEvent:@"message:send" withData:@{@"user_ID" :[DYManager sharedManager].userID ,@"message" : _textField.text}];
    
    // テキストフィールドをリセット
    _textField.text = @"";
    
    
    
    NSLog(@"%d", [_textField isFirstResponder]);
    if (![_textField isFirstResponder]) {
        [_textField becomeFirstResponder];
    }
    [_textField resignFirstResponder];
    
    
    //bottom投稿再配置
    
    bottomView = [[UIView alloc] init];
    if (size.height == 460.0) {
        bottomView.frame = CGRectMake(0, 371, 320, 40);
    }else {
        bottomView.frame = CGRectMake(0, 459, 320, 40);
    }
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 5.0;
    bottomView.clipsToBounds = YES;
    bottomView.userInteractionEnabled = YES;
    
    _textField = [[UITextView alloc] init];
    _textField.frame = CGRectMake(10, 2.5, 240, 35);
    _textField.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
    _textField.delegate = self;
    //textField.font = [];
    _textField.textAlignment = NSTextAlignmentLeft;
    //_textField.clipsToBounds = NO;
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.layer.cornerRadius = 10.0;
    _textField.clipsToBounds = YES;
    [bottomView addSubview:_textField];
    
    postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.frame = CGRectMake(260, 5, 50, 30);
    [postBtn setImage:[UIImage imageNamed:@"postBtn"] forState:UIControlStateNormal];
    //[postBtn setTitle:@"post" forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(commentPost) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:postBtn];
    
    postBtn.enabled = NO;
    
    [self.view addSubview:bottomView];
    
    _textField.inputAccessoryView = bottomView;
    
    
    scrollFlag = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*右上投稿ポタン
-(void)showPostCtl
{
    DYCommentPostViewController *viewCtl = [[DYCommentPostViewController alloc] initWithNibName:@"DYCommentPostViewController" bundle:nil];
    [self presentViewController:viewCtl animated:YES completion:^{
        
    }];
}
*/


#pragma mark - UITextViewDelegate

-(void)registerForKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    //[NSNumber numberWithInt:<#(int)#>];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (!scrollFlag) {
        CGPoint scrollPoint = CGPointMake(0.0, _tableView.contentOffset.y + 165.0);
        [_tableView setContentOffset:scrollPoint animated:YES];
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGPoint scrollPoint = CGPointMake(0.0, _tableView.contentOffset.y - 165.0);
    [_tableView setContentOffset:scrollPoint animated:YES];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self registerForKeyboardNotification];
    
    if (!isEditing) {
        isEditing = YES;
    }else {
        isEditing = NO;
    }
    
    commentPostStr = [NSString stringWithFormat:@"%@", _textField.text];
    NSLog(@"commentPostStr:%@", commentPostStr);
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    scrollFlag = YES;
    // 入力済みのテキストを取得
    NSMutableString *str = [textView.text mutableCopy];
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:text];
    
    //EPLog(@"length2::%d", str.length);
    
    /*
    if (textView.tag == 0) {
        int strCount = MIN(str.length, TitleMaxCount);
        _fieldStrCntLbl.text = [NSString stringWithFormat:@"%d", strCount];
        _titleCountLabel.count = strCount;
    }else if (textView.tag == 1) {
        int strCount = MIN(str.length, BodyMaxCount);
        _strCountLbl.text = [NSString stringWithFormat:@"%d", strCount];
        _bodyCountLabel.count = strCount;
    }*/
    
    int strCount = MIN(str.length, 80);
    NSLog(@"strCount:%d", strCount);
    
    if (_textField.text.length <= 0 || _textField.text.length > 80) {
        postBtn.enabled = NO;
    }else {
        postBtn.enabled = YES;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    
    NSMutableString *str = [textView.text mutableCopy];
    
    /*
    if (textView.tag == 0) {
        if(str.length > TitleMaxCount){
            textView.text = [str substringToIndex:TitleMaxCount];
        }
    }else if (textView.tag == 1) {
        if(str.length > BodyMaxCount){
            textView.text = [str substringToIndex:BodyMaxCount];
        }
    }
    */
    
    if(str.length > 80){
        textView.text = [str substringToIndex:80];
    }
    
    if (_textField.text.length <= 0 || _textField.text.length > 80) {
        postBtn.enabled = NO;
    }else {
        postBtn.enabled = YES;
    }
    
    //[postBtn setEnabled:_textField.text.length > 0 && _textField.text.length > 0];
}



#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10.0;
    view.clipsToBounds = YES;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, -5, 280, 30)];
    lbl.backgroundColor = [UIColor clearColor];
    //lbl.text = @"ガソリンスタンドの溝ってなんなのよ？";
    lbl.font = [UIFont boldSystemFontOfSize:14.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor darkGrayColor];
    [view addSubview:lbl];
    
    if (section == 0) {
        //lbl.text = topicStr;
        lbl.text = [topicArray objectAtIndex:section];
        return view;
    }else if (section == 1) {
        //lbl.text = topicStr;
        lbl.text = [topicArray objectAtIndex:section];
        return view;
    }else if (section == 2) {
        //lbl.text = topicStr;
        lbl.text = [topicArray objectAtIndex:section];
        return view;
    }else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.backgroundColor = [UIColor blackColor];
        return view;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return topicArray.count;
    //return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return commentPastArray.count;
            break;
        case 1:
            return commentCenterArray.count;
            break;
        case 2:
            return commentNewArray.count;
            break;
        default:
            return 0;
            break;
    }
    
    //return commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYModel *m;
    switch (indexPath.section) {
        case 0:
        {
            m = [commentPastArray objectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            m = [commentCenterArray objectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            m = [commentNewArray objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    
    
    if ([m.userID isEqualToString:userID]) {
        //自分のcell
        static NSString *CellIdentifier = @"myCell";
        DYTLCell *myCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!myCell) {
            myCell = [[DYTLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        else {
            [myCell reflesh];
        }
        
        myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.section) {
            case 0:
            {
                DYModel *model = [commentPastArray objectAtIndex:indexPath.row];
                myCell.iconImgView.image = model.iconImg;
                //NSLog(@"iconImg:%@", cell.iconImgView.image);
                myCell.nameLbl.text = model.nameStr;
                myCell.contentLbl.text = model.contentStr;
                
                [myCell.contentLbl sizeToFit];
                //NSLog(@"frame:%f::%f", cell.contentLbl.frame.origin.x, cell.contentLbl.frame.size.width);
                myCell.contentLbl.frame = CGRectMake(320 - 60 - myCell.contentLbl.frame.size.width,
                                                   myCell.iconImgView.frame.origin.y + myCell.iconImgView.frame.size.height - 5,
                                                     myCell.contentLbl.frame.size.width,
                                                     myCell.contentLbl.frame.size.height);
                
                /*
                myCell.bgImgView.frame = CGRectMake(myCell.contentLbl.frame.origin.x - 5,
                                                    myCell.contentLbl.frame.origin.y - 7,
                                                    myCell.bgImgView.image.size.width,
                                                    myCell.bgImgView.image.size.height);
                 */
                myCell.bgImgView.frame = CGRectMake(myCell.contentLbl.frame.origin.x - 5,
                                                    myCell.contentLbl.frame.origin.y - 5,
                                                    myCell.contentLbl.frame.size.width + 25,
                                                    myCell.contentLbl.frame.size.height + 10);
                 
                 
                break;
            }
            case 1:
            {
                DYModel *model = [commentCenterArray objectAtIndex:indexPath.row];
                myCell.iconImgView.image = model.iconImg;
                //NSLog(@"iconImg:%@", cell.iconImgView.image);
                myCell.nameLbl.text = model.nameStr;
                myCell.contentLbl.text = model.contentStr;
                [myCell.contentLbl sizeToFit];
                myCell.contentLbl.frame = CGRectMake(320 - 60 - myCell.contentLbl.frame.size.width,
                                                   myCell.iconImgView.frame.origin.y + myCell.iconImgView.frame.size.height - 5,
                                                     myCell.contentLbl.frame.size.width,
                                                     myCell.contentLbl.frame.size.height);
                
                myCell.bgImgView.frame = CGRectMake(myCell.contentLbl.frame.origin.x - 5,
                                                    myCell.contentLbl.frame.origin.y - 5,
                                                    myCell.contentLbl.frame.size.width + 25,
                                                    myCell.contentLbl.frame.size.height + 10);
                break;
            }
            case 2:
            {
                DYModel *model = [commentNewArray objectAtIndex:indexPath.row];
                myCell.iconImgView.image = model.iconImg;
                //NSLog(@"iconImg:%@", cell.iconImgView.image);
                myCell.nameLbl.text = model.nameStr;
                myCell.contentLbl.text = model.contentStr;
                [myCell.contentLbl sizeToFit];
                myCell.contentLbl.frame = CGRectMake(320 - 60 - myCell.contentLbl.frame.size.width,
                                                   myCell.iconImgView.frame.origin.y + myCell.iconImgView.frame.size.height - 5,
                                                     myCell.contentLbl.frame.size.width,
                                                     myCell.contentLbl.frame.size.height);
                myCell.bgImgView.frame = CGRectMake(myCell.contentLbl.frame.origin.x - 5,
                                                    myCell.contentLbl.frame.origin.y - 5,
                                                    myCell.contentLbl.frame.size.width + 25,
                                                    myCell.contentLbl.frame.size.height + 10);
                break;
            }
                
            default:
                break;
        }
        
        return myCell;

    }else {
        //他人のcell
        static NSString *CellIdentifier = @"otherCell";
        DYOtherTLCell *otherCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!otherCell) {
            otherCell = [[DYOtherTLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        else {
            [otherCell reflesh];
        }
        
        otherCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.section) {
            case 0:
            {
                DYModel *model = [commentPastArray objectAtIndex:indexPath.row];
                otherCell.iconImgView.image = model.iconImg;
                //NSLog(@"iconImg:%@", otherCell.iconImgView.image);
                otherCell.nameLbl.text = model.nameStr;
                otherCell.contentLbl.text = model.contentStr;
                
                [otherCell.contentLbl sizeToFit];
                //NSLog(@"frame:%f::%f", cell.contentLbl.frame.origin.x, cell.contentLbl.frame.size.width);
                otherCell.contentLbl.frame = CGRectMake(59,
                                                   otherCell.iconImgView.frame.origin.y + otherCell.iconImgView.frame.size.height - 5,
                                                   otherCell.contentLbl.frame.size.width,
                                                   otherCell.contentLbl.frame.size.height);
                
                otherCell.bgImgView.frame = CGRectMake(otherCell.contentLbl.frame.origin.x - 19,
                                                    otherCell.contentLbl.frame.origin.y - 5,
                                                    otherCell.contentLbl.frame.size.width + 25,
                                                    otherCell.contentLbl.frame.size.height + 10);
                
                break;
            }
            case 1:
            {
                DYModel *model = [commentCenterArray objectAtIndex:indexPath.row];
                otherCell.iconImgView.image = model.iconImg;
                //NSLog(@"iconImg:%@", otherCell.iconImgView.image);
                otherCell.nameLbl.text = model.nameStr;
                otherCell.contentLbl.text = model.contentStr;
                [otherCell.contentLbl sizeToFit];
                otherCell.contentLbl.frame = CGRectMake(59,
                                                   otherCell.iconImgView.frame.origin.y + otherCell.iconImgView.frame.size.height -5,
                                                   otherCell.contentLbl.frame.size.width,
                                                   otherCell.contentLbl.frame.size.height);
                otherCell.bgImgView.frame = CGRectMake(otherCell.contentLbl.frame.origin.x - 19,
                                                    otherCell.contentLbl.frame.origin.y - 5,
                                                    otherCell.contentLbl.frame.size.width + 25,
                                                    otherCell.contentLbl.frame.size.height + 10);
                break;
            }
            case 2:
            {
                DYModel *model = [commentNewArray objectAtIndex:indexPath.row];
                otherCell.iconImgView.image = model.iconImg;
                //NSLog(@"iconImg:%@", cell.iconImgView.image);
                otherCell.nameLbl.text = model.nameStr;
                otherCell.contentLbl.text = model.contentStr;
                [otherCell.contentLbl sizeToFit];
                otherCell.contentLbl.frame = CGRectMake(59,
                                                   otherCell.iconImgView.frame.origin.y + otherCell.iconImgView.frame.size.height - 5,
                                                   otherCell.contentLbl.frame.size.width ,
                                                   otherCell.contentLbl.frame.size.height);
                
                otherCell.bgImgView.frame = CGRectMake(otherCell.contentLbl.frame.origin.x -19,
                                                    otherCell.contentLbl.frame.origin.y - 5,
                                                    otherCell.contentLbl.frame.size.width + 25,
                                                    otherCell.contentLbl.frame.size.height + 10);
                break;
            }
                
            default:
                break;
        }

        return otherCell;
    }
    
    /*
    static NSString *CellIdentifier = @"otherCell";
    DYOtherTLCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DYOtherTLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else {
        [cell reflesh];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    */
    /*
    //otherCell
    switch (indexPath.section) {
        case 0:
        {
            DYModel *model = [commentPastArray objectAtIndex:indexPath.row];
            cell.iconImgView.image = model.iconImg;
            NSLog(@"iconImg:%@", cell.iconImgView.image);
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;
            
            [cell.contentLbl sizeToFit];
            //NSLog(@"frame:%f::%f", cell.contentLbl.frame.origin.x, cell.contentLbl.frame.size.width);
            cell.contentLbl.frame = CGRectMake(50,
                                               cell.iconImgView.frame.origin.y + cell.iconImgView.frame.size.height + 10,
                                               cell.contentLbl.frame.size.width,
                                               cell.contentLbl.frame.size.height);
            
            break;
        }
        case 1:
        {
            DYModel *model = [commentCenterArray objectAtIndex:indexPath.row];
            cell.iconImgView.image = model.iconImg;
            NSLog(@"iconImg:%@", cell.iconImgView.image);
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;
            [cell.contentLbl sizeToFit];
            cell.contentLbl.frame = CGRectMake(50,
                                               cell.iconImgView.frame.origin.y + cell.iconImgView.frame.size.height + 10,
                                               cell.contentLbl.frame.size.width,
                                               cell.contentLbl.frame.size.height);
            break;
        }
        case 2:
        {
            DYModel *model = [commentNewArray objectAtIndex:indexPath.row];
            cell.iconImgView.image = model.iconImg;
            NSLog(@"iconImg:%@", cell.iconImgView.image);
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;
            [cell.contentLbl sizeToFit];
            cell.contentLbl.frame = CGRectMake(50,
                                               cell.iconImgView.frame.origin.y + cell.iconImgView.frame.size.height + 10,
                                               cell.contentLbl.frame.size.width,
                                               cell.contentLbl.frame.size.height);
            break;
        }
            
        default:
            break;
    }*/
    
    /* myTweetCell
    switch (indexPath.section) {
        case 0:
        {
            DYModel *model = [commentPastArray objectAtIndex:indexPath.row];
            cell.iconImgView.image = model.iconImg;
            NSLog(@"iconImg:%@", cell.iconImgView.image);
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;

            [cell.contentLbl sizeToFit];
            //NSLog(@"frame:%f::%f", cell.contentLbl.frame.origin.x, cell.contentLbl.frame.size.width);
            cell.contentLbl.frame = CGRectMake(320 - 50 - cell.contentLbl.frame.size.width,
                                               cell.iconImgView.frame.origin.y + cell.iconImgView.frame.size.height + 10, cell.contentLbl.frame.size.width, cell.contentLbl.frame.size.height);
            
            break;
        }
        case 1:
        {
            DYModel *model = [commentCenterArray objectAtIndex:indexPath.row];
            cell.iconImgView.image = model.iconImg;
            NSLog(@"iconImg:%@", cell.iconImgView.image);
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;
            [cell.contentLbl sizeToFit];
            cell.contentLbl.frame = CGRectMake(320 - 50 - cell.contentLbl.frame.size.width,
                                               cell.iconImgView.frame.origin.y + cell.iconImgView.frame.size.height + 10, cell.contentLbl.frame.size.width, cell.contentLbl.frame.size.height);
            break;
        }
        case 2:
        {
            DYModel *model = [commentNewArray objectAtIndex:indexPath.row];
            cell.iconImgView.image = model.iconImg;
            NSLog(@"iconImg:%@", cell.iconImgView.image);
            cell.nameLbl.text = model.nameStr;
            cell.contentLbl.text = model.contentStr;
            [cell.contentLbl sizeToFit];
            cell.contentLbl.frame = CGRectMake(320 - 50 - cell.contentLbl.frame.size.width,
                                               cell.iconImgView.frame.origin.y + cell.iconImgView.frame.size.height + 10, cell.contentLbl.frame.size.width, cell.contentLbl.frame.size.height);
            break;
        }
            
        default:
            break;
    }*/
    
    /*
    DYModel *model = [commentArray objectAtIndex:indexPath.row];
    cell.nameLbl.text = model.nameStr;
    cell.contentLbl.text = model.contentStr;
    [cell.contentLbl sizeToFit];
    */
    
    //return cell;
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
    
    switch (indexPath.section) {
        case 0:
        {
            DYModel *model = [commentPastArray objectAtIndex:indexPath.row];
            CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:12.0]
                                                  constrainedToSize:CGSizeMake(170, SIZE_MAX)
                                                      lineBreakMode:NSLineBreakByWordWrapping];
            //NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
            return contentTextSize.height + 50.0;
            break;
        }
        case 1:
        {
            DYModel *model = [commentCenterArray objectAtIndex:indexPath.row];
            CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:12.0]
                                                  constrainedToSize:CGSizeMake(170, SIZE_MAX)
                                                      lineBreakMode:NSLineBreakByWordWrapping];
            //NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
            return contentTextSize.height + 50.0;
            break;
        }
        case 2:
        {
            DYModel *model = [commentNewArray objectAtIndex:indexPath.row];
            CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:12.0]
                                                  constrainedToSize:CGSizeMake(170, SIZE_MAX)
                                                      lineBreakMode:NSLineBreakByWordWrapping];
            //NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
            return contentTextSize.height + 50.0;
            break;

        }
        default:
            return 100.0;
            break;
    }
    
    /*
    DYModel *model = [commentArray objectAtIndex:indexPath.row];
    CGSize contentTextSize = [model.contentStr sizeWithFont:[UIFont boldSystemFontOfSize:14.0]
                                          constrainedToSize:CGSizeMake(300, SIZE_MAX)
                                              lineBreakMode:NSLineBreakByWordWrapping];
    //NSLog(@"row:%d::height:%f", indexPath.row, contentTextSize.height);
    return contentTextSize.height + 70.0;
     */
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
