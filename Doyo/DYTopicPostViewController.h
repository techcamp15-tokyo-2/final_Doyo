//
//  DYTopicPostViewController.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTopicPostViewController : UIViewController
<UITextViewDelegate>
{
    NSString *postStr;
    UIBarButtonItem *postBtn;
}

@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
