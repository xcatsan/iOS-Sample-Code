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

#import <Foundation/Foundation.h>

//------------------------------------------------------------------------------
// Constants
//------------------------------------------------------------------------------

typedef enum {
    LKPopupMenuControllerArrangementModeUp = 0,
    LKPopupMenuControllerArrangementModeDown,
    LKPopupMenuControllerArrangementModeLeft,
    LKPopupMenuControllerArrangementModeRight
    
} LKPopupMenuControllerArrangementMode;

typedef enum {
    LKPopupMenuControllerSizeSmall = 0,
    LKPopupMenuControllerSizeMedium,
    LKPopupMenuControllerSizeLarge
} LKPopupMenuControllerSize;

typedef enum {
    LKPopupMenuControllerColorDefault = 0,
    LKPopupMenuControllerColorBlack,
    LKPopupMenuControllerColorWhite,
    LKPopupMenuControllerColorGray
} LKPopupMenuControllerColor;

typedef enum {
    LKPopupMenuControllerAnimationModeNone = 0,
    LKPopupMenuControllerAnimationModeSlide,
    LKPopupMenuControllerAnimationModeSlideWithBounce,
    LKPopupMenuControllerAnimationModeOpenClose,
    LKPopupMenuControllerAnimationModeFade
} LKPopupMenuControllerAnimationMode;

#define LKPopupMenuControllerBlankImage   @"LKPopupMenuControllerBlankImage"


@class LKPopupMenuController;
//------------------------------------------------------------------------------
/**
 The delegate of a LKPopupMenuController object must adopt the LKPopupMenuControllerDelegate protocol. Optional methods of the protocol allow the delegate to manage notifies and selection.
 */
@protocol LKPopupMenuControllerDelegate <NSObject>
//------------------------------------------------------------------------------
@optional

/**
 @name Managing the view
 */

/**
 Notifies the popup menu that its view is about to be become visible.
 
 @param popupMenuController The popup menu object requesting this information.
 */
- (void)willAppearPopupMenuController:(LKPopupMenuController*)popupMenuController;

/**
 Notifies the popup menu that its view is about to be become visible.
 
 @param popupMenuController The popup menu object requesting this information.
 */
- (void)didAppearPopupMenuController:(LKPopupMenuController*)popupMenuController;

/**
 Notifies the popupMenuController that its view is about to be dismissed.
 
 @param popupMenuController The popup menu object requesting this information.
 */
- (void)willDisappearPopupMenuController:(LKPopupMenuController*)popupMenuController;

/**
 Notifies the popupMenuController that its view is about to be dismissed.
 
 @param popupMenuController The popup menu object requesting this information.
 */
- (void)didDisappearPopupMenuController:(LKPopupMenuController*)popupMenuController;

/**
 @name Managing Selections
 */

/**
 Tell the delegate that the specified row is now selected.
 
 @param popupMenuController The popup menu object requesting this information.
 @param index An index locating the new selected row in popup menu.
 */
- (void)popupMenuController:(LKPopupMenuController*)popupMenuController didSelectRowAtIndex:(NSUInteger)index;

@end


//------------------------------------------------------------------------------
/** 
 Appearance class
 
 This class has colors and sizes set for LKPopupMenuController. It can be changed in some appearances.
 */
@interface LKPopupMenuAppearance : NSObject
//------------------------------------------------------------------------------

/**
 @name Configuring Menu Colors
 */

/** The menu’s background color. */
@property (nonatomic, retain) UIColor* menuBackgroundColor;

/** The color of the menu. */
@property (nonatomic, retain) UIColor* menuTextColor;

/** The highlighted color of the menu. */
@property (nonatomic, retain) UIColor* menuHilightedColor;

/** The title's background color. */
@property (nonatomic, retain) UIColor* titleBackgroundColor;

/** The color of the title. */
@property (nonatomic, retain) UIColor* titleTextColor;

/** The color of the shadow for the title.
 
 The color is used when titleHighlighted is YES. */
@property (nonatomic, retain) UIColor* titleTextShadowColor;

/** The color of the checkmark. */
@property (nonatomic, retain) UIColor* checkMarkColor;

/** The color of the separator. */
@property (nonatomic, retain) UIColor* separatorColor;

/** The color of the outline for the menu. */
@property (nonatomic, retain) UIColor* outlineColor;

/** The style of the scroll indicators.
 
 The default style is UIScrollViewIndicatorStyleDefault. See “Scroll Indicator Style” for descriptions of these constants. 
*/
@property (nonatomic, assign) UIScrollViewIndicatorStyle indicatorStyle;


/**
 @name Configuring Menu Sizes
 */

/** The height of menu title. */
@property (nonatomic, assign) CGFloat titleHeight;

/** The height of each row in the menu. */
@property (nonatomic, assign) CGFloat cellHeight;

/** The font size of menu. */
@property (nonatomic, assign) CGFloat fontSize;

/** The width of menu list.  */
@property (nonatomic, assign) CGFloat listWidth;

/** The height of menu list.  */
@property (nonatomic, assign) CGFloat listHeight;

/** The width of outline. */
@property (nonatomic, assign) CGFloat outlineWith;


/**
 @name Configuring Menu Appearance
 */

/** TODO */
@property (nonatomic, assign) BOOL shadowEnabled;

/**TODO */
@property (nonatomic, assign) BOOL triangleEnabled;

/**TODO */
@property (nonatomic, assign) BOOL separatorEnabled;

/**TODO */
@property (nonatomic, assign) BOOL outlineEnabled;

/**TODO */
@property (nonatomic, assign) BOOL titleHighlighted;



/**
 @name Creating Appearance
 */

/**
 Create and returns a appearance for the specified menu size. 
 
 @param menuSize The appearance size. See LKPopupMenuControllerSize for possible values.
 @return A newly created appearance.
*/

+ (LKPopupMenuAppearance*)defaultAppearanceWithSize:(LKPopupMenuControllerSize)menuSize;
/**
 Create and returns a appearance for the specified menu size and color. 
 
 @param menuSize The appearance size type. See LKPopupMenuControllerSize for possible values.
 @param menuColor The appearance color type. See LKPopupMenuControllerColor for possible values.
 @return A newly created appearance.
 */
+ (LKPopupMenuAppearance*)defaultAppearanceWithSize:(LKPopupMenuControllerSize)menuSize color:(LKPopupMenuControllerColor)menuColor;

@end


//------------------------------------------------------------------------------
@interface LKPopupMenuController : NSObject
//------------------------------------------------------------------------------
/**
 @name Creating Popup Menu
 */

/**
 TODO
 
 @param parentView The view whose content should be displayed by the popup menu.
 @return a newly created popup menu.
 */
+ (LKPopupMenuController*)popupMenuControllerOnView:(UIView*)parentView;

/** 
 TODO
 
 @param parentView The view whose content should be displayed by the popup menu.
 @param appearance appearance of the receiver.
 @return a newly created popup menu.
 */
+ (LKPopupMenuController*)popupMenuControllerOnView:(UIView*)parentView appearacne:(LKPopupMenuAppearance*)appearance;


/**
 @name Presenting and Dismissing the Popup Menu
 */
/**
 Displays the popup menu and anchors it to the specified location.
 
 @param location The location at which to anchor the popup menu window.
 */
- (void)presentPopupMenuFromLocation:(CGPoint)location;

/**
 Dismisses the receiver.
 */
- (void)dismiss;


/**
 @name Confirgring a Popup Menu
 */

/**TODO */
@property (nonatomic, retain) NSArray* textList;

/** TODO */
@property (nonatomic, retain) NSArray* imageFilenameList;

/** The string that appears in the receiver's title bar.
 
If this string is nil or empty, then the title bar will disappear. */
@property (nonatomic, copy) NSString* title;


/**
 @name Managing Selections
 */
/** TODO */
@property (nonatomic, retain) NSIndexSet* selectedIndexSet;

/**
 @name Managing the Delegate
*/

/** The object that acts as the delegate of the receiving popup menu
 
 The delegate must adopt the LKPopupMenuControllerDelegate protocol. The delegate is not retained.
 */
@property (nonatomic, assign) id<LKPopupMenuControllerDelegate> delegate;


/**
 @name Confiruring a Popup Menu
 */

/** A Boolean value that determines whether multiple rows can be selected. */
@property (nonatomic, assign) BOOL multipleSelectionEnabled;

/** A Boolean value that determines whether the height of menu will be resized automatically. */
@property (nonatomic, assign) BOOL autoresizeEnabled;

/** A Boolean value that determines whether the menu will be closed when the row is selected.

NOTE: Though autocloseEnabled is YES it will not be closed automaticaly when multipleSelectionEnabled is YES.
*/
@property (nonatomic, assign) BOOL autocloseEnabled;

/** A Boolean value that determines whether the menu is boucable. */
@property (nonatomic, assign) BOOL bounceEnabled;

/** A Boolean value that determines whether using modal mode. */
@property (nonatomic, assign) BOOL modalEnabled;

/** The direction TODO*
 
 The selection mode. See LKPopupMenuControllerArrangementMode for possible values.
*/
@property (nonatomic, assign) LKPopupMenuControllerArrangementMode arrangementMode;

/**TODO 
 
 The selection mode. See LKPopupMenuControllerAnimationMode for possible values.
 */
@property (nonatomic, assign) LKPopupMenuControllerAnimationMode animationMode;


/**
 @name Setting the Popup Menu Appearance
 */

/** The appearance of menu */
@property (nonatomic, retain) LKPopupMenuAppearance* appearance;


/**
 @name Accessing the Popup Menu View Information
 */

/**TODO */
@property (nonatomic, assign, readonly) UIView* parentView;

/**TODO */
@property (nonatomic, assign, readonly) BOOL popupmenuVisible;


@end
