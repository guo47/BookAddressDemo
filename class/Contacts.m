//
//  Contacts.m
//  BookAddressDemo
//
//  Created by 郭世清 on 16/5/24.
//  Copyright © 2016年 郭世清. All rights reserved.
//

#import "Contacts.h"

#pragma mark contacts的头文件
#import <Contacts/Contacts.h>
//#import <ContactsUI/ContactsUI.h>
#import "ContactModel.h"


// 通讯录变化的通知
//CNContactStoreDidChangeNotification

@interface Contacts ()
{
    NSMutableArray *_maData;
    
    CNContactStore *_contactStore;
}

@end

@implementation Contacts


- (NSMutableArray *)arrayOfContacts{
    
    // 创建通讯录
    _contactStore = [[CNContactStore alloc] init];
    
    // 请求授权: 阻塞方式
//    if (CNAuthorizationStatusAuthorized != [CNContactStore authorizationStatusForEntityType]) {
//        
//    }
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [_contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) {
            NSLog(@"授权成功!");
        } else {
            NSLog(@"授权失败!");
        }
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    // 封装需要获得的字段KEY
    NSArray *keys = @[CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactEmailAddressesKey];
    
    // 创建请求
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    // 枚举所有对象
    _maData = [[NSMutableArray alloc] init];
    [_contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        // 拼接名字
        ContactModel *model = [[ContactModel alloc] init];
        model.name = contact.familyName;
        model.name = [model.name stringByAppendingString:contact.middleName];
        model.name = [model.name stringByAppendingString:contact.givenName];
        
        // 拼接电话号码
        NSString *allPhoneNum = @"";
        NSString *phoneNum = @"";
        for (CNLabeledValue<CNPhoneNumber *>* pN in contact.phoneNumbers) {
            phoneNum = pN.value.stringValue;
            if (0 != phoneNum.length) {
                allPhoneNum = [allPhoneNum stringByAppendingString:phoneNum];
                allPhoneNum = [allPhoneNum stringByAppendingString:@","];
            }
        }
        model.tel = allPhoneNum;
        if (0 != allPhoneNum.length && [[allPhoneNum substringFromIndex:allPhoneNum.length-1] isEqualToString:@","]) {
            model.tel = [allPhoneNum substringToIndex:allPhoneNum.length-1];
        }

        model.headData = contact.imageData;
        
        [_maData addObject:model];
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    return _maData;
}

// 释放通讯录对象
- (void)releaseAddressBook
{
    if (nil != _contactStore) {
        _contactStore = nil;
    }
}



@end
