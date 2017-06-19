//
//  APIDealAddressManager.m
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "APIDealAddressManager.h"

@implementation APIDealAddressManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.paramSource = self;
        self.validator = self;
    }
    return self;
}

#pragma mark - APIManagerVaildator
/*
 所有的callback数据都应该在这个函数里面进行检查，事实上，到了回调delegate的函数里面是不需要再额外验证返回数据是否为空的。
 因为判断逻辑都在这里做掉了。
 而且本来判断返回数据是否正确的逻辑就应该交给manager去做，不要放到回调到controller的delegate方法里面去做。
 */
- (BOOL)manager:(APIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return [data[@"rspCode"] integerValue] == 0;
}

/*
 当调用API的参数是来自用户输入的时候，验证是很必要的。
 当调用API的参数不是来自用户输入的时候，这个方法可以写成直接返回true。反正哪天要真是参数错误，QA那一关肯定过不掉。
 不过我还是建议认真写完这个参数验证，这样能够省去将来代码维护者很多的时间。
 */

- (BOOL)manager:(APIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

#pragma mark - APIManagerParamSourceDelegate
//让manager能够获取调用API所需要的数据
- (NSDictionary *)paramsForApi:(APIBaseManager *)manager
{
    return @{@"address" :self.address?:@"",
             @"receivingId" :self.receiveId?:@"",
             @"consignee" :self.receiveName,
             @"contacts" :self.phone,
             @"province" :self.provinceId,
             @"city" :self.cityId,
             @"district" :self.districtId,
             @"isDefault" :NumberToString(self.isDefault),
             @"operation_type" :NumberToString(self.status)
             };
}

#pragma mark - APIManager Methods
- (NSString *)methodName
{
    return @"receivingSaveOrUpdate";
}

- (NSString *)serviceType
{
    return kAPIServiceWanJiKa;
}

- (APIManagerRequestType)requestType
{
    return APIManagerRequestTypePost;
}
@end
