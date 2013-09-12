//
//  DYModel.h
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYModel : NSObject

@property (nonatomic, retain) UIImage *iconImg;
@property (nonatomic, retain) NSString *nameStr;
@property (nonatomic, retain) NSString *contentStr;
@property (nonatomic, retain) NSString *userID;


-(id)initWithDictionary:(NSDictionary *)d;

@end
