#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MaterialCards.h"
#import "MDCCard.h"
#import "MDCCardCollectionCell.h"
#import "UICollectionViewController+MDCCardReordering.h"
#import "MaterialCards+ColorThemer.h"
#import "MDCCardsColorThemer.h"
#import "MaterialCards+Private.h"
#import "MDCCard+Private.h"
#import "MDCCardCollectionCell+Private.h"
#import "MaterialInk.h"
#import "MDCInkGestureRecognizer.h"
#import "MDCInkTouchController.h"
#import "MDCInkView.h"
#import "MaterialShadowElevations.h"
#import "MDCShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MDCShadowLayer.h"
#import "MaterialShapes.h"
#import "MaterialShapesNew.h"
#import "MDCCornerTreatment.h"
#import "MDCCornerTreatmentNew.h"
#import "MDCEdgeTreatment.h"
#import "MDCEdgeTreatmentNew.h"
#import "MDCPathGenerator.h"
#import "MDCPathGeneratorNew.h"
#import "MDCRectangleShapeGenerator.h"
#import "MDCRectangleShapeGeneratorNew.h"
#import "MDCShapedShadowLayer.h"
#import "MDCShapedShadowLayerNew.h"
#import "MDCShapedView.h"
#import "MDCShapedViewNew.h"
#import "MDCShapeGenerating.h"
#import "MDCShapeGeneratingNew.h"
#import "MaterialIcons.h"
#import "MDCIcons+BundleLoader.h"
#import "MDCIcons.h"
#import "MaterialIcons+ic_check_circle.h"
#import "MaterialMath.h"
#import "MDCMath.h"
#import "MaterialColorScheme.h"
#import "MDCLegacyColorScheme.h"
#import "MDCLegacyTonalColorScheme.h"
#import "MDCLegacyTonalPalette.h"
#import "MDCSemanticColorScheme.h"

FOUNDATION_EXPORT double MaterialComponentsVersionNumber;
FOUNDATION_EXPORT const unsigned char MaterialComponentsVersionString[];

