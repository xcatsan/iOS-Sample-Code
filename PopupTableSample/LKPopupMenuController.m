//==============================================================================
// LKPopupMenuController
//------------------------------------------------------------------------------
//
// Copyright (c) 2011 Hiroshi Hashiguchi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import <QuartzCore/QuartzCore.h>
#import "LKPopupMenuController.h"

//------------------------------------------------------------------------------
@implementation LKPopupMenuAppearance
//------------------------------------------------------------------------------
// colors
@synthesize menuBackgroundColor;
@synthesize menuTextColor;
@synthesize titleBackgroundColor;
@synthesize titleTextColor;
@synthesize titleTextShadowColor;
@synthesize menuHilightedColor;
@synthesize checkMarkColor;
@synthesize separatorColor;
@synthesize outlineColor;
@synthesize indicatorStyle;

// size
@synthesize titleHeight;
@synthesize cellHeight;
@synthesize fontSize;
@synthesize listWidth, listHeight;
@synthesize outlineWith;

// appearance
@synthesize shadowEnabled;
@synthesize triangleEnabled;
@synthesize separatorEnabled;
@synthesize outlineEnabled;
@synthesize titleHighlighted;


+ (LKPopupMenuAppearance*)defaultAppearanceWithSize:(LKPopupMenuControllerSize)menuSize color:(LKPopupMenuControllerColor)menuColor
{
    LKPopupMenuAppearance* appearance = [[[LKPopupMenuAppearance alloc] init] autorelease];

    // setup sizes
    switch (menuSize) {
        case LKPopupMenuControllerSizeSmall:
            appearance.titleHeight = 25.0;
            appearance.cellHeight = 30.0;
            appearance.fontSize = 12.0;
            appearance.listWidth = 120.0;
            appearance.listHeight = 150.0;
            appearance.outlineWith = 1.0;
            break;
            
        case LKPopupMenuControllerSizeMedium:
            appearance.titleHeight = 30.0;
            appearance.cellHeight = 35.0;
            appearance.fontSize = 14.0;
            appearance.listWidth = 160.0;
            appearance.listHeight = 190.0;
            appearance.outlineWith = 2.0;
            break;
            
        case LKPopupMenuControllerSizeLarge:
            appearance.titleHeight = 35.0;
            appearance.cellHeight = 40.0;
            appearance.fontSize = 17.0;
            appearance.listWidth = 200.0;
            appearance.listHeight = 230.0;
            appearance.outlineWith = 3.0;
            break;
            
        default:
            break;
    }

    // setup colors
    switch (menuColor) {
        case LKPopupMenuControllerColorDefault:
        case LKPopupMenuControllerColorBlack:
            appearance.menuBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.65];
            appearance.menuTextColor = [UIColor whiteColor];
            appearance.menuHilightedColor = [UIColor colorWithWhite:0.5 alpha:0.5];    
            appearance.titleBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.85];
            appearance.titleTextColor = [UIColor whiteColor];
            appearance.titleTextShadowColor = [UIColor blackColor];
            appearance.checkMarkColor = [UIColor whiteColor];
            appearance.separatorColor = [UIColor colorWithWhite:0.5 alpha:0.9];
            appearance.outlineColor   = [UIColor whiteColor];
            appearance.indicatorStyle = UIScrollViewIndicatorStyleWhite;            
            break;

        case LKPopupMenuControllerColorWhite:
            appearance.menuBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
            appearance.menuTextColor = [UIColor colorWithWhite:0.25 alpha:1.0];
            appearance.menuHilightedColor = [UIColor colorWithWhite:0.75 alpha:1.0];
            appearance.titleBackgroundColor = [UIColor colorWithWhite:0.85 alpha:0.95];
            appearance.titleTextColor = [UIColor colorWithWhite:0.35 alpha:1.0];
            appearance.titleTextShadowColor = [UIColor whiteColor];
            appearance.checkMarkColor = [UIColor darkGrayColor];
            appearance.separatorColor = [UIColor colorWithWhite:1.0 alpha:1.0];
            appearance.outlineColor   = [UIColor whiteColor];
            appearance.indicatorStyle = UIScrollViewIndicatorStyleBlack;
            break;

        case LKPopupMenuControllerColorGray:
            appearance.menuBackgroundColor = [UIColor colorWithWhite:0.75 alpha:0.9];
            appearance.menuTextColor = [UIColor whiteColor];
            appearance.menuHilightedColor = [UIColor colorWithWhite:0.6 alpha:0.9];
            appearance.titleBackgroundColor = [UIColor colorWithWhite:0.5 alpha:0.9];
            appearance.titleTextColor = [UIColor whiteColor];
            appearance.titleTextShadowColor = [UIColor blackColor];
            appearance.checkMarkColor = [UIColor whiteColor];
            appearance.separatorColor = [UIColor colorWithWhite:0.85 alpha:0.9];
            appearance.outlineColor   = [UIColor whiteColor];
            appearance.indicatorStyle = UIScrollViewIndicatorStyleBlack;
            break;
            
        default:
            break;
    }

    // setup appearance
    appearance.shadowEnabled = YES;
    appearance.triangleEnabled = YES;
    appearance.separatorEnabled = YES;
    appearance.outlineEnabled = YES;
    appearance.titleHighlighted = YES;
    appearance.separatorEnabled = YES;

    return appearance;
}

+ (LKPopupMenuAppearance*)defaultAppearanceWithSize:(LKPopupMenuControllerSize)menuSize
{
    return [self defaultAppearanceWithSize:menuSize color:LKPopupMenuControllerColorDefault];
}

- (void)dealloc
{
    self.menuBackgroundColor = nil;
    self.menuTextColor = nil;
    self.menuHilightedColor = nil;
    self.titleBackgroundColor = nil;
    self.titleTextColor = nil;
    self.titleTextShadowColor = nil;
    self.checkMarkColor = nil;
    self.separatorColor = nil;
    self.outlineColor = nil;
    [super dealloc];
}
            
@end


@class LKPopupMenuView;
@class LKPopupBackgroundView;
//==============================================================================
@interface LKPopupMenuController() <UITableViewDelegate, UITableViewDataSource>
//==============================================================================

@property (nonatomic, assign) UIView* parentView;
@property (nonatomic, retain) LKPopupMenuView* popupMenuBaseView;
@property (nonatomic, assign) BOOL popupmenuVisible;
@property (nonatomic, retain) LKPopupBackgroundView* backgroundView;
@property (nonatomic, retain) NSMutableIndexSet* indexSet;

@end

//------------------------------------------------------------------------------
@interface LKPopupBackgroundView : UIView
//------------------------------------------------------------------------------
@property (nonatomic, assign) LKPopupMenuController* popupMenu;
@end
@implementation LKPopupBackgroundView
@synthesize popupMenu;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.popupMenu dismiss];
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end


//==============================================================================
@interface LKPopupMenuTitleView : UIView
//==============================================================================
@property (nonatomic, assign) CATextLayer* textLayer;
@property (nonatomic, assign) CAGradientLayer* gradientLayer;
- (id)initWithFrame:(CGRect)frame popupMenu:(LKPopupMenuController*)popupMenu;
@end

//------------------------------------------------------------------------------
@implementation LKPopupMenuTitleView
//------------------------------------------------------------------------------
#define LK_POPUP_MENU_PADDING_X     10.0

@synthesize textLayer = textLayer_;
@synthesize gradientLayer = gradientLayer_;

- (id)initWithFrame:(CGRect)frame popupMenu:(LKPopupMenuController*)popupMenu
{
    self = [super initWithFrame:frame];
    if (self) {
        // setup basics
        self.backgroundColor = popupMenu.appearance.titleBackgroundColor;
        
        CGFloat scale = [[UIScreen mainScreen] scale];
        
        // setup gradient layer
        if (popupMenu.appearance.titleHighlighted) {
            self.gradientLayer = [CAGradientLayer layer];
            self.gradientLayer.contentsScale = scale;
            self.gradientLayer.frame = self.bounds;
            self.gradientLayer.locations = [NSArray arrayWithObjects:
                                            [NSNumber numberWithFloat:0.0],
                                            [NSNumber numberWithFloat:0.2],
                                            [NSNumber numberWithFloat:0.5],
                                            [NSNumber numberWithFloat:0.5],
                                            [NSNumber numberWithFloat:1.0],
                                            nil];
            self.gradientLayer.colors =
                [NSArray arrayWithObjects:
                 (id)[UIColor colorWithWhite:1.0 alpha:0.6].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.35].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.3].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
                 nil];

            [self.layer addSublayer:self.gradientLayer];
        }
        
        // setup text layer
        self.textLayer = [CATextLayer layer];
        self.textLayer.contentsScale = scale;

        self.textLayer.string = popupMenu.title;
        UIFont* font = [UIFont boldSystemFontOfSize:popupMenu.appearance.fontSize];
        CGSize textSize = [popupMenu.title sizeWithFont:font];
        self.textLayer.frame = CGRectMake(LK_POPUP_MENU_PADDING_X,
                                          (self.frame.size.height - textSize.height)/2.0 + 3,
                                          self.frame.size.width - LK_POPUP_MENU_PADDING_X*2,
                                          textSize.height);
        CGFontRef cgfont = CGFontCreateWithFontName((CFStringRef)font.fontName);
        self.textLayer.font = cgfont;
        CFRelease(cgfont);
        self.textLayer.fontSize = popupMenu.appearance.fontSize;
        self.textLayer.foregroundColor = popupMenu.appearance.titleTextColor.CGColor;
        self.textLayer.truncationMode = kCATruncationEnd;
        self.textLayer.alignmentMode = kCAAlignmentLeft;
        
        if (popupMenu.appearance.titleHighlighted) {
            self.textLayer.shadowColor = popupMenu.appearance.titleTextShadowColor.CGColor;
            self.textLayer.shadowRadius = 0.5;
            self.textLayer.shadowOffset =CGSizeMake(-0.5, -0.5);
            self.textLayer.shadowOpacity = 1.0;
        }

        [self.layer addSublayer:self.textLayer];
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end



//==============================================================================
@interface LKPopupMenuView : UIView
//==============================================================================
#define LK_POPUP_MENU_PADDING   2.0
#define LK_POPUP_MENU_MARGIN    2.0
#define LK_POPUP_MENU_TRIANGLE_LONG          22.0
#define LK_POPUP_MENU_TRIANGLE_SHORT         14.0

#define LK_POPUP_MENU_SHADOW_OFFSET 2.5
#define LK_POPUP_MENU_CORNER_RADIUS    5.0

typedef enum {
    LKPopupMenuViewTypeBase,
    LKPopupMenuViewTypeFrame
} LKPopupMenuViewType;

@property (nonatomic, assign) LKPopupMenuController* popupMenu;
@property (nonatomic, assign) UITableView* tableView;
@property (nonatomic, assign) CGRect tableFrame;
@property (nonatomic, assign) CGFloat shadowOffset;
@property (nonatomic, assign) CGSize triangleSize;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, retain) UIBezierPath* path;
@property (nonatomic, assign) LKPopupMenuViewType type;

- (id)initAsBaseWithPopupMenu:(LKPopupMenuController*)popupMenu location:(CGPoint)location title:(NSString*)title;
- (id)initAsFrameWithPopupMenu:(LKPopupMenuController*)popupMenu location:(CGPoint)location title:(NSString*)title;
- (void)setupPathAtLocation:(CGPoint)location;
- (void)reloadData;

@end


//------------------------------------------------------------------------------
@implementation LKPopupMenuView
//------------------------------------------------------------------------------
@synthesize popupMenu = popupMenu_;
@synthesize tableView = tableView_;
@synthesize tableFrame = tableFrame_;
@synthesize shadowOffset = shadowOffset_;
@synthesize triangleSize = triangleSize_;
@synthesize titleHeight = titleHeight_;
@synthesize path = path_;
@synthesize type = type_;

- (void)setupPathAtLocation:(CGPoint)location
{
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    
    CGPoint p = self.tableFrame.origin;
    CGPoint tp = location;
    
    p.x += LK_POPUP_MENU_CORNER_RADIUS;
    [path moveToPoint:p];
    
    // upper
    if (self.popupMenu.appearance.triangleEnabled &&
        self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeDown) {
        p.x = tp.x - self.triangleSize.width/2.0;
        [path addLineToPoint:p];
        p.x += self.triangleSize.width/2.0;
        p.y -= self.triangleSize.height;
        [path addLineToPoint:p];
        p.x += self.triangleSize.width/2.0;
        p.y += self.triangleSize.height;
        [path addLineToPoint:p];
        p.x = self.tableFrame.origin.x + self.tableFrame.size.width - LK_POPUP_MENU_CORNER_RADIUS;
        [path addLineToPoint:p];
    } else {
        p.x += self.tableFrame.size.width - LK_POPUP_MENU_CORNER_RADIUS*2;
        [path addLineToPoint:p];
    }
    
    // upper right
    p.y += LK_POPUP_MENU_CORNER_RADIUS;
    [path addArcWithCenter:p
                    radius:LK_POPUP_MENU_CORNER_RADIUS
                startAngle:-1.0*M_PI/2.0
                  endAngle:0.0*M_PI/2.0
                 clockwise:YES];
    
    // right
    p.x += LK_POPUP_MENU_CORNER_RADIUS;
    if (self.popupMenu.appearance.triangleEnabled &&
        self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeLeft) {
        p.y = tp.y - self.triangleSize.width/2.0;
        [path addLineToPoint:p];
        p.x += self.triangleSize.height;
        p.y += self.triangleSize.width/2.0;
        [path addLineToPoint:p];
        p.x -= self.triangleSize.height;
        p.y += self.triangleSize.width/2.0;
        [path addLineToPoint:p];
        p.y = self.tableFrame.origin.y + self.tableFrame.size.height - LK_POPUP_MENU_CORNER_RADIUS;
        [path addLineToPoint:p];
    } else {
        p.y += self.tableFrame.size.height - LK_POPUP_MENU_CORNER_RADIUS*2;
        [path addLineToPoint:p];
    }
    
    // lower right
    p.x -= LK_POPUP_MENU_CORNER_RADIUS;    
    [path addArcWithCenter:p
                    radius:LK_POPUP_MENU_CORNER_RADIUS
                startAngle:0.0*M_PI/2.0
                  endAngle:1.0*M_PI/2.0
                 clockwise:YES];
    
    // lower
    p.y += LK_POPUP_MENU_CORNER_RADIUS;
    if (self.popupMenu.appearance.triangleEnabled &&
        self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeUp) {
        p.x = tp.x + self.triangleSize.width/2.0;
        [path addLineToPoint:p];
        p.x -= self.triangleSize.width/2.0;
        p.y += self.triangleSize.height;
        [path addLineToPoint:p];
        p.x -= self.triangleSize.width/2.0;
        p.y -= self.triangleSize.height;
        [path addLineToPoint:p];
        p.x = self.tableFrame.origin.x + LK_POPUP_MENU_CORNER_RADIUS;
        [path addLineToPoint:p];
    } else {
        p.x -= self.tableFrame.size.width - LK_POPUP_MENU_CORNER_RADIUS*2;
        [path addLineToPoint:p];
    }
    
    // lower left
    p.y -= LK_POPUP_MENU_CORNER_RADIUS;
    [path addArcWithCenter:p
                    radius:LK_POPUP_MENU_CORNER_RADIUS
                startAngle:1.0*M_PI/2.0
                  endAngle:2.0*M_PI/2.0
                 clockwise:YES];
    
    // left
    p.x -= LK_POPUP_MENU_CORNER_RADIUS;
    if (self.popupMenu.appearance.triangleEnabled &&
        self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeRight) {
        p.y = tp.y + self.triangleSize.width/2.0;
        [path addLineToPoint:p];
        p.x -= self.triangleSize.height;
        p.y -= self.triangleSize.width/2.0;
        [path addLineToPoint:p];
        p.x += self.triangleSize.height;
        p.y -= self.triangleSize.width/2.0;
        [path addLineToPoint:p];
        p.y = self.tableFrame.origin.y + LK_POPUP_MENU_CORNER_RADIUS;
        [path addLineToPoint:p];
    } else {
        p.y -= self.tableFrame.size.height - LK_POPUP_MENU_CORNER_RADIUS*2;
        [path addLineToPoint:p];
    }
    
    // upper left
    p.x += LK_POPUP_MENU_CORNER_RADIUS;
    [path addArcWithCenter:p
                    radius:LK_POPUP_MENU_CORNER_RADIUS
                startAngle:2.0*M_PI/2.0
                  endAngle:3.0*M_PI/2.0
                 clockwise:YES];
    [path closePath];

    self.path = path;
}

 - (id)_initAsType:(LKPopupMenuViewType)type WithPopupMenu:(LKPopupMenuController*)popupMenu location:(CGPoint)location title:(NSString*)title
{
    self.type = type;
    self.popupMenu = popupMenu;
    LKPopupMenuAppearance* appearance = popupMenu.appearance;
    
    self.shadowOffset = self.popupMenu.appearance.shadowEnabled ? LK_POPUP_MENU_SHADOW_OFFSET : 0;
    self.triangleSize = CGSizeMake(LK_POPUP_MENU_TRIANGLE_LONG, LK_POPUP_MENU_TRIANGLE_SHORT);

    if (title && [[title stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceCharacterSet]] length] > 0) {
        self.titleHeight = appearance.titleHeight;
    } else {
        self.titleHeight = 0.0;
    }

    // setup list size
    CGFloat listWidth, listHeight;
    listWidth = appearance.listWidth;
    if (self.popupMenu.autoresizeEnabled) {
        listHeight = appearance.cellHeight * [self.popupMenu.textList count] + self.titleHeight;
    } else {
        listHeight = appearance.listHeight;
    }
    
    // setup menu size
    CGFloat menuWidth, menuHeight;
    menuWidth = listWidth + LK_POPUP_MENU_PADDING*2 + self.shadowOffset;
    menuHeight = listHeight + LK_POPUP_MENU_PADDING*2 + self.shadowOffset;

    switch (self.popupMenu.arrangementMode) {
        case LKPopupMenuControllerArrangementModeUp:
            menuHeight += self.triangleSize.height;
            break;
            
        case LKPopupMenuControllerArrangementModeDown:
            menuHeight += self.triangleSize.height;
            break;
            
        case LKPopupMenuControllerArrangementModeRight:
            menuWidth += self.triangleSize.height;
            break;
            
        case LKPopupMenuControllerArrangementModeLeft:
            menuWidth += self.triangleSize.height;
            break;
    }

    // adjust origin and size
    CGFloat menuX, menuY;    
    switch (self.popupMenu.arrangementMode) {
        case LKPopupMenuControllerArrangementModeUp:
            menuX = location.x - menuWidth/2.0;
            menuY = location.y - menuHeight;
            break;
            
        case LKPopupMenuControllerArrangementModeDown:
            menuX = location.x - menuWidth/2.0;
            menuY = location.y;
            break;
            
        case LKPopupMenuControllerArrangementModeRight:
            menuX = location.x;
            menuY = location.y - menuHeight/2.0;
            break;
            
        case LKPopupMenuControllerArrangementModeLeft:
            menuX = location.x - menuWidth;
            menuY = location.y - menuHeight/2.0;
            break;
    }

    CGSize parentViewSize = self.popupMenu.parentView.frame.size;
    CGFloat delta;

    if (menuX < 0) {
        if (self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeLeft ||
            self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeRight) {
            menuWidth += menuX - LK_POPUP_MENU_MARGIN;
            listWidth += menuX - LK_POPUP_MENU_MARGIN;
        }
        menuX = LK_POPUP_MENU_MARGIN;
    }

    delta = parentViewSize.width - (menuX + menuWidth + LK_POPUP_MENU_MARGIN);
    if (delta < 0) {
        if (-delta < menuX) {
            menuX += delta;
        } else {
            if (self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeUp ||
                self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeDown) {
                if (LK_POPUP_MENU_MARGIN < menuX) {
                    delta += menuX - LK_POPUP_MENU_MARGIN;
                    if (delta > 0) {
                        delta = 0;
                    }
                    menuX = LK_POPUP_MENU_MARGIN;
                }
            }
            menuWidth += delta;
            listWidth+= delta;
        }
    }

    if (menuY < 0) {
        if (self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeUp ||
            self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeDown) {
            menuHeight += menuY - LK_POPUP_MENU_MARGIN;
            listHeight += menuY - LK_POPUP_MENU_MARGIN;
        }
        menuY = LK_POPUP_MENU_MARGIN;
    }
    
    delta = parentViewSize.height - (menuY + menuHeight + LK_POPUP_MENU_MARGIN);
    //        fabs(deltaY) < menuY) {    menuY += deltaY

    if (delta < 0) {
        if (-delta < menuY) {
            menuY += delta;
        } else {
            if (self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeLeft ||
                self.popupMenu.arrangementMode == LKPopupMenuControllerArrangementModeRight) {
                if (LK_POPUP_MENU_MARGIN < menuY) {
                    delta += menuY - LK_POPUP_MENU_MARGIN;
                    if (delta > 0) {
                        delta = 0;
                    }
                    menuY = LK_POPUP_MENU_MARGIN;
                }
            }
            menuHeight += delta;
            listHeight += delta;
        }
    }
    
    menuX = floor(menuX + 0.5);
    menuY = floor(menuY + 0.5);

    CGRect frame = CGRectZero;
    
    if (type == LKPopupMenuViewTypeBase) {
        frame = CGRectMake(menuX, menuY, menuWidth, menuHeight);
    } else if (type == LKPopupMenuViewTypeFrame) {
        frame = CGRectMake(0, 0, menuWidth, menuHeight);
    }

    self = [super initWithFrame:frame];
    if (self) {
        // setup table view
        CGFloat tableX = LK_POPUP_MENU_PADDING;
        CGFloat tableY = LK_POPUP_MENU_PADDING;
        switch (self.popupMenu.arrangementMode) {
            case LKPopupMenuControllerArrangementModeUp:
                break;
                
            case LKPopupMenuControllerArrangementModeDown:
                tableY += self.triangleSize.height;
                break;
                
            case LKPopupMenuControllerArrangementModeRight:
                tableX += self.triangleSize.height;
                break;
                
            case LKPopupMenuControllerArrangementModeLeft:
                break;
        }

        self.tableFrame = CGRectMake(tableX, tableY, listWidth, listHeight);

        if (type == LKPopupMenuViewTypeBase) {
            // setup table        
            self.tableView = [[[UITableView alloc] initWithFrame:self.tableFrame
                                                           style:UITableViewStylePlain] autorelease];
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            self.tableView.showsVerticalScrollIndicator = YES;
            self.tableView.indicatorStyle = appearance.indicatorStyle;
            self.tableView.bounces = popupMenu.bounceEnabled;
            
            self.tableView.backgroundColor = [UIColor clearColor];
            CALayer* layer = self.tableView.layer;
            layer.masksToBounds = YES;
            layer.cornerRadius = 5.0;
            
            // setup header
            if (title && [[title stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]] length] > 0) {
                LKPopupMenuTitleView* view = [[[LKPopupMenuTitleView alloc] initWithFrame:
                                 CGRectMake(0, 0, self.tableView.frame.size.width, self.titleHeight)
                                               popupMenu:popupMenu] autorelease];
                self.tableView.tableHeaderView = view;
            }

            self.tableView.dataSource = popupMenu;
            self.tableView.delegate = popupMenu;

            [self addSubview:self.tableView];

        } else if (type ==LKPopupMenuViewTypeFrame) {
            self.userInteractionEnabled = NO;
        }

        // setup basics
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initAsFrameWithPopupMenu:(LKPopupMenuController*)popupMenu location:(CGPoint)location title:(NSString*)title
{
    return [self _initAsType:LKPopupMenuViewTypeFrame
               WithPopupMenu:popupMenu
                    location:location
                       title:title];
}

- (id)initAsBaseWithPopupMenu:(LKPopupMenuController*)popupMenu location:(CGPoint)location title:(NSString*)title
{
    return [self _initAsType:LKPopupMenuViewTypeBase
               WithPopupMenu:popupMenu
                    location:location
                       title:title];
}

- (void)dealloc {
    self.popupMenu = nil;
    if (self.tableView) {
        [self.tableView removeFromSuperview];
    }
    self.tableView = nil;
    self.path = nil;
    [super dealloc];
}

- (void)reloadData
{
    [self.tableView reloadData];
}


- (void)drawRect:(CGRect)rect
{
    if (self.type == LKPopupMenuViewTypeBase) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorRef shadowColor = [[UIColor colorWithWhite:0.0 alpha:0.5] CGColor];
        CGContextSetShadowWithColor(context,CGSizeMake(0, 0), self.shadowOffset, shadowColor);
        [self.popupMenu.appearance.menuBackgroundColor setFill];
        [self.path fill];
        
    } else if (self.type == LKPopupMenuViewTypeFrame) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorRef shadowColor = [[UIColor colorWithWhite:0.0 alpha:0.35] CGColor];
        CGContextSetShadowWithColor(context,CGSizeMake(1, 1), 2, shadowColor);
        [self.popupMenu.appearance.outlineColor setStroke];
        [self.path setLineWidth:self.popupMenu.appearance.outlineWith];
        [self.path stroke];
    }
}

@end

//------------------------------------------------------------------------------
@interface LKPopupMenuCheckMarkView : UIView
//------------------------------------------------------------------------------
@property (nonatomic, retain) UIColor* color;
+ (LKPopupMenuCheckMarkView*)checkMarkViewAtPoint:(CGPoint)p color:(UIColor*)color;
@end

//------------------------------------------------------------------------------
@implementation LKPopupMenuCheckMarkView
//------------------------------------------------------------------------------
#define LK_POPUP_MENU_CHECK_MARK_SIZE   16

@synthesize color = color_;

+ (LKPopupMenuCheckMarkView*)checkMarkViewAtPoint:(CGPoint)p color:(UIColor*)color
{
    CGRect frame = CGRectMake(p.x, p.y, LK_POPUP_MENU_CHECK_MARK_SIZE, LK_POPUP_MENU_CHECK_MARK_SIZE);
    LKPopupMenuCheckMarkView* view = [[[LKPopupMenuCheckMarkView alloc]
                                       initWithFrame:frame] autorelease];
    view.color = color;
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath* path = [UIBezierPath bezierPath];

    CGPoint p = CGPointMake(3, 9);
    [path moveToPoint:p];
    
    p.x += 4;
    p.y += 4;
    [path addLineToPoint:p];

    p.x += 6;
    p.y -= 10;
    [path addLineToPoint:p];
    
    [path setLineWidth:2.0];
    [self.color setStroke];
    [path stroke];
}

- (void)dealloc {
    self.color = nil;
    [super dealloc];
}

@end


//------------------------------------------------------------------------------
@interface LKPopupMenuCell : UITableViewCell
//------------------------------------------------------------------------------
+ (LKPopupMenuCell*)cellForTableView:(UITableView*)tableView popupMenu:(LKPopupMenuController*)popupMenu;
@property (nonatomic, retain) LKPopupMenuCheckMarkView* checkMarkView;
@property (nonatomic, assign) LKPopupMenuAppearance* appearance;
@property (nonatomic, assign) BOOL separatorEnabled;
@end

@implementation LKPopupMenuCell
@synthesize checkMarkView = checkMarkView_;
@synthesize appearance = appearance_;
@synthesize separatorEnabled = separatorEnabled_;

+ (LKPopupMenuCell*)cellForTableView:(UITableView*)tableView popupMenu:(LKPopupMenuController*)popupMenu
{
    static NSString *cellIdentifier = @"LKPopupMenuCell";
    
    LKPopupMenuCell *cell = (LKPopupMenuCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[LKPopupMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.appearance = popupMenu.appearance;
        cell.textLabel.font = [UIFont systemFontOfSize:cell.appearance.fontSize];
        cell.textLabel.textColor = cell.appearance.menuTextColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGPoint p = CGPointMake(tableView.frame.size.width - LK_POPUP_MENU_CHECK_MARK_SIZE - 8.0,
                                (cell.appearance.cellHeight - LK_POPUP_MENU_CHECK_MARK_SIZE)/2.0);
        cell.checkMarkView = [LKPopupMenuCheckMarkView checkMarkViewAtPoint:p color:cell.appearance.checkMarkColor];
        cell.separatorEnabled = popupMenu.appearance.separatorEnabled;
        [cell.contentView addSubview:cell.checkMarkView];
    }
    return cell;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.contentView.backgroundColor = self.appearance.menuHilightedColor;
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.separatorEnabled) {
        UIBezierPath* path = [UIBezierPath bezierPath];
        CGPoint p = CGPointMake(0, 0);
        [path moveToPoint:p];
        p.x += self.bounds.size.width - 1.0;
        [path addLineToPoint:p];
        [path setLineWidth:0.5];
        [[UIColor blackColor] setStroke];
        [path stroke];
        
        path = [UIBezierPath bezierPath];
        p = CGPointMake(0, 0.5);
        [path moveToPoint:p];
        p.x += self.bounds.size.width - 1.0;
        [path addLineToPoint:p];
        [path setLineWidth:0.5];
        [self.appearance.separatorColor setStroke];
        [path stroke];
    }    
}

- (void)dealloc {
    self.checkMarkView = nil;
    self.appearance = nil;
    [super dealloc];
}
@end

//------------------------------------------------------------------------------
@implementation LKPopupMenuController
//------------------------------------------------------------------------------
@synthesize indexSet = indexSet_;

@synthesize textList = textList_;
@synthesize imageFilenameList = imageFilenameList;
@synthesize delegate = delegate_;
@synthesize multipleSelectionEnabled = multipleSelectionEnabled_;
@synthesize arrangementMode = arrangementMode_;
@synthesize animationMode = animationMode_;
@synthesize modalEnabled = modalEnabled_;

@synthesize parentView = parentView_;
@synthesize title = title_;
@synthesize popupmenuVisible = shown_;

@synthesize autoresizeEnabled = autoresizeEnabled_;
@synthesize autocloseEnabled = autocloseEnabled_;
@synthesize bounceEnabled = bounceEnabled_;

@synthesize appearance = appearance_;

@synthesize popupMenuBaseView = popupMenuBaseView_;
@synthesize backgroundView = backgroundView_;


#pragma mark -
#pragma mark Basics

- (id)initWithView:(UIView*)parentView appearance:(LKPopupMenuAppearance*)appearance
{
    self = [super init];
    if (self) {
        self.parentView = parentView;
        self.autoresizeEnabled = YES;
        self.autocloseEnabled = YES;
        self.bounceEnabled = NO;
        self.multipleSelectionEnabled = NO;
        self.arrangementMode = LKPopupMenuControllerArrangementModeDown;
        self.animationMode = LKPopupMenuControllerAnimationModeSlide;
        self.selectedIndexSet = [NSMutableIndexSet indexSet];
        self.modalEnabled = YES;
        self.indexSet = [NSMutableIndexSet indexSet];

        self.appearance = appearance;
    }
    return self;
}

- (void)dealloc {
    self.textList = nil;
    self.imageFilenameList = nil;
    self.delegate = nil;
    if (self.popupMenuBaseView) {
        [self.popupMenuBaseView removeFromSuperview];
    }
    self.popupMenuBaseView = nil;
    self.parentView = nil;
    self.title = nil;

    self.indexSet = nil;

    self.appearance = nil;
    
    if (self.backgroundView) {
        [self.backgroundView removeFromSuperview];
    }
    self.backgroundView = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark Properties
- (void)setSelectedIndexSet:(NSIndexSet *)selectedIndexSet
{
    self.indexSet = [[[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexSet] autorelease];
}

- (NSIndexSet*)selectedIndexSet
{
    return self.indexSet;
}

#pragma mark -
#pragma mark API
+ (LKPopupMenuController*)popupMenuControllerOnView:(UIView*)parentView
{
    return [[[self alloc] initWithView:parentView
                            appearance:[LKPopupMenuAppearance defaultAppearanceWithSize:LKPopupMenuControllerSizeMedium]] autorelease];
}

+ (LKPopupMenuController*)popupMenuControllerOnView:(UIView*)parentView appearacne:(LKPopupMenuAppearance*)appearance
{
    return [[[self alloc] initWithView:parentView
                            appearance:appearance] autorelease];
}

- (void)presentPopupMenuFromLocation:(CGPoint)location
{
    self.popupmenuVisible = YES;

    if ([self.delegate respondsToSelector:@selector(willAppearPopupMenuController:)]) {
        [self.delegate willAppearPopupMenuController:self];
    }

    if (self.popupMenuBaseView) {
        [self.popupMenuBaseView removeFromSuperview];
        self.popupMenuBaseView = nil;
    }
    
    // create new popup mewnu view
    NSString* title = self.title ? [@"  " stringByAppendingString:self.title] : nil;
    self.popupMenuBaseView = [[[LKPopupMenuView alloc] initAsBaseWithPopupMenu:self
                                                                      location:location
                                                                         title:title] autorelease];

    if (self.modalEnabled) {
        self.backgroundView = [[[LKPopupBackgroundView alloc] initWithFrame:self.parentView.bounds] autorelease];
        self.backgroundView.popupMenu = self;
        [self.parentView addSubview:self.backgroundView];
    }
    
    [self.parentView addSubview:self.popupMenuBaseView];
    CGPoint p = [self.popupMenuBaseView convertPoint:location fromView:self.parentView];
    [self.popupMenuBaseView setupPathAtLocation:p];
    
    if (self.appearance.outlineEnabled) {
        LKPopupMenuView* frameView = [[[LKPopupMenuView alloc] initAsFrameWithPopupMenu:self
                                                                               location:location
                                                                                  title:title] autorelease];
        [self.popupMenuBaseView addSubview:frameView];
        [frameView setupPathAtLocation:p];
    }

    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    if (self.animationMode != LKPopupMenuControllerAnimationModeNone) {

        CGAffineTransform t1 = self.popupMenuBaseView.transform;
        CGAffineTransform t2 = self.popupMenuBaseView.transform;
        CGSize viewSize = self.popupMenuBaseView.frame.size;
        
        if (self.animationMode == LKPopupMenuControllerAnimationModeSlide ||
            self.animationMode == LKPopupMenuControllerAnimationModeSlideWithBounce) {
            CGFloat bx, by;
            switch (self.arrangementMode) {
                case LKPopupMenuControllerArrangementModeUp:
                    t1 = CGAffineTransformTranslate(t1, 0, viewSize.height/2.0);
                    self.popupMenuBaseView.transform = CGAffineTransformScale(t1, 1.0, 0.001);
                    bx = 0;
                    by = 20.0;
                    break;

                case LKPopupMenuControllerArrangementModeDown:
                    t1 = CGAffineTransformTranslate(t1, 0, -viewSize.height/2.0);
                    self.popupMenuBaseView.transform = CGAffineTransformScale(t1, 1.0, 0.001);
                    bx = 0;
                    by = -20.0;
                    break;
                    
                case LKPopupMenuControllerArrangementModeRight:
                    t1 = CGAffineTransformTranslate(t1, -viewSize.width/2.0, 0);
                    self.popupMenuBaseView.transform = CGAffineTransformScale(t1, 0.001, 1.0);
                    bx = -20.0;
                    by = 0;
                    break;

                case LKPopupMenuControllerArrangementModeLeft:
                    t1 = CGAffineTransformTranslate(t1, viewSize.width/2.0, 0);
                    self.popupMenuBaseView.transform = CGAffineTransformScale(t1, 0.001, 1.0);
                    bx = 20.0;
                    by = 0;
                    break;
            }
            self.popupMenuBaseView.alpha = 0.5;
            self.popupMenuBaseView.tableView.alpha = 0.0;

            [UIView animateWithDuration:0.15
                             animations:^{
                                 self.popupMenuBaseView.transform = t2;
                                 self.popupMenuBaseView.alpha = 1.0;
                             }
                             completion:^(BOOL finished) {
                                 [UIView animateWithDuration:0.1
                                                  animations:^{
                                                      self.popupMenuBaseView.tableView.alpha = 1.0;
                                                  }];
                                 
                                 if (self.animationMode == LKPopupMenuControllerAnimationModeSlideWithBounce) {
                                     self.popupMenuBaseView.tableView.contentOffset = CGPointMake(bx/2.0, by/2.0);
                                     [UIView animateWithDuration:0.1
                                                      animations:^{
                                                          self.popupMenuBaseView.tableView.contentOffset = CGPointMake(bx, by);
                                                    }
                                                      completion:^(BOOL finished) {
                                                          [UIView animateWithDuration:0.5
                                                                           animations:^{
                                                                               self.popupMenuBaseView.tableView.contentOffset = CGPointMake(0, 0);
                                                                           }completion:^(BOOL finished) {
                                                                               if ([self.delegate respondsToSelector:@selector(didAppearPopupMenuController:)]) {
                                                                                   [self.delegate didAppearPopupMenuController:self];
                                                                               }
                                                                           }];
                                                      }];
                                 } else {
                                     if ([self.delegate respondsToSelector:@selector(didAppearPopupMenuController:)]) {
                                         [self.delegate didAppearPopupMenuController:self];
                                     }
                                 }
                             }];

        } else if (self.animationMode == LKPopupMenuControllerAnimationModeOpenClose) {
            switch (self.arrangementMode) {
                case LKPopupMenuControllerArrangementModeUp:
                case LKPopupMenuControllerArrangementModeDown:
                    self.popupMenuBaseView.transform = CGAffineTransformScale(t1, 0.001, 1.0);
                    break;
                    
                case LKPopupMenuControllerArrangementModeRight:
                case LKPopupMenuControllerArrangementModeLeft:
                    self.popupMenuBaseView.transform = CGAffineTransformScale(t1, 1.0, 0.001);
                    break;
            }
            self.popupMenuBaseView.alpha = 0.5;
            self.popupMenuBaseView.tableView.alpha = 0.0;
            [UIView animateWithDuration:0.15
                             animations:^{
                                 self.popupMenuBaseView.transform = t2;
                                 self.popupMenuBaseView.alpha = 1.0;
                             }
                             completion:^(BOOL finished) {
                                 [UIView animateWithDuration:0.1
                                                  animations:^{
                                                      self.popupMenuBaseView.tableView.alpha = 1.0;
                                                  } completion:^(BOOL finished) {
                                                      if ([self.delegate respondsToSelector:@selector(didAppearPopupMenuController:)]) {
                                                          [self.delegate didAppearPopupMenuController:self];
                                                      }
                                                  }];
            }];

        } else if (self.animationMode == LKPopupMenuControllerAnimationModeFade) {
            self.popupMenuBaseView.alpha = 0.0;
            [UIView animateWithDuration:0.2 animations:^{
                self.popupMenuBaseView.alpha = 1.0;
            } completion:^(BOOL finished) {
                if ([self.delegate respondsToSelector:@selector(didAppearPopupMenuController:)]) {
                    [self.delegate didAppearPopupMenuController:self];
                }
            }];
        }
    }    
}

- (void)dismiss
{
    if (!self.popupmenuVisible) {
        return;
    }
    self.popupmenuVisible = NO;
    
    if (self.backgroundView) {
        [self.backgroundView removeFromSuperview];
    }
    self.backgroundView = nil;

    if ([self.delegate respondsToSelector:@selector(willDisappearPopupMenuController:)]) {
        [self.delegate willDisappearPopupMenuController:self];
    }

    CGAffineTransform t = self.popupMenuBaseView.transform;
    CGSize viewSize = self.popupMenuBaseView.frame.size;
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];

    if (self.animationMode == LKPopupMenuControllerAnimationModeNone) {
        self.popupMenuBaseView.hidden = YES;
        if ([self.delegate respondsToSelector:@selector(didDisappearPopupMenuController:)]) {
            [self.delegate didDisappearPopupMenuController:self];
        }

    } else if (self.animationMode == LKPopupMenuControllerAnimationModeFade) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.popupMenuBaseView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             self.popupMenuBaseView.hidden = YES;
                             if ([self.delegate respondsToSelector:@selector(didDisappearPopupMenuController:)]) {
                                 [self.delegate didDisappearPopupMenuController:self];
                             }
                         }];

    } else if (self.animationMode == LKPopupMenuControllerAnimationModeSlide ||
               self.animationMode == LKPopupMenuControllerAnimationModeSlideWithBounce) {
        switch (self.arrangementMode) {
            case LKPopupMenuControllerArrangementModeUp:
                t = CGAffineTransformTranslate(t, 0, viewSize.height/2.0);
                t = CGAffineTransformScale(t, 1.0, 0.001);
                break;
                
            case LKPopupMenuControllerArrangementModeDown:
                t = CGAffineTransformTranslate(t, 0, -viewSize.height/2.0);
                t = CGAffineTransformScale(t, 1.0, 0.001);
                break;
                
            case LKPopupMenuControllerArrangementModeRight:
                t = CGAffineTransformTranslate(t, -viewSize.width/2.0, 0);
                t = CGAffineTransformScale(t, 0.001, 1.0);
                break;
                
            case LKPopupMenuControllerArrangementModeLeft:
                t = CGAffineTransformTranslate(t, viewSize.width/2.0, 0);
                t = CGAffineTransformScale(t, 0.001, 1.0);
                break;
        }
        
        self.popupMenuBaseView.tableView.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.popupMenuBaseView.transform = t;
            self.popupMenuBaseView.alpha = 0.25;
        } completion:^(BOOL finished){
            self.popupMenuBaseView.hidden = YES;
            if ([self.delegate respondsToSelector:@selector(didDisappearPopupMenuController:)]) {
                [self.delegate didDisappearPopupMenuController:self];
            }
        }];
        
    } else if (self.animationMode == LKPopupMenuControllerAnimationModeOpenClose) {
        switch (self.arrangementMode) {
            case LKPopupMenuControllerArrangementModeUp:
            case LKPopupMenuControllerArrangementModeDown:
                t = CGAffineTransformScale(t, 0.001, 1.0);
                break;
                
            case LKPopupMenuControllerArrangementModeRight:
            case LKPopupMenuControllerArrangementModeLeft:
                t = CGAffineTransformScale(t, 1.0, 0.001);
                break;
        }
        
        self.popupMenuBaseView.tableView.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.popupMenuBaseView.transform = t;
            self.popupMenuBaseView.alpha = 0.25;
        } completion:^(BOOL finished){
            self.popupMenuBaseView.hidden = YES;
            if ([self.delegate respondsToSelector:@selector(didDisappearPopupMenuController:)]) {
                [self.delegate didDisappearPopupMenuController:self];
            }
        }];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.textList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LKPopupMenuCell* cell = [LKPopupMenuCell cellForTableView:tableView popupMenu:self];

    cell.checkMarkView.hidden = ![self.selectedIndexSet containsIndex:indexPath.row];
    cell.textLabel.text = [self.textList objectAtIndex:indexPath.row];
    
    if (self.imageFilenameList && indexPath.row < [self.imageFilenameList count]) {
        NSString* imageFilename = [self.imageFilenameList objectAtIndex:indexPath.row];
        if ([imageFilename isEqualToString:LKPopupMenuControllerBlankImage]) {
            UIGraphicsBeginImageContext(CGSizeMake(32, 32));
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        } else {
            cell.imageView.image = [UIImage imageNamed:imageFilename];
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.appearance.cellHeight;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.multipleSelectionEnabled) {
        if ([self.indexSet containsIndex:indexPath.row]) {
            [self.indexSet removeIndex:indexPath.row];
        } else {
            [self.indexSet addIndex:indexPath.row];        
        }
        if ([self.delegate respondsToSelector:@selector(popupMenuController:didSelectRowAtIndex:)]) {
            [self.delegate popupMenuController:self didSelectRowAtIndex:indexPath.row];
        }
        [self.popupMenuBaseView reloadData];
    } else {
        [self.indexSet removeAllIndexes];
        [self.indexSet addIndex:indexPath.row];
        if ([self.delegate respondsToSelector:@selector(popupMenuController:didSelectRowAtIndex:)]) {
            [self.delegate popupMenuController:self didSelectRowAtIndex:indexPath.row];
        }
        if (self.autocloseEnabled) {
            [self dismiss];
        } else {
            [self.popupMenuBaseView reloadData];
        }
    }
}

@end
