//
//  ABClass.h
//  BookAddressDemo
//
//  Created by 郭世清 on 16/5/24.
//  Copyright © 2016年 郭世清. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark addressbook的头文件
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h> //没用到UI，不包含还是会报错

#import "ContactModel.h"

@interface ABClass : NSObject

// 创建一个通讯录对象
- (id)initWithBlock:(void (^)())complate;

// 获取通讯录中所有的信息
- (NSMutableArray *)arrayOfContacts;

// 往通讯录中添加一条信息
- (BOOL)addRecordWithModel:(ContactModel *)record;

// 释放通讯录
- (void)releaseAddressBook;

@end
