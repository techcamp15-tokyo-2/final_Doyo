//
//  DYManager.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYManager.h"
#import "DYTopicModel.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "DYTwiLoginViewController.h"
#import "SVProgressHUD.h"
#import "DYModel.h"

#define TOPIC_NEW_URL           @"http://49.212.140.71/Doyo_php/select_topic_new.php"
#define TOPIC_RANK_URL          @"http://49.212.140.71/Doyo_php/select_topic_rank.php"
#define TWITTER_LOGIN_URL       @"http://49.212.140.71/Doyo_php/insert_profile.php"
#define INSERT_TOPIC            @"http://49.212.140.71/Doyo_php/insert_topic.php"
#define UPDATE_TOPIC_POINT      @"http://49.212.140.71/Doyo_php/update_topic_point.php"
#define INSERT_USER_TOPIC_ID    @"http://49.212.140.71/Doyo_php/insert_user_topic_ID.php"
#define SELECT_USER_TOPIC_ID    @"http://49.212.140.71/Doyo_php/select_user_topic_ID.php"
#define SELECT_LOG_RANK_URL     @"http://49.212.140.71/Doyo_php/select_log_rank.php"
#define SELECT_LOG_NEW_URL      @"http://49.212.140.71/Doyo_php/select_log_new.php"
#define SELECT_LOG_PUSH         @"http://49.212.140.71/Doyo_php/select_log_push.php"

@implementation DYManager

+(DYManager *)sharedManager{
    static DYManager *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[DYManager alloc] init];
    });
    return obj;
}

-(id)init{
    self = [super init];
    if(self){
        
        
        /*
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:@"09dasan" forKey:@"user_ID"];
        [ud setObject:@"ゆうまっちょだっちょ" forKey:@"name"];
        [ud setObject:@"http://a0.twimg.com/profile_images/2498123633/image_normal.jpg" forKey:@"iconImgStr"];
        [ud synchronize];
        */
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        if ([ud objectForKey:@"user_ID"] && [ud objectForKey:@"name"] && [ud objectForKey:@"iconImgStr"]) {
            _userID = [ud objectForKey:@"user_ID"];
            _name = [ud objectForKey:@"name"];
            _iconImgStr = [ud objectForKey:@"iconImgStr"];
            
            NSLog(@"userID:%@::name:%@::iconImg:%@", _userID, _name, _iconImgStr);
            
        }else {
            //ログインビュー表示
            /*
            DYTwiLoginViewController *viewCtl = [[DYTwiLoginViewController alloc] initWithNibName:@"DYTwiLoginViewController" bundle:nil];
            [ presentViewController:viewCtl animated:YES completion:^{
                
            }];
             */
            
            [self login:^(BOOL flag) {
                if (flag) {
                    
                }
            }];
        }
        
        _isPostFlag = NO;
        
        _alredyBtnArray = [NSMutableArray array];
        [self niceArray];
        
    }
    return self;
}

-(void)niceArray
{
    //一度押したボタンはもう押すことは出来ません。
    [self requestSelectUserTopicIDDataCompletion:^(BOOL success, NSArray *array) {
        NSLog(@"%d", success);
        if (success) {
            //NSLog(@"success:%@", array);
            //[BtnArray addObjectsFromArray:array];
            
            
            for (NSDictionary *d in array) {
                //[d objectForKey:@"topic_ID"];
                NSLog(@"%@", [d objectForKey:@"topic_ID"]);
                [_alredyBtnArray addObject:[d objectForKey:@"topic_ID"]];
            }
            NSLog(@"alredyBtn:%@", _alredyBtnArray);
            //[_tableView reloadData];
        }else {
            
        }
    }];
}

-(void)requestInsertUserTopicIDData:(int)topicID Completion:(LoadInsertUserTopicIDDataCompletion)comp
{
    //[SVProgressHUD showWithStatus:@"Loading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *httpDataUrl = [NSURL URLWithString:INSERT_USER_TOPIC_ID];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpDataUrl];
        [request setHTTPMethod:@"POST"];
        NSString *body = [NSString stringWithFormat:@"user_ID=%@&topic_ID=%d", [DYManager sharedManager].userID, topicID];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *resStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSError *e;
        //NSString *str = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        //NSLog(@"str:::::%@", resStr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([resStr isEqualToString:@"OK"]) {
                //[SVProgressHUD dismiss];
                comp(YES);
                
            }else {
                //[SVProgressHUD dismiss];
                comp(NO);
            }
            
        });
        
    });
}

-(void)requestSelectUserTopicIDDataCompletion:(LoadSelectUserTopicIDDataCompletion)comp
{
    //[SVProgressHUD showWithStatus:@"Loading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *httpDataUrl = [NSURL URLWithString:SELECT_USER_TOPIC_ID];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpDataUrl];
        [request setHTTPMethod:@"POST"];
        NSString *body = [NSString stringWithFormat:@"user_ID=%@", [DYManager sharedManager].userID];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        //NSString *resStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *e;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        
        if (e) {
            //NSLog(@"topicNewError");
            //[SVProgressHUD dismiss];
            comp(NO, [NSArray array]);
        }else {
            //NSLog(@"topicNewAarray:%@", array);
            //comp(array);
            //NSMutableArray *resArray = [[NSMutableArray alloc] init];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                comp(YES, array);
                
            });
        }
    });
}



-(void)requestInsertTopicData:(NSString *)title Completion:(LoadInsertTopicDataCompletion)comp
{
    [SVProgressHUD showWithStatus:@"Loading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *httpDataUrl = [NSURL URLWithString:INSERT_TOPIC];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpDataUrl];
        [request setHTTPMethod:@"POST"];
        NSString *body = [NSString stringWithFormat:@"user_ID=%@&title=%@", [DYManager sharedManager].userID, title];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *resStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSError *e;
        //NSString *str = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        //NSLog(@"str:::::%@", resStr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([resStr isEqualToString:@"OK"]) {
                [SVProgressHUD dismiss];
                comp(YES);
                
            }else {
                [SVProgressHUD dismiss];
                comp(NO);
            }
            
        });
        
    });
}

-(void)requestTopicNewDataCompletion:(LoadTopicDataCompletion)comp
{
    [SVProgressHUD showWithStatus:@"Loading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *httpDataUrl = [NSURL URLWithString:TOPIC_NEW_URL];
        NSURLRequest *request = [NSURLRequest requestWithURL:httpDataUrl];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *e;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        if (e) {
            NSLog(@"topicNewError");
            [SVProgressHUD dismiss];
            comp(NO, [NSArray array]);
        }else {
            //NSLog(@"topicNewAarray:%@", array);
            //comp(array);
            NSMutableArray *resArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in array) {
                DYTopicModel *model = [[DYTopicModel alloc] init];
                model.titleStr = [dic objectForKey:@"title"];
                model.nameStr = [dic objectForKey:@"name"];
                model.point = [[dic objectForKey:@"point"] intValue];
                //model.iconImgStr = [dic objectForKey:@"iconURL"];
                model.iconImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"iconURL"]]]];
                model.topicIDStr = [dic objectForKey:@"topic_ID"];
                
                [resArray addObject:model];
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                comp(YES, resArray);
                //[SVProgressHUD dismiss];
                //[_tweetArray addObjectsFromArray:rtnArray];
                [SVProgressHUD dismiss];
            });
        }
    });
}

-(void)requestTopicRankDataCompletion:(LoadTopicRankDataCompletion)comp
{
    [SVProgressHUD showWithStatus:@"Loading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *httpDataUrl = [NSURL URLWithString:TOPIC_RANK_URL];
        NSURLRequest *request = [NSURLRequest requestWithURL:httpDataUrl];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *e;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        if (e) {
            NSLog(@"topicRankError");
            [SVProgressHUD dismiss];
            comp(NO, [NSArray array]);
        }else {
            //NSLog(@"TopicRankArray:%@", array);
            //comp(array);
            NSMutableArray *resArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in array) {
                DYTopicModel *model = [[DYTopicModel alloc] init];
                model.titleStr = [dic objectForKey:@"title"];
                model.nameStr = [dic objectForKey:@"name"];
                model.point = [[dic objectForKey:@"point"] intValue];
                //model.iconImgStr = [dic objectForKey:@"iconURL"];
                model.iconImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"iconURL"]]]];
                model.topicIDStr = [dic objectForKey:@"topic_ID"];
                
                [resArray addObject:model];
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                comp(YES, resArray);
                //[SVProgressHUD dismiss];
                //[_tweetArray addObjectsFromArray:rtnArray];
                
            });
        }
    });
}

-(void)requestTopicLogDataCompletion:(LoadTopicRankDataCompletion)comp
{
    //[SVProgressHUD showWithStatus:@"Loading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *httpDataUrl = [NSURL URLWithString:SELECT_LOG_RANK_URL];
        NSURLRequest *request = [NSURLRequest requestWithURL:httpDataUrl];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *e;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        if (e) {
            NSLog(@"logError");
            //[SVProgressHUD dismiss];
            comp(NO, [NSArray array]);
        }else {
            //NSLog(@"TopicRankArray:%@", array);
            //comp(array);
            NSMutableArray *resArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in array) {
                DYTopicModel *model = [[DYTopicModel alloc] init];
                model.titleStr = [dic objectForKey:@"title"];
                model.nameStr = [dic objectForKey:@"name"];
                model.point = [[dic objectForKey:@"point"] intValue];
                //model.iconImgStr = [dic objectForKey:@"iconURL"];
                model.iconImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"iconURL"]]]];
                model.topicIDStr = [dic objectForKey:@"topic_ID"];
                
                [resArray addObject:model];
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[SVProgressHUD dismiss];
                comp(YES, resArray);
                //[SVProgressHUD dismiss];
                //[_tweetArray addObjectsFromArray:rtnArray];
                
            });
        }
    });
}

-(void)requestTopicLogNewDataCompletion:(LoadTopicRankDataCompletion)comp
{
    //[SVProgressHUD showWithStatus:@"Loading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *httpDataUrl = [NSURL URLWithString:SELECT_LOG_NEW_URL];
        NSURLRequest *request = [NSURLRequest requestWithURL:httpDataUrl];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *e;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        if (e) {
            NSLog(@"logError");
            //[SVProgressHUD dismiss];
            comp(NO, [NSArray array]);
        }else {
            //NSLog(@"TopicRankArray:%@", array);
            //comp(array);
            NSMutableArray *resArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in array) {
                DYTopicModel *model = [[DYTopicModel alloc] init];
                model.titleStr = [dic objectForKey:@"title"];
                model.nameStr = [dic objectForKey:@"name"];
                model.point = [[dic objectForKey:@"point"] intValue];
                //model.iconImgStr = [dic objectForKey:@"iconURL"];
                model.iconImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"iconURL"]]]];
                model.topicIDStr = [dic objectForKey:@"topic_ID"];
                
                [resArray addObject:model];
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[SVProgressHUD dismiss];
                comp(YES, resArray);
                //[SVProgressHUD dismiss];
                //[_tweetArray addObjectsFromArray:rtnArray];
                
            });
        }
    });
}

-(void)requestLogPushDataTopic_ID:(int)topic_ID Completion:(LoadTopicRankDataCompletion)comp
{
    //[SVProgressHUD showWithStatus:@"Loading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *httpDataUrl = [NSURL URLWithString:SELECT_LOG_PUSH];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpDataUrl];
        [request setHTTPMethod:@"POST"];
        NSString *body = [NSString stringWithFormat:@"topic_ID=%d", topic_ID];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *e;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        if (e) {
            NSLog(@"logPushError");
            //[SVProgressHUD dismiss];
            comp(NO, [NSArray array]);
        }else {
            //NSLog(@"TopicRankArray:%@", array);
            //comp(array);
            NSMutableArray *resArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in array) {
                DYModel *model = [[DYModel alloc] init];
                //model.titleStr = [dic objectForKey:@"title"];
                model.nameStr = [dic objectForKey:@"name"];
                //model.point = [[dic objectForKey:@"point"] intValue];
                //model.iconImgStr = [dic objectForKey:@"iconURL"];
                model.iconImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"iconURL"]]]];
                model.contentStr = [dic objectForKey:@"message"];
                //model.topicIDStr = [dic objectForKey:@"topic_ID"];
                
                [resArray addObject:model];
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[SVProgressHUD dismiss];
                comp(YES, resArray);
                //[SVProgressHUD dismiss];
                //[_tweetArray addObjectsFromArray:rtnArray];
                
            });
        }
    });
}

-(void)updateTopicPointTopic_ID:(int)topic_ID completion:(LoadUpdateTopicDataCompletion)comp
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *httpDataUrl = [NSURL URLWithString:UPDATE_TOPIC_POINT];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpDataUrl];
        [request setHTTPMethod:@"POST"];
        NSString *body = [NSString stringWithFormat:@"topic_ID=%d", topic_ID];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *resStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSError *e;
        //NSString *str = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
        //NSLog(@"str:::::%@", resStr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([resStr isEqualToString:@"OK"]) {
                //[SVProgressHUD dismiss];
                comp(YES);
                
            }else {
                //[SVProgressHUD dismiss];
                comp(NO);
            }
            
        });
        
    });

}

-(void)login:(LoadTwitterLoginDataCompletion)comp
{
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [store requestAccessToAccountsWithType:twitterAccountType options:nil completion:^(BOOL granted, NSError *error) {
            if (!granted) {
                //ユーザーがアプリへのアクセスを拒否
                
                
            }else {
                NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
                
                
                if (twitterAccounts.count > 0) {
                    
                    //NSLog(@"twitterNum::%d", twitterAccounts.count);
                    //NSLog(@"twitterAcconts::%@", twitterAccounts);
                    
                    ACAccount *account = [twitterAccounts objectAtIndex:0];
                    NSString *userName = account.username;
                    //NSLog(@"%@", userName);
                    
                    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"];
                    
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    [params setObject:userName forKey:@"screen_name"];
                    
                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                            requestMethod:SLRequestMethodGET
                                                                      URL:url
                                                               parameters:params];
                    [request setAccount:account];
                    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        if (error) {
                            
                        }else {
                            NSError *e;
                            NSDictionary *profileDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&e];
                            if (e) {
                                
                            }else {
                                //NSLog(@"%@", profileDic);
                                
                                NSString *nameStr = [profileDic objectForKey:@"name"];
                                NSString *user_IDStr = [profileDic objectForKey:@"screen_name"];
                                NSString *profileImgStr = [profileDic objectForKey:@"profile_image_url"];
                                NSLog(@"name:%@", nameStr);
                                NSLog(@"user_ID:%@", user_IDStr);
                                NSLog(@"imgStr:%@", profileImgStr);
                                //NSURL *iconURL = [NSURL URLWithString:profileImgStr];
                                //NSData *iconData = [NSData dataWithContentsOfURL:iconURL];
                                //UIImage *iconImg = [UIImage imageWithData:iconData];
                                
                                NSURL *httpDataUrl = [NSURL URLWithString:TWITTER_LOGIN_URL];
                                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpDataUrl];
                                [request setHTTPMethod:@"POST"];
                                NSString *body = [NSString stringWithFormat:@"user_ID=%@&name=%@&iconURL=%@", user_IDStr, nameStr, profileImgStr];
                                [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
                                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                                NSString *resStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    //_iconImgView.image = iconImg;
                                    
                                    if ([resStr isEqualToString:@"OK"]) {
                                        _userID = [NSString stringWithString:user_IDStr];
                                        
                                        
                                        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                                        [ud setObject:_userID forKey:@"user_ID"];
                                        [ud setObject:profileImgStr forKey:@"iconImgStr"];
                                        [ud setObject:nameStr forKey:@"name"];
                                        [ud synchronize];
                                        
                                        comp(YES);
                                    }else {
                                        comp(NO);
                                    }
                                    
                                    
                                    
                                });
                                
                                                                
                                
                            }
                        }
                    }];
                }
            }
        }];
        
    });
}

@end
