//
//  DYTLViewController.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/06.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTLViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
{
    NSMutableArray *commentArray;
    
    BOOL isBottomLoading;
    
    BOOL isDragging;
    UIActivityIndicatorView *refreshSpinner;
    
    UIView *refreshView;
    
//    UITextView *textField;
    
    //UITextView *inputTextView;
    
    UIView *bottomView;
    UIButton *postBtn;
    
    BOOL isEditing;
    
    NSString *commentPostStr;
}

@property (nonatomic, strong) UITextView *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
