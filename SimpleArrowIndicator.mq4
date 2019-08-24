//+------------------------------------------------------------------+
//|                                         SimpleArrowIndicator.mq4 |
//|                                                             Roxy |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Roxy"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   // Create an Array for the price data
   MqlRates PriceInformation[];
   
   // Sort the Array from the current candle downwards
   ArraySetAsSeries(PriceInformation, true);
   
   // Fill the price array with data
   int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation);
   
   // Calculate number of candles
   int NumberOfCandles = Bars(Symbol(), Period());
   
   // Convert integer to string
   string NumberOfCandlesText = IntegerToString(NumberOfCandles);
   
   // Calculate highest and lowest candle number
   // 1 means the last candle
   int HighestCandleNumber = iHighest(NULL, 0, MODE_HIGH, 100, 1);
   int LowestCandleNumber = iLowest(NULL, 0, MODE_LOW, 100, 1);
   
   // Calculate highest and lowest candle price
   double HighestPrice = PriceInformation[HighestCandleNumber].high;
   double LowestPrice = PriceInformation[LowestCandleNumber].low;
   
   if (PriceInformation[0].low < LowestPrice) {
      // Create an arrow upwards
      ObjectCreate(_Symbol, NumberOfCandlesText, OBJ_ARROW_BUY, 0, TimeCurrent(), (PriceInformation[0].low));
   }
  
   if (PriceInformation[0].high > HighestPrice) {
      // Create an arrow upwards
      ObjectCreate(_Symbol, NumberOfCandlesText, OBJ_ARROW_SELL, 0, TimeCurrent(), (PriceInformation[0].high));
   }
   
   Comment(
      "NumberOfCandles: ", NumberOfCandles, "\n",
      "HighestCandleNumber:", HighestCandleNumber, "\n",
      "HighestPrice: ", HighestPrice, "\n",
      "LowestCandleNumber:", LowestCandleNumber, "\n",
      "LowestPrice: ", LowestPrice, "\n"
      );
   
  }
//+------------------------------------------------------------------+
