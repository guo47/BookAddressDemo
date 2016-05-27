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

+ (NSArray *)arrayOfContacts{
    
    // 生成一个addressbook实例
    ABAddressBookRef addressBook;
    
    if (SYSTEM_VERSION >= 6.0)
    {
        addressBook =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        // 获取通讯录权限
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        addressBook = ABAddressBookCreate();
    }
    
    // 获得所有联系人
    NSArray *allPeople = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFRelease(addressBook);
    return allPeople;
}

// 获得通讯录中联系人的数量
+ (NSUInteger)countsOfContacts
{
    NSArray *arrayOfPeople = [ABClass arrayOfContacts];
    if (nil != arrayOfPeople) {
        return arrayOfPeople.count;
    }
    return 0;
}

// 根据索引ID获得当前用户的对象
+ (ABRecordRef)getCurrentPerson:(NSUInteger)identifier{
    
    NSArray *arrayContacts = [ABClass arrayOfContacts];
    ABRecordRef currentPerson = (__bridge ABRecordRef)[arrayContacts objectAtIndex:identifier];
    
    return currentPerson;
}

// 获取firstname
+ (NSString *)fetchFirstNameForPersonID:(NSUInteger)identifier{
    
    ABRecordRef currentPerson = [ABClass getCurrentPerson:identifier];
    
    NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(currentPerson, kABPersonFirstNameProperty);
    if (nil == firstName) {
        firstName = @"";
    }
    return firstName;
}

// 获取middlename
+ (NSString *)fetchMidNameForPersonID:(NSUInteger)identifier{
    
    ABRecordRef currentPerson = [ABClass getCurrentPerson:identifier];
    
    NSString *midName = (__bridge_transfer NSString *)ABRecordCopyValue(currentPerson, kABPersonMiddleNameProperty);
    if (nil == midName) {
        midName = @"";
    }
    return midName;
}

// 获取lastname
+ (NSString *)fetchLastNameForPersonID:(NSUInteger)identifier{
    
    ABRecordRef currentPerson = [ABClass getCurrentPerson:identifier];
    
    NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(currentPerson, kABPersonLastNameProperty);
    if (nil == lastName) {
        lastName = @"";
    }
    return lastName;
}

// 获取工作单位
+ (NSString *)fetchJobTitleForPersonID:(NSUInteger)identifier{
    
    ABRecordRef currentPerson = [ABClass getCurrentPerson:identifier];
    
    NSString *jobTitle = (__bridge_transfer NSString *)ABRecordCopyValue(currentPerson, kABPersonJobTitleProperty);
    if (nil == jobTitle) {
        jobTitle = @"";
    }
    return jobTitle;
}

// 获取电话号码
+ (NSString *)fetchTelNumForPersonId:(NSUInteger)identifier{
    
    NSString * personPhone;
    
    ABRecordRef currentPerson = [ABClass getCurrentPerson:identifier];
    
    ABMultiValueRef phone = ABRecordCopyValue(currentPerson, kABPersonPhoneProperty);
    NSUInteger phoneCounts = ABMultiValueGetCount(phone);
    for (NSUInteger i = 0; i < phoneCounts; ++i)
    {
        // 获取电话Label(住宅、公司 可编辑的标签)
        NSString * personPhoneLabel = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, i));
        // 获取該Label下的电话值
        personPhone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phone, i);
        
        if (nil != personPhone)break;
    }
    
    return personPhone;
}

// 获取邮箱
+ (NSString *)fetchEmailForPersonId:(NSUInteger)identifier{
    
    NSString * personEmail;
    
    ABRecordRef currentPerson = [ABClass getCurrentPerson:identifier];
    
    //获取email多值
    ABMultiValueRef emailsArray = ABRecordCopyValue(currentPerson, kABPersonEmailProperty);
    int emailcount = ABMultiValueGetCount(emailsArray);
    for (int x = 0; x < emailcount; x++)
    {
        //获取email Label
        NSString* emailLabel = (__bridge_transfer NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(emailsArray, x));
        //获取email值
        personEmail = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emailsArray, x);
        
        if (nil != personEmail)break;
    }
    
    return personEmail;
}


// 获取头像
+ (NSData *)fetchHeadImageForPersonId:(NSUInteger)identifier{
    
    ABRecordRef currentPerson = [ABClass getCurrentPerson:identifier];
    
    NSData *imageData = (__bridge_transfer NSData *)ABPersonCopyImageData(currentPerson);
    
    return imageData;
}




#pragma mark 需要获得相应数据，可以参考注释部分的代码



@end


