//
//  NoFriendView.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "NoFriendView.h"
#import <QuartzCore/QuartzCore.h>

@implementation NoFriendView {
    NSRange targetRang;
}

-(id)init {
    self = [super init];
    if(self) {
        [[NSBundle mainBundle] loadNibNamed:@"NoFriendView" owner:self options:nil];
        [self addSubview:self.contentView];
        self.contentView.frame = self.bounds;
        [self initView];
    }
    return self;
}

-(void)layoutSubviews {
    [self.button.layer setMasksToBounds:NO];

    CAGradientLayer *gradient = [CAGradientLayer layer];

    gradient.frame = self.button.bounds;
    UIColor *colorStar = [UIColor colorWithRed:86/255.0 green:179/255.0 blue:11/255.0 alpha:1];
    UIColor *colorEnd = [UIColor colorWithRed:166/255.0 green:204/255.0 blue:66/255.0 alpha:1];
    gradient.colors = @[(id)colorStar.CGColor, (id)colorEnd.CGColor];
    gradient.startPoint = CGPointZero;
    gradient.endPoint = CGPointMake(0, 1);
    gradient.cornerRadius = 20;

    [self.button.layer insertSublayer:gradient atIndex:0];

    [self.button.layer setCornerRadius:20];
    
    [self.button.layer setShadowOffset:CGSizeMake(0, 4)];
    [self.button.layer setShadowRadius:2];
    [self.button.layer setShadowOpacity:0.4];
    [self.button.layer setShadowColor:[UIColor colorWithRed:121/255.0 green:196/255.0 blue:27/255.0 alpha:1].CGColor];
    

}

-(void)initView {
    self.button.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *addFriendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFriendClick)];
    [self.button addGestureRecognizer:addFriendTap];
    
    UITapGestureRecognizer *setIdTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setIdClick:)];
    [self.attrLabel setUserInteractionEnabled:YES];
    [self.attrLabel addGestureRecognizer:setIdTap];
    self.attrLabel.text = @"";
    NSString *sStr = @"幫助好友更快找到你？設定 KOKO ID";
    NSString *idStr = @"設定 KOKO ID";
    targetRang = [sStr rangeOfString:idStr];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:sStr];
    //NSMutableAttributedString *aIdStr = [[NSMutableAttributedString alloc] initWithString:idStr];
    [aStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:targetRang];
    [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:236/255.0 green:0/255.0 blue:140/255.0 alpha:1] range:targetRang];
    
    
    self.attrLabel.attributedText = aStr;
    targetRang.location += 4;

    
}

-(void)addFriendClick {
    if(self.delegate != nil) {
        [self.delegate addFriendClick];
    }
}

-(void)setIdClick:(UITapGestureRecognizer *)tapGesture {
    CGPoint tapLocation = [tapGesture locationInView:tapGesture.view];

    // init text storage
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attrLabel.attributedText];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];

    // init text container
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize: CGSizeMake(self.attrLabel.frame.size.width, self.attrLabel.frame.size.height) ];
    textContainer.lineFragmentPadding  = 0;
    textContainer.maximumNumberOfLines = self.attrLabel.numberOfLines;
    textContainer.lineBreakMode        = self.attrLabel.lineBreakMode;

    [layoutManager addTextContainer:textContainer];

    NSUInteger indexOfCharacter = [layoutManager characterIndexForPoint:tapLocation inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    if(NSLocationInRange(indexOfCharacter, targetRang) && self.delegate != nil) {
        [self.delegate setIDClick];
    }
}

@end
