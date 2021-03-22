using UnityEngine;

[ExecuteInEditMode]
public class ReplacementEffect : MonoBehaviour
{
    public Shader shader;

    private void OnEnable()
    {
        if(shader)
        {
            GetComponent<Camera>().SetReplacementShader(shader, "RenderType");
        }
    }

    private void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }
}
