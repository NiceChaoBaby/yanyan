//
//  UIButton+MYFont.m
//  XXFontAdaptation
//
//  Created by xiangxx on 16/6/7.
//  Copyright © 2016年 xiangxx. All rights reserved.
//

#import "UIButton+MYFont.h"

#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
//#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
////#define SizeScale ((IPHONE_HEIGHT > 568) ? IPHONE_HEIGHT/568 : 1)
//#define SizeScale ((IPHONE_WIDTH > 375) ? 1 : IPHONE_WIDTH/375)

@implementation UIButton (MYFont)

@end

@implementation UIButton(myFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    Method Imp2 = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myImp2 = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(Imp2, myImp2);
}

- (id)myInitWithCoder:(NSCoder *)aDecode{

    [self myInitWithCoder:aDecode];
    if (self) {
        // 部分不想改变字体的 把tag值设置成555跳过
        if (self.titleLabel.tag != 555) {
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize * SizeScale];
            
            [self setExclusiveTouch:YES];
            //    ExclusiveTouch的作用是：可以达到同一界面上多个控件接受事件时的排他性,从而避免一些问题。也就是说避免在一个界面上同时点击多个button。
//            [[UIButton appearance] setExclusiveTouch:YES];
        }
    }
    return self;
}

-(id)myInitWithFrame:(CGRect)frame
{
    [self myInitWithFrame:frame];
    
    if (self) {
        // 部分不想改变字体的 把tag值设置成555跳过
        if (self.titleLabel.tag != 555) {
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize * SizeScale];
            
            [self setExclusiveTouch:YES];
            //    ExclusiveTouch的作用是：可以达到同一界面上多个控件接受事件时的排他性,从而避免一些问题。也就是说避免在一个界面上同时点击多个button。
            //            [[UIButton appearance] setExclusiveTouch:YES];
        }
    }
    return self;
}


@end

@implementation UILabel(myFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
      Method Imp2 = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myImp2 = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(imp, myImp);
    
     method_exchangeImplementations(Imp2, myImp2);
//    //只执行一次这个方法
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//        //替换三个方法
//        SEL originalSelector = @selector(init);
//        SEL originalSelector2 = @selector(initWithFrame:);
//        SEL originalSelector3 = @selector(awakeFromNib);
//        SEL swizzledSelector = @selector(YHBaseInit);
//        SEL swizzledSelector2 = @selector(YHBaseInitWithFrame:);
//        SEL swizzledSelector3 = @selector(YHBaseAwakeFromNib);
//        
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method originalMethod2 = class_getInstanceMethod(class, originalSelector2);
//        Method originalMethod3 = class_getInstanceMethod(class, originalSelector3);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        Method swizzledMethod2 = class_getInstanceMethod(class, swizzledSelector2);
//        Method swizzledMethod3 = class_getInstanceMethod(class, swizzledSelector3);
//        BOOL didAddMethod =
//        class_addMethod(class,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod));
//        BOOL didAddMethod2 =
//        class_addMethod(class,
//                        originalSelector2,
//                        method_getImplementation(swizzledMethod2),
//                        method_getTypeEncoding(swizzledMethod2));
//        BOOL didAddMethod3 =
//        class_addMethod(class,
//                        originalSelector3,
//                        method_getImplementation(swizzledMethod3),
//                        method_getTypeEncoding(swizzledMethod3));
//        
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//            
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//        if (didAddMethod2) {
//            class_replaceMethod(class,
//                                swizzledSelector2,
//                                method_getImplementation(originalMethod2),
//                                method_getTypeEncoding(originalMethod2));
//        }else {
//            method_exchangeImplementations(originalMethod2, swizzledMethod2);
//        }
//        if (didAddMethod3) {
//            class_replaceMethod(class,
//                                swizzledSelector3,
//                                method_getImplementation(originalMethod3),
//                                method_getTypeEncoding(originalMethod3));
//        }else {
//            method_exchangeImplementations(originalMethod3, swizzledMethod3);
//        }
//    });
    
}

- (id)myInitWithCoder:(NSCoder *)aDecode{
    [self myInitWithCoder:aDecode];
    
    if (self) {
        // 部分不想改变字体的 把tag值设置成555跳过
        if (self.tag != 555) {
            
            CGFloat fontSize = self.font.pointSize;
//            self.font = [UIFont systemFontOfSize:fontSize * SizeScale];
            self.font =  [UIFont fontWithName:K_fontPingfang size:fontSize * SizeScale];
              DLog(@"%.2d--%.2f",SizeScale,SizeScale*fontSize);
            
        }
    }
    return self;
}
-(id)myInitWithFrame:(CGRect)frame
{
    [self myInitWithFrame:frame];
    
    if (self) {
        // 部分不想改变字体的 把tag值设置成555跳过
        if (self.tag != 555) {
            
            CGFloat fontSize = self.font.pointSize;
//             self.font = [UIFont systemFontOfSize:fontSize * SizeScale];
            self.font = [UIFont fontWithName:K_fontPingfang size:fontSize * SizeScale];
            DLog(@"%.2d--%.2f",SizeScale,SizeScale*fontSize);
            
        }
    }
    return self;
}


///**
// *在这些方法中将你的字体名字换进去
// */
//- (instancetype)YHBaseInit
//{
//    id __self = [self YHBaseInit];
//    // 部分不想改变字体的 把tag值设置成555跳过
//   if (self.tag != 555) {
//     CGFloat fontSize = self.font.pointSize;
//    UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize * SizeScale];
//    if (font) {
//        self.font=font;
//    }
//    }
//    return __self;
//}
//
//-(instancetype)YHBaseInitWithFrame:(CGRect)rect{
//    id __self = [self YHBaseInitWithFrame:rect];
//    // 部分不想改变字体的 把tag值设置成555跳过
//    if (self.tag != 555) {
//     CGFloat fontSize = self.font.pointSize;
//    UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize * SizeScale];
//    if (font) {
//        self.font=font;
//    }
//    }
//    return __self;
//}
//-(void)YHBaseAwakeFromNib{
//    [self YHBaseAwakeFromNib];
//    // 部分不想改变字体的 把tag值设置成555跳过
//    if (self.tag != 555) {
//     CGFloat fontSize = self.font.pointSize;
//    UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize * SizeScale];
//    if (font) {
//        self.font=font;
//    }
//    }
//    
//}

@end
@implementation UITextField(myFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder *)aDecode{
    [self myInitWithCoder:aDecode];
    
    if (self) {
        // 部分不想改变字体的 把tag值设置成555跳过
        if (self.tag != 555) {
                        CGFloat fontSize = self.font.pointSize;
            self.font =  [UIFont fontWithName:K_fontPingfang size:fontSize * SizeScale];
//            DLog(@"%.2f--%.2f",SizeScale,SizeScale*fontSize);
//            [self setValue: [UIFont systemFontOfSize:fontSize * SizeScale] forKeyPath:@"_placeholderLabel.font"];

        }
    }
    return self;
}

@end
@implementation UITextView(myFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder *)aDecode{
    [self myInitWithCoder:aDecode];
    
    if (self) {
        // 部分不想改变字体的 把tag值设置成555跳过
        if (self.tag != 555) {
            
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont fontWithName:K_fontPingfang size:fontSize * SizeScale];
//            DLog(@"%.2f--%.2f",SizeScale,SizeScale*fontSize);
            
        }
    }
    return self;
}

@end
