XML xml;
JSONObject json;
Float price;

Float Oeth = 8.52177; 
Float OOriginalPrice = 181.9;
Float OOriginalInvest = (Oeth*OOriginalPrice);
Float OReturns; 
Float OValue; 

void setup() {
  size(800, 600);
  //  fullScreen(); //1440 x 900
  pixelDensity(displayDensity());
  noStroke();
}

void draw() {
  background(40);
  json = loadJSONObject("https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=EUR");
  price = json.getFloat("EUR");

  OValue = (Oeth*price);
  OReturns = (OValue-OOriginalInvest);

  fill(255);
  text("AVKASTNING:", 200, 75);
  if (OReturns > 0 ) {
    fill(#00FF00);
  } else {
    fill(#FF0000);
  }
  text("Ola:  " + OReturns + " €", 200, 100);

 // println("eth price:", price);
 // println("olas beholdning:", OValue);
 // println("avkastning:", OReturns);
}