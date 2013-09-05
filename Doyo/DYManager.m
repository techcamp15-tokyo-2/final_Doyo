//
//  DYManager.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/05.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYManager.h"

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
        
        
        
    }
    return self;
}



@end
