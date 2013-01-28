///// Fonction permettant de d�finir le ou les objets occludeurs pour une lumi�re donn�e /////
//Usage: SL_light_cast_obj(object,mask)

if !variable_local_exists("sl_light_shadowlist") sl_light_shadowlist[0,0] = -1;
for (i=0; i>=0; i+=1)
{
    if sl_light_shadowlist[i,0]=argument0 break; 
    else if sl_light_shadowlist[i,0]=-1
    {
        sl_light_shadowlist[i,0]   = argument0;
        sl_light_shadowlist[i,1]   = argument1;
        sl_light_shadowlist[i+1,0] = -1;
        break;
    }
}