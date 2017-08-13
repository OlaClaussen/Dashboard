import java.util.*;
import java.text.*;

float my_num=10;
float r=100;

int bronze = #cd7f32; 
int movState = 0; 

JSONObject eth, infoEurNok;
JSONArray ruter;

float price, EURNOK;
float Oeth = 8.52177; 
float OOriginalPrice = 181.9;
float OOriginalInvest = (Oeth * OOriginalPrice);
float OReturns; 
float OValue; 

float AndOrigEth = 640.0;
float AndOrigBuyEthPrice = 8.64; // euro / eth
float AndOrigEthInvest = AndOrigEth * AndOrigBuyEthPrice;
float AndCurrentValue = 0.0;
float AndCurrentProfit = 0.0;

void setup() {


  fullScreen(); //1440 x 900
  pixelDensity(displayDensity());
}


void mouseClicked() {
  if (movState == 0) {
    movState = 1;
    background(0);
  } else {
    movState = 0;
  }
}

void draw() {
  if (movState == 0) {
    background(0);
    fill(bronze);

    //text(hour() + ":" + minute(), 50, 50); // ENKEL KLOKKE
fill(255);
    //----------------------------------------------------------------------------ETHEREUM

    eth = loadJSONObject("https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=EUR");
    price = eth.getFloat("EUR");
    
    Date date = new Date();
    String dagensDato = date.toString();
    SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
    //text(ft.format(date), 200, 160);
    dagensDato = (ft.format(date)).toString();  // Må se ut som 2017-08-10 hvis 10. aug 2017
    infoEurNok = loadJSONObject("http://api.fixer.io/latest?base=EUR&date=" + dagensDato);
    EURNOK     = infoEurNok.getJSONObject("rates").getFloat("NOK");
    
    
    fill(bronze);
    SimpleDateFormat ft2 = new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
    fill(255);
    text(ft2.format(date), 50, 50);
    text("1 EUR = " + EURNOK + " NOK", 200, 90);
    text("1 ETH = " + price*EURNOK + " NOK", 200, 105);
    OValue = (Oeth*price);
    OReturns = (OValue-OOriginalInvest);
    AndCurrentValue = AndOrigEth * price;
    AndCurrentProfit = AndCurrentValue - AndOrigEthInvest;


    text("AVKASTNING:", 200, 75);
    if (OReturns > 0 ) {
      fill(#00FF00);
    } else {
      fill(#FF0000);
    }

    text("Ola:  " + OReturns*EURNOK + " kr.", 200, 130);
    text("Ola  (etter 28 % skatt):  " + OReturns * EURNOK * 0.72 + " kr.", 200, 145);
    fill(255); // Stopper tidligere fargevalg
    line(200,150,450,150);
    stroke(#00FF00);
    
    if (AndCurrentProfit > 0 ) {
      fill(#00FF00);
    } else {
      fill(#FF0000);
    }
    
    text("Anders:  " + AndCurrentProfit * EURNOK + " kr.", 200, 170);
    text("Anders (etter 28 % skatt):  " + AndCurrentProfit * EURNOK * 0.72 + " kr.", 200, 185);
    fill(255); // Stopper tidligere fargevalg
        
    // println("eth price:", price);
    // println("olas beholdning:", OValue);
    // println("avkastning:", OReturns);

    //-----------------------------------------------------------------------------RUTER


    ruter = loadJSONArray("http://reis.trafikanten.no/reisrest/realtime/getrealtimedata/3010730");

    for (int i = 0; i < 3; i++) {
      JSONObject tram = ruter.getJSONObject(i);

      String number = tram.getString("PublishedLineName");
      String name = tram.getString("DestinationName");

      String time = tram.getString("ExpectedDepartureTime");
      Date d = new Date();
      long a = d.getTime();
      String time2 = time.substring(6, 19); 
      long b = Long.parseLong(time2);
      long c = b - a; 
      int dif = (int(c)/1000)/60;

      text("SPORTSPLASSEN:", 600, 75);
      text(number + " " + name + " -  " + dif +"min", 600, 100+(i*30));
    }
  } else {

    translate(width/2, height/2);
    rotate(r);
    float x=0;
    while (x<width) {
      point(width*noise(x/250, my_num), x);
      stroke(bronze, 20);
      x=x+.7;
    }
    my_num=my_num+0.001;
    r=r+0.002;
  }
}
