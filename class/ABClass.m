//
//  ABClass.m
//  BookAddressDemo
//
//  Created by 郭世清 on 16/5/24.
//  Copyright © 2016年 郭世清. All rights reserved.
//

#import "ABClass.h"


#pragma mark addressbook的头文件
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h> //没用到UI，不包含还是会报错

#import "ContactModel.h"


//已有的宏，详见Common.h
#define SYSTEM_VERSION       ([[[UIDevice currentDevice] systemVersion] floatValue])


@interface ABClass()
{
    NSArray *_arrayContacts;
    
    ABAddressBookRef _addressBook;
}

@end


@implementation ABClass



/*
//读取prefix前缀
NSString *prefix = (NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
//读取suffix后缀
NSString *suffix = (NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
//读取nickname呢称
NSString *nickname = (NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
//读取firstname拼音音标
NSString *firstnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
//读取lastname拼音音标
NSString *lastnamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
//读取middlename拼音音标
NSString *middlenamePhonetic = (NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
//读取organization公司
NSString *organization = (NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
//读取jobtitle工作
NSString *jobtitle = (NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
//读取department部门
NSString *department = (NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
//读取birthday生日
NSDate *birthday = (NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
//读取note备忘录
NSString *note = (NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
//第一次添加该条记录的时间
NSString *firstknow = (NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
//最后一次修改該条记录的时间
NSString *lastknow = (NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
//获取email多值
ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
int emailcount = ABMultiValueGetCount(email);
for (int x = 0; x < emailcount; x++)
{
    //获取email Label
    NSString* emailLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
    //获取email值
    NSString* emailContent = (NSString*)ABMultiValueCopyValueAtIndex(email, x);
}
//读取地址多值
ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
int count = ABMultiValueGetCount(address);
for(int j = 0; j < count; j++)
{
    //获取地址Label
    NSString* addressLabel = (NSString*)ABMultiValueCopyLabelAtIndex(address, j);
    //获取該label下的地址6属性
    NSDictionary* personaddress =(NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
    //国家
    NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
    //城市
    NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
    //省
    NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
    //街道
    NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
    //邮编
    NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
    //国家编号
    NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
}

//获取dates多值
ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
int datescount = ABMultiValueGetCount(dates);
for (int y = 0; y < datescount; y++)
{
    //获取dates Label
    NSString* datesLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
    //获取dates值
    NSString* datesContent = (NSString*)ABMultiValueCopyValueAtIndex(dates, y);
}
//获取kind值
CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
if (recordType == kABPersonKindOrganization) {
    // it's a company
    NSLog(@"it's a company\n");
} else {
    // it's a person, resource, or room
    NSLog(@"it's a person, resource, or room\n");
}

//获取IM多值
ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
{
    //获取IM Label
    NSString* instantMessageLabel = (NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
    //获取該label下的2属性
    NSDictionary* instantMessageContent =(NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
    NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
    NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
}

//读取电话多值
ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);  
for (int k = 0; k<ABMultiValueGetCount(phone); k++)  
{  
    //获取电话Label
    NSString * personPhoneLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));  
    //获取該Label下的电话值  
    NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
}

//获取URL多值
ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);  
for (int m = 0; m < ABMultiValueGetCount(url); m++)  
{  
    //获取电话Label
    NSString * urlLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));  
    //获取該Label下的电话值  
    NSString * urlContent = (NSString*)ABMultiValueCopyValueAtIndex(url,m);
}

//读取照片
NSData *image = (NSData*)ABPersonCopyImageData(person);
UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];  
[myImage setImage:[UIImage imageWithData:image]];  
myImage.opaque = YES;
*/

// 获取通讯录中的所有数据
- (NSMutableArray *)arrayOfContacts
{
    // 数据缓存
    NSMutableArray *maContact = [[NSMutableArray alloc] init];
    
    //遍历通讯录
    _arrayContacts = [self importArrayOfContacts];
    NSUInteger countsContact = _arrayContacts.count;
    for (NSUInteger i = 0; i < countsContact; ++i) {
        
        ABRecordRef currentPerson = CFBridgingRetain([_arrayContacts objectAtIndex:i]);
        //获取名字
        NSString *fullName = [self fetchFullNameForPerson:currentPerson];
        //如果名字为空，本条记录丢弃不用
        if (0 == fullName.length) {
            CFRelease(currentPerson);
            continue;
        }
        
        //获取电话号码列表(以逗号分割)，如果电话号码为空，本条记录丢弃不用
        NSString *telNum = [self fetchTelNumForPerson:currentPerson];
        if (nil == telNum || 0 == telNum.length) {
            CFRelease(currentPerson);
            continue;
        }
        
        //获取头像
        NSData *headData = [self fetchHeadImageForPerson:currentPerson];
        if (nil == headData) {
            //头像为非必须参数，do nonting
            NSLog(@"用户%@没有头像", fullName);
        }
        
        //申明通讯录对象
        ContactModel *model = [[ContactModel alloc] init];
        model.name = fullName;
        model.tel = telNum;
        model.headData = headData;
        [maContact addObject:model];
        CFRelease(currentPerson);
    }
    return maContact;
}


- (NSArray *)importArrayOfContacts{
    
    // 先获取授权
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        
        // 获取通讯录权限
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    // 定义一个addressbook实例
    if (SYSTEM_VERSION >= 6.0)
    {
        _addressBook =  ABAddressBookCreateWithOptions(NULL, NULL);
    }
    else
    {
        _addressBook = ABAddressBookCreate();
    }

    // 获得所有联系人
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(_addressBook));
#warning 此处不能release，否则通讯录就被释放了
    //    CFRelease(addressBook);
    return allPeople;
}

// 获取全名
- (NSString *)fetchFullNameForPerson:(ABRecordRef)person{
    
    // 名字
    NSString *lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    
    // 中间的名字
    NSString *midName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
    
    // 姓
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    
    NSString *fullName = (firstName!=nil)?firstName:@"";
    fullName = (midName!=nil)?[fullName stringByAppendingString:midName]:fullName;
    fullName = (lastName!=nil)?[fullName stringByAppendingString:lastName]:fullName;

    return fullName;
}

// 获取全名的拼音
- (NSString *)fetchPinyinFullNameForPerson:(ABRecordRef)person
{
    NSString *lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty));
    
    NSString *midName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty));
    
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty));
    
    
    NSString *fullName = (firstName!=nil)?firstName:@"";
    fullName = (midName!=nil)?[fullName stringByAppendingString:midName]:fullName;
    fullName = (lastName!=nil)?[fullName stringByAppendingString:lastName]:fullName;
    
    return fullName;
}


// 获取电话号码
- (NSString *)fetchTelNumForPerson:(ABRecordRef)person{

    NSString * personPhone = @"";

    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSUInteger phoneCounts = ABMultiValueGetCount(phone);

    // 拼接电话号码
    NSString *allPhoneNum = @"";
    NSString *phoneNum = @"";
    for (NSUInteger i = 0; i < phoneCounts; ++i) {
        // 获取該Label下的电话值
        phoneNum = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phone, i);;
        if (0 != phoneNum.length) {
            allPhoneNum = [allPhoneNum stringByAppendingString:phoneNum];
            allPhoneNum = [allPhoneNum stringByAppendingString:@","];
        }
    }
    personPhone = allPhoneNum;
    if (0 != allPhoneNum.length && [[allPhoneNum substringFromIndex:allPhoneNum.length-1] isEqualToString:@","]) {
        personPhone = [allPhoneNum substringToIndex:allPhoneNum.length-1];
    }

    if(phone != NULL) CFRelease(phone);
    return personPhone;
}

// 获取头像
- (NSData *)fetchHeadImageForPerson:(ABRecordRef)person{

    NSData *imageData = CFBridgingRelease(ABPersonCopyImageData(person));
    
    return imageData;
}



// 释放通讯录对象
- (void)releaseAddressBook
{
    if (nil != _addressBook) {
        CFRelease(_addressBook);
    }
}


#pragma mark 需要获得相应数据，可以参考注释部分的代码



@end


