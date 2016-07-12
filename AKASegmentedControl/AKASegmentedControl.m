//
// AKASegmentedControl.m
//
// Copyright (c) 2016 Ali Karagoz (http://alikaragoz.net)
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

#import "AKASegmentedControl.h"

// Default separator width.
static CGFloat const kAKButtonSeparatorWidth = 1.0;

@interface AKASegmentedControl ()

@property (nonatomic, strong) NSMutableArray *separatorsArray;
@property (nonatomic, strong) UIImageView *backgroundImageView;

// Init
- (void)commonInitializer;

@end

@implementation AKASegmentedControl

#pragma mark - Init and Dealloc

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self commonInitializer];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    
    [self commonInitializer];
    
    return self;
}

- (void)commonInitializer {
    _separatorsArray = [NSMutableArray array];
    self.selectedIndexes = [NSIndexSet indexSet];
    self.contentEdgeInsets = UIEdgeInsetsZero;
    self.segmentedControlMode = AKASegmentedControlModeSticky;
    self.buttonsArray = [[NSArray alloc] init];
    
    [self addSubview:self.backgroundImageView];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect contentRect = UIEdgeInsetsInsetRect(self.bounds, _contentEdgeInsets);
    
    NSUInteger buttonsCount    = _buttonsArray.count;
    NSUInteger separtorsNumber = buttonsCount - 1;
    CGFloat separatorWidth     = (_separatorImage != nil) ? _separatorImage.size.width : kAKButtonSeparatorWidth;
    CGFloat buttonWidth        = floorf((CGRectGetWidth(contentRect) - (separtorsNumber * separatorWidth)) / buttonsCount);
    CGFloat buttonHeight       = CGRectGetHeight(contentRect);
    CGSize buttonSize          = CGSizeMake(buttonWidth, buttonHeight);
    
    __block CGFloat offsetX      = CGRectGetMinX(contentRect);
    __block CGFloat offsetY      = CGRectGetMinY(contentRect);
    __block CGFloat spaceLeft    = CGRectGetWidth(contentRect) - (buttonsCount * buttonSize.width) - (separtorsNumber * separatorWidth);
    __block CGFloat dButtonWidth = 0;
    __block NSUInteger increment = 0;
    
    [_buttonsArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        if (![button isKindOfClass:UIButton.class]) {
            return;
        }
        
        dButtonWidth = buttonSize.width;
        
        if (spaceLeft != 0) {
            dButtonWidth++;
            spaceLeft--;
        }
        
        if (increment != 0) {
            offsetX += separatorWidth;
        }
        
        button.frame = CGRectMake(offsetX, offsetY, dButtonWidth, buttonSize.height);
        
        if (increment < separtorsNumber) {
            UIImageView *separatorImageView = _separatorsArray[increment];
            [separatorImageView setFrame:CGRectMake(CGRectGetMaxX(button.frame),
                                                    offsetY,
                                                    separatorWidth,
                                                    CGRectGetHeight(self.bounds) - _contentEdgeInsets.top - _contentEdgeInsets.bottom)];
        }
        
        increment++;
        offsetX = CGRectGetMaxX(button.frame);
    }];
    
    [_backgroundImageView setFrame:self.bounds];
}

#pragma mark - Button Actions

- (void)segmentButtonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (![button isKindOfClass:UIButton.class]) {
        return;
    }
    
    NSUInteger selectedIndex = button.tag;
    NSIndexSet *set = _selectedIndexes;
    
    if (_segmentedControlMode == AKASegmentedControlModeMultipleSelectionable) {
        
        NSMutableIndexSet *mutableSet = [set mutableCopy];
        if ([_selectedIndexes containsIndex:selectedIndex]) {
            [mutableSet removeIndex:selectedIndex];
        }
        
        else {
            [mutableSet addIndex:selectedIndex];
        }
        
        [self setSelectedIndexes:[mutableSet copy]];
    }
    
    else {
        [self setSelectedIndex:selectedIndex];
    }
    
    BOOL willSendAction = (![_selectedIndexes isEqualToIndexSet:set] || _segmentedControlMode == AKASegmentedControlModeButton);
    
    if (willSendAction) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
}

#pragma mark - Setters

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    [_backgroundImageView setImage:_backgroundImage];
}

- (void)setButtonsArray:(NSArray *)buttonsArray {
    [_buttonsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_separatorsArray removeAllObjects];
    
    _buttonsArray = buttonsArray;
    
    [_buttonsArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [self addSubview:button];
        [button addTarget:self action:@selector(segmentButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [button setTag:idx];
    }];
    
    [self rebuildSeparators];
    [self updateButtons];
}

- (void)setSeparatorImage:(UIImage *)separatorImage {
    _separatorImage = separatorImage;
    [self rebuildSeparators];
}

- (void)setSegmentedControlMode:(AKASegmentedControlMode)segmentedControlMode {
    _segmentedControlMode = segmentedControlMode;
    [self updateButtons];
}

- (void)setSelectedIndex:(NSUInteger)index {
    _selectedIndexes = [NSIndexSet indexSetWithIndex:index];
    [self updateButtons];
}

- (void)setSelectedIndexes:(NSIndexSet *)indexSet byExpandingSelection:(BOOL)expandSelection {
    
    if (_segmentedControlMode != AKASegmentedControlModeMultipleSelectionable) {
        return;
    }
    
    if (!expandSelection) {
        _selectedIndexes = [NSIndexSet indexSet];
    }
    
    NSMutableIndexSet *mutableIndexSet = [_selectedIndexes mutableCopy];
    [mutableIndexSet addIndexes:indexSet];
    [self setSelectedIndexes:mutableIndexSet];
}

- (void)setSelectedIndexes:(NSIndexSet *)selectedIndexes {
    _selectedIndexes = [selectedIndexes copy];
    [self updateButtons];
}

#pragma mark - Rearranging

- (void)rebuildSeparators {
    [_separatorsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger separatorsNumber = [_buttonsArray count] - 1;
    
    [_separatorsArray removeAllObjects];
    [_buttonsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx < separatorsNumber) {
            UIImageView *separatorImageView = [[UIImageView alloc] initWithImage:_separatorImage];
            [self addSubview:separatorImageView];
            [_separatorsArray addObject:separatorImageView];
        }
    }];
}

- (UIImageView *)backgroundImageView {
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    }
    
    return _backgroundImageView;
}

- (void)updateButtons {
    
    if ([_buttonsArray count] == 0) {
        return;
    }
    
    [_buttonsArray makeObjectsPerformSelector:@selector(setSelected:) withObject:nil];
    
    [_selectedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        if (_segmentedControlMode != AKASegmentedControlModeButton) {
            if (idx >= [_buttonsArray count]) return;
            
            UIButton *button = _buttonsArray[idx];
            button.selected = YES;
        }
    }];
}

@end
