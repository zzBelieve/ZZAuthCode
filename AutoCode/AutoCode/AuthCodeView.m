//
//  AuthCodeView.m
//  AutoCode
//
//  Created by ZZBelieve on 15/8/24.
//  Copyright (c) 2015年 galaxy-link. All rights reserved.
//

#import "AuthCodeView.h"

#define kRandromCOlor [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1]

#define kLineCount 6

#define kLineWidth 1.0

#define kCharCount 6

#define kFontSize [UIFont systemFontOfSize:arc4random()%5+15]


@implementation AuthCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {

    
        self.layer.cornerRadius = 5.0f;
        
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = kRandromCOlor;
        
        
        [self getAuthCode];
        
        
        
        
        
    }
    return self;
}
- (void)getAuthCode{

    //字符串素材
    _dataArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
    
    _authCodeStr = [[NSMutableString alloc] initWithCapacity:kCharCount];
    
    for (int i = 0; i<kCharCount; i++) {
        
    //随机从数组中选取需要的字符串个数 拼接为验证码
        
        NSInteger index = arc4random() % (_dataArray.count-1);
        
        NSString *tempStr = [_dataArray objectAtIndex:index];
        
        _authCodeStr = (NSMutableString *)[_authCodeStr stringByAppendingString:tempStr];
        
        
    }


}
// 点击界面切换验证码
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self getAuthCode];
    
    
    //调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];

}
- (void)drawRect:(CGRect)rect{

  
    [super drawRect:rect];
    
    
    self.backgroundColor = kRandromCOlor;
    
    
    
    NSString *str = [NSString stringWithFormat:@"%@",_authCodeStr];

    
    CGSize Ssize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];

  
    int width = rect.size.width/str.length - Ssize.width;
    
    int height = rect.size.height - Ssize.height;
    
    
    CGPoint point;
    
    
    //依次绘制每一个字符/////////呵呵呵呵呵呵
    
    float pX,pY;
    
    
    for (int i  =0 ; i<str.length; i++) {
        
        pX = arc4random()%width + rect.size.width/str.length *i;
        pY = arc4random()%height;
        point = CGPointMake(pX, pY);
        
        
        
        unichar c = [str characterAtIndex:i];
        
        NSString *text = [NSString stringWithFormat:@"%C",c];
        
        [text drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
        
    }

    
    //调用drawRect: 之前 系统会向栈中压入一个CGContextRef,调用UIGraphicsGetCurrentText()会取栈顶的CGContextRef

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //线条宽度
    
    CGContextSetLineWidth(context, kLineWidth);
    
    
    //绘制干扰线
    
    for (int i = 0; i<kLineCount; i++) {
        
        UIColor *color = kRandromCOlor;
        
        //设置线条填充色
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        
        //设置线的起点
        
        pX = arc4random() % (int )rect.size.width;
        pY = arc4random() % (int )rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        
        
        //设置线的终点
        pX = arc4random() % (int )rect.size.width;
        pY = arc4random() % (int )rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        
        //画线
        CGContextStrokePath(context);
    }


}
@end
