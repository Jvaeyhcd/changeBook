//
//  HcdReplyView.m
//  govlan
//
//  Created by polesapp-hcd on 2016/11/17.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import "HcdReplyView.h"
#import "NSString+Polesapp.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreen_Width/320))

#define kContenViewHeight kScaleFrom_iPhone5_Desgin(110)
#define kPadding kScaleFrom_iPhone5_Desgin(8)

@interface HcdReplyView()<UITextViewDelegate>

@property (nonatomic, strong) UIView *dialogView, *mainView;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIPlaceHolderTextView* textView;
@property (nonatomic, strong) UILabel *tipsLbl;
@property (nonatomic, strong) HCSStarRatingView *ratingView;

@end

@implementation HcdReplyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self initUIWithStar: NO];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self initUIWithStar: NO];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame showRateStar:(BOOL)showRateStar {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self initUIWithStar: YES];
    }
    return self;
}

- (void)initUIWithStar:(BOOL)showRateStar {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _mainView.userInteractionEnabled = YES;
        UIView *maskView;
        
        // 毛玻璃效果
//        double version = [[UIDevice currentDevice].systemVersion doubleValue];
//        if (version >= 8.0f) {
//            
//            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//            maskView = [[UIVisualEffectView alloc] initWithEffect:blur];
//            ((UIVisualEffectView *)maskView).frame = _mainView.bounds;
//            
//        } else if(version >= 7.0f){
//            
//            maskView = [[UIToolbar alloc] initWithFrame:_mainView.bounds];
//            ((UIToolbar *)maskView).barStyle = UIBarStyleDefault;
//            
//        }
        
        // 般透明效果
        maskView = [[UIView alloc]initWithFrame:_mainView.bounds];
        maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideReplayView)];
        
        [maskView addGestureRecognizer:singleTap];
        
        [_mainView addSubview:maskView];
        
        [self addSubview:_mainView];
    }
    
    CGFloat dialogViewHeight = kContenViewHeight;
    CGFloat textViewY = kPadding;

    if (showRateStar) {
        dialogViewHeight += kScaleFrom_iPhone5_Desgin(60);
        textViewY = kScaleFrom_iPhone5_Desgin(60) + kPadding;
    }
    
    if (!_dialogView) {
        _dialogView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, kScreen_Width, dialogViewHeight)];
        _dialogView.userInteractionEnabled = YES;
        _dialogView.backgroundColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.965 alpha:1.00];
        [_mainView addSubview:_dialogView];
    }
    
    if (showRateStar && !_ratingView) {
        _ratingView= [[HCSStarRatingView alloc]initWithFrame:CGRectMake((kScreen_Width - kScaleFrom_iPhone5_Desgin(200)) / 2, kScaleFrom_iPhone5_Desgin(10), kScaleFrom_iPhone5_Desgin(200), kScaleFrom_iPhone5_Desgin(40))];
        _ratingView.maximumValue = 5;
        _ratingView.minimumValue = 1;
        _ratingView.emptyStarImage = [UIImage imageNamed:@"pingjia_btn_star2"];
        _ratingView.filledStarImage = [UIImage imageNamed:@"pingjia_btn_star1"];
        _ratingView.allowsHalfStars = NO;
        _ratingView.backgroundColor = [UIColor clearColor];
        _ratingView.value = 5;
        
        [_dialogView addSubview:_ratingView];
    }
    
    if (!_textView) {
        _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(kPadding, textViewY, kScreen_Width - 2 * kPadding, kContenViewHeight - 3 * kPadding - 24)];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.clipsToBounds = YES;
        _textView.layer.borderColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.965 alpha:1.00].CGColor;
        _textView.layer.borderWidth = 1;
        _textView.layer.cornerRadius = 2;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor blackColor];
        _textView.placeholderColor = [UIColor colorWithRed:0.600 green:0.600 blue:0.600 alpha:1.00];
        [_dialogView addSubview:_textView];
    }
    
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc]initWithFrame:CGRectMake(kPadding, CGRectGetMaxY(_textView.frame) + kPadding, kScreen_Width - 2 * kPadding - 50, 24)];
        _tipsLbl.font = [UIFont systemFontOfSize:12];
        _tipsLbl.textColor = [UIColor colorWithRed:0.600 green:0.600 blue:0.600 alpha:1.00];
        [_dialogView addSubview:_tipsLbl];
    }
    
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width - kPadding - 50, CGRectGetMaxY(_textView.frame) + kPadding, 50, 24)];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBtn.layer.cornerRadius = 4;
        _commitBtn.clipsToBounds = YES;
        [_commitBtn addTarget:self action:@selector(confrimClick) forControlEvents:UIControlEventTouchUpInside];
        [_commitBtn setTitle:@"评论" forState:UIControlStateNormal];
        _commitBtn.backgroundColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1.00];
        [_dialogView addSubview:_commitBtn];
    }
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    _textView.placeholder = _placeHolder;
}

- (void)showReplyInView:(UIView *)view {
    [view addSubview:self];
    self.commitBtn.enabled = YES;
    [self.textView becomeFirstResponder];
}

- (void)hideReplayView {
    
    [self removeFromSuperview];
    [self.textView resignFirstResponder];
    self.dialogView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, kContenViewHeight);
}

- (void)confrimClick {
    
    // 去掉头尾的空格、换行和Tab
    NSString *content = [self.textView.text removeBothSideSpaceAndNewline];
    // 将换行替换成空格
    content = [content stringByReplacingOccurrencesOfString: @"\n" withString: @" "];
    // 将中间连续十个以上的空格替换成十个
    content = [content replaceMoreThan10SpaceTo10Space];
    
    NSString *score = @"";
    if (_ratingView) {
        score = [NSString stringWithFormat:@"%f", _ratingView.value];
    }
    
    if (content.length > 0) {
        if (self.commitReplyBlock) {
            self.commitReplyBlock(content, score);
        }
        [self hideReplayView];
    } else {
        
    }
}

#pragma mark TextView Delegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.isBlankString) {
        textView.text = @"";
    }
    
    if (textView.text && textView.text.length > 0) {
        
        if (textView.text.length > 150) {
            textView.text = [textView.text substringToIndex:150];
        }
        
        self.tipsLbl.text = [NSString stringWithFormat:@"您已输入%lu字", (unsigned long)textView.text.length];
        [self.commitBtn setBackgroundColor:[UIColor colorWithRed:0.973 green:0.357 blue:0.353 alpha:1.00]];
    } else {
        self.tipsLbl.text = @"请输入1~150个文字";
        [self.commitBtn setBackgroundColor:[UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1.00]];
    }
}

- (void)removeKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    int  keyBoardHeight=keyboardBounds.size.height;
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    _dialogView.center = CGPointMake(kScreen_Width / 2, kScreen_Height - keyBoardHeight - _dialogView.frame.size.height / 2);
    
    [UIView commitAnimations];
}

-(void)dealloc{
    
    [self removeKeyboardNotifications];
}

@end
