//
// AKSegmentedControl.m
//
// Copyright (c) 2013 Ali Karagoz (http://alikaragoz.net)
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

#import "AKSegmentedControl.h"

#define kAKButtonSeparatorWidth 1.0

@interface AKSegmentedControl ()

/**
 Buttons target method
 */
- (void)segmentButtonPressed:(id)sender;

@end

@implementation AKSegmentedControl
{
    /**
     Array containing all the separators, for easy access
     */
    NSMutableArray *separatorsArray;
    
    /**
     Background Image view of the segmented control
     */
    UIImageView *backgroundImageView;
}

#pragma mark -
#pragma mark Init and Dealloc

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self setContentEdgeInsets:UIEdgeInsetsZero];
    [self setSelectedIndex:0];
    [self setSegmentedControlMode:AKSegmentedControlModeSticky];
    [self setButtonsArray:[NSMutableArray array]];
    separatorsArray = [NSMutableArray array];
    
    backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self addSubview:backgroundImageView];
    
    return self;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews
{
    // creating the content rect that will "contain" the button
    CGRect contentRect = UIEdgeInsetsInsetRect(self.bounds, _contentEdgeInsets);
    
    // for more clarity we create simple variables
    NSUInteger buttonsCount = [_buttonsArray count];
    NSUInteger separtorsNumber = buttonsCount - 1;
    
    // calculating the button prperties
    CGFloat separatorWidth = (_separatorImage != nil) ? _separatorImage.size.width : kAKButtonSeparatorWidth;
    CGFloat buttonWidth = floorf((CGRectGetWidth(contentRect) - (separtorsNumber * separatorWidth)) / buttonsCount);
    CGFloat buttonHeight = CGRectGetHeight(contentRect);
    CGSize buttonSize = CGSizeMake(buttonWidth, buttonHeight);
    
    CGFloat dButtonWidth = 0;
    CGFloat spaceLeft = CGRectGetWidth(contentRect) - (buttonsCount * buttonSize.width) - (separtorsNumber * separatorWidth);
    
    CGFloat offsetX = CGRectGetMinX(contentRect);
    CGFloat offsetY = CGRectGetMinY(contentRect);
    
    NSUInteger increment = 0;
    
    // laying-out the buttons
    for (UIButton *button in _buttonsArray)
    {
        // trick to incread the size of the button a little bit because of the separators
        dButtonWidth = buttonSize.width;
        
        if (spaceLeft != 0)
        {
            dButtonWidth++;
            spaceLeft--;
        }
        
        if (increment != 0) offsetX += separatorWidth;
    
        //
        [button setFrame:CGRectMake(offsetX, offsetY, dButtonWidth, buttonSize.height)];
        
        // replacing each separators
        if (increment < separtorsNumber)
        {
            UIImageView *separatorImageView = separatorsArray[increment];
            [separatorImageView setFrame:CGRectMake(CGRectGetMaxX(button.frame),
                                                    offsetY,
                                                    separatorWidth,
                                                    CGRectGetHeight(self.bounds) - _contentEdgeInsets.top - _contentEdgeInsets.bottom)];
        }
        
        increment++;
        offsetX = CGRectGetMaxX(button.frame);
    }
}

#pragma mark -
#pragma mark Button Actions

- (void)segmentButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (!button || ![button isKindOfClass:[UIButton class]])
        return;
    
    NSUInteger selectedIndex = button.tag;
    
    [self setSelectedIndex:selectedIndex];
}

#pragma mark -
#pragma mark Setters

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    [backgroundImageView setImage:_backgroundImage];
}

- (void)setButtonsArray:(NSArray *)buttonsArray
{
    [_buttonsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIButton *)obj removeFromSuperview];
    }];
    
    [separatorsArray removeAllObjects];
    
    // filling the arrays
    _buttonsArray = buttonsArray;
    
    [_buttonsArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         [self addSubview:(UIButton *)obj];
        [(UIButton *)obj addTarget:self action:@selector(segmentButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [(UIButton *)obj setTag:idx];
        
        if (idx ==_selectedIndex)
            [(UIButton *)obj setSelected:YES];
    }];
    
    [self setSeparatorImage:_separatorImage];
    [self setSegmentedControlMode:_segmentedControlMode];
}

- (void)setSeparatorImage:(UIImage *)separatorImage
{
    [separatorsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIImageView *)obj removeFromSuperview];
    }];
    
    _separatorImage = separatorImage;
    
    NSUInteger separatorsNumber = [_buttonsArray count] - 1;
    
    [_buttonsArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         if (idx < separatorsNumber)
         {
             UIImageView *separatorImageView = [[UIImageView alloc] initWithImage:_separatorImage];
             [self addSubview:separatorImageView];
             [separatorsArray addObject:separatorImageView];
         }
     }];
}

- (void)setSegmentedControlMode:(AKSegmentedControlMode)segmentedControlMode
{
    _segmentedControlMode = segmentedControlMode;
    
    if ([_buttonsArray count] == 0) return;
    
    if (_segmentedControlMode == AKSegmentedControlModeButton)
    {
        UIButton *currentSelectedButton = (UIButton *)_buttonsArray[_selectedIndex];
        [currentSelectedButton setSelected:NO];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex != _selectedIndex || _segmentedControlMode == AKSegmentedControlModeButton)
    {        
        if (_segmentedControlMode == AKSegmentedControlModeSticky)
        {
            if ([_buttonsArray count] == 0) return;
            
            UIButton *currentSelectedButton = (UIButton *)_buttonsArray[_selectedIndex];
            UIButton *selectedButton = (UIButton *)_buttonsArray[selectedIndex];
            
            [currentSelectedButton setSelected:!currentSelectedButton.selected];
            [selectedButton setSelected:!selectedButton.selected];
        }
        
        _selectedIndex = selectedIndex;
        
        if ([_delegate respondsToSelector:@selector(segmentedViewController:touchedAtIndex:)])
            [_delegate segmentedViewController:self touchedAtIndex:selectedIndex];
    }
}

@end