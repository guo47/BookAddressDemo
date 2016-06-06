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

// 通讯录变化的通知
//CNContactStoreDidChangeNotification

@interface Contacts ()
{
    NSMutableArray *_maData;
    
    CNContactStore *_contactStore;
}

@end

@implementation Contacts

- (id)initWithBlock:(void (^)())complate
{
    if (self = [super init]) {
        [self makeAddressBookWithBlock:complate];
    }
    return self;
}

- (BOOL)makeAddressBookWithBlock:(void (^)())complate
{
    // 创建通讯录
    _contactStore = [[CNContactStore alloc] init];
    
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    // 2.判断授权状态,如果不是已经授权,则直接返回
    if (status != CNAuthorizationStatusAuthorized)
    {
        return YES;
    }
    else
    {
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
    }
        

    if (CNAuthorizationStatusAuthorized != [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) {
        complate();
        return NO;
    }

    return YES;
}


- (NSMutableArray *)arrayOfContacts{

    // 封装需要获得的字段KEY
    NSArray *keys = @[CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactEmailAddressesKey];
    
    // 创建请求
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    // 枚举所有对象
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
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

// 往通讯录中添加一条信息
- (BOOL)addRecordWithModel:(ContactModel *)record
{
    // 判断电话号码是否存在，存在直接返回
    NSMutableArray *maRecord = [self arrayOfContacts];
    
//    // 根据电话号码判断是否继续添加用户
//    for (ContactModel *model in maRecord) {
//        // 电话号码是多个号码拼接的结果，所以用串找串的方式
//        NSRange range = [model.tel rangeOfString:record.tel];
//        if (NSNotFound != range.location) {
//            return YES;
//        }
//    }
    
    // 新建一条通讯录记录
    CNMutableContact * contact = [[CNMutableContact alloc]init];
    
    //////////////////////////// 添加实际内容 ////////////////////////////
    // 名字和公司名称
    //设置姓氏
    contact.familyName = record.name;
    contact.organizationName = @"来自爱办公";
    
    // 电话号码，暂时不区分有没有逗号
    contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:record.tel]]];
    
    // 头像
    contact.imageData = record.headData;
    ////////////////////////////         ////////////////////////////
    
    // 写入通讯录
    //初始化方法
    CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
    //添加联系人
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    [_contactStore executeSaveRequest:saveRequest error:nil];
    
    return YES;
}




// 释放通讯录对象
- (void)releaseAddressBook
{
    if (nil != _contactStore) {
        _contactStore = nil;
    }
}



@end
