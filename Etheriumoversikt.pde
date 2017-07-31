import java.util.Date;
float my_num=0;
float r=0;

int bronze = #cd7f32; 
int movState = 0; 

JSONObject eth;
JSONArray ruter;

Float price;
Float Oeth = 8.52177; 
Float OOriginalPrice = 181.9;
Float OOriginalInvest = (Oeth*OOriginalPrice);
Float OReturns; 
Float OValue; 




void setup() {


  fullScreen(); //1440 x 900
  pixelDensity(displayDensity());
}


void mouseClicked() {
  if (movState == 0) {
    movState = 1;
    background(30);
  } else {
    movState = 0;
  }
}

void draw() {
  if (movState == 0) {
    background(30);
    fill(bronze);

    text(hour() + ":" + minute(), 50, 50); // ENKEL KLOKKE

    //----------------------------------------------------------------------------ETHERIUM

    eth = loadJSONObject("https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=EUR");
    price = eth.getFloat("EUR");

    OValue = (Oeth*price);
    OReturns = (OValue-OOriginalInvest);


    text("AVKASTNING:", 200, 75);
    if (OReturns > 0 ) {
      fill(#00FF00);
    } else {
      fill(#FF0000);
    }

    text("Ola:  " + OReturns + " €", 200, 100);
    fill(255);

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
