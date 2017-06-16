//
//  WJWebTableViewCell.m
//  HuPlus
//
//  Created by reborn on 17/3/9.
//  Copyright © 2017年 IHUJIA. All rights reserved.
//

#import "WJWebTableViewCell.h"
@interface WJWebTableViewCell ()<UIWebViewDelegate>
{
    UIWebView   *detailWebView;
    BOOL        isRequest;
}
@end

@implementation WJWebTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        detailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(300))];
        detailWebView.delegate = self;
        detailWebView.scrollView.bounces = NO;
        detailWebView.scrollView.scrollEnabled = NO;
        [detailWebView sizeToFit];
        detailWebView.scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:detailWebView];
        
        [detailWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

- (void)dealloc
{
    [detailWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)configWithURL:(NSString *)urlstr
{
    [detailWebView loadHTMLString:urlstr baseURL:nil];
    if (isRequest == YES) {
        return;
    }
    isRequest = YES;
    NSURL *url = [NSURL URLWithString:urlstr];
    [detailWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    isRequest = NO;
//    
//    //获取页面高度（像素）
//    CGFloat webViewHeight= [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
//    //再次设置WebView高度（点）
//    webView.frame = CGRectMake(0, 0, webView.frame.size.width, webViewHeight);
//    [self reloadByHeight:webViewHeight];
//
//}
//
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    NSLog(@"%@",error);
//
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        isRequest = NO;
        CGFloat webViewHeight= [[detailWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
        //再次设置WebView高度（点）
        detailWebView.frame = CGRectMake(0, 0, detailWebView.frame.size.width, webViewHeight);
        [self reloadByHeight:webViewHeight];
    }
    
}

- (void)reloadByHeight:(CGFloat)height
{
    if ([self.heightDelegate respondsToSelector:@selector(reloadByHeight:)])
    {
        [self.heightDelegate reloadByHeight:height];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
