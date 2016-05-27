//
//  ABClass.h
//  BookAddressDemo
//
//  Created by 郭世清 on 16/5/24.
//  Copyright © 2016年 郭世清. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABClass : NSObject


// 获得通讯录中联系人的数量
+ (NSUInteger)countsOfContacts;


// 获取firstname
+ (NSString *)fetchFirstNameForPersonID:(NSUInteger)identifier;
// 获取middlename
+ (NSString *)fetchMidNameForPersonID:(NSUInteger)identifier;
// 获取lastname
+ (NSString *)fetchLastNameForPersonID:(NSUInteger)identifier;


// 获取工作单位
+ (NSString *)fetchJobTitleForPersonID:(NSUInteger)identifier;

// 获取电话号码
+ (NSString *)fetchTelNumForPersonId:(NSUInteger)identifier;

// 获取邮箱
+ (NSString *)fetchEmailForPersonId:(NSUInteger)identifier;

// 获取头像
+ (NSData *)fetchHeadImageForPersonId:(NSUInteger)identifier;


@end
