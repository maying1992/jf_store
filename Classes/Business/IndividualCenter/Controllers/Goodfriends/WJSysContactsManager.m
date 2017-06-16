//
//  WJSysContactsManager.m
//  jf_store
//
//  Created by reborn on 2017/5/23.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSysContactsManager.h"
// iOS 9.0 以下
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

// iOS 9.0 及以上
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

#import <MessageUI/MessageUI.h>

#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController


@implementation WJContactModel


- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber
{
    self = [super init];
    if (self) {
        self.name = name;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

@end

@interface WJSysContactsManager ()<UINavigationControllerDelegate, ABPeoplePickerNavigationControllerDelegate, CNContactPickerDelegate, MFMessageComposeViewControllerDelegate>
@property (nonatomic, copy) WJContactsBlock contactBlock;
@property (nonatomic, copy) WJMessageBlock messageBlock;
@end

@implementation WJSysContactsManager

#pragma mark - 调用系统通讯录 选择并获取联系人信息
- (void)callContactsHandler:(WJContactsBlock)handler {
    
    self.contactBlock = handler;
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [kRootViewController presentViewController:peoplePicker animated:YES completion:nil];
        
    }else{  // iOS 9.0 以后，使用新的系统通讯录框架
        
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        //    [CNContactStore authorizationStatusForEntityType:(CNEntityTypeContacts)];
        
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
                picker.delegate = self;
                [kRootViewController presentViewController:picker animated:YES completion:^{}];
            }
            
        }];
        
    }
}

#pragma mark - ABPeoplePickerNavigationController delegate
// 在联系人详情页可直接发信息/打电话
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (!firstName) {
        firstName = @""; //!!!: 注意这里firstName/lastName是 给@"" 还是 @" ", 如果姓名要求无空格, 则必须为@""
    }
    
    NSString *lastName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (!lastName) {
        lastName = @"";
    }
    
    NSString *personName = [NSString stringWithFormat:@"%@%@", lastName,firstName];
    NSString *phoneNumber = (__bridge NSString*)value;
    phoneNumber =  [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""]; // 不然是3-4-4
    
    
    WJContactModel *model = [[WJContactModel alloc] initWithName:personName phoneNumber:phoneNumber];
    if (self.contactBlock) {
        self.contactBlock(model);
    }
    
    [kRootViewController dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - CNContactPickerViewController delegate
// 通讯录列表 - 点击某个联系人 - 详情页 - 点击一个号码, 返回
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    
    NSString *personName = [NSString stringWithFormat:@"%@%@", contactProperty.contact.familyName, contactProperty.contact.givenName];
    NSString *phoneNumber = [contactProperty.value stringValue];
    phoneNumber =  [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    WJContactModel *model = [[WJContactModel alloc] initWithName:personName phoneNumber:phoneNumber];
    if (self.contactBlock) {
        self.contactBlock(model);
    }
    
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    
}

#pragma mark - 群发/单发 指定信息 #####
- (void)sendContacts:(NSArray<NSString *> *)phoneNumbers message:(NSString *)message completion:(WJMessageBlock)completion{
    
    self.messageBlock = completion;
    
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if(messageClass != nil){
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
        messageVC.messageComposeDelegate = self;
        messageVC.body = message;
        messageVC.recipients = phoneNumbers;
        
        [kRootViewController presentViewController:messageVC animated:NO completion:nil];
    }else {
        //        Have error here ...
    }
    
}

/** 发送信息后的回调  **/
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [kRootViewController dismissViewControllerAnimated:NO completion:^{}];
    
    if (self.messageBlock) {
        NSInteger num = result;
        self.messageBlock(num);
    }
    
    //    switch (result) {
    //        case MessageComposeResultCancelled:
    //
    //            break;
    //        case MessageComposeResultSent:
    //
    //            break;
    //        case MessageComposeResultFailed:
    //
    //            break;
    //
    //        default:
    //            break;
    //    }
}
@end
