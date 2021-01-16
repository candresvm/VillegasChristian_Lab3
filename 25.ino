int dato;
void setup() {
  Serial.begin(9600);
  pinMode(7,INPUT);
  pinMode(6,INPUT);
}

void loop() {
  if(digitalRead(7)==LOW){
      delay(250);
      Serial.print("A");
    }
  if(digitalRead(6)==LOW){
      delay(250);
      Serial.print("B");
    }
  if(digitalRead(5)==LOW){
      delay(250);
      Serial.print("C");
    }
}
