//
//  TopicModel.h
//  YJTangguo
//
//  Created by wanyongjian on 2017/7/18.
//  Copyright © 2017年 eco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface TopicModel : NSObject

@property(nonatomic, strong) UserModel *user;
@property(nonatomic, strong) NSString *comments;
@property(nonatomic, strong) NSString *create_time_str;
@property(nonatomic, strong) NSString *dateline;
@property(nonatomic, strong) NSString *datestr;
@property(nonatomic, strong) NSString *hide_new;
@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *is_recommend;
@property(nonatomic, strong) NSString *is_show_like;
@property(nonatomic, strong) NSString *islike;
@property(nonatomic, strong) NSString *items;
@property(nonatomic, strong) NSString *likes;
@property(nonatomic, strong) NSString *pic;
@property(nonatomic, strong) NSString *pics;
@property(nonatomic, strong) NSString *praises;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *trace_id;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *type_id;
@property(nonatomic, strong) NSString *update_time;
@property(nonatomic, strong) NSString *views;

@end
