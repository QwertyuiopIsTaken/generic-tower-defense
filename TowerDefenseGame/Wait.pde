class Wait {
  int lastTime;
  int waitTime;
  EnemySet es;
  int method;
  
  Wait(int _waitTime, EnemySet _es, int _method) {
    waitTime = _waitTime;
    lastTime = millis();
    es = _es;
    method = _method;
  }
  
  void looping() {
    if (millis() - lastTime > waitTime) {
      if (method == 1 && wave < 6) {
        wave++;
        es.roundEnd();
      } else if (method == 2) {
        es.sendEnemy();
      } else if (method == 3) {
        es.spawn = true;
      }
      lastTime = millis();
    }
  }
}
