//
//  ContactModel.h
//  BookAddressDemo
//
//  Created by 郭世清 on 16/5/24.
//  Copyright © 2016年 郭世清. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
{
    NSInteger sectionNumber;
    NSInteger recordID;
    NSString *name;
    NSString *pinyinName;    // 名字全拼
    NSString *tel;
    NSData *headData;
}

@property NSInteger sectionNumber;
@property NSInteger recordID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *pinyinName;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSData *headData;

@end
