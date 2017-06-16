//
//  WJLineView.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJKLineView.h"
#import "PNChart.h"

@interface WJKLineView()<PNChartDelegate>
{
    UILabel         * titleLabel;
    UILabel         * tradingVolumeLabel;
    UILabel         * priceLabel;
    UILabel         * integralLabel;
    UIImageView     * integralIV;
    PNLineChart     * lineChart;
    
}

@end


@implementation WJKLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = WJFont16;
        titleLabel.textColor = WJColorDardGray3;
        titleLabel.text = @"百草堂";
        [self addSubview:titleLabel];
        [self addConstraints:[titleLabel constraintsTopInContainer:13]];
        [self addConstraints:[titleLabel constraintsLeftInContainer:15]];
        
        tradingVolumeLabel = [[UILabel alloc]initForAutoLayout];
        tradingVolumeLabel.font = WJFont12;
        tradingVolumeLabel.textColor = WJColorDardGray3;
        tradingVolumeLabel.text = @"成交量：2382432积分";
        [self addSubview:tradingVolumeLabel];
        [self addConstraints:[tradingVolumeLabel constraintsTop:5 FromView:titleLabel]];
        [self addConstraints:[tradingVolumeLabel constraintsLeftInContainer:15]];
        
        priceLabel = [[UILabel alloc]initForAutoLayout];
        priceLabel.font = WJFont12;
        priceLabel.textColor = WJColorDardGray3;
        priceLabel.text = @"单位：1000积分";
        [self addSubview:priceLabel];
        [self addConstraints:[priceLabel constraintsTop:5 FromView:tradingVolumeLabel]];
        [self addConstraints:[priceLabel constraintsLeftInContainer:15]];
        
        
        integralIV = [[UIImageView alloc]initForAutoLayout];
        integralIV.image = [UIImage imageNamed:@"trading-hall_icon_up"];
        [self addSubview:integralIV];
        [self addConstraints:[integralIV constraintsTopInContainer:31]];
        [self addConstraints:[integralIV constraintsRightInContainer:20]];
        
        
        integralLabel = [[UILabel alloc]initForAutoLayout];
        integralLabel.font = WJFont13;
        integralLabel.textColor = WJColorDardGray3;
        integralLabel.text = @"400多功能积分";
        [self addSubview:integralLabel];
        [self addConstraints:[integralLabel constraintsTopInContainer:35]];
        [self addConstraints:[integralLabel constraintsRight:3 FromView:integralIV]];
        
        
        lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(20, 80, kScreenWidth - 40, 150)];
        [self addSubview:lineChart];
        lineChart.showYGridLines = YES;//Y轴虚线
        lineChart.yGridLinesColor = WJColorCardRed;
        lineChart.showCoordinateAxis = YES; //显示坐标系
        lineChart.showSmoothLines = YES; //曲线或折线
        
        [lineChart setXLabels:@[@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00"]];

        //描点
        NSArray * data01Array = @[@200, @400, @100, @250, @300, @250, @240];
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = WJColorMainColor;
        data01.inflexionPointStyle = PNLineChartPointStyleCircle;//坐标点样式
        data01.itemCount = lineChart.xLabels.count;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        lineChart.displayAnimated = NO;//动画
        lineChart.chartData = @[data01];
        [lineChart strokeChart];
        
        UIView * horizontalLine = [[UIView alloc]initForAutoLayout];
        horizontalLine.backgroundColor = WJColorSeparatorLine;
        [self addSubview:horizontalLine];
        [self addConstraints:[horizontalLine constraintsSize:CGSizeMake(kScreenWidth, 0.5)]];
        [self addConstraints:[horizontalLine constraintsBottomInContainer:44]];
        
        UIView * verticalLine = [[UIView alloc]initForAutoLayout];
        verticalLine.backgroundColor = WJColorSeparatorLine;
        [self addSubview:verticalLine];
        [self addConstraints:[verticalLine constraintsSize:CGSizeMake(0.5, 26)]];
        [self addConstraints:[verticalLine constraintsBottomInContainer:9]];
        [self addConstraint:[verticalLine constraintCenterXInContainer]];
        
        self.inputButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _inputButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_inputButton setTitle:@"买入" forState:UIControlStateNormal];
        _inputButton.titleLabel.font = WJFont16;
        [_inputButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
        [_inputButton setBackgroundColor:WJColorWhite];
        [self addSubview:_inputButton];
        [self addConstraints:[_inputButton constraintsSize:CGSizeMake((kScreenWidth - 1)/2, 43)]];
        [self addConstraints:[_inputButton constraintsBottomInContainer:0]];
        [self addConstraints:[_inputButton constraintsRight:0 FromView:verticalLine]];
        
        self.outputButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _outputButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_outputButton setTitle:@"卖出" forState:UIControlStateNormal];
        _outputButton.titleLabel.font = WJFont16;
        [_outputButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
        [_outputButton setBackgroundColor:WJColorWhite];
        [self addSubview:_outputButton];
        [self addConstraints:[_outputButton constraintsSize:CGSizeMake((kScreenWidth - 1)/2, 43)]];
        [self addConstraints:[_outputButton constraintsBottomInContainer:0]];
        [self addConstraints:[_outputButton constraintsLeft:0 FromView:verticalLine]];
        
    }
    return self;
}

@end
