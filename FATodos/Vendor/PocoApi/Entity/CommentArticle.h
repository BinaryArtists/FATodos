//
//  CommentArticle.h
//  FATodos
//
//  Created by qingqing on 16/1/27.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "MTLModel.h"

@class CommentSkill;
@class CommentFlow; // 评论流

@interface CommentArticle : MTLModel

@property (nonatomic, copy) NSString * article_id;
@property (nonatomic, copy) NSString * art_id;
@property (nonatomic, copy) NSString * img_item_id;
@property (nonatomic, copy) NSString * img_url;         // 作品url
@property (nonatomic, copy) NSString * img_title;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * dianping_count;  // 评论数量
@property (nonatomic, copy) NSString * theme_type_id;   // ???
@property (nonatomic, strong) NSMutableArray *skill_type_id; // 技能方向类型
@property (nonatomic, copy) NSString * add_time;
@property (nonatomic, copy) NSString * is_choice;
@property (nonatomic, copy) NSString * not_readed_count;
@property (nonatomic, copy) NSString * last_update_time;
@property (nonatomic, strong) NSMutableArray<CommentSkill *> *skill_type_arr;
@property (nonatomic, copy) NSString * user_name;       // 用户姓名
@property (nonatomic, copy) NSString * cut_user_name;
@property (nonatomic, copy) NSString * img_url_145; // 小图
@property (nonatomic, copy) NSString * img_url_165;
@property (nonatomic, copy) NSString * dianping_log_list_total_count; // 评论数目
@property (nonatomic, copy) NSString * time_section;     // 时间段
@property (nonatomic, copy) NSMutableArray<CommentFlow *> *dianping_log_list; // 评论内容

@end
