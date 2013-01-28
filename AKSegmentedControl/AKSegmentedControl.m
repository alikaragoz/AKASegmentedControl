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

@property (nonatomic, strong) NSMutableArray *separatorsArray;
@property (nonatomic, strong) NSMutableIndexSet *mutableIndexSet;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation AKSegmentedControl

#pragma mark - Init and Dealloc

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _mutableIndexSet = [[NSMutableIndexSet alloc] init];
    _separatorsArray = [NSMutableArray array];
    
    _contentEdgeInsets = UIEdgeInsetsZero;
    _segmentedControlMode = AKSegmentedControlModeSticky;
    _buttonsArray = [[NSArray alloc] init];
    
    [self addSubview:self.backgroundImageView];
    
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    CGRect contentRect = UIEdgeInsetsInsetRect(self.bounds, self.contentEdgeInsets);
    
    NSUInteger buttonsCount = self.buttonsArray.count;
    NSUInteger separtorsNumber = buttonsCount - 1;
    
    CGFloat separatorWidth = (self.separatorImage != nil) ? self.separatorImage.size.width : kAKButtonSeparatorWidth;
    CGFloat buttonWidth = floorf((CGRectGetWidth(contentRect) - (separtorsNumber * separatorWidth)) / buttonsCount);
    CGFloat buttonHeight = CGRectGetHeight(contentRect);
    CGSize buttonSize = CGSizeMake(buttonWidth, buttonHeight);
    
    CGFloat dButtonWidth = 0;
    CGFloat spaceLeft = CGRectGetWidth(contentRect) - (buttonsCount * buttonSize.width) - (separtorsNumber * separatorWidth);
    
    CGFloat offsetX = CGRectGetMinX(contentRect);
    CGFloat offsetY = CGRectGetMinY(contentRect);
    
    NSUInteger increment = 0;
    
    for (UIButton *button in self.buttonsArray)
    {
        dButtonWidth = buttonSize.width;
        
        if (spaceLeft != 0)
        {
            dButtonWidth++;
            spaceLeft--;
        }
        
        if (increment != 0) offsetX += separatorWidth;
        
        [button setFrame:CGRectMake(offsetX, offsetY, dButtonWidth, buttonSize.height)];
        
        if (increment < separtorsNumber)
        {
            UIImageView *separatorImageView = self.separatorsArray[increment];
            [separatorImageView setFrame:CGRectMake(CGRectGetMaxX(button.frame),
                                                    offsetY,
                                                    separatorWidth,
                                                    CGRectGetHeight(self.bounds) - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom)];
        }
        
        increment++;
        offsetX = CGRectGetMaxX(button.frame);
    }
}

#pragma mark - Button Actions

- (void)segmentButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (!button || ![button isKindOfClass:[UIButton class]])
        return;
    
    NSUInteger selectedIndex = button.tag;
    
    NSIndexSet *set = self.selectedIndeces;
    if (self.segmentedControlMode == AKSegmentedControlModeMultipleSelectionable) {
        NSMutableIndexSet *mutableSet = [set mutableCopy];
        if ([self.selectedIndeces containsIndex:selectedIndex]) {
            [mutableSet removeIndex:selectedIndex];
        } else {
            [mutableSet addIndex:selectedIndex];
        }
        set = [mutableSet copy];
    } else {
        set = [NSIndexSet indexSetWithIndex:selectedIndex];
    }
    
    BOOL willSendAction = ![self.selectedIndeces isEqualToIndexSet:set];
    
    [self selectItemsWithIndexSet:set byExpandingSelection:NO];
    
    if (willSendAction) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    if (self.segmentedControlMode == AKSegmentedControlModeButton) {
        [self selectItemsWithIndexSet:[NSIndexSet indexSet] byExpandingSelection:NO];
    }
}

#pragma mark - Setters

- (NSIndexSet *)selectedIndeces {
    return [self.mutableIndexSet copy];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    [self.backgroundImageView setImage:_backgroundImage];
}

- (void)setButtonsArray:(NSArray *)buttonsArray
{
    [_buttonsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.separatorsArray removeAllObjects];
    
    _buttonsArray = buttonsArray;
    
    [_buttonsArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         [self addSubview:(UIButton *)obj];
        [(UIButton *)obj addTarget:self action:@selector(segmentButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [(UIButton *)obj setTag:idx];
    }];
    
    [self rebuildSeparators];
    [self updateButtons];
}

- (void)setSeparatorImage:(UIImage *)separatorImage
{
    _separatorImage = separatorImage;
    [self rebuildSeparators];
}

- (void)rebuildSeparators {
    [self.separatorsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger separatorsNumber = [self.buttonsArray count] - 1;
    
    [self.buttonsArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx < separatorsNumber) {
            UIImageView *separatorImageView = [[UIImageView alloc] initWithImage:self.separatorImage];
            [self addSubview:separatorImageView];
            [self.separatorsArray addObject:separatorImageView];
        }
    }];
}

- (void)setSegmentedControlMode:(AKSegmentedControlMode)segmentedControlMode
{
    _segmentedControlMode = segmentedControlMode;
    [self updateButtons];
}

- (void)selectItemsWithIndexSet:(NSIndexSet *)indexSet byExpandingSelection:(BOOL)expandSelection {
    if (!expandSelection) {
        [self.mutableIndexSet removeAllIndexes];
    }
    [self.mutableIndexSet addIndexes:indexSet];
    
    [self updateButtons];
}

- (UIImageView *)backgroundImageView {
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    }
    return _backgroundImageView;
}

- (void)updateButtons {
    [self.buttonsArray makeObjectsPerformSelector:@selector(setSelected:) withObject:nil];
    [self.selectedIndeces enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (self.segmentedControlMode != AKSegmentedControlModeButton) {
            UIButton *button = self.buttonsArray[idx];
            button.selected = YES;
        }
    }];
}

@end