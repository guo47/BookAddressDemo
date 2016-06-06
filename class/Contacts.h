//
//  Contacts.h
//  BookAddressDemo
//
//  Created by 郭世清 on 16/5/24.
//  Copyright © 2016年 郭世清. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ContactModel.h"

@interface Contacts : NSObject

// 创建一个通讯录对象
- (id)initWithBlock:(void (^)())complate;

// 获取通讯录中所有的信息
- (NSMutableArray *)arrayOfContacts;

// 往通讯录中添加一条信息
- (BOOL)addRecordWithModel:(ContactModel *)record;

// 释放通讯录对象
- (void)releaseAddressBook;


@end
