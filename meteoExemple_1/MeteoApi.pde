/*
    -COPYLEFT- SHARE IT COPY IT ^^

    this a very very simple class for my student
    to make some work with meteo data.
    I know it's now very well coded but
    the meaning is it to be very very simplistic
    and easy tu use.

    [!] WARNING [!]
    >>> But don't forget you need a API Code on the openweathermap website
    the key api is free but it need registration and you can only make 60 call by minute
    https://openweathermap.org/current
    
    >>> Sign up here please!
    https://openweathermap.org/

    Share it, use it and enjoy it with this!
    VERSION 3.0
    [1/12/2019]
*/
import java.util.*;
import java.lang.reflect.Method;
//---------------------------------------------------------------------------------------
//  METEO CLASS   (*-*)
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
class Meteo {
    PApplet p;
    boolean debug = true;
    boolean celsius = true;

    String apiKey = "none";

    Meteo(PApplet p) {
        this.p = p;
    }

    void setApi(String k) {
        apiKey = k;
    }

    //--------------------------------------------
    //  REQUEST LINK FOR YAHOO API
    //--------------------------------------------
    String url_request = "https://api.openweathermap.org/data/2.5/weather?q=";

    //---------------------------------------------------------
    //GET THE DATA
    //---------------------------------------------------------
    JSONObject rawData;

    void requestFor(String city) {

        if(!apiKey.equals("none")){

            String req = url_request + city + "&appid=" + apiKey + "&units=metric" + "&lang=fr";
            println(">>> REQUEST FOR : " + city);
            println(req);

            try {
                rawData = loadJSONObject(req);
                println(rawData);
            } catch (Exception e) {
                println("ERROR : CANNOT LOAD THE URL");
            }

            //auto fill var en securise it for student
            autoFillVar();
            //reflection if we need a call back
            if(cible!=null)reflect();
        }else{
            println("-------------------------------------------");
            println("ERROR YOU NEED A API CODE");
            println("SIGN UP IN : ");
            println("https://home.openweathermap.org/users/sign_up");
            println();
            println("            thank you!");
            println("-------------------------------------------");
        }
    }

    JSONObject getData() {
        return rawData;
    }

    //-------------------------------------------------------------
    // Auto fill var common data
    // please use this var for less errors
    //-------------------------------------------------------------
    float coord_lon = 0; //coordonnée longitude;
    float coord_lat = 0; //coordonnée laitude;

    int weather_id = 0; //id du type de temps;
    String weather_main = "none"; //Descritpion courte et standard;
    String weather_description = "none"; //description étendu;
    String weather_icon = "none"; //icon standard;

    String base = "none"; //type de donnée / provenance;
    float main_temp = 0; //température actuelle;
    float main_pressure = 0; //pression actuelle;
    float main_humidity = 0; //humidité actuelle;
    float main_temp_min = 0; //température minimum sur la journée;
    float main_temp_max = 0; //température maximum sur la journée;

    float visibility = 0; //visibilité;
    float wind_speed = 0; //vitesse du vent;
    float wind_deg = 0; //orientation du vent;
    /*
    float "clouds": {
        "all": 90
    },*/
    float dt = 0; //temp de calcul des données;

    float sys_type = 0; //paramètre interne;
    float sys_id = 0; //6505;
    String sys_country = "none"; //pays
    long sys_sunrise = 0; //heure du levé de soleil (timeStamp)
    long sys_sunset = 0; //heure du couhé de soleil (timeStamp)

    String sys_sunrise_string = ""; //heure du levé de soleil (timeStamp)
    String sys_sunset_string = ""; //heure du couhé de soleil (timeStamp)

    float timezone = 0; //zone horaire;
    float id = 0; //id de la localité;
    String name = "none"; //nom de la localité;
    float cod = 0; //paramètre interne;

    void autoFillVar(){
        
        try{
            coord_lon = rawData.getJSONObject("coord").getFloat("lon");
        }catch(Exception e){}
        try{
            coord_lat = rawData.getJSONObject("coord").getFloat("lat");
        }catch(Exception e){}
        
        try{
            weather_id = rawData.getJSONArray("weather").getJSONObject(0).getInt("id");
        }catch(Exception e){}
        try{
            weather_main = rawData.getJSONArray("weather").getJSONObject(0).getString("main");
        }catch(Exception e){}
        try{
            weather_description = rawData.getJSONArray("weather").getJSONObject(0).getString("description");
        }catch(Exception e){}
        try{
            weather_icon = rawData.getJSONArray("weather").getJSONObject(0).getString("icon");
        }catch(Exception e){}
        
        try{
            base = rawData.getString("base");
        }catch(Exception e){}
        
        try{
            main_temp = rawData.getJSONObject("main").getFloat("temp");
        }catch(Exception e){}
        try{
            main_pressure = rawData.getJSONObject("main").getFloat("pressure");
        }catch(Exception e){}
        try{
            main_humidity = rawData.getJSONObject("main").getFloat("humidity");
        }catch(Exception e){}
        try{
            main_temp_min = rawData.getJSONObject("main").getFloat("temp_min");
        }catch(Exception e){}
        try{
            main_temp_max = rawData.getJSONObject("main").getFloat("temp_max");
        }catch(Exception e){}
        
        try{
            visibility = rawData.getFloat("visibility");
        }catch(Exception e){}
        
        try{
            wind_deg = rawData.getJSONObject("wind").getFloat("deg");
        }catch(Exception e){}
        try{
            wind_speed = rawData.getJSONObject("wind").getFloat("speed");
        }catch(Exception e){}

        try{
            dt = rawData.getFloat("dt");
        }catch(Exception e){}

        try{
            sys_type = rawData.getJSONObject("sys").getFloat("type");
        }catch(Exception e){}
        try{
            sys_id = rawData.getJSONObject("sys").getFloat("id");
        }catch(Exception e){}
        try{
            sys_country = rawData.getJSONObject("sys").getString("country");
        }catch(Exception e){}
        try{
            sys_sunrise = rawData.getJSONObject("sys").getLong("sunrise");
        }catch(Exception e){}
        try{
            sys_sunset = rawData.getJSONObject("sys").getLong("sunset");
        }catch(Exception e){}

        try{
            timezone = rawData.getFloat("timezone");
        }catch(Exception e){}
        try{
            id = rawData.getFloat("id");
        }catch(Exception e){}
        try{
            name = rawData.getString("name");
        }catch(Exception e){}
        try{
            cod = rawData.getFloat("cod");
        }catch(Exception e){}
        calc();
    }


    void calc(){
        Date da = new Date(sys_sunrise*1000);
        sys_sunrise_string = da.toString();
    
        Date db = new Date(sys_sunset*1000);
        sys_sunset_string = db.toString();
    }


    //---------------------------------------------------------
    //  REFLECT METHOD FOR CALLBACK
    //---------------------------------------------------------
    Object cible;
    String methodName="";
    void reflect() {
        Method callBackMethod;
        try {
            callBackMethod = p.getClass().getMethod(methodName, null);
            callBackMethod.invoke(p, null);
        } catch (Exception e) {
            println("CallBack method not found");
        }
    }

    void addCallBack(Object cible,String methodName){
        this.cible = cible;
        this.methodName = methodName;
    }
    //---------------------------------------------------------
    //  UTILS THING TO MAKE CALCULATION
    //---------------------------------------------------------
    //CONVERTISSOR OF T°
    float celsius2far(float v) {
        float r = (v + 32.0) / (0.55);
        return r;
    }
    //farenheight to celsius [  (F°-32)  x  0.55 = °C ]
    float far2celsius(float v) {
        float r = (v - 32.0) * (0.55);
        return r;
    }
    //------------------------------------END OF CLASS
}
