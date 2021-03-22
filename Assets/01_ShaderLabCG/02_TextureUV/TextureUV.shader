Shader "Custom/TextureUV"
{
    Properties
    {
        _MainTex("Texture",2D) = "white"{}
        _Color("Tint", Color) = (1,1,1,1)
    }

    SubShader
    {
        Tags 
        {
            "RenderType"="Opaque"
            "Queue" = "Geometry" 
        }

        //Zwrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vertexShader
            #pragma fragment fragmentShader

            #include "UnityCG.cginc"

            uniform sampler2D _MainTex; // Property connection
            uniform float4 _MainTex_ST; // Offset and Tiling connection
            uniform float4 _Color;

            struct vertexInput {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;  //TEXCOORD1,TEXCOORD2
            };

            struct vertexOutput {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            vertexOutput vertexShader(vertexInput i) {
                vertexOutput o;
                o.position = UnityObjectToClipPos(i.vertex);
                /*o.uv = i.uv;*/
                /*o.uv = (i.uv * _MainTex_ST.xy + _MainTex_ST.zw);*/
                o.uv = TRANSFORM_TEX(i.uv, _MainTex);
                // _MainTex_ST.x = tiling X ; 
                // _MainTex_ST.y = tiling Y ; 
                // _MainTex_ST.z = Offset X ;
                // _MainTex_ST.w = tiling Y ; 
                return o;
            }

            fixed4 fragmentShader(vertexOutput o) : SV_TARGET{
                fixed4 col = tex2D(_MainTex, o.uv) * _Color;
                return col;
            }

            ENDCG
        }
    }
}
