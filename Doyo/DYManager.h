//
//  DYManager.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoadTopicDataCompletion)(BOOL success, NSArray *array);
typedef void (^LoadTopicRankDataCompletion)(BOOL success, NSArray *array);
typedef void (^LoadTwitterLoginDataCompletion)(BOOL flag);
typedef void (^LoadInsertTopicDataCompletion)(BOOL flag);
typedef void (^LoadUpdateTopicDataCompletion)(BOOL flag);
typedef void (^LoadInsertUserTopicIDDataCompletion)(BOOL flag);
typedef void (^LoadSelectUserTopicIDDataCompletion)(BOOL success, NSArray *array);

@interface DYManager : NSObject

@property (nonatomic, retain) NSString *userID;
@property BOOL isPostFlag;

+(DYManager *)sharedManager;
-(void)requestTopicNewDataCompletion:(LoadTopicDataCompletion)comp;
-(void)requestTopicRankDataCompletion:(LoadTopicRankDataCompletion)comp;
-(void)login:(LoadTwitterLoginDataCompletion)comp;
-(void)requestInsertTopicData:(NSString *)title Completion:(LoadInsertTopicDataCompletion)comp;

-(void)updateTopicPointTopic_ID:(int)topic_ID completion:(LoadUpdateTopicDataCompletion)comp;
-(void)requestInsertUserTopicIDData:(int)topicID Completion:(LoadInsertUserTopicIDDataCompletion)comp;
-(void)requestSelectUserTopicIDDataCompletion:(LoadSelectUserTopicIDDataCompletion)comp;

@end
