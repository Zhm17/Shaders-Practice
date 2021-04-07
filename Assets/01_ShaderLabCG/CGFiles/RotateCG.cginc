#ifndef RotateCG
#define RotateCG

//FUNCTIONS HERE
float2 rotate(float2 uv, float center)
{
    float pivot = (center);

    float cosAngle = _CosTime.w; //cos(_Time.y);
    float sinAngle = _SinTime.w; //sin(_Time.y);
    float2x2 rot = float2x2
    (
        cosAngle, -sinAngle,
        sinAngle, cosAngle
    );

    float2 uvPiv =  uv - pivot;

    float2 uvRot = mul(rot, uvPiv);

    return uvRot;
}


#endif