//
//  ViewController.m
//  BookAddressDemo
//
//  Created by 郭世清 on 16/5/23.
//  Copyright © 2016年 郭世清. All rights reserved.
//

#import "ViewController.h"

//写好的addressbook的类
#import "ABClass.h"
//写好的contacts的类
#import "Contacts.h"
//通讯录模型类
#import "ContactModel.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *_tableView;
    
    NSMutableArray *_maContact;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //根据版本选择不同的framework
    //IOS9以前用AddressBook framework,9.0以后用Contacts framework
    //参考：http://www.cocoachina.com/ios/20160518/16321.html
    
    _maContact = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 显示通讯录的方法

- (IBAction)ABButtonClick:(id)sender {
    
    [self getContactUsingAddressBook];
}


- (IBAction)ContactButtonClick:(id)sender {
    
    [self getContactUsingContact];
}

- (void)getContactUsingAddressBook
{
    if (0 != _maContact.count) {
        [_maContact removeAllObjects];
    }
    
    //遍历通讯录
    id contact = [[ABClass alloc] initWithBlock:^{
        //用户取消授权后，提示用户在“设置-隐私-通讯录”中重新设置APP的通讯录访问权限
        //此处可以弹出alterview
        return;
    }];
    _maContact = [contact arrayOfContacts];
    [contact releaseAddressBook];
    [_tableView reloadData];
}
         
- (void)getContactUsingContact
{
    if (0 != _maContact.count) {
        [_maContact removeAllObjects];
    }
    
    id contact = [[Contacts alloc] initWithBlock:^{
        //用户取消授权后，提示用户在“设置-隐私-通讯录”中重新设置APP的通讯录访问权限
        //此处可以弹出alterview
        return;
    }];
    _maContact = [contact arrayOfContacts];
    [_tableView reloadData];
}


#pragma mark - 添加通讯录的方法
- (IBAction)addRecordWithAB:(id)sender {
    
    //构造一条记录
    ContactModel *tempModel = [[ContactModel alloc] init];
    tempModel.name = @"郭世清";
    tempModel.tel = @"13700272437";
    
    //添加一条记录
    id contact = [[ABClass alloc] initWithBlock:^{
        //用户取消授权后，提示用户在“设置-隐私-通讯录”中重新设置APP的通讯录访问权限
        //此处可以弹出alterview
        return;
    }];
    [contact addRecordWithModel:tempModel];
    [contact releaseAddressBook];
    [_tableView reloadData];
}


- (IBAction)addRecordWithContact:(id)sender {
    
    //构造一条记录
    ContactModel *tempModel = [[ContactModel alloc] init];
    tempModel.name = @"郭世清";
    tempModel.tel = @"12345678901";
    
    //添加一条记录
    id contact = [[Contacts alloc] initWithBlock:^{
        //用户取消授权后，提示用户在“设置-隐私-通讯录”中重新设置APP的通讯录访问权限
        //此处可以弹出alterview
        return;
    }];
    [contact addRecordWithModel:tempModel];
    [_tableView reloadData];
}


#pragma mark - UITableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _maContact.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == _maContact.count) return nil;
    
    // 设置cell的内容
    static NSString *indentifier = @"contactsIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    
    // 获得对象
    ContactModel *model = _maContact[indexPath.row];
    
    // 设置头像
    cell.imageView.image = [UIImage imageWithData:model.headData];
    // 设置名字
    cell.textLabel.text = model.name;
    // 设置电话号码
    cell.detailTextLabel.text = model.tel;
    
    return cell;
}







@end
