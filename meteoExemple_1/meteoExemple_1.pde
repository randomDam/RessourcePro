Meteo met;

float temp;
float humidity;
float pressure;
String weather="";
String ville="";

PFont typo18;
PFont typo34;
//---------------------------------------------------------
// SETUP
//---------------------------------------------------------
void setup() {
	size(800, 480);
	met = new Meteo(this);
	//mettre ici la clef api
	met.setApi("!api key is here!");
	met.requestFor("Paris");

	met.addCallBack(this,"dispatch");

	typo18 = createFont("Roboto-Medium.ttf",18);
	typo34 = createFont("Roboto-Medium.ttf",34);
}

void draw() {
	background(20);
	int py=40;

	textFont(typo34);
	text(ville, 30, py);

	textFont(typo18);
	text(weather, 30, py+20);
	text("T° : "+temp, 30, py+20*2);
	text("P° : "+pressure, 30, py+20*3);
	text("H° : "+humidity, 30, py+20*4);

	if(frameCount==100)met.requestFor("Zurich");
	if(frameCount==200)met.requestFor("Krāslava");
	if(frameCount==300)met.requestFor("New York,US");
	if(frameCount==400)met.requestFor("Berlin");
	if(frameCount==500)met.requestFor("Moscow");

	//dispatch();
}

void dispatch(){
	temp = met.main_temp;
	humidity = met.main_humidity;
	pressure = met.main_pressure;
	weather = met.weather_description;
	ville = met.name;
}
