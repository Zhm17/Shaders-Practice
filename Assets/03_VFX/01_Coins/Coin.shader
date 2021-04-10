Shader "DreamProject/Coin"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _GoldTex ("Gold Texture", 2D) = "white" {}
        [Space(10)]
        _Range ("Gold Range", Range(1, 5)) = 1
        _Speed ("Gold Speed", Range(-1, 1)) = 0
        _Brightness ("Gold Brightness", Range(0.0, 0.5)) = 0
        _Saturation ("Gold Saturation", Range(0.5, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
               
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 uvv : TEXCOORD1;
            };

            sampler2D _MainTex;
            sampler2D _GoldTex;
            float4 _MainTex_ST;
            float _Range;
            float _Speed;
            float _Brightness;
            float _Saturation;


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uvv = ComputeScreenPos(o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 coords = i.uvv.xy / i.uvv.w;
                coords.x += _Time * _Speed;
                
                fixed4 gol = tex2D(_GoldTex, coords * _Range);
                fixed4 col = tex2D(_MainTex, i.uv);

                col *= gol / _Saturation;
                
                return col + _Brightness;
            }
            ENDCG
        }
    }
}
