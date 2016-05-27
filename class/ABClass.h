//
//  ABClass.h
//  BookAddressDemo
//
//  Created by 郭世清 on 16/5/24.
//  Copyright © 2016年 郭世清. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABClass : NSObject


// 获取通讯录中所有的信息
- (NSMutableArray *)arrayOfContacts;

// 释放通讯录
- (void)releaseAddressBook;

@end
