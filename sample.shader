Shader "Custom/sample" //定义Shader名称,和在材质面板中出现的层级和位置
{
    Properties //Propertise语义块中包含了一系列属性（property）这些属性将会出现在材质面板中
    {
      _Texture("Texture",2D) = "white"{}//输入贴图_Texture，面板上显示名称为Texture，类型为2D，预设值为白色“white”
      _Color("Color",Color) = (1,1,1,1)//输入颜色值_Color,面板上显示的名称为Color，类型为Color，预设值为RGBA为白色“1，1，1，1”

    }

    SubShader//SubShader语义块
    {
       Tags{"Queue"="Geometry" "RenderType"="Opaque"}// 标签Tags{"标签类型"="输入的值""标签类型"="输入的值"}的架构
       LOD 100//渲染的分级

       Pass//一次完整的渲染流程
       {
           CGPROGRAM//创建CGPROGRAM语法的区域，语法的起始

           #pragma vertex vert//定义一个vertex shader 使用的方法是vert
           #pragma fragment frag

           sampler2D _Texture;//把输入的参数拿到CGPROGRAM语法里面，贴图用sampler2D然后_Texture拿下来
           fixed4 _Color;//4个量用fixed定义，fixed精度最低

           struct appdata {//要跟unity拿顶点uv的信息用struct进行资料交换的输入资料结构


                  fixed4 vertex : POSITION;//定义一个fixed拿到模型的定点位置,POSITION语义的意思是告诉unity需要一个vertex定点的位置
                  fixed2 uv : TEXCOORD0;//定义一个uv的位置0就是第一个uv位置

           };
           struct v2f{//vertex to fragment 把vertex的资料传递给fragment,用来输出资料
                  fixed4 vertex : SV_POSITION;//特定值给vertex做 SV_POSITION处理
                  fixed2 uv : TEXCOORD0;


           };

           //这里开始写方法
           v2f vert(appdata i)//回传v2f给unity，unity再拿这个v2f给fragment shader,输入参数appdata
           {
                v2f o;
                o.uv = i.uv;
                o.vertex = mul(UNITY_MATRIX_MVP, i.vertex);
                return o;
           }
           fixed4 frag(v2f v) : SV_Target
           {
                return tex2D(_Texture, v.uv) * _Color;
           }


           ENDCG//语法的终点


       }

    }
}