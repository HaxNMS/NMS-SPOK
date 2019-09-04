////////////////////////////////////////////////////////////////////////////////
///
///     @file       PostCommon.h
///     @author     User
///     @date       
///
///     @brief      PostCommon
///
///     Copyright (c) 2008 Hello Games Ltd. All Rights Reserved.
///
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
//      Compilation defines 


//-----------------------------------------------------------------------------
//      Include files

#include "Common/Defines.shader.h"


//-----------------------------------------------------------------------------
///
///     CustomPerMeshUniforms
///
///     @brief      CustomPerMeshUniforms
///
///     Stuff that is only used for these types of meshes.
//-----------------------------------------------------------------------------

#ifndef D_VERTEX
struct CustomPerMeshUniforms
{
    vec4 gDoFParamsVec4;
    vec4 gHDRParamsVec4;
    vec4 gHBAOParamsVec4;
    vec4 gThresholdParamsVec4;
    vec4 gBlurParamsVec4;
    vec4 gColourLUTParamsVec4;
    vec4 gColourLUTStrengthsVec4;
    vec4 gSharpenStrength;
#if defined ( D_IBL )
    vec4 gIBLParamsVec4;
#else
    vec4 gTextureSizeMipLevelVec4;
#endif
#if defined ( D_UI ) || defined( D_SCREENEFFECT )
    vec4   gUIColourVec4;
    vec4   gUIDeformVec4;
    vec4   gVignetteVec4;
    vec4   gUILowHealthVignetteVec4;
    vec4   gWashParamsVec4;
    vec4   gCriticalHitPointsVec4;
    vec4   gFrontendFlashColourVec4;
#else
    vec4 gSkyUpperParamsVec4;
    vec4 gLightShaftColourBottomVec4;
    vec4 gLightShaftColourTopVec4;
#endif
    vec4 gHDRParams2Vec4;

BEGIN_SAMPLERBLOCK

#ifdef D_LUT
    layout( binding=12 ) SAMPLER3D(gColourLUTBase);
    layout( binding=13 ) SAMPLER3D(gColourLUTFar);
    layout( binding=14 ) SAMPLER3D(gColourLUTStorm);
    layout( binding=15 ) SAMPLER3D(gColourLUTEffect);
#endif

#if defined ( D_SCREENEFFECT )
    layout( binding= 0 ) SAMPLER2D( gBufferMap );
    layout( binding= 1 ) SAMPLER2D( gBuffer1Map );
    layout( binding= 2 ) SAMPLER2D( gBuffer2Map );
    
    // UI shader stuff
    layout( binding= 7 ) SAMPLER2D( gUIFullscreenNormal );
    layout( binding= 9 ) SAMPLER2D( gUIFullScreenRefraction );
    layout( binding= 6 ) SAMPLER2D( gUIFullscreenEffect );
    layout( binding=10 ) SAMPLER2D( gUISurveyingEffect );
    layout( binding= 8 ) SAMPLER2D( gUIZoomEffect );

    layout( binding= 3 ) SAMPLER2D( gBuffer3Map );
    layout( binding= 4 ) SAMPLER2D( gBuffer4Map );
#elif defined ( D_UI )
    layout( binding= 5 ) SAMPLER2D( gUIMap );
    // SAMPLER2D( gUIMask );
    // SAMPLER2D( gUINoiseEffect );
#endif

    // SAMPLER2D( gBuffer1Map );
    // SAMPLER2D( gBuffer2Map );
    // SAMPLER2D( gBuffer3Map );
    // SAMPLER2D( gBuffer4Map );
    // SAMPLER2D( gBuffer5Map );

#if defined ( D_IBL )
    SAMPLER2D(gDualPMapFront);
    SAMPLER2D(gDualPMapBack);
#else
    layout( binding=11 ) SAMPLER2D(gBlurMask);
#endif

#if defined( D_LENSFLARE )
    SAMPLER2D(gLensDirt);
#endif

#if defined( D_DEBUG_QUAD )
    SAMPLER2D( gBuffer6Map );
    SAMPLER2D( gBuffer7Map );
    SAMPLER2D( gBuffer8Map );
    SAMPLER2D( gBuffer9Map );
    SAMPLER2D( gBuffer10Map );
    SAMPLER2D( gBuffer11Map );
    SAMPLER2D( gBuffer12Map );
    SAMPLER2D( gBuffer13Map );
    SAMPLER2D( gBuffer14Map );
#endif

END_SAMPLERBLOCK
};
#endif

#ifndef D_COMPUTE

#define TEX_COORDS IN(mTexCoordsVec2)

#elif defined D_PLATFORM_ORBIS

//-----------------------------------------------------------------------------
///
///     ComputeOutputUniforms
///
///     @brief      ComputeOutputUniforms
///
///     Refs to output textures for compute quad shaders
//-----------------------------------------------------------------------------

struct ComputeOutputUniforms
{
    RW_Texture2D<float4> gOutTexture0; 
    RW_Texture2D<float4> gOutTexture1; 
    RW_Texture2D<float4> gOutTexture2; 
    RW_Texture2D<float4> gOutTexture3; 
    RW_Texture2D<float4> gOutTexture4; 
    RW_Texture2D<float>  gOutTextureDepth;
};

#define TEX_COORDS ( ( vec2( dispatchThreadID.xy ) + vec2(0.5,0.5) ) / vec2( GetImgResolution( lUniforms.mpCmpOutPerMesh->gOutTexture0 ) ) )

#elif defined D_PLATFORM_OPENGL

    RWIMAGE2D( rgba32f, gOutTexture0 ); 
    RWIMAGE2D( rgba32f, gOutTexture1 ); 
    RWIMAGE2D( rgba32f, gOutTexture2 ); 
    RWIMAGE2D( rgba32f, gOutTexture3 ); 
    RWIMAGE2D( rgba32f, gOutTexture4 ); 
    RWIMAGE2D( r32f,  gOutTextureDepth );
    
#define TEX_COORDS ( ( vec2( dispatchThreadID.xy ) + vec2(0.5,0.5) ) / vec2( GetImgResolution( gOutTexture0 ) ) )

#else

RW_Texture2D<float4> gOutTexture0 : register(u0);
RW_Texture2D<float4> gOutTexture1 : register(u1);
RW_Texture2D<float4> gOutTexture2 : register(u2);
RW_Texture2D<float4> gOutTexture3 : register(u3);
RW_Texture2D<float4> gOutTexture4 : register(u4);
RW_Texture2D<float>  gOutTextureDepth : register(u5);
#define TEX_COORDS ( ( vec2( dispatchThreadID.xy ) + vec2(0.5,0.5) ) / vec2( GetImgResolution( gOutTexture0 ) ) )

#endif

#ifndef D_VERTEX
//
// This is the SRT buffer that everything gets uploaded to (on PS4). PC just functions as normal.
//
DECLARE_UNIFORMS
     DECLARE_PTR( PerFrameUniforms,             mpPerFrame )       /*: PER_MESH*/
     DECLARE_PTR( CustomPerMeshUniforms,        mpCustomPerMesh )       /*: PER_MESH*/
     DECLARE_PTR( CommonPerMeshUniforms,        mpCommonPerMesh )       /*: PER_MESH*/

#if defined D_PLATFORM_ORBIS && defined D_COMPUTE
     DECLARE_PTR( ComputeOutputUniforms,        mpCmpOutPerMesh )   /* hack - marked 'per mesh' so it'll be alloced in cmd buf */
#endif
DECLARE_UNIFORMS_END
#endif